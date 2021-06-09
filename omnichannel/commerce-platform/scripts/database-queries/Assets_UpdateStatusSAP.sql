set echo on
REM Querying table



DECLARE
v_ProductId varchar2(40);
v_AssetVersion number(19,0);
v_ProductDiscontinued number(1);

CURSOR c_Products IS 
    SELECT  GN_PA.PRODUCT_ID
            ,GN_PA.ASSET_VERSION
            ,SUM(I.STOCK_LEVEL) AS SUM_STOCK_LEVEL
            ,CASE 
                WHEN (
                        GN_PA.ATTRIBUTE_VALUE = 'S1'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S2'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S3'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S6'
                    ) THEN 0
                WHEN (
                        GN_PA.ATTRIBUTE_VALUE = 'S4'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S5'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S7'
                    ) THEN 
                            CASE 
                                WHEN SUM(I.STOCK_LEVEL) > 0 THEN 0
                                ELSE 1
                            END
                WHEN (  
                        GN_PA.ATTRIBUTE_VALUE = 'S8' 
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S9' 
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S0'
                    ) THEN 1
                ELSE 0
            END AS PRODUCT_DISCONTINUED
    FROM    ATGDB_PUB.GN_PRD_ATTR GN_PA,
            (
                SELECT  PRODUCT_ID
                        ,ASSET_VERSION
                        ,IS_HEAD
                        ,VERSION_DELETED
                FROM    ATGDB_PUB.DCS_PRODUCT
            ) P,
            (
                SELECT  PRODUCT_ID
                        ,ASSET_VERSION
                        ,SKU_ID
                FROM    ATGDB_PUB.DCS_PRD_CHLDSKU
            ) PCS,
            (
                SELECT  INVENTORY_ID
                        ,LOCATION_ID
                        ,CATALOG_REF_ID
                        ,STOCK_LEVEL
                FROM    ATGDB_CORE.DCS_INVENTORY
            ) I
    WHERE   P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND P.ASSET_VERSION = GN_PA.ASSET_VERSION
        AND P.IS_HEAD = 1 
        AND P.VERSION_DELETED = 0
        AND P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND PCS.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND PCS.ASSET_VERSION = GN_PA.ASSET_VERSION
        AND I.CATALOG_REF_ID = PCS.SKU_ID
        AND I.INVENTORY_ID LIKE 'inv_no_location%'
        AND I.LOCATION_ID IS NULL
        AND GN_PA.ATTRIBUTE_NAME = 'SAP_STATUS' 
    GROUP BY GN_PA.PRODUCT_ID, GN_PA.ASSET_VERSION, GN_PA.ATTRIBUTE_VALUE
    ORDER BY GN_PA.PRODUCT_ID;

c_Product c_Products%ROWTYPE;



BEGIN

FOR c_Product IN 
    c_Products
LOOP
    v_ProductId := TO_CHAR(c_Product.PRODUCT_ID);
    v_AssetVersion := TO_NUMBER(c_Product.ASSET_VERSION);
    v_ProductDiscontinued := TO_NUMBER(c_Product.PRODUCT_DISCONTINUED);

    UPDATE  ATGDB_PUB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND ASSET_VERSION = v_AssetVersion;

    UPDATE  ATGDB_CATA.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId;

    UPDATE  ATGDB_CATB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId;

END LOOP;


ROLLBACK;
--COMMIT;


END;
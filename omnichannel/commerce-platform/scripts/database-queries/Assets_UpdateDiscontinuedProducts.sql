set echo on
REM Querying table



DECLARE
v_Count number;
v_CountProducts number;
v_CountAll number;
v_CountNoCrossInventory number;
v_CountCrossInventory number;
v_CountNoStatusSAP number;
v_CountNewDiscontinued number;
v_CountNewNotDiscontinued number;
v_CountOldDiscontinued number;
v_CountOldNotDiscontinued number;
v_CountAllDiscontinued number;
v_CountAllNotDiscontinued number;

v_ProductId varchar2(40);
v_AssetVersion number(19,0);
v_ProductDiscontinued number(1);



BEGIN
v_Count := 0;
v_CountProducts := 0;
v_CountAll := 0;
v_CountNoCrossInventory := 0;
v_CountCrossInventory := 0;
v_CountNoStatusSAP := 0;
v_CountNewDiscontinued := 0;
v_CountNewNotDiscontinued := 0;
v_CountOldDiscontinued := 0;
v_CountOldNotDiscontinued := 0;
v_CountAllDiscontinued := 0;
v_CountAllNotDiscontinued := 0;


DBMS_OUTPUT.PUT_LINE('-- ---------- --');
DBMS_OUTPUT.NEW_LINE();


FOR c_ProductsNoCrossInventory IN (
    SELECT  GN_PA.PRODUCT_ID
            ,GN_PA.ASSET_VERSION
            ,CASE 
                WHEN (
                        GN_PA.ATTRIBUTE_VALUE = 'S1'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S2'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S3'
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S6'
                    ) THEN 0
                WHEN (  
                        GN_PA.ATTRIBUTE_VALUE = 'S8' 
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S9' 
                    OR  GN_PA.ATTRIBUTE_VALUE = 'S0'
                    ) THEN 1
            END AS PRODUCT_DISCONTINUED
    FROM    ATGDB_PUB.GN_PRD_ATTR GN_PA,
            (
                SELECT  PRODUCT_ID
                        ,ASSET_VERSION
                        ,IS_HEAD
                        ,VERSION_DELETED
                FROM    ATGDB_PUB.DCS_PRODUCT
            ) P
    WHERE   P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND P.ASSET_VERSION = GN_PA.ASSET_VERSION
        AND P.IS_HEAD = 1 
        AND P.VERSION_DELETED = 0
        AND P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND GN_PA.ATTRIBUTE_NAME = 'SAP_STATUS' 
        AND GN_PA.ATTRIBUTE_VALUE IN ('S1','S2','S3','S6','S8','S9','S0')
    GROUP BY GN_PA.PRODUCT_ID, GN_PA.ASSET_VERSION, GN_PA.ATTRIBUTE_VALUE
    ORDER BY GN_PA.PRODUCT_ID
    )
LOOP
    v_ProductId := TO_CHAR(c_ProductsNoCrossInventory.PRODUCT_ID);
    v_AssetVersion := TO_NUMBER(c_ProductsNoCrossInventory.ASSET_VERSION);
    v_ProductDiscontinued := TO_NUMBER(c_ProductsNoCrossInventory.PRODUCT_DISCONTINUED);

    v_CountNoCrossInventory := v_CountNoCrossInventory + 1;
    v_CountAll := v_CountAll + 1;
    
    UPDATE  ATGDB_PUB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND ASSET_VERSION = v_AssetVersion
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
    v_Count := SQL%rowcount;
           
    UPDATE  ATGDB_CATA.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
        
    UPDATE  ATGDB_CATB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;

    IF v_Count > 0 THEN
        IF v_ProductDiscontinued = 1 THEN
            v_CountNewDiscontinued := v_CountNewDiscontinued + 1;
        ELSE
            v_CountNewNotDiscontinued := v_CountNewNotDiscontinued + 1;
        END IF;
    ELSE 
        IF v_ProductDiscontinued = 1 THEN
            v_CountOldDiscontinued := v_CountOldDiscontinued + 1;
        ELSE
            v_CountOldNotDiscontinued := v_CountOldNotDiscontinued + 1;
        END IF;
    END IF;
END LOOP;


FOR c_ProductsCrossInventory IN (
    SELECT  GN_PA.PRODUCT_ID
            ,GN_PA.ASSET_VERSION
            ,(
                SELECT  CASE 
                            WHEN SUM(I.STOCK_LEVEL) > 0 THEN 0
                            ELSE 1
                        END AS PRODUCT_DISCONTINUED
                FROM    (
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
                WHERE   PCS.PRODUCT_ID = GN_PA.PRODUCT_ID 
                    AND PCS.ASSET_VERSION = GN_PA.ASSET_VERSION
                    AND I.CATALOG_REF_ID = PCS.SKU_ID
                    AND I.INVENTORY_ID LIKE 'inv_no_location%'
                    AND I.LOCATION_ID IS NULL
            ) AS PRODUCT_DISCONTINUED
    FROM    ATGDB_PUB.GN_PRD_ATTR GN_PA,
            (
                SELECT  PRODUCT_ID
                        ,ASSET_VERSION
                        ,IS_HEAD
                        ,VERSION_DELETED
                FROM    ATGDB_PUB.DCS_PRODUCT
            ) P
    WHERE   P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND P.ASSET_VERSION = GN_PA.ASSET_VERSION
        AND P.IS_HEAD = 1 
        AND P.VERSION_DELETED = 0
        AND P.PRODUCT_ID = GN_PA.PRODUCT_ID 
        AND GN_PA.ATTRIBUTE_NAME = 'SAP_STATUS' 
        AND GN_PA.ATTRIBUTE_VALUE IN ('S4','S5','S7')
    GROUP BY GN_PA.PRODUCT_ID, GN_PA.ASSET_VERSION, GN_PA.ATTRIBUTE_VALUE
    ORDER BY GN_PA.PRODUCT_ID
    )
LOOP
    v_ProductId := TO_CHAR(c_ProductsCrossInventory.PRODUCT_ID);
    v_AssetVersion := TO_NUMBER(c_ProductsCrossInventory.ASSET_VERSION);
    v_ProductDiscontinued := TO_NUMBER(c_ProductsCrossInventory.PRODUCT_DISCONTINUED);

    v_CountCrossInventory := v_CountCrossInventory + 1;
    v_CountAll := v_CountAll + 1;
    
    UPDATE  ATGDB_PUB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND ASSET_VERSION = v_AssetVersion
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
    v_Count := SQL%rowcount;
           
    UPDATE  ATGDB_CATA.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
        
    UPDATE  ATGDB_CATB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;

    IF v_Count > 0 THEN
        IF v_ProductDiscontinued = 1 THEN
            v_CountNewDiscontinued := v_CountNewDiscontinued + 1;
        ELSE
            v_CountNewNotDiscontinued := v_CountNewNotDiscontinued + 1;
        END IF;
    ELSE 
        IF v_ProductDiscontinued = 1 THEN
            v_CountOldDiscontinued := v_CountOldDiscontinued + 1;
        ELSE
            v_CountOldNotDiscontinued := v_CountOldNotDiscontinued + 1;
        END IF;
    END IF;
END LOOP;


FOR c_ProductsNoStatusSAP IN (
    SELECT  P.PRODUCT_ID
            ,P.ASSET_VERSION
            ,1 AS PRODUCT_DISCONTINUED
    FROM    ATGDB_PUB.DCS_PRODUCT P
    WHERE   P.IS_HEAD = 1 
        AND P.VERSION_DELETED = 0
        AND P.PRODUCT_ID NOT IN
            (
                SELECT  GN_PA2.PRODUCT_ID
                FROM    ATGDB_PUB.GN_PRD_ATTR GN_PA2,
                        (
                            SELECT  PRODUCT_ID
                                    ,ASSET_VERSION
                                    ,IS_HEAD
                                    ,VERSION_DELETED
                            FROM    ATGDB_PUB.DCS_PRODUCT
                        ) P2
                WHERE   P2.PRODUCT_ID = GN_PA2.PRODUCT_ID 
                    AND P2.ASSET_VERSION = GN_PA2.ASSET_VERSION
                    AND P2.IS_HEAD = 1 
                    AND P2.VERSION_DELETED = 0
                    AND P2.PRODUCT_ID = GN_PA2.PRODUCT_ID 
                    AND GN_PA2.ATTRIBUTE_NAME = 'SAP_STATUS' 
                GROUP BY GN_PA2.PRODUCT_ID
            )
    )
LOOP
    v_ProductId := TO_CHAR(c_ProductsNoStatusSAP.PRODUCT_ID);
    v_AssetVersion := TO_NUMBER(c_ProductsNoStatusSAP.ASSET_VERSION);
    v_ProductDiscontinued := TO_NUMBER(c_ProductsNoStatusSAP.PRODUCT_DISCONTINUED);

    v_CountNoStatusSAP := v_CountNoStatusSAP + 1;
    v_CountAll := v_CountAll + 1;
    
    UPDATE  ATGDB_PUB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND ASSET_VERSION = v_AssetVersion
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
    v_Count := SQL%rowcount;
           
    UPDATE  ATGDB_CATA.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;
        
    UPDATE  ATGDB_CATB.GN_PRODUCT
    SET     PRODUCT_DISCONTINUED = v_ProductDiscontinued
    WHERE   PRODUCT_ID = v_ProductId
        AND PRODUCT_DISCONTINUED <> v_ProductDiscontinued;

    IF v_Count > 0 THEN
        IF v_ProductDiscontinued = 1 THEN
            v_CountNewDiscontinued := v_CountNewDiscontinued + 1;
        ELSE
            v_CountNewNotDiscontinued := v_CountNewNotDiscontinued + 1;
        END IF;
    ELSE 
        IF v_ProductDiscontinued = 1 THEN
            v_CountOldDiscontinued := v_CountOldDiscontinued + 1;
        ELSE
            v_CountOldNotDiscontinued := v_CountOldNotDiscontinued + 1;
        END IF;
    END IF;
END LOOP;


v_CountAllDiscontinued := v_CountOldDiscontinued + v_CountNewDiscontinued;
v_CountAllNotDiscontinued := v_CountOldNotDiscontinued + v_CountNewNotDiscontinued;


DBMS_OUTPUT.PUT_LINE('SE PROCESARON ' || v_CountAll || ' PRODUCTOS:');
DBMS_OUTPUT.PUT_LINE('  ' || v_CountNoCrossInventory || ' PRODUCTOS QUE NO USAN INVENTARIO');
DBMS_OUTPUT.PUT_LINE('  ' || v_CountCrossInventory || ' PRODUCTOS QUE USAN INVENTARIO');
DBMS_OUTPUT.PUT_LINE('  ' || v_CountNoStatusSAP || ' PRODUCTOS QUE NO TIENEN STATUS SAP');
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('SE MODIFICARON ' || v_CountNewDiscontinued || ' PRODUCTOS CON EL ATRIBUTO DESCONTINUADO');
DBMS_OUTPUT.PUT_LINE('SE MODIFICARON ' || v_CountNewNotDiscontinued || ' PRODUCTOS CON EL ATRIBUTO "NO" DESCONTINUADO');
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('ACTUALMENTE HAY ' || v_CountAllDiscontinued || ' PRODUCTOS CON EL ATRIBUTO DESCONTINUADO');
DBMS_OUTPUT.PUT_LINE('ACTUALMENTE HAY ' || v_CountAllNotDiscontinued || ' PRODUCTOS CON EL ATRIBUTO "NO" DESCONTINUADO');


SELECT  count(PRODUCT_ID)
INTO    v_CountProducts
FROM    ATGDB_PUB.DCS_PRODUCT
WHERE   IS_HEAD = 1
    AND PRODUCT_ID IN
        (
            SELECT  PRODUCT_ID
            FROM    ATGDB_PUB.GN_PRODUCT
        );

IF v_CountProducts > v_CountAll THEN
    v_CountProducts := v_CountProducts - v_CountAll;
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('SE ENCONTRÓ UN TOTAL DE ' || v_CountProducts || ' PRODUCTOS QUE NO TIENEN EL STATUS SAP CONFIGURADO');
END IF;


ROLLBACK;
--COMMIT;


DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('-- ---------- --');


END;
set echo on
REM Querying table



DECLARE
v_CountProjects number;
v_Count number;



BEGIN
v_CountProjects := 0;
v_Count := 0;



SELECT  count(PROJECT_ID)
INTO    v_CountProjects
FROM    ATGDB_PUB.EPUB_PROJECT
WHERE   STATUS = 0;

IF v_CountProjects = 0 THEN
    DBMS_OUTPUT.PUT_LINE('EXISTEN ' || TO_Char(v_CountProjects) || ' PROYECTO(S) PENDIENTE(S) DE EJECUCIÓN O BLOQUEADO(S)');
    DBMS_OUTPUT.PUT_LINE('POR FAVOR, LIMPIE LOS PROYECTOS DE BCC PARA CONTINUAR CON LA LIMPIA DE ASSETS');
ELSE
    DBMS_OUTPUT.PUT_LINE('LIMPIA DE SKU');
    DBMS_OUTPUT.PUT_LINE('DONDE EL SKU TENGA UN "ASSET_VERSION" MAYOR A LA DEL "IS_HEAD"');
    DBMS_OUTPUT.NEW_LINE();
    
    -- TABLAS QUE LIMPIAR
    --     GN_SKU
    --     DBC_MEASUREMENT
    --     DCS_PRD_CHLDSKU
    --     DCS_SKU
    
    DBMS_OUTPUT.PUT_LINE('  GN_SKU');
    
    DELETE  -- GN_SKU
    FROM    ATGDB_PUB.GN_SKU GN_S
    WHERE   GN_S.ASSET_VERSION > (
            SELECT  S.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_SKU S
            WHERE   S.SKU_ID = GN_S.SKU_ID
                AND S.IS_HEAD = 1
                AND S.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA GN_SKU');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DBC_MEASUREMENT');
    
    DELETE  -- DBC_MEASUREMENT
    FROM    ATGDB_PUB.DBC_MEASUREMENT M
    WHERE   M.ASSET_VERSION > (
            SELECT  S.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_SKU S
            WHERE   S.SKU_ID = M.SKU_ID
                AND S.IS_HEAD = 1
                AND S.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DBC_MEASUREMENT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_PRD_CHLDSKU');
    
    DELETE  -- DCS_PRD_CHLDSKU
    FROM    ATGDB_PUB.DCS_PRD_CHLDSKU PCS
    WHERE   PCS.SEC_ASSET_VERSION > (
            SELECT  S.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_SKU S
            WHERE   S.SKU_ID = PCS.SKU_ID
                AND S.IS_HEAD = 1
                AND S.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_PRD_CHLDSKU');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_SKU');
    
    DELETE  -- DCS_SKU
    FROM    ATGDB_PUB.DCS_SKU S
    WHERE   S.IS_HEAD = 0
        AND S.ASSET_VERSION > (
            SELECT  S2.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_SKU S2
            WHERE   S2.SKU_ID = S.SKU_ID
                AND S2.IS_HEAD = 1
                AND S2.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;        
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_SKU');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    -- --------
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('-- -------- --');
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('LIMPIA DE PRODUCTOS');
    DBMS_OUTPUT.PUT_LINE('DONDE EL PRODUCTO TENGA UN "ASSET_VERSION" MAYOR A LA DEL "IS_HEAD"');
    DBMS_OUTPUT.NEW_LINE();
    
    -- TABLAS QUE LIMPIAR
    --      GN_PRD_ATTR
    --      GN_PRODUCT
    --      DCS_PRD_CHLDSKU
    --      DCS_CAT_CHLDPRD
    --      DCS_PRD_PRNT_CATS
    --      DCS_PRODUCT
    
    
    DBMS_OUTPUT.PUT_LINE('  GN_PRD_ATTR');
    
    DELETE  -- GN_PRD_ATTR
    FROM    ATGDB_PUB.GN_PRD_ATTR GN_PA
    WHERE   GN_PA.ASSET_VERSION > (
            SELECT  P.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P
            WHERE   P.PRODUCT_ID = GN_PA.PRODUCT_ID
                AND P.IS_HEAD = 1
                AND P.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA GN_PRD_ATTR');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
            
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  GN_PRODUCT');
    
    DELETE  -- GN_PRODUCT
    FROM    ATGDB_PUB.GN_PRODUCT GN_P
    WHERE   GN_P.ASSET_VERSION > (
            SELECT  P.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P
            WHERE   P.PRODUCT_ID = GN_P.PRODUCT_ID
                AND P.IS_HEAD = 1
                AND P.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA GN_PRODUCT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CAT_CHLDPRD');
    
    DELETE  -- DCS_CAT_CHLDPRD
    FROM    ATGDB_PUB.DCS_CAT_CHLDPRD CCP
    WHERE   CCP.SEC_ASSET_VERSION > (
            SELECT  P.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P
            WHERE   P.PRODUCT_ID = CCP.CHILD_PRD_ID
                AND P.IS_HEAD = 1
                AND P.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CAT_CHLDPRD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
            
            
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_PRD_CHLDSKU');
    
    DELETE  -- DCS_PRD_CHLDSKU
    FROM    ATGDB_PUB.DCS_PRD_CHLDSKU PCS
    WHERE   PCS.ASSET_VERSION > (
            SELECT  P.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P
            WHERE   P.PRODUCT_ID = PCS.PRODUCT_ID
                AND P.IS_HEAD = 1
                AND P.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_PRD_CHLDSKU');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_PRD_PRNT_CATS');
    
    DELETE  -- DCS_PRD_PRNT_CATS
    FROM    ATGDB_PUB.DCS_PRD_PRNT_CATS PPC
    WHERE   PPC.ASSET_VERSION > (
            SELECT  P.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P
            WHERE   P.PRODUCT_ID = PPC.PRODUCT_ID
                AND P.IS_HEAD = 1
                AND P.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_PRD_PRNT_CATS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_PRODUCT');
    
    DELETE  -- DCS_PRODUCT
    FROM    ATGDB_PUB.DCS_PRODUCT P
    WHERE   P.IS_HEAD = 0
        AND P.ASSET_VERSION > (
            SELECT  P2.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_PRODUCT P2
            WHERE   P2.PRODUCT_ID = P.PRODUCT_ID
                AND P2.IS_HEAD = 1
                AND P2.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_PRODUCT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    -- --------
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('-- -------- --');
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('LIMPIA DE CATALOG');
    DBMS_OUTPUT.PUT_LINE('DONDE EL CATALOG TENGA UN "ASSET_VERSION" MAYOR A LA DEL "IS_HEAD"');
    DBMS_OUTPUT.NEW_LINE();
    
    -- TABLAS QUE LIMPIAR
    
    --      DCS_CATALOG_SITES
    --      DCS_CATALOG
    
    
    DBMS_OUTPUT.PUT_LINE('  DCS_CATALOG_SITES');
    
    DELETE  -- DCS_CATALOG_SITES
    FROM    ATGDB_PUB.DCS_CATALOG_SITES CS
    WHERE   CS.ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATALOG C
            WHERE   C.CATALOG_ID = CS.CATALOG_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CATALOG_SITES');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CATALOG');
    
    DELETE  -- DCS_CATALOG
    FROM    ATGDB_PUB.DCS_CATALOG C
    WHERE   C.IS_HEAD = 0
        AND C.ASSET_VERSION > (
            SELECT  C2.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATALOG C2
            WHERE   C2.CATALOG_ID = C.CATALOG_ID
                AND C2.IS_HEAD = 1
                AND C2.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CATALOG');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    -- --------
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('-- -------- --');
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('LIMPIA DE CATEGORY');
    DBMS_OUTPUT.PUT_LINE('DONDE EL CATEGORY TENGA UN "ASSET_VERSION" MAYOR A LA DEL "IS_HEAD"');
    DBMS_OUTPUT.NEW_LINE();
    
    -- TABLAS QUE LIMPIAR
    
    --      DCS_CATEGORY_SITES
    --      DCS_CAT_CATALOGS
    --      DCS_CAT_CHLDCAT
    --      DCS_CAT_CHLDPRD
    --      DCS_CATEGORY
    
    
    DBMS_OUTPUT.PUT_LINE('  DCS_CATEGORY_SITES');
    
    DELETE  -- DCS_CATEGORY_SITES
    FROM    ATGDB_PUB.DCS_CATEGORY_SITES CS
    WHERE   CS.ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C
            WHERE   C.CATEGORY_ID = CS.CATEGORY_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CATEGORY_SITES');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CAT_CATALOGS');
    
    DELETE  -- DCS_CAT_CATALOGS
    FROM    ATGDB_PUB.DCS_CAT_CATALOGS CC
    WHERE   CC.ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C
            WHERE   C.CATEGORY_ID = CC.CATEGORY_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CAT_CATALOGS');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CAT_CHLDCAT');        
            
    DELETE  -- DCS_CAT_CHLDCAT
    FROM    ATGDB_PUB.DCS_CAT_CHLDCAT CCC
    WHERE   CCC.ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C
            WHERE   C.CATEGORY_ID = CCC.CATEGORY_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            )
        OR  CCC.SEC_ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C
            WHERE   C.CATEGORY_ID = CCC.CHILD_CAT_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CAT_CHLDCAT');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
    
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CAT_CHLDPRD');        
    
    DELETE  -- DCS_CAT_CHLDPRD
    FROM    ATGDB_PUB.DCS_CAT_CHLDPRD CCP
    WHERE   CCP.ASSET_VERSION > (
            SELECT  C.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C
            WHERE   C.CATEGORY_ID = CCP.CATEGORY_ID
                AND C.IS_HEAD = 1
                AND C.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CAT_CHLDPRD');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;
          
    
    DBMS_OUTPUT.NEW_LINE();
    DBMS_OUTPUT.PUT_LINE('  DCS_CATEGORY');          
            
    DELETE  -- DCS_CATEGORY
    FROM    ATGDB_PUB.DCS_CATEGORY C
    WHERE   C.IS_HEAD = 0
        AND C.ASSET_VERSION > (
            SELECT  C2.ASSET_VERSION
            FROM    ATGDB_PUB.DCS_CATEGORY C2
            WHERE   C2.CATEGORY_ID = C.CATEGORY_ID
                AND C2.IS_HEAD = 1
                AND C2.VERSION_DELETED = 0
            );
    v_Count := SQL%rowcount;
    IF v_Count > 0 THEN
        DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCS_CATEGORY');
    ELSE
        DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
    END IF;

END IF;


ROLLBACK;
--COMMIT;


END;
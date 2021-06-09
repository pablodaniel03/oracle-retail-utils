set echo on
REM Querying table



DECLARE
c_OrderIds SYS_REFCURSOR;

v_Count number;
v_CountReservedInventory number;

v_OrderId varchar2(40);
v_BaseDate varchar2(10);
v_NewState varchar2(10);



BEGIN
v_BaseDate := '2019-08-13';
v_NewState := 'X';

v_Count := 0;
v_CountReservedInventory := 0;



-- GN RESERVED INVENTOR
DBMS_OUTPUT.PUT_LINE('GN RESERVED INVENTOR');
DBMS_OUTPUT.NEW_LINE();

OPEN c_OrderIds FOR 
SELECT  O.PROFILE_ID
FROM    DCSPP_ORDER O
        INNER JOIN DCSPP_ORDER_PRICE OP ON OP.AMOUNT_INFO_ID = O.PRICE_INFO
WHERE   O.STATE = 'INCOMPLETE' AND O.CREATION_DATE < to_date(v_BaseDate,'YYYY-MM-DD')
ORDER BY O.CREATION_DATE;

LOOP
    FETCH c_OrderIds
    INTO v_OrderId;
    EXIT WHEN c_OrderIds%notfound;
   
    -- GN RESERVED INVENTOR
    DELETE 
    FROM    GN_RESERVED_INVENTORY
    WHERE   PROFILE_ID = (SELECT PROFILE_ID FROM DCSPP_ORDER WHERE ORDER_ID = v_OrderId)
        AND CATALOG_REF_ID IN (SELECT CATALOG_REF_ID FROM DCSPP_ITEM WHERE ORDER_REF = v_OrderId)
        AND RESERVED_QUANTITY IN (SELECT QUANTITY FROM DCSPP_ITEM WHERE ORDER_REF = v_OrderId);
    IF v_Count > 0 THEN
        v_CountReservedInventory := v_CountReservedInventory + v_Count;
    END IF;

END LOOP;

CLOSE c_OrderIds;

IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('  SE ELIMINO ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA GN_RESERVED_INVENTOR');
END IF;



-- ORDER
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('ORDER');
DBMS_OUTPUT.NEW_LINE();

v_CountReservedInventory := 0;

UPDATE  DCSPP_ORDER
SET     STATE = v_NewState
WHERE   ORDER_ID IN 
        (
        SELECT  O.ORDER_ID
        FROM    DCSPP_ORDER O
                INNER JOIN DCSPP_ORDER_PRICE OP ON OP.AMOUNT_INFO_ID = O.PRICE_INFO
        WHERE   (O.STATE = 'INCOMPLETE' AND O.CREATION_DATE < to_date(v_BaseDate,'YYYY-MM-DD') AND OP.RAW_SUBTOTAL = 0)
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    v_CountReservedInventory := v_CountReservedInventory + v_Count;
    DBMS_OUTPUT.PUT_LINE('  SE MODIFICO EL ESTADO DE ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCSPP_ORDER');
    DBMS_OUTPUT.PUT_LINE('  PARA LAS ORDENES CON 0 ITEMS');
END IF;

DBMS_OUTPUT.NEW_LINE();

UPDATE  DCSPP_ORDER
SET     STATE = v_NewState
WHERE   ORDER_ID IN 
        (
        SELECT  O.ORDER_ID
        FROM    DCSPP_ORDER O
                INNER JOIN DCSPP_ORDER_PRICE OP ON OP.AMOUNT_INFO_ID = O.PRICE_INFO
        WHERE   (O.STATE = 'INCOMPLETE' AND O.CREATION_DATE < to_date(v_BaseDate,'YYYY-MM-DD'))
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    v_CountReservedInventory := v_CountReservedInventory + v_Count;
    DBMS_OUTPUT.PUT_LINE('  SE MODIFICO EL ESTADO DE ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCSPP_ORDER');
    DBMS_OUTPUT.PUT_LINE('  PARA LAS ORDENES ANTIGUAS');
END IF;

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EN TOTAL SE MODIFICO EL ESTADO DE ' || TO_Char(v_CountReservedInventory) || ' REGISTRO(S) DE LA TABLA DCSPP_ORDER');



ROLLBACK;
--COMMIT;

END;
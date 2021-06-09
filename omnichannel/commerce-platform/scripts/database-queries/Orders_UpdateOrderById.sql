set echo on
REM Querying table



DECLARE
v_BadOrder varchar2(40);
v_NewStatus varchar2(1);

v_Count number;



BEGIN

v_BadOrder := '5611111';
v_NewStatus := 'X';

v_Count := 0;



-- GN RESERVED INVENTOR
DBMS_OUTPUT.PUT_LINE('GN RESERVED INVENTOR');
DBMS_OUTPUT.NEW_LINE();

DELETE 
FROM    GN_RESERVED_INVENTORY
WHERE   PROFILE_ID = (SELECT PROFILE_ID FROM DCSPP_ORDER WHERE ORDER_ID = v_BadOrder)
    AND CATALOG_REF_ID IN (SELECT CATALOG_REF_ID FROM DCSPP_ITEM WHERE ORDER_REF = v_BadOrder)
    AND RESERVED_QUANTITY IN (SELECT QUANTITY FROM DCSPP_ITEM WHERE ORDER_REF = v_BadOrder);
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('  SE ELIMINO ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA GN_RESERVED_INVENTOR');
END IF;



-- ORDER
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('ORDER');

DBMS_OUTPUT.NEW_LINE();
UPDATE  DCSPP_ORDER
SET     STATE = v_NewStatus
WHERE   ORDER_ID = v_BadOrder;
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('  SE MODIFICO EL ESTADO DE ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA DCSPP_ORDER');
END IF;


    
ROLLBACK;
--COMMIT;

END;
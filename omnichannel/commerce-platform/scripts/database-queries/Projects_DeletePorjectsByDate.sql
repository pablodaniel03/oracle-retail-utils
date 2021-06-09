set echo on
REM Querying table



DECLARE
v_Count number;

v_StartDate varchar2(10);
v_EndDate varchar2(10);



BEGIN
v_StartDate := '2019-10-01';
v_EndDate := '2019-10-31';

v_Count := 0;



DBMS_OUTPUT.PUT_LINE('LIMPIA DE TABLAS DE PROYECTOS DE BCC');
DBMS_OUTPUT.PUT_LINE('PARA LOS PROYECTOS CREADOS ENTRE EL "' || v_StartDate || '" Y EL "' || v_EndDate || '"');
DBMS_OUTPUT.NEW_LINE();
    
    
-- Removing locks of the project if any

DBMS_OUTPUT.PUT_LINE('  AVM_ASSET_LOCK');

DELETE
FROM    ATGDB_PUB.AVM_ASSET_LOCK
WHERE   WORKSPACE_ID IN
        (
            SELECT  ID
            FROM    ATGDB_PUB.AVM_DEVLINE
            WHERE   NAME IN
            (
                SELECT  WORKSPACE
                FROM    ATGDB_PUB.EPUB_PROJECT
                WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                    AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
            )
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA AVM_ASSET_LOCK');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete history of the project

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_PR_HISTORY');

DELETE
FROM    ATGDB_PUB.EPUB_PR_HISTORY
WHERE   PROJECT_ID IN
        (
            SELECT  PROJECT_ID
            FROM    ATGDB_PUB.EPUB_PROJECT
            WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_PR_HISTORY');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete user history of the projects

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_INT_PRJ_HIST');

DELETE
FROM    ATGDB_PUB.EPUB_INT_PRJ_HIST
WHERE   PROJECT_ID IN
        (
            SELECT  PROJECT_ID
            FROM    ATGDB_PUB.EPUB_PROJECT
            WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_INT_PRJ_HIST');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete the project

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_PROJECT');

DELETE
FROM    ATGDB_PUB.EPUB_PROJECT
WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
    AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD');
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_PROJECT');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete history of the process

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_PROC_HISTORY');

DELETE
FROM    ATGDB_PUB.EPUB_PROC_HISTORY
WHERE   PROCESS_ID IN
        (
            SELECT  PROCESS_ID
            FROM    ATGDB_PUB.EPUB_PROCESS
            WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_PROC_HISTORY');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete task information of process

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_PROC_TASKINFO');

DELETE
FROM    ATGDB_PUB.EPUB_PROC_TASKINFO
WHERE   ID IN
        (
            SELECT  PROCESS_ID
            FROM    ATGDB_PUB.EPUB_PROCESS
            WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_PROC_TASKINFO');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- delete states of project (if any)

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_IND_WORKFLOW');

DELETE
FROM    ATGDB_PUB.EPUB_IND_WORKFLOW
WHERE   PROCESS_ID IN
        (
            SELECT  PROCESS_ID
            FROM    ATGDB_PUB.EPUB_PROCESS
            WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
                AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD')
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_IND_WORKFLOW');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- finally delete the process

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_PROCESS');

DELETE
FROM    ATGDB_PUB.EPUB_PROCESS
WHERE   CREATION_DATE >= to_date(v_StartDate, 'YYYY-MM-DD')
    AND CREATION_DATE <= to_date(v_EndDate, 'YYYY-MM-DD');
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_PROCESS');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


-- extra delete deployments

DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_DEPLOYMENT');

DELETE
FROM    ATGDB_PUB.EPUB_DEPLOYMENT
WHERE   DEPLOYMENT_ID IN
        (
            SELECT  DEPLOYMENT_ID
            FROM    ATGDB_PUB.EPUB_DEPLOY_PROJ
            WHERE   PROJECT_ID NOT IN
            (
                SELECT  PROJECT_ID
                FROM    ATGDB_PUB.EPUB_PROJECT
            )
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_DEPLOYMENT');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


DBMS_OUTPUT.NEW_LINE();
DBMS_OUTPUT.PUT_LINE('  EPUB_DEPLOY_PROJ');

DELETE
FROM    ATGDB_PUB.EPUB_DEPLOY_PROJ
WHERE   PROJECT_ID NOT IN
        (
            SELECT  PROJECT_ID
            FROM    ATGDB_PUB.EPUB_PROJECT
        );
v_Count := SQL%rowcount;
IF v_Count > 0 THEN
    DBMS_OUTPUT.PUT_LINE('    SE ELIMINARON ' || TO_Char(v_Count) || ' REGISTRO(S) DE LA TABLA EPUB_DEPLOY_PROJ');
ELSE
    DBMS_OUTPUT.PUT_LINE('    SIN MODIFICACIONES');
END IF;


ROLLBACK;
--COMMIT;


END;
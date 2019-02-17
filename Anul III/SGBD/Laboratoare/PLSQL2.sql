-- EXERCITII REZOLVATE. 

-- Ex. 1
DECLARE
    x NUMBER(1) := 5;
    y x%TYPE := NULL;
BEGIN
    IF x <> y THEN
        DBMS_OUTPUT.PUT_LINE ('valoare <> null este = true');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('valoare <> null este != true');
    END IF;

    x := NULL;
    IF x = y THEN
        DBMS_OUTPUT.PUT_LINE ('null = null este = true');
    ELSE
        DBMS_OUTPUT.PUT_LINE ('null = null este != true');
    END IF;
END;
/

-- Ex. 2
-- a)
DECLARE 
    TYPE EMP_RECORD IS RECORD (
                                COD EMPLOYEES.EMPLOYEE_ID%TYPE,
                                SALARIU EMPLOYEES.SALARY%TYPE,
                                JOB EMPLOYEES.JOB_ID%TYPE);
    v_ang emp_record;
BEGIN
    V_ANG.COD := 700;
    V_ANG.SALARIU := 9000;
    V_ANG.JOB:='SA_MAN';
    DBMS_OUTPUT.PUT_LINE('ANGAJATUL CU CODUL ' || V_ANG.COD || ' SI JOBUL ' || V_ANG.JOB || ' ARE SALARIUL ' || V_ANG.SALARIU);
END;
/
                                
-- b)
DECLARE 
    TYPE EMP_RECORD IS RECORD (
                                COD EMPLOYEES.EMPLOYEE_ID%TYPE,
                                SALARIU EMPLOYEES.SALARY%TYPE,
                                JOB EMPLOYEES.JOB_ID%TYPE);
    v_ang emp_record;
BEGIN
    SELECT EMPLOYEE_ID, SALARY, JOB_ID INTO V_ANG
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = 101;
    
    DBMS_OUTPUT.PUT_LINE('ANGAJATUL CU CODUL ' || V_ANG.COD || ' SI JOBUL ' || V_ANG.JOB || ' ARE SALARIUL ' || V_ANG.SALARIU);
END;
/
 
-- c)
DECLARE 
    TYPE EMP_RECORD IS RECORD (
                                COD EMPLOYEES.EMPLOYEE_ID%TYPE,
                                SALARIU EMPLOYEES.SALARY%TYPE,
                                JOB EMPLOYEES.JOB_ID%TYPE);
    v_ang emp_record;
BEGIN
    DELETE FROM emp_acro
    WHERE employee_id=101
    RETURNING employee_id, salary, job_id INTO v_ang;
    DBMS_OUTPUT.PUT_LINE ('Angajatul cu codul '|| v_ang.cod ||' si jobul ' || v_ang.job || ' are salariul ' || v_ang.salariu);
END;
/
ROLLBACK;

SELECT * 
FROM EMP_ACRO;


-- Ex. 3
DECLARE 
    V_ANG1 EMPLOYEES%ROWTYPE;
    V_ANG2 EMPLOYEES%ROWTYPE;
BEGIN
    DELETE FROM EMP_ACRO
    WHERE EMPLOYEE_ID = 100
    RETURNING EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID 
    INTO V_ANG1;
    
    INSERT INTO EMP_ACRO VALUES V_ANG1;
    
    DELETE FROM EMP_ACRO
    WHERE EMPLOYEE_ID = 101
    RETURNING EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, COMMISSION_PCT, MANAGER_ID, DEPARTMENT_ID 
    INTO V_ANG2;
    
    INSERT INTO EMP_ACRO VALUES (1000,'FN','LN','E',null,SYSDATE,' AD_VP',1000, null,100,90);
    
    UPDATE EMP_ACRO
    SET ROW=V_ANG2
    WHERE EMPLOYEE_ID = 1000;
END;
/

ROLLBACK;

SELECT *
FROM EMP_ACRO;

-- Ex. 4
DECLARE 
    TYPE TABLOU_INDEXAT IS TABLE OF NUMBER INDEX BY PLS_INTEGER;
    T TABLOU_INDEXAT;
BEGIN 
    FOR I IN 1..10 LOOP
        T(I) := I;
    END LOOP;
    
    DBMS_OUTPUT.PUT('TABLOUL ARE ' || T.COUNT || ' ELEMENTE.');
    FOR I IN T.FIRST..T.LAST LOOP
        DBMS_OUTPUT.PUT(T(I) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;

    FOR I IN 1..10 LOOP
        IF I MOD 2 = 1 THEN T(I) := NULL;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT('TABLOUL ARE ' || T.COUNT || ' ELEMENTE');
    DBMS_OUTPUT.NEW_LINE;
    
    t.DELETE(t.first);
    t.DELETE(5,7); -- STERGE TOATE ELEMENTELE INTRE 5 SI 7
    t.DELETE(t.last);
    DBMS_OUTPUT.PUT_LINE('Primul element are indicele ' || t.first ||' si valoarea ' || nvl(t(t.first),0));
    DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||' si valoarea ' || nvl(t(t.last),0));
    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');

    FOR i IN t.FIRST..t.LAST LOOP
        IF t.EXISTS(i) THEN
            DBMS_OUTPUT.PUT(nvl(t(i), 0)|| ' ');
        END IF;
    END LOOP;

    DBMS_OUTPUT.NEW_LINE;
    t.delete;
    DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/

-- Ex. 5
DECLARE
    TYPE tablou_indexat IS TABLE OF emp_acro%ROWTYPE INDEX BY BINARY_INTEGER;
    t tablou_indexat;
BEGIN
-- stergere din tabel si salvare in tablou
    DELETE FROM emp_acro
    WHERE ROWNUM<= 2
    RETURNING employee_id, first_name, last_name, email, phone_number,
              hire_date, job_id, salary, commission_pct, manager_id, department_id
    BULK COLLECT INTO t;

--afisare elemente tablou
    DBMS_OUTPUT.PUT_LINE (t(1).employee_id ||' ' || t(1).last_name);
    DBMS_OUTPUT.PUT_LINE (t(2).employee_id ||' ' || t(2).last_name);
--inserare cele 2 linii in tabel
    INSERT INTO emp_acro VALUES t(1);
    INSERT INTO emp_acro VALUES t(2);
END;
/

-- Ex. 6
DECLARE
    TYPE tablou_imbricat IS TABLE OF NUMBER;
    t tablou_imbricat := tablou_imbricat();
BEGIN
    -- punctul a
    FOR i IN 1..10 LOOP
        t.extend;
        t(i):=i;
    END LOOP;

    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
    FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT(t(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;

    -- punctul b
    FOR i IN 1..10 LOOP
        IF i mod 2 = 1 THEN t(i):=null;
        END IF;
    END LOOP;

    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');

    FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT(nvl(t(i), 0) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    -- punctul c
    t.DELETE(t.first);
    t.DELETE(5,7);
    t.DELETE(t.last);
    DBMS_OUTPUT.PUT_LINE('Primul element are indicele ' || t.first ||' si valoarea ' || nvl(t(t.first),0));
    DBMS_OUTPUT.PUT_LINE('Ultimul element are indicele ' || t.last ||' si valoarea ' || nvl(t(t.last),0));
    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
    FOR i IN t.FIRST..t.LAST LOOP
        IF t.EXISTS(i) THEN
            DBMS_OUTPUT.PUT(nvl(t(i), 0)|| ' ');
        END IF;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    -- punctul d
    t.delete;
    DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/

-- Ex. 7
DECLARE
    TYPE tablou_imbricat IS TABLE OF CHAR(1); -- char(1) inseamna char de 1 caracter; daca puneam char(10) fiecare indice avea 10 pozitii disponibile
    t tablou_imbricat := tablou_imbricat('m', 'i', 'n', 'i', 'm');
    i INTEGER;
BEGIN
    i := t.FIRST;
    WHILE i <= t.LAST LOOP
        DBMS_OUTPUT.PUT(t(i));
        i := t.NEXT(i);
    END LOOP;
    
    DBMS_OUTPUT.NEW_LINE;
    i := t.LAST;
        WHILE i >= t.FIRST LOOP
        DBMS_OUTPUT.PUT(t(i));
    i := t.PRIOR(i);
    END LOOP;

    DBMS_OUTPUT.NEW_LINE;
    t.delete(2);
    t.delete(4);

    i := t.FIRST;
    WHILE i <= t.LAST LOOP
        DBMS_OUTPUT.PUT(t(i));
        i := t.NEXT(i);
    END LOOP;

    DBMS_OUTPUT.NEW_LINE;
    i := t.LAST;
    WHILE i >= t.FIRST LOOP
        DBMS_OUTPUT.PUT(t(i));
        i := t.PRIOR(i);
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
END;
/

-- Ex. 8
DECLARE
    TYPE vector IS VARRAY(10) OF NUMBER;
    t vector:= vector();
BEGIN
    -- punctul a
    FOR i IN 1..10 LOOP
        t.extend; t(i):=i;
    END LOOP;

    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
    FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT(t(i) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    -- punctul b
    FOR i IN 1..10 LOOP
       IF i mod 2 = 1 THEN t(i):=null;
       END IF;
    END LOOP;
    DBMS_OUTPUT.PUT('Tabloul are ' || t.COUNT ||' elemente: ');
    FOR i IN t.FIRST..t.LAST LOOP
        DBMS_OUTPUT.PUT(nvl(t(i), 0) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    -- punctul c
    -- metodele DELETE(n), DELETE(m,n) nu sunt valabile pentru vectori!!!
    -- din vectori nu se pot sterge elemente individuale!!!
    -- punctul d
    t.delete;
    DBMS_OUTPUT.PUT_LINE('Tabloul are ' || t.COUNT ||' elemente.');
END;
/

-- Ex. 9
CREATE OR REPLACE TYPE SUBORDONATI_ACRO AS VARRAY(10) OF NUMBER(4);
/

CREATE TABLE MANAGERI_ACRO(
    COD_MGR NUMBER(10),
    NUME VARCHAR2(20),
    LISTA SUBORDONATI_ACRO);
    
DECLARE 
    V_SUB SUBORDONATI_ACRO := SUBORDONATI_ACRO(100, 200, 300); -- FACE UN VECTOR DE TIP SUBORDONATI_ACRO CU TREI ELEMENTE
    V_LISTA MANAGERI_ACRO.LISTA%TYPE;
BEGIN
    INSERT INTO manageri_ACRO
    VALUES (1, 'Mgr 1', v_sub);
    
    INSERT INTO manageri_ACRO
    VALUES (2, 'Mgr 2', null);
    
    INSERT INTO manageri_ACRO
    VALUES (3, 'Mgr 3', subordonati_ACRO(400,500));
    
    SELECT LISTA
    INTO V_LISTA
    FROM MANAGERI_ACRO
    WHERE COD_MGR=1;
    
    FOR j IN v_lista.FIRST..v_lista.LAST loop
        DBMS_OUTPUT.PUT_LINE (v_lista(j));
    END LOOP;
END;
/

SELECT * FROM manageri_ACRO;    

-- Ex. 10
CREATE TABLE emp_test_acro AS 
SELECT employee_id, last_name 
FROM employees
WHERE ROWNUM <= 2;

CREATE OR REPLACE TYPE tip_telefon_acro IS TABLE OF VARCHAR(12);
/

drop table emp_test_acro;
select *
from emp_test_acro;

ALTER TABLE emp_test_acro
ADD (telefon tip_telefon_acro)
NESTED TABLE telefon STORE AS tabel_telefon_acro;

INSERT INTO emp_test_acro
VALUES (500, 'XYZ',tip_telefon_acro('074XXX', '0213XXX', '037XXX'));

UPDATE emp_test_acro
SET telefon = tip_telefon_acro('073XXX', '0214XXX')
WHERE employee_id=100;

SELECT a.employee_id, b.*
FROM emp_test_acro a, TABLE (a.telefon) b;


DROP TABLE emp_test_acro;
DROP TYPE tip_telefon_acro;

-- Ex. 11
DECLARE
    TYPE tip_cod IS VARRAY(5) OF NUMBER(3);
    coduri tip_cod := tip_cod(205,206);
BEGIN
    FOR i IN coduri.FIRST..coduri.LAST LOOP
        DELETE FROM emp_acro
        WHERE employee_id = coduri (i);
    END LOOP;
END;
/
SELECT employee_id FROM emp_acro;
ROLLBACK;

-- EXERCITII DE REZOLVAT. 
-- Ex. 1
 
DECLARE 
    TYPE TIP_ID IS VARRAY(10) OF EMPLOYEES.EMPLOYEE_ID%TYPE;
    ID_PROST_PLATITI TIP_ID := TIP_ID();
    SALARIU_VECHI EMPLOYEES.SALARY%TYPE;
    SALARIU_NOU EMPLOYEES.SALARY%TYPE;
BEGIN
    SELECT EMPLOYEE_ID BULK COLLECT INTO ID_PROST_PLATITI
    FROM (SELECT EMPLOYEE_ID 
          FROM EMP_ACRO
          WHERE COMMISSION_PCT IS NULL
          ORDER BY SALARY ASC)
    WHERE ROWNUM<=5;

    DBMS_OUTPUT.PUT_LINE('CEI MAI PROST PLATITI 5 ANGAJATI: ');
    FOR I IN ID_PROST_PLATITI.FIRST..ID_PROST_PLATITI.LAST LOOP
        DBMS_OUTPUT.PUT(ID_PROST_PLATITI(I) || ' ');
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    
    FOR I IN ID_PROST_PLATITI.FIRST..ID_PROST_PLATITI.LAST LOOP
        SELECT SALARY INTO SALARIU_VECHI
        FROM EMP_ACRO
        WHERE EMPLOYEE_ID = ID_PROST_PLATITI(I);
        
        SALARIU_NOU := SALARIU_VECHI + 0.05*SALARIU_VECHI;
        UPDATE EMP_ACRO
        SET SALARY = SALARIU_NOU
        WHERE EMPLOYEE_ID = ID_PROST_PLATITI(I);
        
        DBMS_OUTPUT.PUT_LINE('ANGAJATUL ' || ID_PROST_PLATITI(I) || ' AVEA SALARIUL ' || SALARIU_VECHI || ' IAR ACUM ARE ' || SALARIU_NOU);
    END LOOP;
    
END;
/
select *
from emp_acro;

-- Ex. 2
CREATE OR REPLACE TYPE TIP_ORASE_ACRO IS TABLE OF VARCHAR(20);

/
CREATE TABLE EXCURSIE_ACRO (
    COD_EXCURSIE NUMBER(4),
    DENUMIRE VARCHAR(20),
    ORASE TIP_ORASE_ACRO
) NESTED TABLE ORASE STORE AS ORASE_TAB;

-- A)
INSERT INTO EXCURSIE_ACRO VALUES(1, 'ORADEA', TIP_ORASE_ACRO('BUCURESTI', 'SINAIA'));
INSERT INTO EXCURSIE_ACRO VALUES(2, 'IASI', TIP_ORASE_ACRO('SUCEAVA', 'VASLUI'));
INSERT INTO EXCURSIE_ACRO VALUES(3, 'CLUJ', TIP_ORASE_ACRO('BISTRITA'));
INSERT INTO EXCURSIE_ACRO VALUES(4, 'BISTRITA', TIP_ORASE_ACRO('CLUJ', 'SALAJ'));
INSERT INTO EXCURSIE_ACRO VALUES(5, 'CONSTANTA', TIP_ORASE_ACRO('TULCEA', 'GALATI', 'BRAILA'));


-- B)
DECLARE
    V_ID_EXCURSIE EXCURSIE_ACRO.COD_EXCURSIE%TYPE:='&P_ID';
    V_ORAS VARCHAR(20):='&P1_ID';
    V_LISTA EXCURSIE_ACRO.ORASE%TYPE;
BEGIN 
    SELECT ORASE INTO V_LISTA
    FROM EXCURSIE_ACRO
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
    
    V_LISTA.EXTEND;
    V_LISTA(V_LISTA.LAST) := V_ORAS;
    
    UPDATE EXCURSIE_ACRO
    SET ORASE = V_LISTA
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
END;
/

DECLARE
    V_ID_EXCURSIE EXCURSIE_ACRO.COD_EXCURSIE%TYPE:='&EXCURSIE_ID';
    V_ORAS VARCHAR(20):='&ORAS_NUME';
    V_LISTA EXCURSIE_ACRO.ORASE%TYPE;
BEGIN 
    SELECT ORASE INTO V_LISTA
    FROM EXCURSIE_ACRO
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
    
    V_LISTA.EXTEND;
    FOR I IN REVERSE 2..V_LISTA.LAST-1 LOOP
        V_LISTA(I+1) := V_LISTA(I);
    END LOOP;
    
    V_LISTA(2) := V_ORAS;
    
    UPDATE EXCURSIE_ACRO
    SET ORASE = V_LISTA
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
END;
/

DECLARE
    V_ID_EXCURSIE EXCURSIE_ACRO.COD_EXCURSIE%TYPE:='&EXCURSIE_ID';
    V_ORAS_1 VARCHAR(20):='&ORAS_NUME1';
    V_ORAS_2 VARCHAR(20):='&ORAS_NUME2';
    V_LISTA EXCURSIE_ACRO.ORASE%TYPE;
BEGIN 
    SELECT ORASE INTO V_LISTA
    FROM EXCURSIE_ACRO
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
    
    FOR I IN V_LISTA.FIRST..V_LISTA.LAST LOOP
        IF V_LISTA(I) = V_ORAS_1 THEN V_LISTA(I) := V_ORAS_2;
        ELSIF V_LISTA(I) = V_ORAS_2 THEN V_LISTA(I) := V_ORAS_1;
        END IF;
    END LOOP;
    
    UPDATE EXCURSIE_ACRO
    SET ORASE = V_LISTA
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
END;
/

DECLARE
    V_ID_EXCURSIE EXCURSIE_ACRO.COD_EXCURSIE%TYPE:='&EXCURSIE_ID';
    V_ORAS VARCHAR(20):='&ORAS_NUME';
    V_LISTA EXCURSIE_ACRO.ORASE%TYPE;
    V_POZITIE_ORAS NUMBER(8);
BEGIN 
    SELECT ORASE INTO V_LISTA
    FROM EXCURSIE_ACRO
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
    
    FOR I IN V_LISTA.FIRST..V_LISTA.LAST LOOP
        IF V_LISTA(I) = V_ORAS THEN V_POZITIE_ORAS := I;
        END IF;
    END LOOP;
    
    V_LISTA.DELETE(V_POZITIE_ORAS);
    
    UPDATE EXCURSIE_ACRO
    SET ORASE = V_LISTA
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
END;
/

DECLARE
    V_ID_EXCURSIE EXCURSIE_ACRO.COD_EXCURSIE%TYPE:='&EXCURSIE_ID';
    V_LISTA EXCURSIE_ACRO.ORASE%TYPE;
BEGIN 
    SELECT ORASE INTO V_LISTA
    FROM EXCURSIE_ACRO
    WHERE COD_EXCURSIE=V_ID_EXCURSIE;
    
    DBMS_OUTPUT.PUT_LINE('EXCURSIA ' || V_ID_EXCURSIE || ' A VIZITAT ' || V_LISTA.COUNT || ' ORASE.');
    FOR I IN V_LISTA.FIRST..V_LISTA.LAST LOOP 
        DBMS_OUTPUT.PUT_LINE(V_LISTA(I) || ' ');
    END LOOP;
END;
/

-- Ex. 3
CREATE OR REPLACE TYPE TIP_ORASE_VECTOR IS VARRAY(20) OF VARCHAR(20);

/
CREATE TABLE EXCURSIE_ACRO_VECTOR (
    ID_EXCURSIE NUMBER(4),
    DENUMIRE VARCHAR(20),
    ORASE TIP_ORASE_VECTOR,
    STATUS NUMBER(1)
);

INSERT INTO EXCURSIE_ACRO_VECTOR VALUES (1, 'REVELION', TIP_ORASE_VECTOR('BUCURESTI', 'PLOIESTI', 'SINAIA'), 0);
INSERT INTO EXCURSIE_ACRO_VECTOR VALUES (2, 'CRACIUN', TIP_ORASE_VECTOR('SINAIA', 'BRASOV', 'SIGHISOARA'), 0);

SELECT *
FROM EXCURSIE_ACRO_VECTOR;

-- PENTRU VARRAY NU POT FACE COUNT. 

SET SERVEROUTPUT ON; 
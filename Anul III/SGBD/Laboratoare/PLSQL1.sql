-- EXERCITII REZOLVATE

<<principal>>
DECLARE
    v_client_id NUMBER(4):= 1600;
    v_client_nume VARCHAR2(50):= 'N1';
    v_nou_client_id NUMBER(3):= 500;
BEGIN
    <<secundar>>
    DECLARE
        v_client_id NUMBER(4) := 0;
        v_client_nume VARCHAR2(50) := 'N2';
        v_nou_client_id NUMBER(3) := 300;
        v_nou_client_nume VARCHAR2(50) := 'N3';
    BEGIN
        v_client_id:= v_nou_client_id;
        principal.v_client_nume:= v_client_nume ||' '|| v_nou_client_nume;
        DBMS_OUTPUT.PUT_LINE(V_CLIENT_ID);
        DBMS_OUTPUT.PUT_LINE(V_CLIENT_NUME);
        DBMS_OUTPUT.PUT_LINE(V_NOU_CLIENT_ID);
        DBMS_OUTPUT.PUT_LINE(V_NOU_CLIENT_NUME);
    END;
    v_client_id:= (v_client_id *12)/10;
    DBMS_OUTPUT.PUT_LINE('CLIENT ID ' || V_CLIENT_ID);
    DBMS_OUTPUT.PUT_LINE('CLIENT NUME ' || V_CLIENT_NUME);
END;
/

-- Ex. 4
DECLARE
    v_dep departments.department_name%TYPE;
BEGIN
    SELECT department_name
    INTO v_dep
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep);
END;
/

-- Ex. 5
VARIABLE rezultat VARCHAR2(35)

BEGIN
    SELECT department_name 
    INTO :rezultat
    FROM EMPLOYEES E, DEPARTMENTS D 
    WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
    GROUP BY DEPARTMENT_NAME
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                        FROM EMPLOYEES
                        GROUP BY DEPARTMENT_ID);
    DBMS_OUTPUT.PUT_LINE('DEPARTAMENTUL: ' || :rezultat);                        
END;
/
PRINT rezultat

-- Ex. 6
DECLARE
    v_dep departments.department_name%TYPE;
    v_dep_nr NUMBER(8);
BEGIN
    SELECT department_name, COUNT(*) 
    INTO v_dep, v_dep_nr
    FROM employees e, departments d
    WHERE e.department_id=d.department_id
    GROUP BY department_name
    HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                       FROM employees
                       GROUP BY department_id);
    DBMS_OUTPUT.PUT_LINE('Departamentul '|| v_dep || ' are ' || v_dep_nr || ' oameni.');
END;
/


-- Ex. 7
DECLARE 
    V_COD   EMPLOYEES.EMPLOYEE_ID%TYPE:=&P_COD;
    V_BONUS NUMBER(8);
    V_SALARIU_ANUAL NUMBER(8);
BEGIN 
    SELECT SALARY INTO V_SALARIU_ANUAL
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = V_COD;
    
    IF V_SALARIU_ANUAL >= 20001
        THEN V_BONUS:=2000;
    ELSIF V_SALARIU_ANUAL BETWEEN 10001 AND 20000
        THEN V_BONUS:=1000;
    ELSE V_BONUS:=500;
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || v_bonus);
END;
/

-- Ex. 8
DECLARE 
    V_COD EMPLOYEES.EMPLOYEE_ID%TYPE:=&P_COD;
    V_BONUS NUMBER(8);
    V_SALARIU_ANUAL NUMBER(8);
BEGIN
    SELECT salary INTO V_SALARIU_ANUAL
    FROM employees
    WHERE employee_id = V_COD; 
    
    CASE WHEN V_SALARIU_ANUAL >= 20001
        THEN V_BONUS:=2000;
        WHEN V_SALARIU_ANUAL <= 20000 AND V_SALARIU_ANUAL>=10001
        THEN V_BONUS := 1000;
        ELSE V_BONUS := 500;
    END CASE;
    DBMS_OUTPUT.PUT_LINE('Bonusul este ' || V_BONUS);
END;
/

-- Ex. 9

CREATE TABLE EMP_ACRO AS (SELECT * FROM EMPLOYEES);

SELECT *
FROM EMP_ACRO;

DEFINE p_cod_sal= 200
DEFINE p_cod_dept = 80
DEFINE p_procent =20
DECLARE
    v_cod_sal emp_acro.employee_id%TYPE:= &p_cod_sal;
    v_cod_dept emp_acro.department_id%TYPE:= &p_cod_dept;
    v_procent NUMBER(8):=&p_procent;

BEGIN
    UPDATE emp_acro
    SET department_id = v_cod_dept, salary=salary + (salary* v_procent/100)
    WHERE employee_id= v_cod_sal;

    IF SQL%ROWCOUNT =0 THEN
        DBMS_OUTPUT.PUT_LINE('Nu exista un angajat cu acest cod');
    ELSE DBMS_OUTPUT.PUT_LINE('Actualizare realizata');
    END IF;
END;
/

ROLLBACK;

-- Ex. 10 
CREATE TABLE ZILE_ACRO (
    ID NUMBER(8), 
    DATA DATE,
    NUME_ZI VARCHAR2(30),
    CONSTRAINT ID_PK PRIMARY KEY(ID)
);


DECLARE 
    CONTOR NUMBER(6):=-2;
    V_DATA DATE;
    MAXIM NUMBER(2) := LAST_DAY(SYSDATE) - SYSDATE;
BEGIN 
    LOOP 
        V_DATA := SYSDATE+CONTOR;
        INSERT INTO ZILE_ACRO
        VALUES (CONTOR, V_DATA, TO_CHAR(V_DATA, 'Day'));
        contor := contor + 1;
        EXIT WHEN CONTOR > MAXIM;
    END LOOP;
END;
/

-- Ex. 11
DECLARE
    contor NUMBER(6) := -5;
    v_data DATE;
    maxim NUMBER(6) := LAST_DAY(SYSDATE) - SYSDATE;

BEGIN
    WHILE contor <= maxim LOOP
        v_data := sysdate+contor;
        INSERT INTO zile_ACRO 
        VALUES (contor,v_data,to_char(v_data,'Day'));
        contor := contor + 1;
    END LOOP;
END;
/

-- Ex. 12
DECLARE
    v_data DATE;
    maxim NUMBER(2) := LAST_DAY(SYSDATE)-SYSDATE;
BEGIN
    FOR contor IN -2..maxim LOOP
        v_data := sysdate+contor;
        INSERT INTO zile_acro
        VALUES (contor,v_data,to_char(v_data,'Day'));
    END LOOP;
END;
/

-- Ex. 13
DECLARE
    i POSITIVE:=1;
    max_loop CONSTANT POSITIVE:=10;
    BEGIN
        LOOP
            i:=i+1;
            IF i>max_loop THEN
                DBMS_OUTPUT.PUT_LINE('in loop i=' || i);
                GOTO urmator;
            END IF;
        END LOOP;
        <<urmator>>
        i:=1;
        DBMS_OUTPUT.PUT_LINE('dupa loop i=' || i);
END;
/

DROP TABLE ZILE_ACRO;


SELECT *
FROM ZILE_ACRO;

SELECT *
FROM EMPLOYEES;

-- EXERCITII DE REZOLVAT

-- Ex. 1
DECLARE
    numar number(3):=100;
    mesaj1 varchar2(255):='text 1';
    mesaj2 varchar2(255):='text 2';
BEGIN
    DECLARE
        numar number(3):=1;
        mesaj1 varchar2(255):='text 2';
        mesaj2 varchar2(255):='text 3';
    BEGIN
        numar:=numar+1;
        DBMS_OUTPUT.PUT_LINE('VARIABILA NUMAR IN SUBBLOC: ' || numar);
        DBMS_OUTPUT.PUT_LINE('VARIABILA MESAJ1 IN SUBBLOC: ' || MESAJ1);
        DBMS_OUTPUT.PUT_LINE('VARIABILA MESAJ2 IN SUBBLOC: ' || MESAJ2);
        mesaj2:=mesaj2||' adaugat in sub-bloc';
    END;

    numar:=numar+1;
    mesaj1:=mesaj1||' adaugat un blocul principal';
    mesaj2:=mesaj2||' adaugat in blocul principal';
    
    DBMS_OUTPUT.PUT_LINE('VARIABILA NUMAR IN BLOC: ' || numar);
    DBMS_OUTPUT.PUT_LINE('VARIABILA MESAJ1 IN BLOC: ' || MESAJ1);
    DBMS_OUTPUT.PUT_LINE('VARIABILA MESAJ2 IN BLOC: ' || MESAJ2);
END;
/
-- 2, text 2, text 3, 101, text 1 adaugat in blocul principal, text 2 adaugata in blocul principal

-- Ex. 2
-- a) 
SELECT TO_CHAR(BOOK_DATE, 'DD'), COUNT(*)
FROM RENTAL
WHERE TO_CHAR(BOOK_DATE, 'MM') = 10
GROUP BY TO_CHAR(BOOK_DATE, 'DD')
ORDER BY TO_CHAR(BOOK_DATE, 'DD');

-- b) 
CREATE TABLE OCTOMBRIE_ACRO (
    ID NUMBER(8),
    DATA NUMBER(8),
    CONSTRAINT ID_OCT_PK PRIMARY KEY(ID)
);

BEGIN 
    FOR ZI IN 1..30 LOOP
        INSERT INTO OCTOMBRIE_ACRO VALUES (ZI, NULL);
    END LOOP;
    
    FOR ZI IN 1..30 LOOP
        UPDATE OCTOMBRIE_ACRO 
        SET DATA = (SELECT COUNT(*)
                    FROM RENTAL 
                    WHERE TO_CHAR(BOOK_DATE, 'MM') = 10 AND TO_CHAR(BOOK_DATE, 'DD') = ZI)
        WHERE ID = ZI;                    
    END LOOP;
END;
/

DROP TABLE OCTOMBRIE_ACRO;

SELECT *
FROM OCTOMBRIE_ACRO;

-- Ex. 3

DECLARE
    V_NUME MEMBER.LAST_NAME%TYPE:=&P_NUME;
    V_NUMAR_FILME NUMBER(8);
    V_NUMAR_PERSOANE NUMBER(8);
    V_TOTAL V_NUMAR_FILME%TYPE;
BEGIN
    SELECT COUNT(DISTINCT R.TITLE_ID) INTO V_NUMAR_FILME
    FROM RENTAL R, MEMBER_ACRO M
    WHERE M.LAST_NAME = V_NUME AND R.MEMBER_ID=M.MEMBER_ID;
    
    SELECT COUNT(*) INTO V_NUMAR_PERSOANE
    FROM MEMBER_ACRO M
    WHERE M.LAST_NAME = V_NUME;
    
    IF V_NUMAR_PERSOANE = 0
        THEN RAISE_APPLICATION_ERROR(-20001, 'Membrul nu exista!');
    ELSIF V_NUMAR_PERSOANE > 1
        THEN RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi membri cu acest nume');
    ELSE DBMS_OUTPUT.PUT_LINE(V_NUME || ' A IMPRUMUTAT ' || V_NUMAR_FILME || ' FILME.');
    END IF;
    
    SELECT COUNT(*) INTO V_TOTAL
    FROM TITLE;
    
    IF V_NUMAR_FILME > 0.75 * V_TOTAL
        THEN DBMS_OUTPUT.PUT_LINE('CATEGORIA 1');
    ELSIF V_NUMAR_FILME > 0.5 * V_TOTAL
        THEN DBMS_OUTPUT.PUT_LINE('CATEGORIA 2');
    ELSIF V_NUMAR_FILME > 0.25 * V_TOTAL
        THEN DBMS_OUTPUT.PUT_LINE('CATEGORIA 3');
    ELSE DBMS_OUTPUT.PUT_LINE('CATEGORIA 4');
    END IF;
    
END;
/
    
CREATE TABLE MEMBER_ACRO AS (SELECT *
                            FROM MEMBER
                            WHERE ROWNUM < 10);

SELECT *
FROM MEMBER_ACRO;
-- Ex. 5
ALTER TABLE MEMBER_ACRO
    ADD DISCOUNT NUMBER(8,2);
    
DECLARE
    V_NUME MEMBER.LAST_NAME%TYPE:=&P_NUME;
    V_NUMAR_FILME NUMBER(8);
    V_NUMAR_PERSOANE NUMBER(8);
    V_TOTAL V_NUMAR_FILME%TYPE;
    V_DISCOUNT MEMBER_ACRO.DISCOUNT%TYPE;
BEGIN
    SELECT COUNT(DISTINCT R.TITLE_ID) INTO V_NUMAR_FILME
    FROM RENTAL R, MEMBER_ACRO M
    WHERE M.LAST_NAME = V_NUME AND R.MEMBER_ID=M.MEMBER_ID;
    
    SELECT COUNT(*) INTO V_NUMAR_PERSOANE
    FROM MEMBER_ACRO M
    WHERE M.LAST_NAME = V_NUME;
    
    IF V_NUMAR_PERSOANE = 0
        THEN RAISE_APPLICATION_ERROR(-20001, 'Membrul nu exista!');
    ELSIF V_NUMAR_PERSOANE > 1
        THEN RAISE_APPLICATION_ERROR(-20002, 'Exista mai multi membri cu acest nume');
    ELSE DBMS_OUTPUT.PUT_LINE(V_NUME || ' A IMPRUMUTAT ' || V_NUMAR_FILME || ' FILME.');
    END IF;
    
    SELECT COUNT(*) INTO V_TOTAL
    FROM TITLE;
    
    IF V_NUMAR_FILME > 0.75 * V_TOTAL
        THEN V_DISCOUNT := 10;
    ELSIF V_NUMAR_FILME > 0.5 * V_TOTAL
        THEN V_DISCOUNT := 5;
    ELSIF V_NUMAR_FILME > 0.25 * V_TOTAL
        THEN V_DISCOUNT := 2.5;
    ELSE V_DISCOUNT := 0;
    END IF;
    
    UPDATE MEMBER_ACRO
    SET DISCOUNT = V_DISCOUNT
    WHERE LAST_NAME = V_NUME;
END;
/


SELECT *
FROM MEMBER_ACRO;

SET SERVEROUTPUT ON;
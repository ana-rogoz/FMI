-- EXERCITII REZOLVATE. 
-- Ex. 1
-- Functie locala
DECLARE
    v_nume employees.last_name%TYPE := '&p_nume';
    FUNCTION f1 RETURN NUMBER IS
        salariu employees.salary%type;
    BEGIN
        SELECT salary INTO salariu
        FROM employees
        WHERE last_name = v_nume;
        RETURN salariu;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '||'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
    END f1;
BEGIN 
    DBMS_OUTPUT.PUT_LINE('SALARIUL ESTE ' || f1);
END;
/

-- Ex. 2
-- Functie stocata
CREATE OR REPLACE FUNCTION f2_acro(v_nume employees.last_name%TYPE DEFAULT 'Bell')
RETURN NUMBER IS
        salariu employees.salary%type;
    BEGIN
        SELECT salary INTO salariu
        FROM employees
        WHERE last_name = v_nume;
        RETURN salariu;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000,'Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001,'Exista mai multi angajati cu numele dat');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END f2_acro;
/

BEGIN
DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2_acro);
END;
/
BEGIN
DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2_acro('King'));
END;
/

-- Ex. 3
-- Procedura locala
DECLARE
    v_nume employees.last_name%TYPE := Initcap('&p_nume');
    PROCEDURE p3
    IS
        salariu employees.salary%TYPE;
    BEGIN
        SELECT salary INTO salariu
        FROM
        employees
        WHERE last_name = v_nume;
        DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Exista mai multi angajati '||'cu numele dat');
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Alta eroare!');
END p3;

BEGIN
    p3;
END;
/

-- Ex. 4
-- Procedura stocata
CREATE OR REPLACE PROCEDURE p4_acro
    (v_nume employees.last_name%TYPE)
    IS
        salariu employees.salary%TYPE;
    BEGIN
        SELECT salary INTO salariu
        FROM
        employees
        WHERE last_name = v_nume;
        DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20000,'Nu exista angajati cu numele dat');
        WHEN TOO_MANY_ROWS THEN
            RAISE_APPLICATION_ERROR(-20001,'Exista mai multi angajati cu numele dat');
        WHEN OTHERS THEN
            RAISE_APPLICATION_ERROR(-20002,'Alta eroare!');
END p4_acro;
/
-- metode apelare
-- 1. Bloc PLSQL
BEGIN
p4_acro('Bell');
END;
/

-- Ex. 5
VARIABLE ANG_MAN NUMBER 
BEGIN 
    :ANG_MAN:=200;
END;
/

CREATE OR REPLACE PROCEDURE P5_ACRO (NR IN OUT NUMBER) IS -- NR E PARAMETRU SI DE INTRARE SI DE IESIRE 
BEGIN 
    SELECT MANAGER_ID INTO NR
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID=NR;
END P5_ACRO;
/

EXECUTE P5_ACRO(:ANG_MAN)
PRINT ANG_MAN

/ 
-- Ex. 6
DECLARE 
    NUME EMPLOYEES.LAST_NAME%TYPE;
    PROCEDURE P6_ACRO (REZULTAT OUT EMPLOYEES.LAST_NAME%TYPE, 
                        COMISION IN EMPLOYEES.COMMISSION_PCT%TYPE:=NULL,
                        COD IN EMPLOYEES.EMPLOYEE_ID%TYPE:=NULL) IS
    BEGIN 
    IF (COMISION IS NOT NULL) THEN 
        SELECT LAST_NAME INTO REZULTAT
        FROM EMPLOYEES
        WHERE COMMISSION_PCT = COMISION;
        DBMS_OUTPUT.PUT_LINE('NUMELE SALARIATULUI CARE ARE COM ' || REZULTAT);
    ELSE 
        SELECT LAST_NAME 
        INTO REZULTAT
        FROM EMPLOYEES
        WHERE EMPLOYEE_ID = COD;
        DBMS_OUTPUT.PUT_LINE('NUMELE SALARIATULUI AVAND CODUL ' || REZULTAT);
    END IF;
    END P6_ACRO; 
BEGIN
    P6_ACRO(NUME, 0.4);
    P6_ACRO(NUME, COD=>104); -- PASEAZA VALOAREA VARIABILEI COD
END;
/

-- Ex. 7
DECLARE 
    MEDIE1 NUMBER(10,2);
    MEDIE2 NUMBER(10, 2);
    FUNCTION MEDIE (V_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE)
        RETURN NUMBER IS REZULTAT NUMBER(10,2);
    BEGIN 
        SELECT AVG(SALARY)
        INTO REZULTAT
        FROM EMP_ACRO
        WHERE DEPARTMENT_ID=V_DEPT;
        RETURN REZULTAT;
    END;
    
    FUNCTION MEDIE (V_DEPT EMPLOYEES.DEPARTMENT_ID%TYPE,
                    V_JOB EMPLOYEES.JOB_ID%TYPE)
        RETURN NUMBER IS REZULTAT NUMBER(10,2);
    BEGIN 
        SELECT AVG(SALARY)
        INTO REZULTAT
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID=V_DEPT AND JOB_ID=V_JOB;
        RETURN REZULTAT;
    END;
    
BEGIN
    MEDIE1 := MEDIE(80);
    DBMS_OUTPUT.PUT_LINE('MEDIA SALARIILOR DIN DEPARTAMENTUL 80 ESTE ' || MEDIE1);
    
    MEDIE2 := MEDIE(80, 'SA_MAN');
    DBMS_OUTPUT.PUT_LINE('MEDIA SALARIILOR DIN DEPARTAMENTUL 80 AVAND FUNCTIA SA_MAN ESTE ' || MEDIE2);

END;
/

-- Ex. 8
CREATE OR REPLACE FUNCTION FACTORIAL_ACRO (N NUMBER)
    RETURN INTEGER IS
    
    BEGIN 
        IF(N=0) THEN RETURN 1;
        ELSE RETURN N*FACTORIAL_ACRO(N-1);
        END IF;
END FACTORIAL_ACRO;
/

DECLARE 
VAR NUMBER:=NULL;
BEGIN 
    VAR := FACTORIAL_ACRO(5);
    DBMS_OUTPUT.PUT_LINE('CEVA ' || VAR);
END;
/

-- Ex. 9
CREATE OR REPLACE FUNCTION MEDIE_ACRO
RETURN NUMBER 
IS
REZULTAT NUMBER;
BEGIN 
    SELECT AVG(SALARY) INTO REZULTAT
    FROM EMPLOYEES;
    RETURN REZULTAT;
END;
/

SELECT LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= MEDIE_ACRO;

-- EXERCITII DE REZOLVAT. 

CREATE TABLE INFO_ACRO (
    UTILIZATOR VARCHAR(20),
    DATA DATE,
    COMANDA VARCHAR(40),
    NR_LINII NUMBER(8),
    EROARE VARCHAR(100)
);

drop table info_acro;

-- functie stocata
CREATE OR REPLACE FUNCTION f2_rez_acro(v_nume employees.last_name%TYPE DEFAULT 'Bell')
RETURN NUMBER IS
        salariu employees.salary%type:=0;
    BEGIN
        SELECT salary INTO salariu
        FROM employees
        WHERE last_name = v_nume;
        RETURN salariu;
END f2_rez_acro;
/

-- !!!! nu poti face insert in functie daca iese pe o exceptie! 
DECLARE 
    V_USER VARCHAR(20);
BEGIN
    SELECT USER
    INTO V_USER
    FROM DUAL;
    
    DBMS_OUTPUT.PUT_LINE('Salariul este '|| f2_rez_acro('King'));
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'F1_REZ_ACRO', 0, 'NU EXISTA ANGAJATI CU NUMELE DAT');
        WHEN TOO_MANY_ROWS THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'F1_REZ_ACRO', 0, 'Exista mai multi angajati');
        WHEN OTHERS THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'F1_REZ_ACRO', 0, 'ALTA EROARE');
END;
/

-- procedura stocata; 
CREATE OR REPLACE PROCEDURE p4_REZ_acro
    (v_nume employees.last_name%TYPE)
    IS
        salariu employees.salary%TYPE;
    BEGIN
        SELECT salary INTO salariu
        FROM
        employees
        WHERE last_name = v_nume;
        DBMS_OUTPUT.PUT_LINE('Salariul este '|| salariu);
END p4_REZ_acro;
/

DECLARE 
    V_USER VARCHAR(20);
BEGIN
    SELECT USER
    INTO V_USER
    FROM DUAL;
    P4_REZ_ACRO('King');
    
    INSERT INTO INFO_ACRO VALUES (
        V_USER, SYSDATE, 'p4_REZ_ACRO', 0, 'NICIO EROARE');
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'p4_REZ_ACRO', 0, 'NU EXISTA ANGAJATI CU NUMELE DAT');
        WHEN TOO_MANY_ROWS THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'p4_REZ_ACRO', 0, 'Exista mai multi angajati');
        WHEN OTHERS THEN
            INSERT INTO INFO_ACRO VALUES (
                V_USER, SYSDATE, 'p4_REZ_ACRO', 0, 'ALTA EROARE');
END;
/    

-- Ex. 3
CREATE OR REPLACE FUNCTION F3_REZ_ACRO(ORAS LOCATIONS.CITY%TYPE)
    RETURN NUMBER IS NUMARATOR NUMBER;
    
    BEGIN
    
    SELECT COUNT(*) INTO NUMARATOR
    FROM EMPLOYEES E, LOCATIONS L, DEPARTMENTS D, JOB_HISTORY J
    WHERE E.EMPLOYEE_ID=J.EMPLOYEE_ID AND E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID = L.LOCATION_ID 
    GROUP BY L.CITY
    HAVING L.CITY = ORAS AND COUNT(J.EMPLOYEE_ID)>=2;

    RETURN NUMARATOR;
END F3_REZ_ACRO;
/

DECLARE 
    V_ORAS LOCATIONS.CITY%TYPE:='&P_ORAS';
    V_EXISTS NUMBER(1) := 0;
    V_EXISTS_EMPLOYEES NUMBER(1) := 0;
BEGIN
    -- VERIFICAM DACA EXISTA ORASUL;
    SELECT COUNT(*)
    INTO v_exists
    FROM locations
    WHERE city = v_oras;
    
    -- VERIFICAM DACA ANGAJATUL LUCREAZA SI IN PREZENT. 
    SELECT COUNT(*)
    INTO v_exists_employees
    FROM locations l, departments d
    WHERE l.location_id = d.location_id AND l.city = v_oras;
    
    IF v_exists != 0 AND v_exists_employees != 0 THEN
        DBMS_OUTPUT.PUT_LINE(f3_rez_acro(v_oras));
        INSERT INTO INFO_ACRO VALUES (USER, SYSDATE, 'F3_REZ_ACRO', 1, 'Nicio eroare. - 1');
    elsif v_exists = 0 then 
        INSERT INTO INFO_ACRO VALUES (user, SYSDATE, 'F3_REZ_ACRO', 0, 'Orasul nu exista!');
    else INSERT INTO INFO_ACRO VALUES (user, SYSDATE, 'F3_REZ_ACRO', 0, 'Nu lucreaza niciun angajat curent acolo!');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO INFO_ACRO VALUES (USER, SYSDATE, 'F3_REZ_ACRO', 0, 'No data found - 2.');
    WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('ALTA EROARE');
END;
/        

-- Ex. 4
-- nu pot face insert daca dau raise application error!!!
CREATE OR REPLACE PROCEDURE P4_REZ_ACRO(SEF EMPLOYEES.EMPLOYEE_ID%TYPE)
AS 
    MANAGER NUMBER:=0;
    NR_SUBORDONATI NUMBER:=0;
    TYPE TABLOU_SUBORDONATI IS TABLE OF NUMBER;
    SUBORDONATI TABLOU_SUBORDONATI;
BEGIN 

    SELECT COUNT(EMPLOYEE_ID) INTO MANAGER
    FROM EMPLOYEES
    WHERE EMPLOYEE_ID = SEF;
    
    IF MANAGER = 0 THEN 
        -- INSERT INTO INFO_ACRO VALUES (USER, SYSDATE, 'P4_REZ_ACRO', 0, 'NU EXISTA MANAGERUL');
        RAISE_APPLICATION_ERROR(-20001, 'MANAGERUL NU EXISTA');
    END IF;
    
    SELECT COUNT(MANAGER_ID) INTO NR_SUBORDONATI
    FROM EMPLOYEES
    WHERE MANAGER_ID=SEF;
    
    IF NR_SUBORDONATI = 0 THEN 
        -- INSERT INTO INFO_ACRO VALUES (USER, SYSDATE, 'P4_REZ_ACRO', 0, 'MANAGERUL NU ARE SUBORDONATI');
        RAISE_APPLICATION_ERROR(-20002, 'MANAGERUL NU ARE SUBORDONATI');    
    END IF;

    SELECT EMPLOYEE_ID BULK COLLECT INTO SUBORDONATI 
    FROM EMP_ACRO
    START WITH EMPLOYEE_ID=SEF
    CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID;

    FOR I IN SUBORDONATI.FIRST..SUBORDONATI.LAST LOOP
        UPDATE EMP_ACRO
        SET SALARY = SALARY * 1.1
        WHERE EMPLOYEE_ID = SUBORDONATI(I);
    END LOOP;
END P4_REZ_ACRO;
/

EXECUTE P4_REZ_ACRO(2000);
select *
from info_acro;


SET SERVEROUTPUT ON;

SELECT *
FROM EMPLOYEES;
/


-- EXERCITII REZOLVATE.
-- Ex. 1
CREATE OR REPLACE PACKAGE PACHET1_ACRO AS
    FUNCTION F_NUMAR(V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER;
    FUNCTION F_SUMA(V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER;
END PACHET1_ACRO;
/

CREATE OR REPLACE PACKAGE BODY PACHET1_ACRO AS 
    FUNCTION F_NUMAR(V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER IS NUMAR NUMBER;
    BEGIN 
        SELECT COUNT(*) INTO NUMAR
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID=V_DEPT;
        
        RETURN NUMAR;
    END F_NUMAR;
    
    FUNCTION F_SUMA(V_DEPT DEPARTMENTS.DEPARTMENT_ID%TYPE)
        RETURN NUMBER IS NUMAR NUMBER;
    BEGIN 
        SELECT SUM(SALARY+SALARY*NVL(COMMISSION_PCT, 0)) INTO NUMAR
        FROM EMPLOYEES
        WHERE DEPARTMENT_ID=V_DEPT;
        RETURN NUMAR;
    END F_SUMA;
END PACHET1_ACRO;
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('NUMARUL DE SALARIATI ESTE ' || PACHET1_ACRO.F_NUMAR(80));
    DBMS_OUTPUT.PUT_LINE('SUMA SALARIILOR ESTE ' || PACHET1_ACRO.F_SUMA(80));
END;
/

-- Ex. 2
CREATE TABLE DEPT_ACRO AS SELECT * FROM DEPARTMENTS;

CREATE OR REPLACE PACKAGE PACHET2_ACRO AS
    PROCEDURE P_DEPT(V_CODD DEPT_ACRO.DEPARTMENT_ID%TYPE,
                     V_NUME DEPT_ACRO.DEPARTMENT_NAME%TYPE,
                     V_MANAGER DEPT_ACRO.MANAGER_ID%TYPE,
                     V_LOC DEPT_ACRO.LOCATION_ID%TYPE);
                     
    PROCEDURE P_EMP(v_first_name emp_ACRO.first_name%TYPE,
                    v_last_name emp_ACRO.last_name%TYPE,
                    v_email emp_ACRO.email%TYPE,
                    v_phone_number emp_ACRO.phone_number%TYPE:=NULL,
                    v_hire_date emp_ACRO.hire_date%TYPE :=SYSDATE,
                    v_job_id emp_ACRO.job_id%TYPE,
                    v_salary emp_ACRO.salary%TYPE :=0,
                    v_commission_pct emp_ACRO.commission_pct%TYPE:=0,
                    v_manager_id emp_ACRO.manager_id%TYPE,
                    v_department_id emp_ACRO.department_id%TYPE);
                    
    FUNCTION EXISTA (COD_LOC DEPT_ACRO.LOCATION_ID%TYPE,
                     MANAGER DEPT_ACRO.MANAGER_ID%TYPE)
    RETURN NUMBER;
    
END PACHET2_ACRO;
/

CREATE OR REPLACE PACKAGE BODY PACHET2_ACRO AS 
    FUNCTION EXISTA (COD_LOC DEPT_ACRO.LOCATION_ID%TYPE, 
                    MANAGER DEPT_ACRO.MANAGER_ID%TYPE)
    RETURN NUMBER IS 
        REZULTAT NUMBER := 1;
        REZ_COD_LOC NUMBER;
        REZ_MANAGER NUMBER;
    BEGIN 
        SELECT COUNT(*) INTO REZ_COD_LOC
        FROM LOCATIONS
        WHERE LOCATION_ID = COD_LOC;
        
        SELECT COUNT(*) INTO REZ_MANAGER
        FROM EMP_ACRO
        WHERE EMPLOYEE_ID = MANAGER;
        
        IF REZ_COD_LOC=0 OR REZ_MANAGER=0 THEN REZULTAT := 0;
        END IF;
        
        RETURN REZULTAT;        
    END EXISTA;
    
    PROCEDURE p_dept(v_codd dept_ACRO.department_id%TYPE,
                     v_nume dept_ACRO.department_name%TYPE,
                     v_manager dept_ACRO.manager_id%TYPE,
                     v_loc dept_ACRO. location_id%TYPE) IS
    BEGIN
        IF exista(v_loc, v_manager)=0 THEN
            DBMS_OUTPUT.PUT_LINE('Nu s-au introdus date coerente pentru tabelul dept_ACRO');
        ELSE
            INSERT INTO dept_ACRO (department_id,department_name,manager_id,location_id)
            VALUES (v_codd, v_nume, v_manager, v_loc);
        END IF;
    END p_dept;

    PROCEDURE p_emp
                    (v_first_name emp_ACRO.first_name%TYPE,
                    v_last_name emp_ACRO.last_name%TYPE,
                    v_email emp_ACRO.email%TYPE,
                    v_phone_number emp_ACRO.phone_number%TYPE:=null,
                    v_hire_date emp_ACRO.hire_date%TYPE :=SYSDATE,
                    v_job_id emp_ACRO.job_id%TYPE,
                    v_salary emp_ACRO.salary %TYPE :=0,        
                    v_commission_pct emp_ACRO.commission_pct%TYPE:=0,
                    v_manager_id emp_ACRO.manager_id%TYPE,
                    v_department_id emp_ACRO.department_id%TYPE)
                    IS
    BEGIN
        INSERT INTO emp_ACRO
        VALUES (1000, v_first_name, v_last_name, v_email,
        v_phone_number,v_hire_date, v_job_id, v_salary,
        v_commission_pct, v_manager_id,v_department_id);
    END p_emp;

END PACHET2_ACRO;
/
BEGIN
    pachet2_ACRO.p_dept(50,'Economic',99,2000);
    pachet2_ACRO.p_emp('f','l','e',v_job_id=>'j',v_manager_id=>200,
    v_department_id=>50);
END;
/
SELECT * FROM emp_ACRO WHERE job_id='j';
ROLLBACK;

-- Ex. 3
CREATE OR REPLACE PACKAGE PACHET3_ACRO AS 
    CURSOR C_EMP(NR NUMBER) RETURN EMPLOYEES%ROWTYPE;
    FUNCTION F_MAX (V_ORAS LOCATIONS.CITY%TYPE) RETURN NUMBER;
END PACHET3_ACRO;
/

CREATE OR REPLACE PACKAGE BODY PACHET3_ACRO AS 

    CURSOR C_EMP(NR NUMBER) RETURN EMPLOYEES%ROWTYPE 
        IS 
        SELECT *
        FROM EMPLOYEES
        WHERE SALARY >= NR;
    
    FUNCTION F_MAX (V_ORAS LOCATIONS.CITY%TYPE) 
        RETURN NUMBER IS MAXIM NUMBER;
    BEGIN 
        SELECT MAX(SALARY)
        INTO MAXIM
        FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
        WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND D.LOCATION_ID = L.LOCATION_ID AND L.CITY = V_ORAS;
        
        RETURN MAXIM;
    END F_MAX;
END PACHET3_ACRO;
/

DECLARE 
    ORAS LOCATIONS.CITY%TYPE:='Toronto';
    val_max NUMBER;
    lista employees%ROWTYPE;
    BEGIN
        val_max:= pachet3_acro.f_max(oras);
    FOR v_cursor IN pachet3_acro.c_emp(val_max) LOOP
        DBMS_OUTPUT.PUT_LINE(v_cursor.last_name||' '||v_cursor.salary);
    END LOOP;
END;
/

-- Ex. 6
CREATE OR REPLACE PACKAGE pachet4_acro IS
    PROCEDURE p_verific(v_cod employees.employee_id%TYPE,
                        v_job employees.job_id%TYPE);
    
    CURSOR c_emp IS SELECT * FROM EMPLOYEES;
END pachet4_acro;
/

CREATE OR REPLACE PACKAGE BODY PACHET4_ACRO IS

   /* CURSOR C_EMP RETURN EMPLOYEES%ROWTYPE IS -- PUN AICI TIPUL INTORS EMPLOYEES%ROWTYPE PENTRU CA IN DECLARATIA AM SCRIS ASA;
        SELECT *                            -- DACA SCRIAM CORPUL CURSORULUI DIN DECLARATIE PUTEAM FARA RETURN
        FROM EMPLOYEES;
   */
   PROCEDURE p_verific(v_cod employees.employee_id%TYPE,
                       v_job employees.job_id%TYPE)
    IS
        gasit BOOLEAN:=FALSE;
        lista employees%ROWTYPE;
    BEGIN
        OPEN c_emp;
        LOOP
            FETCH c_emp INTO lista;
            EXIT WHEN c_emp%NOTFOUND;
            
            IF lista.employee_id=v_cod AND lista.job_id=v_job
            THEN gasit:=TRUE;
            END IF;
        END LOOP;
        CLOSE c_emp;
        
        IF gasit=TRUE THEN
            DBMS_OUTPUT.PUT_LINE('combinatia data exista');
        ELSE
            DBMS_OUTPUT.PUT_LINE('combinatia data nu exista');
        END IF;
    END p_verific;
    
        
END PACHET4_ACRO;
/

EXECUTE PACHET4_ACRO.P_VERIFIC(200, 'AD_ASST');

-- EXERCITII DE REZOLVAT
CREATE OR REPLACE PACKAGE PACHET1_REZ AS
    -- A)
    PROCEDURE P_ADAUG(NUME EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME EMPLOYEES.FIRST_NAME%TYPE,
                                        TELEFON EMPLOYEES.PHONE_NUMBER%TYPE,
                                        EMAIL EMPLOYEES.EMAIL%TYPE,
                                        NUME_JOB JOBS.JOB_TITLE%TYPE, 
                                        NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE,
                                        NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE);
    
    FUNCTION F_COD_JOB(NUME_JOB JOBS.JOB_TITLE%TYPE)
        RETURN EMPLOYEES.JOB_ID%TYPE;
    
    FUNCTION F_COD_MANAGER(NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                           PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE)
        RETURN EMPLOYEES.EMPLOYEE_ID%TYPE;                                    

    FUNCTION F_COD_DEPARTAMENT(NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
        RETURN EMPLOYEES.DEPARTMENT_ID%TYPE;
                                            
    -- C)
    FUNCTION F_NR_SUBALT(NUME EMPLOYEES.LAST_NAME%TYPE,
                        PRENUME EMPLOYEES.FIRST_NAME%TYPE)
        RETURN NUMBER;                        
    -- F)
    CURSOR C_LISTA_JOB(COD_JOB EMPLOYEES.JOB_ID%TYPE) RETURN EMPLOYEES%ROWTYPE;
    -- E)
    CURSOR C_LISTA_JOBURI_COMPANIE IS
        SELECT DISTINCT JOB_ID 
        FROM EMPLOYEES;
END PACHET1_REZ;
/

CREATE OR REPLACE PACKAGE BODY PACHET1_REZ AS 
    -- CURSOARELE SE DECLARA LA INCEPUT!!!
    CURSOR C_LISTA_JOB(COD_JOB EMPLOYEES.JOB_ID%TYPE) RETURN EMPLOYEES%ROWTYPE IS
        SELECT * 
        FROM EMPLOYEES 
        WHERE COD_JOB = JOB_ID;
        
    PROCEDURE P_ADAUG(NUME EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME EMPLOYEES.FIRST_NAME%TYPE,
                                        TELEFON EMPLOYEES.PHONE_NUMBER%TYPE,
                                        EMAIL EMPLOYEES.EMAIL%TYPE,
                                        NUME_JOB JOBS.JOB_TITLE%TYPE, 
                                        NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                                        PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE,
                                        NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
    IS 
        COD_JOB EMPLOYEES.JOB_ID%TYPE;
        COD_DEPARTAMENT EMPLOYEES.DEPARTMENT_ID%TYPE;
        COD_MANAGER EMPLOYEES.EMPLOYEE_ID%TYPE;
        SALARIU EMPLOYEES.SALARY%TYPE:=0;
    BEGIN 
        COD_JOB := F_COD_JOB(NUME_JOB);
        COD_DEPARTAMENT := F_COD_DEPARTAMENT(NUME_DEPARTAMENT);
        COD_MANAGER := F_COD_MANAGER(NUME_MANAGER, PRENUME_MANAGER);
        
        SELECT MIN(SALARY) INTO SALARIU
        FROM EMP_ACRO
        WHERE JOB_ID = COD_JOB AND DEPARTMENT_ID = COD_DEPARTAMENT;
        
        INSERT INTO EMP_ACRO VALUES (302, NUME, PRENUME, EMAIL, TELEFON, 
                                     SYSDATE, COD_JOB, SALARIU, NULL, 
                                     COD_MANAGER, COD_DEPARTAMENT);
    END P_ADAUG;
    
    FUNCTION F_COD_JOB(NUME_JOB JOBS.JOB_TITLE%TYPE)
        RETURN EMPLOYEES.JOB_ID%TYPE IS COD_JOB EMPLOYEES.JOB_ID%TYPE:='nimic'; 
    BEGIN 
        SELECT JOB_ID INTO COD_JOB
        FROM JOBS
        WHERE JOB_TITLE = NUME_JOB;
        
        IF COD_JOB = 'nimic' THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE JOBULUI NU EXISTA');
        END IF;
        RETURN COD_JOB;
    END F_COD_JOB;

    FUNCTION F_COD_MANAGER(NUME_MANAGER EMPLOYEES.LAST_NAME%TYPE,
                           PRENUME_MANAGER EMPLOYEES.FIRST_NAME%TYPE)
        RETURN EMPLOYEES.EMPLOYEE_ID%TYPE IS COD_MANAGER EMPLOYEES.EMPLOYEE_ID%TYPE:=0;
    BEGIN
        SELECT EMPLOYEE_ID INTO COD_MANAGER
        FROM EMPLOYEES
        WHERE LAST_NAME = NUME_MANAGER AND FIRST_NAME = PRENUME_MANAGER;
        
        IF COD_MANAGER = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE MANAGERULUI NU EXISTA');
        END IF;
        RETURN COD_MANAGER;
    END F_COD_MANAGER;

    FUNCTION F_COD_DEPARTAMENT(NUME_DEPARTAMENT DEPARTMENTS.DEPARTMENT_NAME%TYPE)
        RETURN EMPLOYEES.DEPARTMENT_ID%TYPE IS COD_DEPARTAMENT EMPLOYEES.DEPARTMENT_ID%TYPE:=0; 
    BEGIN 
        SELECT DEPARTMENT_ID INTO COD_DEPARTAMENT
        FROM DEPARTMENTS
        WHERE DEPARTMENT_NAME = NUME_DEPARTAMENT;
        
        IF COD_DEPARTAMENT = 0 THEN
            RAISE_APPLICATION_ERROR(-20001, 'NUMELE DEPARTAMENTULUI NU EXISTA');
        END IF;
        RETURN COD_DEPARTAMENT;
    END F_COD_DEPARTAMENT;
    
    FUNCTION F_NR_SUBALT(NUME EMPLOYEES.LAST_NAME%TYPE,
                        PRENUME EMPLOYEES.FIRST_NAME%TYPE)
        RETURN NUMBER IS 
            NUMARATOR NUMBER:=0;
            COD_SEF EMPLOYEES.EMPLOYEE_ID%TYPE;
    BEGIN 
        COD_SEF := F_COD_MANAGER(NUME, PRENUME);

        DBMS_OUTPUT.PUT_LINE(COD_SEF);
        SELECT COUNT(*) INTO NUMARATOR
        FROM EMPLOYEES
        START WITH EMPLOYEE_ID = COD_SEF
        CONNECT BY PRIOR EMPLOYEE_ID=MANAGER_ID;

        RETURN NUMARATOR;        
    END F_NR_SUBALT;
        
END PACHET1_REZ;
/

BEGIN
    PACHET1_REZ.P_ADAUG('ROGOZ', 'ANA', 'bb','aa', 'Programmer', 'Ernst', 'Bruce', 'IT');
END;
/

DECLARE 
    NR NUMBER;
BEGIN
    NR := PACHET1_REZ.F_NR_SUBALT('Kochhar', 'Neena');
    DBMS_OUTPUT.PUT_LINE('Kochhar Neena ' || NR);
END;
/

BEGIN 
    FOR V_CURSOR IN PACHET1_REZ.C_LISTA_JOB('IT_PROG') LOOP
        DBMS_OUTPUT.PUT_LINE(V_CURSOR.LAST_NAME || ' ' || V_CURSOR.FIRST_NAME);
    END LOOP;
END;
/

BEGIN 
    FOR V_CURSOR IN PACHET1_REZ.C_LISTA_JOBURI_COMPANIE LOOP
        DBMS_OUTPUT.PUT_LINE(V_CURSOR.JOB_ID);
    END LOOP;
END;
/
SELECT * FROM EMP_ACRO;
SET SERVEROUTPUT ON;
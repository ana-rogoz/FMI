-- EXERCITII REZOLVATE.

-- Ex. 1
DECLARE
    v_nr number(4);
    v_nume departments.department_name%TYPE;
    CURSOR c IS
                SELECT department_name nume, COUNT(employee_id) nr
                FROM departments d, employees e
                WHERE d.department_id=e.department_id(+)
                GROUP BY department_name;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_nume,v_nr;
        EXIT WHEN c%NOTFOUND;
        
        IF v_nr=0 THEN
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||' nu lucreaza angajati');
        ELSIF v_nr=1 THEN
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||' lucreaza un angajat');
        ELSE
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||' lucreaza '|| v_nr||' angajati');
        END IF;
    END LOOP;
    CLOSE c;
END;
/

-- Ex. 2
DECLARE
    TYPE tab_nume IS TABLE OF departments.department_name%TYPE;
    TYPE tab_nr IS TABLE OF NUMBER(4);
    t_nr tab_nr;
    t_nume tab_nume;
    CURSOR c IS
                SELECT department_name nume, COUNT(employee_id) nr
                FROM departments d, employees e
                WHERE d.department_id=e.department_id(+)
                GROUP BY department_name;
BEGIN
    OPEN c;
    FETCH c BULK COLLECT INTO t_nume, t_nr;
    CLOSE c;

    FOR i IN t_nume.FIRST..t_nume.LAST LOOP
        IF t_nr(i)=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||' nu lucreaza angajati');
        ELSIF t_nr(i)=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '||t_nume(i)||' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| t_nume(i)||' lucreaza '|| t_nr(i)||' angajati');
        END IF;
    END LOOP;
END;
/

-- Ex. 3
DECLARE
    CURSOR c IS
        SELECT department_name nume, COUNT(employee_id) nr
        FROM
        departments d, employees e
        WHERE d.department_id=e.department_id(+)
        GROUP BY department_name;
BEGIN
    FOR i in c LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||' nu lucreaza angajati');
        ELSIF i.nr=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume ||' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||' lucreaza '|| i.nr||' angajati');
        END IF;
    END LOOP;
END;
/

-- Ex. 4
BEGIN
    FOR i in (SELECT department_name nume, COUNT(employee_id) nr
              FROM departments d, employees e
              WHERE d.department_id=e.department_id(+)
              GROUP BY department_name) LOOP
        IF i.nr=0 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||' nu lucreaza angajati');
        ELSIF i.nr=1 THEN
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume ||' lucreaza un angajat');
        ELSE
            DBMS_OUTPUT.PUT_LINE('In departamentul '|| i.nume||' lucreaza '|| i.nr||' angajati');
        END IF;
    END LOOP;
END;
/

-- Ex. 5
DECLARE
    v_cod  employees.employee_id%TYPE;
    v_nume employees.last_name%TYPE;
    v_nr NUMBER(4); 
    CURSOR c IS SELECT sef.employee_id cod, MAX(sef.last_name) nume, count(*) nr
                FROM employees sef, employees ang
                WHERE ang.manager_id = sef.employee_id
                GROUP BY sef.employee_id
                ORDER BY nr DESC;
BEGIN
    OPEN c;
    LOOP
        FETCH c INTO v_cod,v_nume,v_nr;
        EXIT WHEN c%ROWCOUNT>3 OR c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Managerul '|| v_cod ||' avand numele ' || v_nume ||' conduce ' || v_nr||' angajati');
    END LOOP;
    CLOSE c;
END;
/
-- Ex. 6
DECLARE
    CURSOR c IS
        SELECT sef.employee_id cod, MAX(sef.last_name) nume, count(*) nr
        FROM employees sef, employees ang
        WHERE ang.manager_id = sef.employee_id
        GROUP BY sef.employee_id
        ORDER BY nr DESC;
BEGIN
    FOR i IN c LOOP
        EXIT WHEN c%ROWCOUNT>3 OR c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Managerul '|| i.cod ||' avand numele ' || i.nume ||' conduce '|| i.nr||' angajati');
    END LOOP;
END;
/

-- Ex. 7
DECLARE
    top number(1):= 0;
BEGIN
    FOR i IN (SELECT sef.employee_id cod, MAX(sef.last_name) nume, count(*) nr
    FROM employees sef, employees ang
    WHERE ang.manager_id = sef.employee_id
    GROUP BY sef.employee_id
    ORDER BY nr DESC)
    LOOP
        DBMS_OUTPUT.PUT_LINE('Managerul '|| i.cod ||' avand numele ' || i.nume ||' conduce '|| i.nr||' angajati');
        Top := top+1;
        EXIT WHEN top=3;
    END LOOP;
END;
/

-- Ex. 8
DECLARE
    v_x number(4) := &p_x;
    v_nr number(4);
    v_nume departments.department_name%TYPE;
    CURSOR c (paramentru NUMBER) IS
                                    SELECT department_name nume, COUNT(employee_id) nr
                                    FROM
                                    departments d, employees e
                                    WHERE d.department_id=e.department_id
                                    GROUP BY department_name
                                    HAVING COUNT(employee_id)> paramentru;


BEGIN
    OPEN c(v_x);
    LOOP
        FETCH c INTO v_nume,v_nr;
        EXIT WHEN c%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('In departamentul '|| v_nume||' lucreaza '|| v_nr||' angajati');
    END LOOP;
    CLOSE c;
END;
/

-- Ex. 9
DECLARE
    CURSOR c IS
        SELECT *
        FROM emp_acro
        WHERE TO_CHAR(hire_date, 'YYYY') = 2000
        FOR UPDATE OF salary NOWAIT;
BEGIN
    FOR i IN c LOOP
        UPDATE emp_acro
        SET salary= salary+1000
        WHERE CURRENT OF c;
    END LOOP;
END;
/

SELECT last_name, hire_date, salary
FROM
emp_acro
WHERE TO_CHAR(hire_date, 'yyyy') = 2000;

ROLLBACK;
SELECT sef.employee_id cod, MAX(sef.last_name) nume, count(*) nr
FROM employees sef, employees ang
WHERE ang.manager_id = sef.employee_id
GROUP BY sef.employee_id
ORDER BY nr DESC;
    
    
-- Ex. 10
BEGIN
    FOR v_dept IN (SELECT department_id, department_name
                    FROM
                    departments
                    WHERE department_id IN (10,20,30,40)) LOOP
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||v_dept.department_name);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR v_emp IN (SELECT last_name
                    FROM
                    employees
                    WHERE department_id = v_dept.department_id) LOOP
            DBMS_OUTPUT.PUT_LINE (v_emp.last_name);
        END LOOP;
    END LOOP;
END;
/

-- Ex. 11
DECLARE
    TYPE emp_tip IS REF CURSOR;
    v_emp emp_tip;
    v_optiune NUMBER := &p_optiune;
    v_ang employees%ROWTYPE;
BEGIN
    IF v_optiune = 1 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees;
    ELSIF v_optiune = 2 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees
                       WHERE salary BETWEEN 10000 AND 20000;
    ELSIF v_optiune = 3 THEN
        OPEN v_emp FOR SELECT *
                       FROM employees
                       WHERE TO_CHAR(hire_date, 'YYYY') = 2000;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Optiune incorecta');
    END IF;
    
    LOOP
        FETCH v_emp into v_ang;
        EXIT WHEN v_emp%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_ang.last_name);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Au fost procesate '||v_emp%ROWCOUNT|| ' linii');
    CLOSE v_emp;
END;
/

-- EXERCITII DE REZOLVAT. 
-- Ex. 1
-- a) CURSOARE CLASICE
DECLARE 
    CURSOR JOBURI IS SELECT JOB_ID, JOB_TITLE
                FROM JOBS;
    CURSOR ANGAJATI IS SELECT LAST_NAME, SALARY, JOB_ID
                       FROM EMP_ACRO;
    v_job_id1 JOBS.JOB_ID%TYPE;
    V_JOB_ID2 EMPLOYEES.JOB_ID%TYPE;
    V_JOB_TITLE JOBS.JOB_TITLE%TYPE;
    V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    V_SALARY EMPLOYEES.SALARY%TYPE;
BEGIN
    OPEN JOBURI;
        LOOP
            FETCH JOBURI INTO V_JOB_ID1, V_JOB_TITLE;
            EXIT WHEN JOBURI%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||v_JOB_TITLE);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            
            OPEN ANGAJATI;
                LOOP
                    FETCH ANGAJATI INTO V_LAST_NAME, V_SALARY,  V_JOB_ID2;
                    EXIT WHEN ANGAJATI%NOTFOUND;
                    IF V_JOB_ID1 = V_JOB_ID2
                        THEN DBMS_OUTPUT.PUT_LINE(V_LAST_NAME || ' ' || TO_CHAR(V_SALARY));
                    END IF;
                END LOOP;
            CLOSE ANGAJATI;
        END LOOP;
    CLOSE JOBURI;
END;
/
-- b) CICLU CURSOARE 
DECLARE 
    CURSOR JOBURI IS SELECT JOB_ID, JOB_TITLE
                FROM JOBS;
    CURSOR ANGAJATI IS SELECT LAST_NAME, SALARY, JOB_ID
                       FROM EMP_ACRO;
BEGIN
    FOR V_JOB IN JOBURI LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR V_ANG IN ANGAJATI LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN DBMS_OUTPUT.PUT_LINE(V_ANG.LAST_NAME || ' ' || TO_CHAR(V_ANG.SALARY));
           END IF;
        END LOOP;
    END LOOP;
END;
/

-- c) ciclu cursoare cu subcereri
BEGIN
    FOR V_JOB IN (SELECT JOB_ID, JOB_TITLE FROM JOBS) LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID FROM EMPLOYEES) LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN DBMS_OUTPUT.PUT_LINE(V_ANG.LAST_NAME || ' ' || TO_CHAR(V_ANG.SALARY));
           END IF;
        END LOOP;
    END LOOP;
END;
/

-- d) EXPRESII CURSOR 
DECLARE 
    TYPE REFCURSOR IS REF CURSOR;
    CURSOR C IS SELECT JOB_ID, JOB_TITLE, CURSOR (SELECT LAST_NAME, SALARY, JOB_ID
                                                  FROM EMP_ACRO)
                FROM JOBS;
    v_job_id1 JOBS.JOB_ID%TYPE;
    V_JOB_ID2 EMPLOYEES.JOB_ID%TYPE;
    V_JOB_TITLE JOBS.JOB_TITLE%TYPE;
    V_LAST_NAME EMPLOYEES.LAST_NAME%TYPE;
    V_SALARY EMPLOYEES.SALARY%TYPE;
    V_CURSOR REFCURSOR;
BEGIN
    OPEN C;
        LOOP
            FETCH C INTO V_JOB_ID1, V_JOB_TITLE, V_CURSOR;
            EXIT WHEN C%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||v_JOB_TITLE);
            DBMS_OUTPUT.PUT_LINE('-------------------------------------');
            
            LOOP
                FETCH V_CURSOR INTO V_LAST_NAME, V_SALARY,  V_JOB_ID2;
                EXIT WHEN V_CURSOR%NOTFOUND;
                IF V_JOB_ID1 = V_JOB_ID2
                    THEN DBMS_OUTPUT.PUT_LINE(V_LAST_NAME || ' ' || TO_CHAR(V_SALARY));
                END IF;
            END LOOP;
        
        END LOOP;
    CLOSE C;
END;
/

-- Ex. 2
DECLARE 
    V_INDEX_ANG NUMBER(4);
    V_TOTAL_ANG NUMBER(8);
    V_MEDIE_ANG NUMBER(8);

BEGIN
    FOR V_JOB IN (SELECT JOB_ID, JOB_TITLE FROM JOBS) LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        V_INDEX_ANG := 0;
        V_TOTAL_ANG := 0;
        V_MEDIE_ANG := 0;
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID FROM EMPLOYEES) LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN DBMS_OUTPUT.PUT_LINE(V_INDEX_ANG || ' ' || V_ANG.LAST_NAME || ' ' || TO_CHAR(V_ANG.SALARY));
                     V_INDEX_ANG := V_INDEX_ANG + 1;
                     V_TOTAL_ANG := V_TOTAL_ANG + V_ANG.SALARY;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('TOTAL SALARII ANGAJATI: ' || V_TOTAL_ANG);
        DBMS_OUTPUT.PUT_LINE('SALARIU MEDIU: ' || (V_TOTAL_ANG/V_INDEX_ANG));
    END LOOP;
END;
/

-- Ex. 3
DECLARE 
    V_INDEX_ANG NUMBER(4);
    V_TOTAL_ANG NUMBER(8);
    V_MEDIE_ANG NUMBER(8);

BEGIN
    FOR V_JOB IN (SELECT JOB_ID, JOB_TITLE FROM JOBS) LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        V_INDEX_ANG := 0;
        V_TOTAL_ANG := 0;
        V_MEDIE_ANG := 0;
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID FROM EMPLOYEES) LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN 
                     V_INDEX_ANG := V_INDEX_ANG + 1;
                     V_TOTAL_ANG := V_TOTAL_ANG + V_ANG.SALARY;
            END IF;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('TOTAL SALARII ANGAJATI: ' || V_TOTAL_ANG);
        DBMS_OUTPUT.PUT_LINE('SALARIU MEDIU: ' || (V_TOTAL_ANG/V_INDEX_ANG));
        V_INDEX_ANG := 1;
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID FROM EMPLOYEES) LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN DBMS_OUTPUT.PUT_LINE(V_INDEX_ANG || ' ' || V_ANG.LAST_NAME || ' ' || V_ANG.SALARY/V_TOTAL_ANG*100);                     
            END IF;
        END LOOP;
    END LOOP;
END;
/

-- Ex. 4
DECLARE 
    V_INDEX_ANG NUMBER(4);
    V_TOTAL_ANG NUMBER(8);
    V_MEDIE_ANG NUMBER(8);

BEGIN
    FOR V_JOB IN (SELECT JOB_ID, JOB_TITLE FROM JOBS) LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        V_INDEX_ANG := 0;
        V_TOTAL_ANG := 0;
        V_MEDIE_ANG := 0;
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID 
                      FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = V_JOB.JOB_ID ORDER BY SALARY DESC)
                      WHERE ROWNUM <= 5) LOOP
            IF V_JOB.JOB_ID = V_ANG.JOB_ID
                THEN DBMS_OUTPUT.PUT_LINE(V_INDEX_ANG || ' ' || V_ANG.LAST_NAME || ' ' || TO_CHAR(V_ANG.SALARY));
                     V_INDEX_ANG := V_INDEX_ANG + 1;
                     V_TOTAL_ANG := V_TOTAL_ANG + V_ANG.SALARY;
            END IF;
        END LOOP;
        IF V_INDEX_ANG <= 4
        THEN DBMS_OUTPUT.PUT_LINE('PENTRU ACEST JOB SUNT MAI PUTIN DE 5 ANGAJATI');
        END IF;
        DBMS_OUTPUT.PUT_LINE('TOTAL SALARII ANGAJATI: ' || V_TOTAL_ANG);
        DBMS_OUTPUT.PUT_LINE('SALARIU MEDIU: ' || (V_TOTAL_ANG/V_INDEX_ANG));
    END LOOP;
END;
/

-- Ex. 5
DECLARE 
    V_INDEX_ANG NUMBER(4);
    V_TOTAL_ANG NUMBER(8);
    V_MEDIE_ANG NUMBER(8);
    gasit number(1);
    TYPE SALARII IS VARRAY(100) OF NUMBER(10);
    SALARII_MAX SALARII:=SALARII();
BEGIN
    FOR V_JOB IN (SELECT JOB_ID, JOB_TITLE FROM JOBS) LOOP    
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        DBMS_OUTPUT.PUT_LINE ('DEPARTAMENT '||V_JOB.JOB_TITLE);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------');
        V_INDEX_ANG := 0;
        V_TOTAL_ANG := 0;
        V_MEDIE_ANG := 0;
        
        FOR I IN (SELECT SALARY 
                  FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = V_JOB.JOB_ID ORDER BY SALARY DESC)
                  WHERE ROWNUM <= 5) LOOP
            V_INDEX_ANG := V_INDEX_ANG + 1;
            SALARII_MAX.EXTEND;
            SALARII_MAX(V_INDEX_ANG) := I.SALARY;
        END LOOP;

        V_INDEX_ANG := 0;
        FOR V_ANG IN (SELECT LAST_NAME, SALARY, JOB_ID 
                      FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = V_JOB.JOB_ID ORDER BY SALARY DESC)
                      WHERE ROWNUM <= 5) LOOP
            gasit := 0;
            FOR I IN SALARII_MAX.FIRST..SALARII_MAX.LAST LOOP 
                IF V_ANG.SALARY = SALARII_MAX(I) and gasit = 0
                THEN DBMS_OUTPUT.PUT_LINE(V_INDEX_ANG || ' ' || V_ANG.LAST_NAME || ' ' || TO_CHAR(V_ANG.SALARY));
                     V_INDEX_ANG := V_INDEX_ANG + 1;
                     V_TOTAL_ANG := V_TOTAL_ANG + V_ANG.SALARY;
                     gasit := 1;
                END IF;
            END LOOP;
        END LOOP;
        IF V_INDEX_ANG <= 4
        THEN DBMS_OUTPUT.PUT_LINE('PENTRU ACEST JOB SUNT MAI PUTIN DE 5 ANGAJATI');
        END IF;
        DBMS_OUTPUT.PUT_LINE('TOTAL SALARII ANGAJATI: ' || V_TOTAL_ANG);
        DBMS_OUTPUT.PUT_LINE('SALARIU MEDIU: ' || (V_TOTAL_ANG/V_INDEX_ANG));
    END LOOP;
END;
/

SELECT LAST_NAME, SALARY, JOB_ID 
                      FROM (SELECT * FROM EMPLOYEES WHERE JOB_ID = 'IT_PROG' ORDER BY SALARY DESC);
IT_PROG
-- !!! VEZI SI CURSOARE DINAMICE :)  
-- + CURSOR CU PARAMETRU - EX 8
SET SERVEROUTPUT ON;
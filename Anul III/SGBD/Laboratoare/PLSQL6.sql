-- EXERCITII REZOLVATE

--Ex. 1 
-- DECLANSATOR LA NIVEL DE INSTRUCTIUNE
CREATE OR REPLACE TRIGGER trig1_acro
    BEFORE INSERT OR UPDATE OR DELETE ON emp_acro
BEGIN
    IF (TO_CHAR(SYSDATE,'D') = 1) OR (TO_CHAR(SYSDATE,'HH24') NOT BETWEEN 8 AND 20)
    THEN
        RAISE_APPLICATION_ERROR(-20001,'tabelul nu poate fi actualizat');
    END IF;
END;
/

DROP TRIGGER trig1_acro;

-- Ex. 2
-- DECLANSATOR LA NIVEL DE INSTRUCTIUNE
CREATE OR REPLACE TRIGGER TRIG21_ACRO
    BEFORE UPDATE OF SALARY ON EMP_ACRO
    FOR EACH ROW
BEGIN
    IF (:NEW.SALARY < :OLD.SALARY) THEN RAISE_APPLICATION_ERROR(-20002, 'SALARIUL NU POATE FI MICSORAT');
    END IF;
END;
/

UPDATE EMP_ACRO
SET SALARY = SALARY-100;

DROP TRIGGER TRIG21_ACRO;

/
CREATE TABLE JOB_GRADES_ACRO AS (SELECT * FROM JOB_GRADES);
/
-- Ex. 3
CREATE OR REPLACE TRIGGER TRIG3_ACRO
    BEFORE UPDATE OF LOWEST_SAL, HIGHEST_SAL ON JOB_GRADES_ACRO
    FOR EACH ROW 
DECLARE 
    V_MIN_SAL EMP_ACRO.SALARY%TYPE;
    V_MAX_SAL EMP_ACRO.SALARY%TYPE;
    EXCEPTIE EXCEPTION;
BEGIN
    SELECT MIN(SALARY), MAX(SALARY)
    INTO V_MIN_SAL, V_MAX_SAL
    FROM EMP_ACRO;
    
    IF(:OLD.GRADE_LEVEL=1) AND (V_MIN_SAL < :NEW.LOWEST_SAL)
        THEN RAISE EXCEPTIE;
    END IF;
    
    IF (:OLD.GRADE_LEVEL=7) AND (V_MAX_SAL > :NEW.HIGHEST_SAL)
        THEN RAISE EXCEPTIE;
    END IF;
EXCEPTION 
    WHEN EXCEPTIE THEN 
        RAISE_APPLICATION_ERROR(-20003, 'EXISTA SALARII CARE SE GASESC INAFARA INTERVALULUI');
END;
/

UPDATE JOB_GRADES_ACRO
SET LOWEST_SAL = 3000
WHERE GRADE_LEVEL = 1;

UPDATE JOB_GRADES_ACRO
SET HIGHEST_SAL = 20000
WHERE GRADE_LEVEL = 7;
/

-- Ex. 4
CREATE TABLE INFO_DEPT_ACRO (
    ID NUMBER(4),
    NUME_DEPT VARCHAR2(20),
    PLATI NUMBER(8),
    CONSTRAINT PK_ID_INFO_DEPT PRIMARY KEY(ID)
);

INSERT INTO INFO_DEPT_ACRO (SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, SUM(E.SALARY)
                                    FROM DEPARTMENTS D, EMPLOYEES E
                                    WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
                                    GROUP BY D.DEPARTMENT_ID, D.DEPARTMENT_NAME);


SELECT * FROM INFO_DEPT_ACRO;

CREATE OR REPLACE PROCEDURE MODIFIC_PLATI_ACRO
    (V_CODD INFO_DEPT_ACRO.ID%TYPE,
     V_PLATI INFO_DEPT_ACRO.PLATI%TYPE) AS 
BEGIN 
    UPDATE INFO_DEPT_ACRO
    SET PLATI = NVL(PLATI, 0) + V_PLATI
    WHERE ID = V_CODD;
END;    
/

CREATE OR REPLACE TRIGGER TRIG4_ACRO
    AFTER INSERT OR DELETE OR UPDATE OF SALARY ON EMP_ACRO
    FOR EACH ROW
BEGIN
    IF DELETING THEN 
        MODIFIC_PLATI_ACRO(:OLD.DEPARTMENT_ID, -1*:OLD.SALARY);
    ELSIF UPDATING THEN 
        modific_plati_ACRO(:OLD.department_id,:NEW.salary-:OLD.salary);
    ELSE
-- se introduce un nou angajat
        modific_plati_ACRO(:NEW.department_id, :NEW.salary);
    END IF;
END;
/

SELECT * FROM
info_dept_ACRO WHERE id=90;


INSERT INTO emp_ACRO (employee_id, last_name, email, hire_date,
job_id, salary, department_id)
VALUES (300, 'N1', 'n1@g.com',sysdate, 'SA_REP', 2000, 90);

UPDATE emp_ACRO
SET salary = salary + 1000
WHERE employee_id=300;
/ 

DROP TRIGGER TRIG4_ACRO;

-- Ex. 5
create table info_emp_acro (
    ID NUMBER(4),
    NUME VARCHAR2(20),
    PRENUME VARCHAR2(20),
    SALARIU NUMBER(8),
    ID_DEPT NUMBER(4),
    CONSTRAINT PK_INFO_EMP_ACRO PRIMARY KEY(ID)
);

INSERT INTO INFO_EMP_ACRO (SELECT EMPLOYEE_ID, LAST_NAME, FIRST_NAME, SALARY, DEPARTMENT_ID
                            FROM EMPLOYEES);
                            
CREATE OR REPLACE VIEW v_info_ACRO AS
    SELECT e.id, e.nume, e.prenume, e.salariu, e.id_dept, d.nume_dept, d.plati
    FROM info_emp_ACRO e, info_dept_ACRO d
    WHERE e.id_dept = d.id;



SELECT *
FROM user_updatable_columns
WHERE table_name = UPPER('v_info_ACRO');


CREATE OR REPLACE TRIGGER trig5_ACRO
    INSTEAD OF INSERT OR DELETE OR UPDATE ON v_info_ACRO
    FOR EACH ROW
BEGIN
    IF INSERTING THEN
        -- inserarea in vizualizare determina inserarea
        -- in info_emp_*** si reactualizarea in info_dept_***
        -- se presupune ca departamentul exista
        INSERT INTO info_emp_ACRO
        VALUES (:NEW.id, :NEW.nume, :NEW.prenume, :NEW.salariu,:NEW.id_dept);
        
        UPDATE info_dept_ACRO
        SET plati = plati + :NEW.salariu
        WHERE id = :NEW.id_dept;
    ELSIF DELETING THEN
        -- stergerea unui salariat din vizualizare determina
        -- stergerea din info_emp_*** si reactualizarea in
        -- info_dept_***
        DELETE FROM info_emp_ACCRO
        WHERE id = :OLD.id;
        UPDATE info_dept_ACRO
        SET plati = plati - :OLD.salariu
        WHERE id = :OLD.id_dept;
    ELSIF UPDATING ('salariu') THEN
        /* modificarea unui salariu din vizualizare determina
        modificarea salariului in info_emp_*** si reactualizarea
        in info_dept_***
        */
        UPDATE      info_emp_***
        SET salariu = :NEW.salariu
        WHERE id = :OLD.id;

        UPDATE info_dept_***
        SET plati = plati - :OLD.salariu + :NEW.salariu
        WHERE id = :OLD.id_dept;
    ELSIF UPDATING ('id_dept') THEN
        /* modificarea unui cod de departament din vizualizare
        determina modificarea codului in info_emp_***
        si reactualizarea in info_dept_*** */ 
        UPDATE info_emp_ACRO
        SET id_dept = :NEW.id_dept
        WHERE id = :OLD.id;
        
        UPDATE info_dept_ACRO
        SET plati = plati - :OLD.salariu
        WHERE id = :OLD.id_dept;
        
        UPDATE info_dept_ACRO
        SET plati = plati + :NEW.salariu
        WHERE id = :NEW.id_dept;
    END IF;
END;
/

-- Ex. 6
CREATE OR REPLACE TRIGGER trig6_ACRO
    BEFORE DELETE ON emp_ACRO
BEGIN
    IF USER= UPPER('grupa_32') THEN
        RAISE_APPLICATION_ERROR(-20900,'Nu ai voie sa stergi!');
    END IF;
END;
/

-- Ex. 8
CREATE OR REPLACE PACKAGE pachet_acro AS
    smin emp_***.salary%type;
    smax emp_***.salary%type;
    smed emp_***.salary%type;
END pachet_acro;
/
CREATE OR REPLACE TRIGGER trig81_acro
    BEFORE UPDATE OF salary ON emp_acro
BEGIN
    SELECT MIN(salary),AVG(salary),MAX(salary)
        INTO pachet_acro.smin, pachet_acro.smed, pachet_acro.smax
    FROM emp_acro;
END;
/
    
CREATE OR REPLACE TRIGGER trig82_acro
    BEFORE UPDATE OF salary ON emp_***
    FOR EACH ROW
BEGIN
    IF(:OLD.salary=pachet_acro.smin)AND (:NEW.salary>pachet_acro.smed)
    THEN
        RAISE_APPLICATION_ERROR(-20001,'Acest salariu depaseste
        valoarea medie');
    ELSIF (:OLD.salary= pachet_***.smax) AND (:NEW.salary< pachet_***.smed)
    THEN
        RAISE_APPLICATION_ERROR(-20001,'Acest salariu este sub
        valoarea medie');
    END IF;
END;
/

select avg(salary)
from emp_acro;

update emp_acro
set salary = 10000
where salary = (select min(salary) from emp_acro)
/
update emp_acro
set salary=1000
where salary = (select max(salary) from emp_acro);

-- EXERCITII DE REZOLVAT. 
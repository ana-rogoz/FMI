-- Laborator 8 (continuare)

-- 31
ALTER TABLE ANGAJATI_ACRO
DROP CONSTRAINT COD_DEP_FK;

ALTER TABLE ANGAJATI_ACRO
ADD CONSTRAINT COD_DEP_FK_CASCADE FOREIGN KEY(COD_DEP) REFERENCES DEPARTAMENTE_ACRO(COD_DEP) 
ON DELETE CASCADE;

SELECT *
FROM DEPARTAMENTE_ACRO 
WHERE COD_DEP = 20;

-- 32
DELETE FROM DEPARTAMENTE_ACRO
WHERE COD_DEP = 20;

ROLLBACK;

-- 33
ALTER TABLE DEPARTAMENTE_ACRO
ADD CONSTRAINT COD_DIRECTOR_FK FOREIGN KEY(COD_DIRECTOR) REFERENCES ANGAJATI_ACRO(COD_ANG)
ON DELETE SET NULL;
-- CAND STERG SEFUL UNUI DEPARTAMENT DIN ANGAJATI,
-- CODUL SEFULUI DEPARTAMENTULUI DEVINE NULL

UPDATE DEPARTAMENTE_ACRO
SET COD_DIRECTOR = 107
WHERE COD_DEP = 60;

ROLLBACK;

-- 34 
UPDATE DEPARTAMENTE_ACRO
SET COD_DIRECTOR = 102
WHERE COD_DEP = 30;

DELETE FROM ANGAJATI_ACRO
WHERE COD_ANG = 102;
-- COD DIRECTOR PT DEPARTAMENTUL 30 A DEVENIT NULL.
ROLLBACK;

-- 35
ALTER TABLE ANGAJATI_ACRO
ADD CONSTRAINT SALARIU_MAX CHECK(SALARIU < 30000);


-- 36
UPDATE ANGAJATI_ACRO
SET SALARIU = 35000
WHERE COD_ANG = 100;
-- The values being inserted do not satisfy the named check.


-- 37 
ALTER TABLE ANGAJATI_ACRO
MODIFY CONSTRAINT SALARIU_MAX DISABLE;

UPDATE ANGAJATI_ACRO
SET SALARIU = 35000
WHERE COD_ANG = 100;

ALTER TABLE ANGAJATI_ACRO
MODIFY CONSTRAINT SALARIU_MAX ENABLE;
-- NU POATE DA ENABLE LA CONSTRANGERE.
--  an alter table operation tried to validate a check constraint to
           --populated table that had nocomplying values.



-- Laborator 7

-- 1 
CREATE TABLE EMP_ACRO AS
SELECT * 
FROM EMPLOYEES;

CREATE TABLE DEPT_ACRO AS
SELECT *
FROM DEPARTMENTS;

-- 2 
DESC EMP_ACRO;
DESC EMPLOYEES;

DESC DEPT_ACRO;
DESC DEPARTMENTS;
-- nu se pastreaza constrangerea de cheie primara.

-- 3 
SELECT * 
FROM DEPT_ACRO;

SELECT * 
FROM EMP_ACRO;

-- 4 
ALTER TABLE EMP_ACRO
ADD CONSTRAINT PK_EMP_ACRO PRIMARY KEY(employee_id);

ALTER TABLE DEPT_ACRO
ADD CONSTRAINT PK_DEPT_ACRO PRIMARY KEY(department_id);

ALTER TABLE EMP_ACRO
ADD CONSTRAINT FK_EMP_DEPT_ACRO FOREIGN KEY(department_id) REFERENCES dept_ACRO(department_id); 
-- nu am implementat constrangerea dintre angajat si manager.

-- 5 a) 
INSERT INTO DEPT_ACRO
VALUES (300, 'Programare'); 
-- Error: not enough values.

rollback;

-- 5 b)
INSERT INTO DEPT_ACRO (department_id, department_name)
VALUES (300, 'Programare'); 
-- merge 
rollback;

-- 5 c)
 INSERT INTO DEPT_ACRO (department_name, department_id)
 VALUES (300, 'Programare'); 
-- campurile sunt inversate; transmite un numar drept department_name 
-- Error: invalid number.
 rollback;
 
 -- 5 d)
 INSERT INTO DEPT_ACRO (department_id, department_name, location_id)
 VALUES (300, 'Programare', null);
 -- MERGE.
 rollback;
 
 -- 5 e)
 INSERT INTO DEPT_acro (department_name, location_id)
 VALUES ('Programare', null); 
 -- department_id nu poate fi null.
rollback;
 
-- daca incercam sa adaugam de doua ori departamentul programre nu putem deoarece
-- cheia primara trebuie sa fie unica. 

-- 6) 
INSERT INTO EMP_ACRO 
VALUES (1111, NULL, 'ION', 'NANN@YAHOO.COM', NULL, TO_DATE('11-JAN-2008'), 20, NULL, NULL, NULL, 300);

ROLLBACK;

COMMIT;

desc dept_acro;
DESC EMP_ACRO;



SELECT * 
FROM dept_ACRO;

SELECT * 
FROM EMP_ACRO;


SELECT * 
FROM ANGAJATI_ACRO;

SELECT *
FROM DEPARTAMENTE_ACRO;
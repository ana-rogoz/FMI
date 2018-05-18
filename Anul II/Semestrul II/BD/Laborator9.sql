-- 3
CREATE TABLE ANGAJATI10_ACRO AS (SELECT *
               FROM ANGAJATI_ACRO
               WHERE COD_DEP=10);
 
-- 4
ALTER TABLE ANGAJATI_ACRO
ADD (COMISION NUMBER(4,2));

-- 5
-- NU

-- 6
ALTER TABLE ANGAJATI_ACRO
MODIFY (SALARIU NUMBER(8,2) DEFAULT 0);

-- 7
ALTER TABLE ANGAJATI_ACRO
MODIFY (COMISION NUMBER(2,2),
        SALARIU NUMBER(10,2));
        
-- 8
UPDATE ANGAJATI_ACRO
SET COMISION = 0.1 WHERE JOB LIKE 'A%';

-- 9
ALTER TABLE ANGAJATI_ACRO
MODIFY (EMAIL VARCHAR2(15));

-- 10
ALTER TABLE ANGAJATI_ACRO
ADD (NR_TELEFON NUMBER(10) DEFAULT 0);

-- 11
SELECT *
FROM ANGAJATI_ACRO;

ALTER TABLE ANGAJATI_ACRO
DROP COLUMN NR_TELEFON;

-- 12
RENAME ANGAJATI_ACRO TO ANGAJATI3_ACRO;

-- 13
SELECT *
FROM TAB;

RENAME ANGAJATI3_ACRO TO ANGAJATI_ACRO;

-- 14
TRUNCATE TABLE ANGAJATI10_ACRO;

-- 15
CREATE TABLE DEPARTAMENTE_ACRO(
  COD_DEP NUMBER(2),
  NUME VARCHAR2(15) CONSTRAINT NUMEDEP_NN NOT NULL,
  COD_DIRECTOR NUMBER(4));
  
DESC DEPARTAMENTE_ACRO;

-- 16
INSERT INTO DEPARTAMENTE_ACRO VALUES 
        ( 10
        , 'Administrativ'
        , 100
        );
        
INSERT INTO DEPARTAMENTE_ACRO VALUES 
        ( 20
        , 'Proiectare'
        , 101
        );
        
INSERT INTO DEPARTAMENTE_ACRO VALUES 
        ( 30
        , 'Programare'
        , null
        );
        
-- 17
ALTER TABLE DEPARTAMENTE_ACRO
ADD (CONSTRAINT COD_DEP_PK PRIMARY KEY(COD_DEP));
        
-- 18 A)
ALTER TABLE ANGAJATI_ACRO
ADD (CONSTRAINT COD_DEP_FK FOREIGN KEY(COD_DEP) REFERENCES DEPARTAMENTE_ACRO(COD_DEP));

-- 18 B)
DROP TABLE ANGAJATI_ACRO;

CREATE TABLE ANGAJATI_ACRO(
  COD_ANG NUMBER(4) PRIMARY KEY,
  NUME VARCHAR2(20) CONSTRAINT NUME_NN NOT NULL,
  PRENUME VARCHAR2(20),
  EMAIL CHAR(15) UNIQUE,
  DATA_ANG DATE,
  JOB VARCHAR2(10),
  COD_SEF NUMBER(4), 
  SALARIU NUMBER(8,2),
  COD_DEP NUMBER(2) CHECK (COD_DEP > 0),
  COMISION NUMBER(4,2) DEFAULT 0,
  CONSTRAINT NUME_PRENUME UNIQUE(NUME,PRENUME),
  CONSTRAINT COD_SEF_FRK FOREIGN KEY(COD_SEF) REFERENCES ANGAJATI_ACRO(COD_ANG),
  CONSTRAINT SALARIU_CH CHECK (SALARIU > COMISION * 10)
  );
  
ALTER TABLE ANGAJATI_ACRO
ADD (CONSTRAINT COD_DEP_FK FOREIGN KEY(COD_DEP) REFERENCES DEPARTAMENTE_ACRO(COD_DEP));
  
-- 20
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 100
        , 'Nume1'
        , 'Prenume1'
        , null
        , null
        , 'Director'
        , null
        , 20000
        , 10
        , 0
        );
        
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 101
        , 'Nume2'
        , 'Prenume2'
        , 'Nume2'
        , TO_DATE('02-FEB-2004')
        , 'Inginer'
        , 100
        , 10000
        , 10
        , 0
        );
        
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 102
        , 'Nume3'
        , 'Prenume3'
        , 'Nume3'
        , TO_DATE('05-JUN-2000')
        , 'Analist'
        , 101
        , 5000
        , 20
        , 0
        );
INSERT INTO ANGAJATI_ACRO VALUES 
      ( 103
      , 'Nume4'
      , 'Prenume4'
      , Null
      , Null
      , 'Inginer'
      , 100
      , 9000
      , 20
      , 0
      );
      
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 104
        , 'Nume5'
        , 'Prenume5'
        , 'Nume5'
        , Null
        , 'Analist'
        , 101
        , 3000
        , 30
        , 0
        );      

-- 21
DROP TABLE DEPARTAMENTE_ACRO;
--An attempt was made to drop a table with unique or
  --         primary keys referenced by foreign keys in another table.

-- 22
SELECT *
FROM USER_TABLES;

SELECT *
FROM TAB;

SELECT *
FROM USER_CONSTRAINTS;

-- 23 A)
SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'DEPARTAMENTE_ACRO' OR TABLE_NAME = 'ANGAJATI_ACRO';

SELECT constraint_name, constraint_type, table_name
FROM user_constraints
WHERE table_name IN ('ANGAJATI_ACRO', 'DEPARTAMENTE_ACRO');

-- 23 B)
SELECT table_name, constraint_name, column_name
FROM user_cons_columns
WHERE LOWER(table_name) IN ('angajati_acro', 'departamente_acro');

-- 25
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 106
        , 'Nume6'
        , 'Prenume6'
        , 'Nume6'
        , Null
        , 'Analist'
        , 101
        , 3000
        , 50
        , 0
        );  
--  A foreign key value has no matching primary key value.

-- 26
INSERT INTO DEPARTAMENTE_ACRO VALUES 
        ( 60
        , 'Analiza'
        , null
        );

COMMIT DEPARTAMENTE_ACRO;


-- 27
DELETE FROM DEPARTAMENTE_ACRO
WHERE COD_DEP = 20;
-- attempted to delete a parent key value that had a foreign
   --        dependency.

-- 28
DELETE FROM DEPARTAMENTE_ACRO
WHERE COD_DEP = 60;

ROLLBACK;
-- 29
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 107
        , 'Nume7'
        , 'Prenume7'
        , 'Nume7'
        , Null
        , 'Analist'
        , 114
        , 3000
        , 30
        , 0
        ); 
-- A foreign key value has no matching primary key value.

-- 30
INSERT INTO ANGAJATI_ACRO VALUES 
        ( 114
        , 'Nume14'
        , 'Prenume14'
        , 'Nume14'
        , Null
        , 'Analist'
        , 101
        , 3000
        , 30
        , 0
        ); 
 INSERT INTO ANGAJATI_ACRO VALUES 
        ( 107
        , 'Nume7'
        , 'Prenume7'
        , 'Nume7'
        , Null
        , 'Analist'
        , 114
        , 3000
        , 30
        , 0
        ); 
-- Acum merge. Mai intai introducem cheia de care depinde cheia externa, dupa 
-- care valoarea cheii externe.
        
COMMIT;        
        
SELECT *
FROM ANGAJATI_ACRO;
select *
from departamente_acro;
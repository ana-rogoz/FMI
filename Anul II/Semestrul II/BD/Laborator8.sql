select *
from user_constraints;

-- 1
CREATE TABLE ANGAJATI_ACRO(
  COD_ANG NUMBER(4),
  NUME VARCHAR2(20),
  PRENUME VARCHAR2(20),
  EMAIL CHAR(15),
  DATA_ANG DATE,
  JOB VARCHAR2(10),
  COD_SEF NUMBER(4),
  SALARIU NUMBER(8,2),
  COD_DEP NUMBER(2));
  
DROP TABLE ANGAJATI_ACRO;

CREATE TABLE ANGAJATI_ACRO(
  COD_ANG NUMBER(4) PRIMARY KEY,
  NUME VARCHAR2(20) CONSTRAINT NUME_NN NOT NULL,
  PRENUME VARCHAR2(20),
  EMAIL CHAR(15),
  DATA_ANG DATE,
  JOB VARCHAR2(10),
  COD_SEF NUMBER(4),
  SALARIU NUMBER(8,2) CONSTRAINT SALARIU_NN NOT NULL,
  COD_DEP NUMBER(2));
  
 DROP TABLE ANGAJATI_ACRO;
 
CREATE TABLE ANGAJATI_ACRO(
  COD_ANG NUMBER(4),
  NUME VARCHAR2(20) CONSTRAINT NUME_NN NOT NULL,
  PRENUME VARCHAR2(20),
  EMAIL CHAR(15),
  DATA_ANG DATE,
  JOB VARCHAR2(10),
  COD_SEF NUMBER(4),
  SALARIU NUMBER(8,2) CONSTRAINT SALARIU_NN NOT NULL,
  COD_DEP NUMBER(2),
  CONSTRAINT COD_ANG_PK PRIMARY KEY(COD_ANG)
  );
  
-- 2
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
        );      
        
SELECT *
FROM ANGAJATI_ACRO;
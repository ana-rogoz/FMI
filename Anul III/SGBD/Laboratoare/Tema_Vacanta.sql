drop table note_acro cascade constraints;
drop table curs_acro cascade constraints;
drop table student_acro cascade constraints;
drop table profesor_acro cascade constraints;
drop table prieteni_acro cascade constraints;

/
create table student_acro(cod_student number(4) primary key,
                    	nume varchar2(20),
					    prenume varchar2(20),
					    data_nasterii date,
					    nr_matricol varchar2(20),
					    grupa varchar2(3),
					    an number,
	                    CNP varchar2(13),
		      			sectie varchar2(20));

create table profesor_acro(cod_profesor number(4) primary key,
					    nume varchar2(20),
					    prenume varchar2(20),
	                    data_nasterii date,
	                    data_angajarii date,
	                    titlu varchar2(20),
					    salariu number(10));

create table curs_acro (cod_curs number(4) primary key, 
	                    denumire varchar2(20), 
					    nr_credite number(4), 
					    cod_profesor number(4) references profesor_acro(cod_profesor));
                        
create table note_acro(cod_student number(4) references student_acro(cod_student), 
                		cod_curs number(4) references curs_acro(cod_curs), 
						nota number(4),
						data_examinare date,
						PRIMARY KEY(cod_student,cod_curs,data_examinare));

CREATE TABLE prieteni_acro (cod_student1 NUMBER(20) NOT NULL,
							cod_student2 NUMBER(20) NOT NULL,
							data DATE NOT NULL,
							CONSTRAINT fk_prieten_cod_student11 FOREIGN KEY (cod_student1) REFERENCES student_acro(cod_student),
							CONSTRAINT fk_prieten_cod_student22 FOREIGN KEY (cod_student2) REFERENCES student_acro(cod_student),
							CONSTRAINT fara_duplicate_1 UNIQUE (cod_student1, cod_student2));

insert into student_acro
values(1,'Barbu','Lavinia',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',421,4,'2830201893510','mate-info');


insert into student_acro
values(8,'Sandulescu','Xenia',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',421,4,'2830201893510','mate-info');

insert into student_acro
values(2,'Anton','Maria',TO_DATE('03-03-1981','dd-mm-yyyy'),'6589',211,2,'2810303907818','mate');

insert into student_acro
values(3,'Anton','Catalin',TO_DATE('04-05-1981','dd-mm-yyyy'),'136',221,2,'2810504568564','mate-info');

insert into student_acro
values(4,'Busuioc','Gigi',TO_DATE('15-12-1980','dd-mm-yyyy'),'248',221,2,'2801215873510','info');

insert into student_acro
values(5,'Antonescu','Teodor',TO_DATE('01-02-1983','dd-mm-yyyy'),'156',211,2,'2830201893510','mate-info');

insert into student_acro
values(6,'Dragan','Dan',TO_DATE('22-05-1989','dd-mm-yyyy'),'0890',111,1,'2890522893510','mate');

insert into student_acro
values(7,'Roman','Daniel',TO_DATE('07-06-1985','dd-mm-yyyy'),'1786',421,4,'2850706893510','mate-info');

insert into profesor_acro
values(11,'Todorache','Petre',TO_DATE('21-03-1950','dd-mm-yyyy'),TO_DATE('01-08-1973','dd-mm-yyyy'),'profesor',3000);

insert into profesor_acro
values(12,'Dumitrescu','Dorin',TO_DATE('24-05-1980','dd-mm-yyyy'),TO_DATE('01-08-2004','dd-mm-yyyy'),'asistent',1300);

insert into profesor_acro
values(13,'Gheorghe','Stefan',TO_DATE('20-02-1975','dd-mm-yyyy'),TO_DATE('24-09-2000','dd-mm-yyyy'),'lector',2100);

insert into profesor_acro
values(14,'Mares','Madalina',TO_DATE('24-06-1975','dd-mm-yyyy'),NULL,'conferentiar',4000);

insert into curs_acro
values (31,'ecuatii',6,11);

insert into curs_acro
values (32,'ecuatii der par',7,11);

insert into curs_acro
values (33, 'analiza matematica',4,12);

insert into curs_acro
values (34, 'analiza functionala', 6,12);

insert into curs_acro
values(35,'baze de date',7, 13);

insert into curs_acro
values(36,'retele',7,13);

insert into curs_acro
values(37,'interfete',5,NULL);

insert into curs_acro
values(38,'poo',15,NULL);

insert into curs_acro
values(39,'algebra',NULL,NULL);

insert into note_acro
values(2,32,7,TO_DATE('01-06-2007','dd-mm-yyyy'));

insert into note_acro
values(4,33,8,TO_DATE('25-05-2006','dd-mm-yyyy'));

insert into note_acro
values(4,34,9,TO_DATE('20-05-2007','dd-mm-yyyy'));

insert into note_acro
values(4,35,10,TO_DATE('21-05-2007','dd-mm-yyyy'));

insert into note_acro
values(4,36,9,TO_DATE('22-05-2007','dd-mm-yyyy'));

insert into note_acro
values(2,33,6,TO_DATE('03-05-2007','dd-mm-yyyy'));

insert into note_acro
values(1,35,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_acro
values(1,35,5,TO_DATE('03-10-2005','dd-mm-yyyy'));

insert into note_acro
values(1,36,4,TO_DATE('03-01-2004','dd-mm-yyyy'));

insert into note_acro
values(1,36,4,TO_DATE('01-02-2004','dd-mm-yyyy'));

insert into note_acro
values(1,36,6,TO_DATE('03-07-2004','dd-mm-yyyy'));

insert into note_acro
values(7,35,10,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_acro
values(8,35,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_acro
values(8,37,4,TO_DATE('03-05-2005','dd-mm-yyyy'));

insert into note_acro
values(8,37,5,TO_DATE('04-05-2005','dd-mm-yyyy'));

insert into note_acro
values(8,36,3,TO_DATE('05-05-2006','dd-mm-yyyy'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(2, 4, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(2, 5, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(3, 6, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(4, 5, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(4, 8, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(5, 6, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(7, 3, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

INSERT INTO prieteni_acro (cod_student1, cod_student2, data) VALUES
(7, 8, TO_DATE('04-01-2017', 'DD-MM-YYYY'));

commit;

/*
a. Creați vizualizarea v_info_acro care va contine informatii complete despre studenti, secțiile de care aparțin, notele, 
numarul total de credite si numarul de prieteni ai acestora. 
*/
CREATE OR REPLACE VIEW V_INFO_ACRO AS
    SELECT E.COD_STUDENT, E.NUME, E.PRENUME, E. DATA_NASTERII, E.NR_MATRICOL, E.GRUPA, E.AN, E.CNP, E.SECTIE, N.NOTA, 
         (SELECT SUM(C.NR_CREDITE)
                         FROM STUDENT_ACRO E1, NOTE_ACRO N1, CURS_ACRO C1
                         WHERE E1.COD_STUDENT = E.COD_STUDENT AND E1.COD_STUDENT = N1.COD_STUDENT AND N1.COD_CURS = C1.COD_CURS AND N1.NOTA >= 5) AS SUMA_CREDITE,
         (SELECT COUNT(*) 
          FROM PRIETENI_ACRO
          WHERE COD_STUDENT1 = E.COD_STUDENT OR COD_STUDENT2 = E.COD_STUDENT) AS NR_PRIETENI
    FROM STUDENT_ACRO E, NOTE_ACRO N, CURS_ACRO C
    WHERE E.COD_STUDENT = N.COD_STUDENT AND N.COD_CURS = C.COD_CURS
    ORDER BY E.COD_STUDENT;
/

select * 
from v_INFO_ACRO;
/

/* b. Definiti un declansator prin care actualizarile ce au loc asupra vizualizarii se propaga automat 
in tabelele de bază (declansator INSTEAD OF). Se consideră că au loc următoarele actualizări asupra vizualizării:
- se adaugă un student într-o secție deja existentă;
- se elimină un student;
- se elimină o prietenie;
- se modifică nota unui student;
- se modifică o prietenie;
- se modifică secția unui student (codul secției).
*/

CREATE OR REPLACE TRIGGER TRIGGER_TEMA_ACRO 
    INSTEAD OF INSERT OR DELETE OR UPDATE ON V_INFO_ACRO
    FOR EACH ROW
BEGIN

    IF INSERTING THEN 
        INSERT INTO STUDENT_ACRO
        VALUES(:NEW.COD_STUDENT, :NEW.NUME, :NEW.PRENUME, 
               :NEW.DATA_NASTERII, :NEW.NR_MATRICOL, 
               :NEW.GRUPA, :NEW.AN, :NEW.CNP, :NEW.SECTIE, :NEW.NOTA);
         
        
    ELSIF DELETING THEN 
        DELETE FROM STUDENT_ACRO
        WHERE COD_STUDENT = :OLD.COD_STUDENT;
        
        DELETE FROM NOTE_ACRO
        WHERE COD_STUDENT = :OLD.COD_STUDENT;
        
        DELETE FROM PRIETENI_ACRO
        WHERE COD_STUDENT1 = :OLD.COD_STUDENT OR COD_STUDENT2 = :OLD.COD_STUDENT;
    ELSIF UPDATING ('NOTA') THEN 
        UPDATE NOTE_ACRO
        SET NOTA = :NEW.NOTA
        WHERE COD_STUDENT = :OLD.COD_STUDENT;
        
    ELSIF UPDATING ('COD_STUDENT') THEN 
        UPDATE PRIETENI_ACRO
        SET COD_STUDENT1 = :NEW.COD_STUDENT
        WHERE COD_STUDENT1 = :OLD.COD_STUDENT;
        
        UPDATE PRIETENI_ACRO
        SET COD_STUDENT2 = :NEW.COD_STUDENT
        WHERE COD_STUDENT2 = :OLD.COD_STUDENT;
        
    ELSIF UPDATING('SECTIE') THEN 
        UPDATE STUDENT_ACRO
        SET SECTIE = :NEW.SECTIE
        WHERE COD_STUDENT = :OLD.COD_STUDENT;
    END IF;
END;    
/

SELECT * FROM STUDENT_ACRO;
/
/* c. Verificati daca declansatorul definit functioneaza corect.*/

-- adaugarea unui student intr-o sectie deja existenta
INSERT INTO V_INFO_ACRO VALUES (10, 'ION', 'ION', TO_DATE('02-02-2000', 'DD-MM-YYYY'), 
                                2000, 332, 3, 1200202420011, 'mate-info', 10, 5, 0);

-- se elimina un student
delete FROM V_INFO_ACRO
WHERE COD_STUDENT = 7;
/


SELECT * FROM V_INFO_ACRO;
/

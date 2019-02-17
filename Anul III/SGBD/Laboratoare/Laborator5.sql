DECLARE 
  TYPE rec IS RECORD (cod employees.employee_id%type,
                      salariu employees.salary%type);
                      
  type tab_ind is table of rec index by PLS_integer;
  v_tab tab_ind;
  
begin 
select *
bulk collect into v_tab
FROM (SELECT EMPLOYEE_ID, SALARY
      FROM EMPLOYEES
      ORDER BY SALARY)
WHERE ROWNUM <= 5; 

for it in v_tab.first..v_tab.last loop
  dbms_output.put_line(v_tab(it).cod || ' ' || v_tab(it).salariu);
end loop;

end;
/

CREATE TYPE obj_acro as object (
cod number, 
salariu number(8,2)
);

CREATE OR REPLACE TYPE tabind_acro is table of obj_acro;

create table test_acro (
name varchar(100),
email varchar(100),
informatii_salariu tabind_acro
) nested table informatii_salariu store as informatii_acro;

insert into test_acro values (
'Ana',
'ana@ana.co', 
tabind_acro (obj_acro(1,1500), obj_acro(2,3500))
);

select * from test_acro;

declare 
  type ind2 is table of tabind_acro%type;
  v_tabind ind2;
begin 
  select informatii_salariu into v_tabind

set serveroutput on;
-- 23
SELECT 'Departamentul ' || D.DEPARTMENT_NAME || ' este condus de ' || NVL(TO_CHAR(D.MANAGER_ID), 'nimeni') || ' si ' || DECODE(COUNT(E.EMPLOYEE_ID) , 0, 'nu are salariati', 'are ' ||COUNT(E.EMPLOYEE_ID)||  ' salariati' )
FROM EMPLOYEES E, DEPARTMENTS D
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+)
GROUP BY D.DEPARTMENT_NAME, D.MANAGER_ID;

-- angajati care lucreaza la proiecte de 10k
SELECT DISTINCT W.EMPLOYEE_ID
FROM WORKS_ON W, PROJECT P
WHERE W.PROJECT_ID = P.PROJECT_ID AND P.BUDGET = 10000;

-- 1 varianta 1
SELECT DISTINCT employee_id
FROM works_on a
WHERE NOT EXISTS
  (SELECT 1
   FROM project p
   WHERE START_DATE >= TO_DATE('01-JAN-2006') AND START_DATE <= TO_DATE('01-JUL-2006')
   AND NOT EXISTS (SELECT 'x'
                   FROM works_on b
                   WHERE p.project_id=b.project_id AND b.employee_id=a.employee_id));


-- 1 varianta 2
SELECT employee_id
FROM works_on
WHERE project_id IN
(SELECT project_id
FROM project
WHERE START_DATE >= TO_DATE('01-JAN-2006') AND START_DATE <= TO_DATE('01-JUL-2006'))
GROUP BY employee_id
HAVING COUNT(project_id)=
(SELECT COUNT(*)
FROM project
WHERE START_DATE >= TO_DATE('01-JAN-2006') AND START_DATE <= TO_DATE('01-JUL-2006'));

-- 1 varianta 3
SELECT employee_id
FROM works_on
MINUS
SELECT employee_id from
( SELECT employee_id, project_id
FROM (SELECT DISTINCT employee_id FROM works_on) t1,
(SELECT project_id FROM project WHERE START_DATE >= TO_DATE('01-JAN-2006') AND START_DATE <= TO_DATE('01-JUL-2006')) t2
MINUS
SELECT employee_id, project_id FROM works_on
) t3;

-- 1 varianta 4
SELECT DISTINCT employee_id
FROM works_on a
WHERE NOT EXISTS (
(SELECT project_id
FROM project p
WHERE START_DATE >= TO_DATE('01-JAN-2006') AND START_DATE < TO_DATE('01-JUL-2006'))
MINUS
(SELECT p.project_id
FROM project p, works_on b
WHERE p.project_id=b.project_id
AND b.employee_id=a.employee_id));


-- 2 varianta 1
SELECT DISTINCT PROJECT_ID, PROJECT_NAME, PROJECT_MANAGER
FROM PROJECT P
WHERE NOT EXISTS (SELECT 'X'
                   FROM JOB_HISTORY j
                   GROUP BY EMPLOYEE_ID
                   HAVING COUNT(j.EMPLOYEE_ID) = 2 and not exists 
                  (SELECT 1
                   FROM  works_on w
                   WHERE P.PROJECT_ID = w.project_id and w.employee_id = j.employee_id) 
                  );


-- 16
SELECT last_name, salary, department_id, job_id
FROM  (select last_name, salary, department_id, job_id
       from employees
       where job_id = &p_cod);
              
-- 17
SELECT last_name, salary, department_id, job_id, HIRE_DATE
FROM  (select last_name, salary, department_id, job_id, hire_date
       from employees
       where hire_date >= to_date(&data));
       
-- 18
SELECT &coloana C
FROM  &tabel t
WHERE &WH
order by C;


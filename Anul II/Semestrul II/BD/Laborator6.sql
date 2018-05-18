-- 13 varianta MINUS 1
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS 
MINUS
SELECT DEPARTMENT_ID, DEPARTMENT_NAME
FROM DEPARTMENTS D 
WHERE EXISTS(SELECT 'x' 
             FROM EMPLOYEES
             WHERE DEPARTMENT_ID = D.DEPARTMENT_ID);
-- 13 
SELECT DEPARTMENT_ID
FROM DEPARTMENTS 
MINUS
SELECT DEPARTMENT_ID
FROM EMPLOYEES;

-- 14
SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
WHERE manager_id = (SELECT employee_id
FROM employees
WHERE LOWER(last_name)='de haan');


SELECT employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH employee_id=( SELECT employee_id
FROM employees
WHERE LOWER(last_name)='de haan')
CONNECT BY employee_id = PRIOR manager_id;


-- 20
WITH SUBORDONATI_DIRECTI AS(SELECT employee_id, last_name, hire_date
                    FROM employees
                    WHERE manager_id = (SELECT employee_id
                                        FROM employees
                                        WHERE LOWER(last_name)='king' AND LOWER(first_name)='steven')),
     SUBORD_VECHIME AS (SELECT EMPLOYEE_ID, LAST_NAME, HIRE_DATE
                        FROM SUBORDONATI_DIRECTI
                        WHERE HIRE_DATE <= ALL(SELECT HIRE_DATE
                                               FROM SUBORDONATI_DIRECTI))
                      
                    
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME, HIRE_DATE, LEVEL,SALARY
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY') <> 1970
START WITH EMPLOYEE_ID=(SELECT employee_id
                         FROM SUBORD_VECHIME)
CONNECT BY manager_id = PRIOR employee_id
ORDER BY LEVEL;

-- 22
SELECT E.JOB_ID, AVERAGE, J.JOB_TITLE
FROM (SELECT JOB_ID, AVG(SALARY) AS AVERAGE
      FROM EMPLOYEES E
      GROUP BY JOB_ID
      ORDER BY AVG(SALARY))  E, JOBS J
WHERE ROWNUM < 4 AND E.JOB_ID = J.JOB_ID;

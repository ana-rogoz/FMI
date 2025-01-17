SELECT SUM(SALARY), DEPARTMENT_ID
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID;

SELECT DISTINCT COMMISSION_PCT
FROM EMPLOYEES;

SELECT COMMISSION_PCT 
FROM EMPLOYEES;

SELECT COUNT(DISTINCT COMMISSION_PCT)
FROM EMPLOYEES;

-- 4)
SELECT COUNT(JOB_ID)
FROM EMPLOYEES 
GROUP BY JOB_ID;

--5)
SELECT COUNT(DISTINCT MANAGER_ID) AS "Nr. manageri"
FROM EMPLOYEES;

--6)
SELECT MAX(SALARY) - MIN(SALARY) AS "Diferenta"
FROM EMPLOYEES;

--7)
SELECT D.DEPARTMENT_NAME, L.CITY, COUNT(E.EMPLOYEE_ID) AS "Nr. angajati", AVG(E.SALARY) AS "Salariu mediu"
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID 
GROUP BY D.DEPARTMENT_NAME, L.CITY;

--8)
SELECT EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);

--9)
SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
GROUP BY MANAGER_ID
HAVING MIN(SALARY) > 1000
ORDER BY MIN(SALARY) DESC;

-- 10)
SELECT E.DEPARTMENT_ID, D.DEPARTMENT_NAME, MAX(E.SALARY) 
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY E.DEPARTMENT_ID, D.DEPARTMENT_NAME
HAVING MAX(E.SALARY) > 3000;

-- 17)
SELECT D.DEPARTMENT_NAME, MIN(SALARY)
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME;
HAVING AVG(SALARY) = (SELECT MAX(AVG(SALARY)) FROM EMPLOYEES GROUP BY DEPARTMENT_ID);

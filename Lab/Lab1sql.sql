select * from employees;

describe employees;

select employee_id from employees;

SELECT employee_id, salary sal
FROM employees
WHERE salary > 10000
AND employee_id < 150
ORDER BY sal DESC;

SELECT job_id, min_salary "Salariul minim", max_salary, max_salary - min_salary AS "diferenta calcul"
FROM jobs; 

DESCRIBE employees;

SELECT  first_name || ' ' || last_name || ' , ' ||job_id || ' , ' || hire_date AS "Angajat si titluri"
FROM employees;

SELECT 1+2
FROM dual; --1 raspuns

SELECT 1+2
FROM employees; --107 raspunsuri

SELECT sysdate
FROM dual;

SELECT to_char(sysdate, 'DAY/MM/YEAR')
FROM dual;

SELECT to_char(hire_date, 'Month'), to_char(hire_date, 'DAY')
FROM employees;

SELECT first_name, salary , nvl(commission_pct , 0) comis
FROM employees
ORDER BY comis DESC;
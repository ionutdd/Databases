--Lab7-9 prima parte e necesar codul luat de pe Teams




--Sa se afiseze id-ul, numele departamentului si salariul mediu din departamentul avand cel mai mare salariu mediu.

SELECT d.department_id, d.department_name, round(avg(e.salary))
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING round(avg(e.salary)) = (SELECT max(round(avg(e.salary)))
                        FROM employees e, departments d
                        WHERE d.department_id = e.department_id
                        GROUP BY d.department_id);
                        
                        
--Pt fiecare departament, afisati id, nume ordonnat, suma sal, nr angajati.



--sa se afiseze numele departamenetului si cel mai mic salariu din departamentul avand cel mai mare salariu mediu.

SELECT d.department_id, d.department_name, round(avg(e.salary)) , min(salary)
FROM employees e, departments d
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING round(avg(e.salary)) = (SELECT max(round(avg(e.salary)))
                        FROM employees e, departments d
                        WHERE d.department_id = e.department_id
                        GROUP BY d.department_id);
                   
            
--S? se afi?ezecodul, numele departamentului ?i num?rul de angaja?i care lucreaz? în acel departament pentru:
--a)departamentele în care lucreaz? mai pu?in de 4 angaja?i;       
                   
SELECT d.department_id, d.department_name, count(*)
FROM departments d, employees e
WHERE d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING count(d.department_id) < 4;
                        
                        
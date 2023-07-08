--care este angajatul/angajatii cu acest salariu maxim din fiecare departament? 

select employee_id, last_name , department_id, salary 
from employees 
where (department_id, salary) in (select department_id, max(salary) 
                                    from employees 
                                    group by department_id) 
order by department_id; --11 rez 


--R: v2 -- subcerere corelata 

select e.employee_id, e.last_name , e.department_id, e.salary 
from employees e  -- linie candidat e..... 
where e.salary = (select max(salary)  -- calculam salariul maxim pentru linia candidat 
                  from employees b 
                  where b.department_id = e.department_id 
                  --fara clauza de GROUP BY!!!!!! 
                 ) 
order by department_id; --11 rez 
 
--R: v3 -- SELECT folosit in clauza FROM 

select employee_id, last_name , department_id, salary, sal_max 
from employees e, (select department_id dept_id, max(salary) sal_max 
                  from employees 
                  group by department_id) dept_sal  --tabela 
where e.department_id = dept_sal.dept_id 
and e.salary = dept_sal.sal_max 
order by department_id; --11 rez 


--12. S? se afi?eze minimul, maximul, suma ?i media salariilor pentru fiecare job. _+titlu_job 

select e.job_id, job_title, max(salary) Maxim, min(salary) MINIM, sum(salary) TOTAL, round(avg(salary)) MEDIA,  
        count(employee_id) NR_ang 
from employees e, jobs j 
where e.job_id = j.job_id 
group by e.job_id, job_title; 
 

17. S? se afi?eze codul ?i numele angaja?ilor care câstig? mai mult decât  
salariul mediu din firm?. Se va sorta rezultatul în ordine descresc?toare a salariilor. 
  

--care este salariul mediu din firma? 

select avg(salary) 
from employees; 
--6461,682242990654205607476635514018691589 


select employee_id, last_name, salary 
from employees 
where salary> (select avg(salary) 
                from employees) 
order by salary desc;    


--17". S? se afi?eze codul ?i numele angaja?ilor care câstig? mai mult decât  
--salariul mediu din departamentul in care lucreaza. 
--Se va sorta rezultatul în ordine descresc?toare a salariilor. 

select e.employee_id, e.last_name, e.salary, department_id 
from employees e 
where e.salary> (select avg(a.salary) --salariul mediu din departamentul in care lucreaza. 
                from employees a 
                where a.department_id = e.department_id) --fara group by!!! 
order by  e.salary desc;  --38 rez 

---V2:  

select employee_id, first_name || ' ' || last_name, salary,aux.sal 
from employees e,(select department_id, avg(salary) sal 
                  from employees 
                  group by department_id) aux 
where e.department_id=aux.department_id  
and salary > aux.sal 
order by 3 desc;--38 rez 

--Sa se afiseze cel mai mare sal, cel mai mic sal, suma si media sal fara virgula
SELECT max(salary) as "MAXIM" , min(salary) as "MINIM" , sum(salary) as "SUMA" , round(avg(salary)) as "MEDIA"
FROM employees;

--Sa se determine nr de angajati care sunt sefi

SELECT count(distinct(manager_id))
FROM employees;

--Sa se afiseze nume departament, locatia, nr ang, si sal mediu
SELECT d.department_name, l.city, count(e.employee_id), avg(e.salary)
FROM departments d, locations l, employees e
WHERE d.location_id = l.location_id and e.department_id = d.department_id
GROUP BY d.department_id,d.department_name, d.location_id, l.city;
   
   --varianta cu select in line view
select department_name, city, nr_ang, sal_mediu, aux.dept_id 
from locations l, departments d,  
    (select department_id dept_id, count(*) nr_ang, round(avg(salary)) sal_mediu --- trebuie sa pune alias pt coloanele cu fct de agregare 
    from employees 
    group by department_id) aux 
where l.location_id = d.location_id 
and aux.dept_id = d.department_id; 

--Ex:  Sa se afiseze codul si numele angajatilor care câstiga   
--cel mai mult pe job-ul pe care lucreaza. 
--Se va sorta rezultatul în ordine descrescatoare a salariilor.   


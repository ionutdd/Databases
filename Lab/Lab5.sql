--Lab5

CREATE TABLE ANGAJATI_DIA(cod_ang number(4),    --facem tabela
    nume varchar2(20),
    prenume varchar2(20),
    email char(15),
    data_ang  date,
    job  varchar2(10),
    cod_sef  number(4),
    salariu  number(8,  2),
    cod_dep number(2));
    
DROP TABLE ANGAJATI_DIA;  --ii dam drop

CREATE TABLE ANGAJATI_DIA   --ii adaugam acum constrangeri; ar trebui sa si adaugam denumire la fiecare constrangere. e good practice
    (cod_ang number(4) PRIMARY KEY,
    nume varchar2(20) NOT NULL,
    prenume varchar2(20),
    email char(15),
    data_ang  date DEFAULT SYSDATE,
    job  varchar2(10),
    cod_sef  number(4),
    salariu  number(8,  2) NOT NULL,
    cod_dep number(2));
    


--adaugam niste linii in tabel

insert into angajati_DIA(Cod_ang,Nume,Prenume,Email,Data_ang,Job,Cod_sef,Salariu,Cod_dep)
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);
select * from angajati_DIA;

insert into angajati_DIA
values (101, 'Nume2','Prenume2','Nume2@gmail.com',
        to_date('02-02-2004', 'dd-mm-yyyy'), 'Inginer',	100,10000,10);
        
insert into angajati_DIA
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', 
        to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20);

insert into angajati_DIA
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', 
        to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20);

insert into angajati_DIA (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);


insert into angajati_DIA
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30);

commit;

SELECT * FROM ANGAJATI_DIA;


--3 creati tabela angajati10 copiind angajatii din departamentul cu doul 10

CREATE TABLE ANGAJATI10_DIA AS SELECT * FROM ANGAJATI_DIA WHERE cod_dep = 10;

SELECT * FROM ANGAJATI10_DIA; --2rez


--4 Introduceti coloana de comision in tabela ANGAJATI_DIA

ALTER TABLE ANGAJATI_DIA
ADD (comision number(4,2));


--5 Este posibil modificarea tipului coloanei comision in NUMBER(6,2)?

ALTER TABLE ANGAJATI_DIA
MODIFY (comision NUMBER(6,2));


--6 Setati o valoare DEFAULT pt coloana salariu

ALTER TABLE ANGAJATI_DIA
MODIFY(salariu default 1111);


--7 Modificati tipul coloanei comision in NUMBER(2,2) si al coloanei salariu in NUMBER(10,2)

ALTER TABLE ANGAJATI_DIA
MODIFY (salariu NUMBER(10,2),
        comision NUMBER(2,2));
        

--8 Actualizati valoarea coloanei comision setand-o la valoarea 0.1 pt salariatii al caror job incepe cu litera I (UPDATE)

UPDATE ANGAJATI_DIA
SET comision = 0.1
WHERE lower(job) LIKE 'i%';




DROP TABLE ANGAJATI10_DIA;


-- 15. Creati tabelul DEPARTAMENTE_DIA, corespunzator schemei relationale:
-- DEPARTAMENTE_DIA (cod_dep# number(2), nume varchar2(15), cod_director number(4))
-- specificand doar constrangerea NOT NULL pentru nume
-- (nu precizati deocamdata constrangerea de cheie primara). 

CREATE TABLE departamente_DIA 
(cod_dep number(2), 
nume varchar2(15) constraint NL_nume_DIA NOT NULL, 
cod_director number(4)); 

--inseram in departamente

insert into departamente_DIA
values(10,	'Administrativ',	100);
insert into departamente_DIA
values(20, 'Proiectare',	101);
insert into departamente_DIA
values(30,	'Programare',	Null);
-- atentie
insert into departamente_DIA
values(30,	'DE_STERS',	Null);


DESC departamente_DIA;


-- 18.

alter  table angajati_DIA
add  constraint fk_ang_depart_DIA foreign key(cod_dep) references departamente_DIA(cod_dep);


--18b

drop table angajati_DIA; --table ANGAJATI_DIA dropped.

create table ANGAJATI_DIA(
  cod_ang number(4) constraint pk_ang_DIA primary key, 
  nume varchar2(20) constraint null_nume_DIA not null, 
  prenume varchar2(20), 
  email char(15) constraint unq_email_DIA unique, 
  data_ang date default sysdate, 
  job varchar2(10), 
  cod_sef number(4) constraint fk_ang_ang_DIA references angajati_DIA(cod_ang), 
  salariu number(8, 2),
  cod_dep number(2) constraint ck_cod_dep_DIA check(cod_dep>0), 
  comision number(4,2),
  constraint unq_nume_pren_DIA unique(nume, prenume),
  constraint ck_sal_com_DIA check( salariu>comision *100),
  constraint fk_ang_depart_DIA foreign key(cod_dep) references departamente_DIA(cod_dep)--se poate punse si la nivel de coloana
    );
    
--bagam in angajati 

insert into angajati_DIA(Cod_ang,	Nume	,Prenume,	Email,	Data_ang	,Job,	Cod_sef,	Salariu,	Cod_dep)
values( 100	,'Nume1',	'Prenume1',	Null	,Null,	'Director',	null,	20000	,10);


insert into angajati_DIA
values (101, 	'Nume2',	'Prenume2',	'Nume2@gmail.com', to_date(	'02-02-2004', 'dd-mm-yyyy'), 	'Inginer',	100,	10000	,10, 0.1);

insert into angajati_DIA
values (102, 'Nume3', 'Prenume3', 'Nume3@gmail.com', to_date('05-06-2004', 'dd-mm-yyyy'), 'Analist', 101, 5000, 20, null);

insert into angajati_DIA (Cod_ang, Nume, Prenume, Job, Cod_sef, Salariu, Cod_dep)
values (103, 'Nume4', 'Prenume4', 'Inginer', 100, 9000, 20);
--atentie la data de angajare a lui 103 

insert into angajati_DIA
values (104, 'Nume5', 'Prenume5', 'Nume5@gmail.com', Null, 'Analist', 101, 3000, 30, 0.2);

select * from angajati_DIA;
commit;

--26

insert into departamente_DIA
values(60,	'Testare',	null); --1 rows inserted.
commit;

28. ªtergeti departamentul 60 din DEPARTAMENTE_pnu. ROLLBACK.

select * from departamente_***;
delete from departamente_***
where cod_dep =60; --1 rows deleted.
commit;

--31

SELECT constraint_name, constraint_type, table_name
FROM     user_constraints
WHERE  lower(table_name) IN ('departamente_dia', 'angajati_dia');


alter table angajati_DIA
drop constraint FK_ANG_DEPART_DIA;
--table ANGAJATI_DIA altered.

alter table angajati_DIA
add constraint FK_ANG_DEPART2_DIA foreign key(cod_dep) 
            references departamente_DIA(cod_dep) on delete cascade;
            
--32. ªtergeti departamentul 20 din DEPARTAMENTE_pnu. Ce se intampla? Rollback.

select * from angajati_DIA;

delete from departamente_DIA 
where cod_dep =60;
commit;

select * from angajati_DIA;

ROLLBACK;

select * from angajati_DIA; --7 rez
select * from departamente_DIA; --3 rez


alter table angajati_DIA
drop constraint fk_ang_depart2_DIA;

alter table angajati_DIA
add constraint fk_depart_DIA3 foreign key(cod_dep) 
        references departamente_DIA(cod_dep) on delete set null;
        
SELECT * FROM angajati_dia;



--38. Creati o secventa pentru generarea codurilor de departamente, SEQ_DEPT_PNU. 
Secventa va incepe de la 400, va creste cu 10 de fiecare data si va avea valoarea maxima 
10000, nu va cicla si nu va incarca nici un numar inainte de cerere.

create  sequence seq_dept_DIA
start with 400
increment by 10
maxvalue 10000
nocycle
nocache;
--Sequence SEQ_DEPT_DIA created.

select seq_dept_DIA.nextval
from dual;

select seq_dept_DIA.currval
from dual;

insert into departamente_DIA
values(seq_dept_DIA.nextval, 'Dept_sec', null);  --420
--SQL Error: ORA-01438: valoare mai mare decat precizia specificata permisa pentru aceasta coloana

insert into dept_DIA
values(seq_dept_DIA.nextval, 'Dept_sec', null, null); 
--1 rows inserted.
select * from dept_DIA;
--430	Dept_sec		null null
--440	Dept_sec		null null 




SELECT last_name, hire_date  FROM employees WHERE  hire_date > (SELECT hire_date  FROM  employees WHERE  INITCAP(last_name)='Gates');

describe employees;

SELECT last_name, salary from employees
WHERE manager_id = (SELECT employee_id FROM employees WHERE manager_id is NULL);
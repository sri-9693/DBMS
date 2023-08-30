--table creation and insertion of values
create table emp1(emp_id int primary key,emp_name varchar(20) NOT NULL,emp_dept varchar(10));
insert into emp1 values(10,'Ajay','IT'),(20,'Vijay','SALES'),(30,'Ravi','Finance');

--table creation and insertion of values
create table baccount1(emp_id int,acc_no bigint,bname varchar(10),bank_id int primary key);

alter table baccount1 add foreign key(emp_id) references emp(emp_id);

insert into baccount1 values(10,1234345645,'Axis',1),(10,456889848,'HDFC',2),(10,567946573,'UBI',3);
insert into baccount1 values(20,356647887,'SBI',4),(20,987687664,'KOTAK',5),(20,897646794,'DBS',6);
insert into baccount1 values(30,257655476,'HDFC',7),(30,687988783,'AXIS',8),(30,786876948,'PNB',9);

--table creartion and insertion of values
create table sal1(bank_id int,sal_id int primary key,emp_sal decimal,sal_for_month varchar(20));

alter table sal1 add foreign key(bank_id) references baccount1(bank_id);

insert into sal1 values(1,01,20000,'29-09-2002'),(1,02,30000,'14-10-2002'),(2,03,40000,'27-11-2002'),(3,04,40000,'25-12-2002');
insert into sal1 values(4,05,50000,'29-09-2002'),(5,06,60000,'14-10-2002'),(5,07,60000,'27-11-2002'),(6,08,70000,'25-12-2002');
insert into sal1 values(7,09,70000,'29-09-2002'),(8,10,70000,'14-10-2002'),(9,11,80000,'27-11-2002'),(9,12,90000,'25-12-2002');

select * from emp1;
select * from sal1;
select * from baccount1;


--Attendence table creation 

create table attendence(a_id int primary key,login_time time,logout_time time,working_hours int,no_of_leaves int,emp_id int,attendence_for_day int);

alter table attendence add foreign key(emp_id) references emp1(emp_id);
--Insertion of values 
insert into attendence values(101,'7:00:00','6:00:00',9,3,10,1),
                               (102,'8:00:00','7:00:00',8,2,10,2);

insert into attendence values(103,'7:45:00','6:45:00',7,0,20,1),
                               (104,'8:00:00','7:00:00',8,2,20,2);
select * from attendence;


--Employee tabe creation

create table employee2(emp_id int,emp_code varchar(20),emp_name varchar(10),
                             primary key(emp_id,emp_name));
--salary table creation
create table salary2(emp_id int,sal_id int primary key,
             emp_name varchar(10),emp_sal decimal,
	constraint abc foreign key(emp_id,emp_name) references employee2(emp_id,emp_name));

insert into employee2 values(10,'ABC01','Ajay'),(11,'DEF02','Vijay'),(12,'IJK03','Bhargav');

insert into salary2 values(10,101,'Ajay',50000),(11,102,'Vijay',60000),
                          (12,103,'Bhargav',70000);
insert into salary2 values(10,104,'Ramesh',40000);

select * from employee2;
select * from salary2;

drop table salary2;
drop table employee2;

alter table salary2 drop constraint abc;


--adding constraint to column after table creation
create table employee4(emp_id int primary key,emp_name varchar(20),
             emp_age int,emp_sal decimal,com_name varchar(20)NOT NULL default 'prolifics'); 

alter table employee4 add constraint abc default('prolifics') for com_name ;

insert into employee4 values(10,'Ajay',25,60000);

insert into employee4(emp_id) values(20);

--Assignment

create table employee4(emp_id int primary key,emp_name varchar(20),emp_sal decimal);

alter table employee4 add constraint sal_restriction check(emp_sal>50000);

alter table employee4 add constraint abc default(70000) for emp_sal;

insert into employee4(emp_id,emp_name) values(102,'Vijay');

select * from employee4;


--Assignment 1
create table employee5(emp_id int primary key,emp_name varchar(20) default 'Prolifics',
                    emp_age int check(emp_age>18 and emp_age <60));

create table salary5(sal_id int primary key,emp_sal int check(emp_sal>10000),
           emp_id int foreign key references employee5(emp_id),salary_for_month date);

insert into employee5 values(101,'Ajay',25),(102,'Vijay',30),(103,'Bhargav',32);

insert into employee5(emp_id,emp_age) values (104,37);

select * from employee5;

insert into salary5 values(1,20000,101,'2022-09-29'),
                          (2,30000,101,'2022-10-28'),
						  (3,40000,101,'2022-11-29');

insert into salary5 values(4,25000,102,'2022-09-27'),
                          (5,39000,102,'2022-10-23'),
						  (6,50000,102,'2022-11-12');

insert into salary5 values(7,30000,103,'2022-09-30'),
                          (8,35000,103,'2022-10-23'),
						  (9,49000,103,'2022-11-25');

insert into salary5(sal_id,emp_sal) values(10,5000);

select * from salary5 where emp_id=101;


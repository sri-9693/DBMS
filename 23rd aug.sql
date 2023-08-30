create table emp9(id int identity(1,1) primary key,
name varchar(20),age int,sal int);

insert into emp9 values('Ramesh',23,3000),('Raju',23,4000),('Rajamouli',45,5000);
insert into emp9 values('Varma',89,7000), ('Varma',21,9000);
--update more than one column
update emp9 set name='Raju' where id=2;
update emp9 set name='Vijay',age=21 where id=3;

select * from emp9;
--delete data
delete from emp9 where id=3;
--delete entire table
delete from emp9;
-------------------------------------------------------------
delete from orderitem where orderitem_id = 653;
select * from orderitem;
update orderitem set book_id=3 where orderitem_id=879;
-------------------------------------------------------------
select top 2 * from emp9;

select top 50 percent * from emp9 where name='Vijay';

--To show any particular row
select * from emp9 order by id offset 2 rows fetch next 1 row only;

--works with the text datatype--
alter table emp9 alter column name text;
--shows name that start with vijay
select * from emp9 where name like 'vijay%';
--shows name that end with vijay
select * from emp9 where name like '%vijay';
--shows names which doesnot start with v
select * from emp9 where name Not Like 'v%';
--shows names that has i in their second position
select * from emp9 where name like '_i%';
--shows names that has a in any position
select * from emp9 where name like '%a%'

--To know no of records
select COUNT(id) from emp9;
--Total sum
select sum(sal) from emp9;
--Average
select avg(sal) from emp9;

--fetch values where id between and not between specific values
select * from emp9 where id in(1,2,3);
select * from emp9 where id not in(1,2,3);

--fetch details where salary between and not between specific values
select * from emp9 where sal between 3000 and 7000;
select * from emp9 where sal not between 4000 and 7000;

create table fb(id int identity(1,1) primary key,
name varchar(20),age int);
create table sb(id int identity(1,1) primary key,
name varchar(20),age int);

insert into fb values('Kiran',21),('PS',20),('Raju',23);
insert into sb values('Michael',21),('Sherlock',23),('James',19);
insert into sb values('Kiran',21);

--Merging table
select * from fb where age=21 union select * from sb where age=21;
select name from fb union select name from sb;
select name from fb union all select name from sb;

create table t1(id int identity(1,1) primary key,name varchar(10),
 trainer_name varchar(20),age int);
 create table t2(id int identity(1,1) primary key,name varchar(10),age int);

 insert into t1 values('Raju','Nitesh',23),('Ajay','Nitesh',21);
 insert into t2 values('Ramesh',21),('Suresh',23);

 select * from t1 union select * from t2;
 select * from t1;
 select * from t2;
 ------------------------------------------------------------------------------
 
 create table emp10(emp_id int primary key,first_name varchar(10),
 last_name varchar(10),age int,salary money);

 insert into emp10 values(1,'john','smith',30,60000),
                         (2,'emily','johnson',28,55000),
						 (3,'michael','williams',32,62000);

create table empc(c_id int primary key,emp_id int foreign key references
emp10(emp_id) on delete cascade
,email varchar(30),
phone numeric);

insert into empc values(1,1,'abc@gmail.com',765326536),
                        (2,1,'def@rediff.com',63056464);
insert into empc values(3,2,'djhj@hotmail.com',8756765344),
                        (4,2,'def@yahoo.com',7864764876);
insert into empc values(5,3,'vathsa@gmail.com',65645744344),
                        (6,3,'raju@rediff.com',9868747665);
select * from emp10

----TASK----

--salary updation
update emp10 set salary=65000 where emp_id=1;
--age updation
update emp10 set age=29,salary=58000 where emp_id=2;
--deletion
delete from emp10 where emp_id =3; 
--deletion of all records
delete from empc;

--Truncate is used to delete entire data in table 
--Delete is used to delete specific row in a table

--retriving first 50 percent employee data based on name in asc
select top 50 percent * from emp10 order by first_name asc;
--retriving names of employees name start with J
select * from emp10 where first_name like 'J%';
--retriving names of employees name end with n
select * from emp10 where first_name like '%n';
--retriving names of employees containing letter i at any pos
select * from emp10 where first_name like '%i%';
--retriving names of employees start with M and end with L
select * from emp10 where first_name like 'M%L';
--retriving names of employees whose names have O as 2nd character
select * from emp10 where first_name like '_O%';
--retriving names of employees whose names doesnt start with J
select * from emp10 where first_name NOT LIKE 'J%';



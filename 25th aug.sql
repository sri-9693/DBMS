create table cust3(cust_id int primary key,
cust_name varchar(20));

insert into cust3 values(1,'Ajay'),(2,'Vijay'),(3,'sanjay');

create table pro3(pro_id int primary key,
pro_name varchar(20));

insert into pro3 values(10,'Washing Machine'),(11,'Tooth Brush'),
(12,'Book');

create table ord3(ord_id int primary key,cust_id int foreign key references 
cust3(cust_id),pro_id int foreign key references pro3(pro_id),
delivered_date date);

insert into ord3 values(101,1,10,getdate()),(102,2,11,getdate()),(103,3,12,getdate());

select ord3.ord_id,cust3.cust_name,pro3.pro_name from 
((ord3 inner join cust3 on ord3.cust_id=cust3.cust_id)
inner join pro3 on ord3.pro_id=pro3.pro_id);

--------------------------------------------------------------------------------
create table p10(id int identity(1,1) primary key,
name varchar(10));
insert into p10 values('nitesh'),('Ramesh'),('Suresh');
---Creating a view
create view test as 
select * from p10 union all select * from pro3
select * from test

--creating stored procedure and reading data
create procedure spname as
select * from pro3

---For calling stored procedure
exec spname

---For inserting data
create procedure spname3 as
insert into pro3 values(13,'ABC'),(14,'DEF')
select * from pro3

exec spname3
---------------------------------------------------------------------------
---Create Variable

declare @varname varchar(100);

--setting the value
set @varname='Employee'

select charindex('p',@varname) as ResultString
select charindex('l',@varname) as ResultString
select charindex('m',@varname) as ResultString

---CONCAT---
select concat('sri','vathsa') as Name;
--LOWER--
select lower('Hello WORld') as lowercase;
--REPLACE--
select replace('Kiran Kumar','k','M') as replace;
--TRIM--
select trim('      Srivathsa   ..!!   ') as trimmedstring;
--LENGTH--
select len('Srivathsa');
--NUMERIC--
select ISNUMERIC(6546);
--CEILING--(returns integer that is greater than or equal to given no)
select ceiling(29.3) as ceilvalue;
--FLOOR--
select floor(29.9) as floorvalue;
--SQUARE--
select square(8);
--DATEDIFF--
select datediff(year,'2020-08-29','2022-08-29') as datediff;
-------------------------------------------------------------------
---Crating table with indexing---
Create Table Employees27
(
Id int primary key identity,
Name nvarchar(50),
Email nvarchar(50),
Department nvarchar(50)
)

Go
SET NOCOUNT ON
Declare @counter int = 1
While(@counter <= 1000000)
Begin
Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter)+'@pragimtech.com'
Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)
Insert into Employees27 values (@Name, @Email, @Dept)
Set @counter = @counter +1
If(@Counter%100000 = 0)
Print RTRIM(@Counter) + ' rows inserted'
End

select * from Employees27 where Id=12;

-----Creating without indexing
Create Table Employees28
(
Id int identity,
Name nvarchar(50),
Email nvarchar(50),
Department nvarchar(50)
);

Go
SET NOCOUNT ON
Declare @counter int = 1
While(@counter <= 1000000)
Begin
Declare @Name nvarchar(50) = 'ABC ' + RTRIM(@counter)
Declare @Email nvarchar(50) = 'abc' + RTRIM(@counter)+'@pragimtech.com'
Declare @Dept nvarchar(10) = 'Dept ' + RTRIM(@counter)
Insert into Employees28 values (@Name, @Email, @Dept)
Set @counter = @counter +1
If(@Counter%100000 = 0)
Print RTRIM(@Counter) + ' rows inserted'
End

---With Indexing
select * from employees27 where id=12;
---WithOut Indexing
select * from employees28 where id=12;
----------------------------------------------------------------------
----Convert one datatype to another
select cast(26.99 as int) as convertedvalue;

create table pikachu(abc_id int identity(1,1) primary key,
abc_name text);
insert into pikachu values('Ramesh'),('Ajay');
insert into pikachu values('Ravi');

select cast( abc_name as varchar(10)) from pikachu;

----Using IIF----
create table marks(id int primary key,marks int)
insert into marks values(1,90),(2,85),(3,79),(4,67);

select id,iif(marks>80,'pass','fail') from marks;
---------------------------------------------------------
select isnumeric(373);
select isnumeric('hi');
---------------------------------------------------------
declare @n1 int;
declare @n2 int;
set @n1 =2
set @n2 = 2;

select sum(@n1+@n2-1) 

create table exam(id int identity(1,1) primary key,
name varchar(20),historymarks int,chemistrymarks int);
insert into exam values('Nitesh',80,90),('rahul',78,90);

select * from exam
-------Creating a function--------
create function getmarks(@fn int,@sn int)
returns varchar(20)
as
begin

return @fn+@sn;
end

select name,dbo.getmarks(historymarks,chemistrymarks) as result 
from exam ;

-----Modifying existing function------
alter function getmarks(@fn int,@sn int)
returns varchar(10)
as
begin 
    return @fn * @sn
end

select name,dbo.getmarks(historymarks,chemistrymarks) as result 
from exam ;
----To Drop a function-----
drop function if exists getmarks;

--------------------------------------------------------------------
----ASSIGNMENT----

create table students(stu_id int primary key,
stu_name varchar(20));

insert into students values(1,'Naruto'),(2,'Sasuke'),(3,'Rocklee');

create table courses(c_id int primary key,
c_name varchar(20));

insert into courses values(101,'Ninjutsu'),(102,'Genjutsu'),
(103,'Taijutsu');

create table enrollments(e_id int primary key,
stu_id int foreign key references students(stu_id),
c_id int foreign key references courses(c_id),
grade char(2));

insert into enrollments values(1001,1,101,'B'),(1002,1,102,'C'),
(1003,2,102,'B'),(1004,2,101,'A'),
(1005,3,103,'A'),(1006,3,101,'F');

select * from students
select * from courses
select * from enrollments
-----------------------------------------------------------
----GPA FUNCTION-----
create function calculate_gpa(@stu_id int) returns dec(3,2)

Begin
   declare @total_points decimal(10,2);
   declare @total_credits int;
   declare @gpa decimal(4,2);

   select @total_points=coalesce(sum(
 case grade
 when 'A' Then 4.0
 when 'B' Then 3.0
 when 'C' Then 2.0
 when 'D' Then 1.0
 when 'F' Then 0.0
 else 0.0
End 
),0) 

From enrollments
where stu_id=@stu_id;

select @total_credits=count(*)
from enrollments
where stu_id=@stu_id

if @total_credits>0
 set @gpa=@total_points/@total_credits;
else
 set @gpa=0.0

return @gpa;
End

select stu_id,stu_name,dbo.calculate_gpa(stu_id) as GPA 
from students;
----------------------------------------------------


















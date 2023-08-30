create table sample1(
id int identity(1,1) primary key,
name varchar(20));

select * from sample1

begin transaction
insert into sample1 values('raju');
insert into sample1 values('ramesh');
insert into sample1 values('rajesh');

commit
rollback

begin transaction
create procedure s9
as
select * from sample1
go

exec s9
----------------------------------------------------------------------
create table sample4(
id int identity(1,1) primary key,
name varchar(20));

select * from sample4

begin transaction
insert into sample4 values('raju');
insert into sample4 values('ramesh');

commit
insert into sample4 values('rajesh');

rollback

truncate table sample4

begin transaction
insert into sample4 values('raju');
save transaction s1
insert into sample4 values('ramesh');
save transaction s2
insert into sample4 values('rajesh');
save transaction s3

rollback transaction s2
---------------------------------------------------------------------------
create table emp25(emp_id int primary key,
emp_name varchar(20));

create table sal25(sal_id int primary key,
emp_id int foreign key references emp25(emp_id),
salary money,credited_date date,credited_for_month varchar(20));

create table report(id int identity(1,1) primary key,
emp_id int foreign key references emp25(emp_id),
sal_id int foreign key references sal25(sal_id),
salary money,credited_date date);


insert into emp25 values(1,'Ajay'),(2,'Vijay');

insert into sal25 values(101,1,10000,getdate(),'Jan'),
(102,1,20000,getdate(),'Feb'),
(103,2,15000,getdate(),'Jan'),(104,2,30000,getdate(),'Feb');

----CREATING A TRIGGER-----
create trigger trgafterinsert on [dbo].[Emp25]
for insert
as
declare @empid int
declare @empname varchar(100);
declare @empsal decimal(10,2);

select @empid=i.emp_id from inserted i;
select @empname=i.emp_name from inserted i;
select @empsal=i.salary from inserted i;

-------------------------------------------------------------------------
create table bt(
name varchar(20),
age int)

create table bt1(
name varchar(20),
age int)
---------Creation of trigger for insertion for a particular row---------
create trigger za on dbo.bt
for insert
as
declare @name varchar(20),@age int

select @name=i.name from inserted i
select @age=i.age from inserted i

insert into bt1 values(@name,@age)

select * from bt
select * from bt1

insert into bt values('Raju',23);
insert into bt values('Venkat',29);

-----Trigger to insert complete data---------
create trigger abcd on dbo.bt
for insert
as

insert into bt1 select * from inserted

select * from bt
select * from bt1

insert into bt values('Raju',23);
insert into bt values('Venkat',29);

----------------------------------------------------------------------------
-----------------------------------------------------------------------------
----Creation of trigger for deletion for specific column----
create trigger yyy on dbo.bt
for delete
as
declare @age int
select @age=d.age from deleted d

delete from bt1 where @age=age

select * from bt
select * from bt1

delete from bt where age=23
----Trigger to delete entire data-----

create trigger rykj on dbo.bt
for delete
as

delete from bt1 

select * from bt
select * from bt1

delete from bt 

----------------------------------------------------------------------------
----Trigger for Updation----
create trigger spf on dbo.bt
for update
as
declare @name varchar(10)
declare @age int

select @name=u.name from inserted u
select @age=u.age from inserted u

update bt1 set name=@name where age=@age

select * from bt
select * from bt1

update bt set name='Ajay' where age=23

--------------------------------------------------------------------------
create table Monthlysalary(emp_id int,
salary_amount money)

create table Reportsalary(emp_id int,
total_amount_paid money)

--Trigger to update salary
create trigger totalsalaryupdate on dbo.Monthlysalary
for insert
as
begin

declare @emp_id int,@amount money,@total_amount money

select @emp_id=emp_id from inserted 
select @amount=salary_amount from inserted

select @total_amount=total_amount_paid from reportsalary 
where emp_id=@emp_id 

if(@total_amount is not null)
  BEGIN
    set @total_amount=@amount+@total_amount
	update reportsalary set total_amount_paid = 
	@total_amount where emp_id=@emp_id
	print 'Updated'
  END
else
  BEGIN
     insert into reportsalary values(@emp_id,@amount)
     print 'Inserted'
  END

end

insert into monthlysalary values(1,30000)
insert into monthlysalary values(1,40000)
insert into monthlysalary values(2,10000)
insert into monthlysalary values(3,30000)
insert into monthlysalary values(2,20000)

select * from monthlysalary
select * from reportsalary





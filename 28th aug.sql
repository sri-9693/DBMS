create function plus(@num1 int,@num2 int,@month int) returns decimal(10,4)
Begin
  return @num1+@num2+@month;

End

select dbo.plus(2,2,8) as result
---------------------------------------------------------------------------------
create table cd(id int identity(1,1) primary key,
car_name varchar(20),
man_year int);
insert into cd values('BMW',1997),('Ferrari',2002),('volvo',2002),('Porshe',1997),
('Audi',2000);
---Function Creation
create function cardetails(@man_year int) returns table

 return select * from cd where man_year=@man_year;

select * from dbo.cardetails(1997);
---------------------------------------------------------------------------------
create table b1(id int identity(1,1) primary key,
name varchar(20));
insert into b1 values('harhsa'),('Ravi'),('Ramesh'),('Kiran');

create table b2(id int identity(1,1) primary key,
name varchar(20));
insert into b1 values('Arvind'),('Alluarjun'),('Priya'),('Anupama');

select * from b1 union select * from b2

---Using function
create function combine() returns table
As
 return select * from b1 union select * from b2

 select * from dbo.combine()

-----creating a new table in return type itself--------
create function comb1() returns @comb table(id int primary key,name varchar(20))
As
Begin
 insert into @comb
 select * from b1;

 insert into @comb
 select * from b2;

return 

end

select * from dbo.comb1();
-------------------------------------------------------------
create table cust5(id int primary key,
cust_name varchar(20));
insert into cust5 values(1,'Rajesh'),(2,'Ravi'),(3,'Raju'),(4,'Ravinder'),
(5,'Uday');

create table orders5(o_id int primary key,id int foreign key references cust5(id),
o_amount money);
insert into orders5 values(101,1,100),(102,1,200),(103,2,300),
(104,3,150),(105,4,390),(106,5,460),(107,5,200);

---_With out function----
select cust5.cust_name,sum(orders5.o_amount) from 
cust5 inner join orders5 on cust5.id=orders5.id group by cust5.cust_name

----Using Function----
create function ordervalue()
returns @cost table(name varchar(20),price money)
As
begin

insert into @cost
select id from cust5

insert into @cost
select sum(o_amount) from orders5

 return
end

select * from dbo.ordervalue();

-----OR-----
create function total_price(@cust_id int) returns money
as 
begin
    declare @total_price money;
    select @total_price = sum(o_amount) from orders5 where id = @cust_id
    return @total_price;
end
select cust_name,dbo.total_price(cust_id) as total_purchase from cust5

------- JOINING TWO TABLES BY BREAKING QUERY------------
with customerTotalAmounts as 
(
select id,sum(o_amount) as totalamount from orders5 group by id
)
select cust5.cust_name,customerTotalAmounts.totalamount from cust5 inner join 
customerTotalAmounts on customertotalamounts.id=cust5.id;
--------------------------------------------------------------------------
create table item(item_id int primary key,
item_name varchar(20),o_id int foreign key references orders5(o_id));
insert into item values(1,'Fridge',101),(2,'TV',101),(3,'Fridge',102),
(4,'WM',102),(5,'Laptop',103),(6,'Sofa',104),(7,'Mobile',105);
---------------------------------------------------------------------------
create table orders5(o_id int primary key,id int foreign key references cust5(id),
o_amount money);
insert into orders5 values(101,1,100),(102,1,200),(103,2,300),
(104,3,150),(105,4,390),(106,5,460),(107,5,200);

select * from item
-----------------------------------------------------------------------------
create table batch1(id int identity(1,1) primary key,
name varchar(20),batch_no int);
insert into batch1 values('harhsa',1),('Ravi',1),('Ramesh',1),('Kiran',1),
('pranay',2),('Ram',2);

select * from batch1

select name,batch_no,ROW_NUMBER() 
over(partition by batch_no order by batch_no)as rownumber from batch1

select name,batch_no,row_number()
over(partition by batch_no order by batch_no)as rownumber,rank()
over (order by batch_no) as ranknumber,dense_rank() 
over(order by batch_no) as densenumber from batch1
-----------------------------------------------------------------------------
------ENTRY OF 500 VALUES-------
create table manyentries(
id int identity(1,1),
name varchar(20));

select * from manyentries
----WORKING OF LOOP----
declare @counter int;

set @counter=1;

while(@counter<=500)
BEGIN
  insert into manyentries values('Ajay');
  set @counter=@counter+1

END

---------------------------------------------------------------------------
create table student(s_id int primary key,
s_name varchar(20),
marks float, status varchar(10));

insert into student values(1,'Ramesh',45,'Pass'),
(2,'vijay',35,'Pass'),(3,'Bhargav',49,'Pass'),(4,'Ajay',39,'Pass');
insert into student values(5,'harsha',56,'pass'),(6,'sravan',19,'pass'),
(7,'bhavya',95,'pass'),(8,'salman',37,'pass'),(9,'venkatesh',56,'pass'),
(10,'Abhinav',56,'pass');

declare @counter int
declare @marks decimal
declare @total_rows int

set @counter=1;
select @total_rows = count(s_id) from student

while(@counter<=@total_rows)
begin
     select @marks=marks from student where s_id=@counter
	 if(@marks>40)
	    update student set status='pass' where s_id=@counter
	else
	    update student set status='fail' where s_id=@counter
	set @counter=@counter+1
end

select top 10 * from student

--Selecting top 10----
DECLARE @cnt int;
SELECT @cnt = COUNT(*) FROM student;
DECLARE @rows int = 1;

WHILE(@rows < 11 and @rows <= @cnt)
BEGIN
    IF (SELECT marks from student where s_id = @rows)>40
        update student set status= 'pass' where s_id = @rows;
    else
        update student set status= 'fail' where s_id = @rows;
    SET @rows = @rows + 1;
END
SELECT * FROM student

--------------------------------------------------------------------------------
-----TASK------
declare @counter int
set @counter=0;

while(@counter<15)
BEGIN
 set @counter=@counter+1

 if @counter>7 and @counter<11 continue

 print @counter

END
------------------------------------------------------------------------------
----Even Numbers---
declare @n1 int
set @n1=1

while(@n1<=20)
begin
  if @n1%2=0 
    print @n1
  set @n1=@n1+1
 
end
------------------------------------------------------------------------------













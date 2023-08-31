create database project2

use project2

-----------------------------------------------------------------------------------------
----CREATION OF AUTHOR TABLE----
create table Author(
auth_id int primary key,
Auth_name varchar(100),
Auth_country varchar(100),
created_date date,
);

----CREATION OF BOOKS TABLE----
create table Books(
book_id int primary key,
book_title varchar(100),
book_category varchar(100),
book_price money,
book_ISBN bigint UNIQUE,
auth_id int foreign key references author(auth_id),
created_date date,
);

----CREATION OF INVENTORY TABLE----
create table Inventory(
inventory_id int identity(301,1) primary key,
stock_level_used int,
stock_level_new int,
book_id int  foreign key references Books(book_id),
book_name varchar(100),
);


----CREATION OF CUSTOMER TABLE-----
create table customers(
cust_id int primary key,
cust_name varchar(100),
cust_mobile numeric(10,0),
street_name varchar(100),
postal_code int,
state varchar(100),
country varchar(100)
);

 
------CREATION OF ORDERS TABLE-----
create table orders(created_date date,
ord_id int identity(1,1) primary key,
cust_id int foreign key references customers(cust_id),
order_date datetime,
total_amount_after_tax int
);

 
-----CREATION  OF BUCKET TABLE----------
create table bucket(
book_id int  foreign key references Books(book_id),
cust_id int foreign key references customers(cust_id),
price money,
quantity int);


-----CREATION OF PAYMENT------
create table payment(created_date date,
pay_id int identity(601,1) primary key,
cust_id int foreign key references customers(cust_id),
order_date datetime,
tax money,
total_amount money);

 
-----CREATION OF ORDER-ITEM TABLE---
create table orderitems(created_date date,
item_id int identity(701,1) primary key,
ord_id int foreign key references orders(ord_id),
cust_id int foreign key references customers(cust_id),
book_id int foreign key references books(book_id),
order_date datetime
);
select * from inventory
------- REPORT------
Create table Reports
(
Report_id int identity(1,1) primary key,
Book_id int foreign key references Books(Book_id),
book_name varchar(40),
stock_level_used int not null,
Created_date date,
);

---------------------------------------------------

--creating procedure
create procedure view_books_by_title @book_title varchar(100)
as

select * from books where book_title=@book_title

exec view_books_by_title @book_title='One piece'


--creating procedure
----------------------------------------------------
create procedure view_books_by_Author @auth_id int
as

select * from books where auth_id=@auth_id


exec view_books_by_Author @auth_id=101

----------------------------------------------------
--creating procedure

create procedure view_books_by_category @book_category varchar(100)
as begin


select * from books where book_category=@book_category

end

exec view_books_by_category @book_category='Manga'

------------------------------------------------------------------------------------------------------
--creating stored procedure for inserting into bucket

create PROCEDURE insertintobucket(
    @book_id INT,
    @cust_id INT,
	@quantity int

)
as begin
declare @price money
select @price=book_price from books where book_id=@book_id

  insert into bucket(book_id,cust_id,price,quantity) values (@book_id, @cust_id,@price,@quantity); 

end
select * from customers
exec insertintobucket @book_id=210,@cust_id=501,@quantity=30;
exec insertintobucket @book_id=202,@cust_id=502
exec insertintobucket @book_id=203,@cust_id=503
exec insertintobucket @book_id=204,@cust_id=504

------------------------------------------------

------------procedure for bucket to payment-------------

alter procedure makepayment(@cust_id int)

as begin

declare @total_amount money,@stock_level_used int,@Book_id int
select @total_amount = sum(price)from bucket where cust_id=@cust_id

declare @total_amount_after_tax money
set @total_amount_after_tax=(@total_amount)*0.05 + @total_amount;

if(@total_amount is not null)

insert into payment(cust_id,total_amount) values(@cust_id,@total_amount_after_tax)

Update reports set stock_level_used = @stock_level_used where Book_id = @Book_id

end

 exec makepayment @cust_id =501

 select * from books
select * from customers
select * from payment
select * from inventory
select * from orders
select * from orderitems
---------------------------------------------------------------------------------

--creating trigger to insert into orders

alter trigger paymenttrigger on dbo.payment
for insert as begin

declare @cust_id int,@order_date date,@total_amount_after_tax money,@quantity int,@book_id int

select @cust_id=cust_id from bucket

select @order_date=order_date from inserted

select @total_amount_after_tax= total_amount from inserted
select @quantity = quantity from bucket where cust_id=@cust_id

select @book_id =book_id from bucket where cust_id=@cust_id


insert into orders(cust_id,order_date,total_amount_after_tax) values(@cust_id,@order_date,@total_amount_after_tax)
 declare @order_id int
 print @quantity
 select @order_id = ord_id from orders 
 
insert into orderitems(created_date,ord_id,cust_id,book_id,order_date,quantity) values(getdate(),@order_id,@cust_id,@book_id,getdate(),@quantity)

 update inventory set stock_level_new-=@quantity where book_id=@book_id
 update inventory set stock_level_used+=@quantity where book_id=@book_id
 
 delete from bucket where cust_id=@cust_id
end

select * from inventory

select * from orders
select * from orderitems
select * from bucket
-----------------------------------------------------------------------------------

----Procedure for inserting into customers-----
CREATE PROCEDURE insertcustomers (
  @cust_id int,
  @cust_name varchar(100),
  @cust_mobile numeric(10,0),
  @street_name varchar(100),
  @postal_code int,
  @state varchar(100),
  @country varchar(100)
  )
as begin

    insert into customers values(
  @cust_id,
  @cust_name ,
  @cust_mobile,
  @street_name,
  @postal_code,
  @state,
  @country
  )
  
end
exec insertcustomers @cust_id=501,@cust_name='ajay',@cust_mobile=6301457891,@street_name='abc street',@postal_code=535002,@state='telangana',@country='India'
exec insertcustomers @cust_id=502,@cust_name='Vijay',@cust_mobile=8974537363,@street_name='MG street',@postal_code=500083,@state='Karnataka',@country='India'
exec insertcustomers @cust_id=503,@cust_name='Sanjay',@cust_mobile=934563728,@street_name='T street',@postal_code=534728,@state='Mumbai',@country='India'
exec insertcustomers @cust_id=504,@cust_name='Bhargav',@cust_mobile=6389372837,@street_name='Hexa street',@postal_code=535056,@state='Karnataka',@country='India'
exec insertcustomers @cust_id=505,@cust_name='Ravi',@cust_mobile=7894927483,@street_name='Park street',@postal_code=535742,@state='Tamilnadu',@country='India'
exec insertcustomers @cust_id=506,@cust_name='Rajesh',@cust_mobile=9865614763,@street_name='BG street',@postal_code=538981,@state='Kerala',@country='India'
exec insertcustomers @cust_id=507,@cust_name='DJ tillu',@cust_mobile=6285327483,@street_name='RAM street',@postal_code=512973,@state='Andhra',@country='India'
exec insertcustomers @cust_id=508,@cust_name='Nitesh',@cust_mobile=6787824483,@street_name='ugf',@postal_code=7876774,@state='Andhra',@country='India'
exec insertcustomers @cust_id=509,@cust_name='Nitesh',@cust_mobile=8408748940,@street_name='iuhf',@postal_code=987647,@state='And',@country='India'


select * from customers

select * from inventory


----------------------------------------------------
----TRIGGERS-----

alter trigger insertintoinventory on dbo.books
for insert
as
begin
declare @book_name varchar(100),@book_id int,@stock_level_used int

select @book_name = book_title from inserted
select @book_id = book_id from inserted
select @stock_level_used = stock_level_used from inventory
insert into inventory values(100,50,@book_id,@book_name);

end

select * from books
select * from inventory
-----------------------------------------------------------
--inserting values into author-----

insert into author values(101,'valmiki','india',getdate()),(102,'justin','australia',getdate());
insert into author values(103,'Shiv Khera','india',getdate()),(104,'Kishimoto','Japan',getdate());
insert into author values(105,'Oda','Japan',getdate());

----Inserting values into book----
insert into books values(201,'ramayana','epic',1500,951478521,101,getdate());
insert into books values(202,'naruto','Manga',500,452222211,104,getdate());
insert into books values(203,'You can win','Motivation',1500,8564676412,103,getdate());
insert into books values(204,'One piece','Manga',500,6488764764,105,getdate());
insert into books values(205,'Rap','Motivation',1500,9654761764,102,getdate());
insert into books values(206,'abc','kjgfn',1500,4846654784,102,getdate());
insert into books values(210,'Life of pie','Motivation',1500,654765417654,102,getdate());

--fetching values
select * from books;
select * from author;
select * from registration
select * from customers
select * from bucket
select * from inventory
-------------------------------------------------------------------------
--To generate the Customer order history

create procedure Customerorderhistory(@cust_id int)
as begin
    select o.ord_id, o.order_date, p.total_amount,c.cust_name
    from Orders o
     join Payment p on o.cust_id = p.cust_id join customers c on c.cust_id=p.cust_id
    order by o.ord_id;
end;

exec Customerorderhistory @cust_id=501

-------------------------------------------------------------------------
--drop tables

drop table customers
  drop table registration
   drop table books
    drop table cart
     drop table orders
drop table order_items
drop table author
drop table payments
drop table sales
drop table report
  drop table inventeory

  select * from customers;
------------------------------------------------------------------------

------------------------------
select * from orderitems
------------------------------------------------
create procedure popularbooks
as begin
select book_id,sum(quantity) as result from orderitems group by book_id order by result desc
end

exec popularbooks


---------------------------------------------
Create Trigger UpdateToReport on dbo.Inventory
For Update
As Begin
Declare @Book_id int;
Declare @stock_level_used int
Declare @book_name varchar(100)

Select @Book_id = Book_id from inserted;
Select @stock_level_used = stock_level_used from inserted;
Select @Book_name = Book_name from inserted;

Update reports set quantity = @stock_level_used where Book_id = @Book_id

Print 'Report is Updated'
End


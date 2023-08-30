--Auto Increment
create table emp4(id int identity(2,2) primary key,name varchar(10));

insert into emp4(name) values('Harsha');

select * from emp4; 

--Using date and datetime
create table person(id int primary key,name varchar(20),
            dob datetime,created_on date);
insert into person values(1,'Ajay','2002-09-29 07:45:55',getdate()),
                         (2,'Vijay','2000-08-15 05:55:27',getdate());
						 
select * from person;

--difference between datetime and smalldatetime
create table def(id int primary key,xyz smalldatetime,lmn datetime);
insert into def values(3,'2002-09-29 23:24:30','2002-09-29 23:24:32:009');
select * from def;

--using datetimeoffset and timestamp
create table demo(x datetimeoffset,y timestamp);
insert into demo(x) values(getdate());
select * from demo;
--using where,and,or 
select * from person where id=2 or id=1;
select * from person where id=2 and id=1;

create table emp5(emp_id int primary key,emp_age int,emp_name varchar(20),emp_gender char(1));

create table ba5(bank_id int primary key,emp_id int foreign key references
                emp5(emp_id),ba_no bigint,b_name varchar(10));

create table sal5(sal_id int primary key,emp_sal decimal,bank_id int 
      foreign key references ba5(bank_id),sal_for_month date);

create table a5(a_id int primary key,emp_id int foreign key references
                  emp5(emp_id),login_time time,logout_time time,
				  no_of_hours_worked int);
--Asc and desc
create table emp6(emp_id int identity(1,1) primary key,emp_age int,
      emp_name varchar(20),emp_sal decimal);
insert into emp6 values(25,'Gowtham',1000),(27,'Bahubali',32000),
      (29,'Rajamouli',5000),(35,'RGV',100000);
select * from emp6 order by emp_sal asc;
select * from emp6 order by emp_sal desc;
select * from emp6 where emp_sal>10000 and emp_sal<=100000;

create table emp7(emp_id int identity(1,1) primary key,
emp_name varchar(20) NOT NULL default('Vijay'),emp_age int NOT NULL);

insert into emp7(emp_age) values(49);

create table emp8(emp_id int identity(1,1) primary key,
emp_name varchar(20),emp_age int NOT NULL);
insert into emp8(emp_age) values(26);

--usage of operators
select * from emp8 where emp_id =1 or emp_name =NULL;
select * from emp8 where emp_name is not null; 
select * from emp7;
select * from emp8; 


----------------------------------------------------------------------------
--creating customer table(4)
create table customers1(cust_id int primary key,first_name varchar(10),
last_name varchar(10),st_no int,st_name varchar(20),p_code int,country text,
p_no numeric);

insert into customers1 values(123,'ss','Rajuamouli',5,'MG Street',500087,
                              'India',76587658975),
(456,'Michael','Jackson',5,'MG Street',500056,'America',9765425427),
(789,'Ben','Stokes',5,'MG Street',500063,'England',865654423),
(158,'Eoin','Morgan',5,'MG Street',500081,'England',576787128);

-------------------------------------------------------------------------------------
--creating orders table(5)
create table orders1(order_id int primary key,cust_id int foreign key references
customers1(cust_id),order_date date,subtotal decimal,shipping decimal,
Total decimal);

insert into orders1 values(13431,123,'2022-05-30',1500,350,1850),
                          (23432,123,'2021-03-21',1800,500,2300);
insert into orders1 values(56765,456,'2019-01-21',1000,350,1350),
                          (98089,456,'2020-12-31',700,500,1200);
insert into orders1 values(34543,789,'2019-01-21',100,50,150),
                          (67876,789,'2020-12-31',500,500,1000);
insert into orders1 values(12343,158,'2018-10-19',2500,100,2600),
                          (14341,158,'2017-08-26',600,50,650);

-------------------------------------------------------------------
--creation of book table(3)
create table books(book_id int primary key,author_id int foreign key
references Authors(author_id),pub_id int foreign key references 
publishers(pub_id),title text,ISBN bigint NOT NULL,
Genre text,pub_year date,price money,Conditon char(5));

insert into books values
(1,1001,1000,'You can win',655497653,'Motivation','2002-09-29',1000,'New'),
(2,1002,2000,'ABCD',765376467,'Comedy','2003-10-18',2000,'New'),
(3,1003,3000,'EFGH',954542878,'Horror','2004-06-15',1500,'New'),
(4,1004,4000,'IJKL',876765464,'Action','2002-10-27',700,'New');

-----------------------------------------------------------------
--creation of author table(2)
create table Authors(author_id int primary key,first_name varchar(10),
last_name varchar(10));

insert into authors values(1001,'Ajay','Saxena'),(1002,'Vijay','Bhargav'),
 (1003,'Siddharth','Naik'),(1004,'Harsha','Vardhan');

-------------------------------------------------------------------
--creation of publisher table(1)
create table publishers(pub_id int primary key,country varchar(30),
pub_name varchar(30));

insert into publishers values(1000,'India','MSDhoni'),
                      (2000,'NewZealand','KaneWilliamson'),
                           (3000,'Srilanka','Sangakarra'),
                         (4000,'England','JasonRoy');
------------------------------------------------------------------------------
--creation of orderitem
create table orderitem(orderitem_id int primary key,order_id int
  foreign key references orders1(order_id),cust_id int foreign key references
  customers1(cust_id),
book_id int foreign key references books(book_id),quantity int,price money);
--same customer orders different books under single order.
insert into orderitem values(135,13431,123,1,1,1000),
                            (472,13431,123,2,1,1500);
--same customer with different order.
insert into orderitem values(879,23432,123,3,1,1000);
--Different customer ordering same book as above
insert into orderitem values(739,56765,456,1,2,1000);   

--------------------------------------------------------------------------
--creation of Inventory table
create table inventory(Inventory_id int primary key,
book_id int foreign key references books(book_id) UNIQUE,stock_level_used int,
stock_level_new int);

insert into inventory values(12453,1,78,105),
							(15436,2,78,105),
							(76468,3,78,105),
                            (65465,4,89,95);

 select * from orderitem
 select * from orderitem where cust_id=123;
 select * from orders1


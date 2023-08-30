create table c1(c_id int primary key,c_name varchar(20),
c_address varchar(50));

insert into c1 values(1,'Nitesh','6-76/1,MG street,Banglore'),
                      (2,'Ravindra','7-89/2,GM street,Hyderabad'),
					  (3,'Ajay','5-56/7,TN street,Tamil Nadu');

create table o1(o_id int primary key,o_name varchar(20),o_amount money,
c_id int foreign key references  c1(c_id));

insert into o1 values(101,'Washing machine',35000,1),
               (102,'Fridge',45000,2),  
			    (103,'shoes',90000,3);

select * from o1 where c_id=1;

--Using of Joins
select * from c1 inner join o1 on c1.c_id=o1.c_id

--To select specific columns to be retrived
select c1.c_id,c1.c_name,c1.c_address,o1.o_id,o1.o_name,o1.o_amount from 
c1 inner join o1 on c1.c_id=o1.c_id;

----------TASK-------
create table candidate(c_id int primary key,c_name varchar(20),c_age int,
c_mobile numeric);

insert into candidate values(1,'Ramesh',21,9768757733),
 (2,'Raju',23,84616464444),(3,'Kiran',21,787487657864),
 (4,'PS',24,69875878985);

 insert into candidate values(5,'Nitesh',30,6654653653);

 create table Training(t_id int primary key,c_id int foreign key references
 candidate(c_id),t_name varchar(10),t_subject text);

 alter table training drop constraint FK__Training__c_id__4B0D20AB;

 insert into training values(101,1,'Nitesh','Database'),
 (102,1,'VG','Java'),(103,2,'Nitesh','Database'),(104,2,'Harley','English'),
 (105,3,'Nitesh','Database'),(106,3,'VG','Java'),(107,3,'Harley','English'),
 (108,4,'VG','Java'),(109,4,'Harley','English');

 insert into training values(111,6,'DEF','Python');

 select * from Candidate;
 select * from Training;

select * from candidate inner join training on candidate.c_id=training.c_id;
----Inner Join----
select candidate.c_name,training.t_subject from candidate inner join
training on candidate.c_id = training.c_id;

----Left Join----
select candidate.c_name,training.t_subject from candidate left join
training on candidate.c_id = training.c_id;

----Right join----
select candidate.c_name,training.t_subject from candidate right join
training on candidate.c_id = training.c_id;

----TASK----
create table p2(p_id int primary key,p_name varchar(20),category varchar(20),
price money);

insert into p2 values(1,'Fridge','Electronic item',39000),
 (2,'TV','Electronic item',60000),(3,'Grinder','Kitchen Appliance',5000),
 (4,'Bag','Travelling',1000),(5,'Shoe','Footwear',39000);
 insert into p2 values(6,'WM','Electronics',69000);
 insert into p2 values(7,'ABC','DEF',2000);

 create table o3(o_id int primary key,p_id int foreign key references 
 p2(p_id),cust_name varchar(20),order_date date);

 insert into o3 values(101,1,'Ajay','2002-09-29'),
 (102,1,'Vijay','2003-09-13'),(103,2,'Harsha','2020-06-19'),
 (104,3,'Veerappan','2000-12-14'),(105,4,'Allu arjun','2000-12-14'),
 (106,5,'Rajan','2001-09-27');

 alter table o3 drop constraint FK__o3__p_id__567ED357

 insert into o3 values(107,8,'Ramesh','1997-09-28'),
 (108,9,'ABCD','1997-09-28');

 select * from p2 inner join o3 on p2.p_id=o3.p_id;

 --Orders ordered by customers
 select p2.p_name,o3.cust_name from p2 inner join o3 on p2.p_id=o3.p_id;
 --TASK 1
 select p2.p_name,p2.category,p2.price,o3.cust_name,o3.order_date from 
 p2 inner join o3 on p2.p_id=o3.p_id;
 --TASK 2
 select p2.p_name,p2.category,p2.price,o3.cust_name,o3.order_date from 
 p2 left join o3 on p2.p_id=o3.p_id;
 --TASK 3
  select o3.o_id,o3.order_date,o3.cust_name,p2.p_name,p2.category,
 p2.price from p2 right join o3 on p2.p_id=o3.p_id;
 --------------------------------------------------------------------------------
 create table staff1(s_id int primary key,
 name varchar(20),
 add_id int UNIQUE,store_id int UNIQUE,active varchar(10));

 insert into staff1 values(1001,'Ajay',25,101,'YES'),
 (1002,'Vijay',26,102,'YES'),(1003,'Bhargav',27,103,'YES');

----------------------------------------------------------------------------
 create table customer1(c_id int primary key,store_id int unique,name varchar(20),
 add_id int unique,create_date date,active varchar(10));

 insert into customer1 values(001,1,'Raju',135,getdate(),'YES'),
 (002,2,'Ramesh',136,getdate(),'YES'),(003,3,'Ravi',137,getdate(),'YES');
 insert into customer1 values(004,4,'Harsha',138,getdate(),'YES');
 
---------------------------------------------------------------------------
create table payment(p_id int primary key,c_id int foreign key references
customer1(c_id),
s_id int foreign key references staff1(s_id),
 payment_date date,
 amount money);

insert into payment values(678,001,1001,getdate(),6000),
(679,002,1002,getdate(),7000),(680,003,1003,getdate(),3000);

----------------------------------------------------------------------
select * from customer1 inner join payment on customer1.c_id=payment.c_id

select * from staff1 inner join payment on staff1.s_id=payment.s_id
----TASK 1----
select customer1.c_id,customer1.name,payment.p_id,payment.amount,
payment.payment_date from customer1 left join payment on customer1.c_id=payment.c_id;
----TASK 2----
select staff1.s_id,staff1.name,payment.p_id,payment.payment_date,payment.amount
from staff1 left join payment on staff1.s_id=payment.s_id;

------------------------------------------------------------------------
create table tourist(
id int identity(1,1) primary key,
name varchar(200),
country varchar(200));

insert into tourist values('raju','India'),('Elisa','Italy'),('Kiran','India'),
('Matt','Italy');
insert into tourist values('ABC','America');

select * from tourist

----To find Count
select count(id) as Countofcountry,country from tourist 
group by country;

----To use Having and filter the records
select count(id) as Countofcountry,country from tourist 
group by country having count(country)>1;

------------------------------------------------------------
create table supplier(
id int identity(1,1) primary key,
name varchar(20));

insert into supplier values('Ravi'),('Kiran'),('Harsha'),('DJ Tillu');

create table product(id int identity(1,1) primary key,
p_name varchar(20),sup_id int,cost money);

insert into product values('pen',1,100),('Book',1,500),('Shoe',2,300),
('shirt',2,600);
-------------------------------------------------------------------
----Using Exists----

select name from supplier where EXISTS(select id from product 
where product.id = supplier.id and cost>300);

--------------------------------------------------------------------
create table tr1(t_id int primary key,t_name varchar(20));

insert into tr1 values(1,'Raju'),(2,'Ravi'),(3,'Ajay'),(4,'Vijay');
insert into tr1 values(5,'Raju')

----To copy the data to new table or Creating a duplicate table
select * into duplicate from tr1;
select * from tr1
select * from duplicate

select * into newtable from product
insert into newtable(p_name,sup_id,cost) select p_name,sup_id,cost
from product where id=6;
select * from newtable;

----------------------------------------------------------------------------
create table a(id int identity(1,1) primary key,name varchar(10));
insert into a values('nitesh'),('vivek'),('Rahul'),('Vishal');
----Use Of Case Statement
select name,

case
 when name='Nitesh' Then 'It is me'
 when name='Vivek' Then 'It is my brother'
 else 'Dont know'
End as Result

From a
--------------------------------------------------------------------------------
-----ASSIGNMENT-----
----TASK 1-------
create table Cust1(cust_id int primary key,
cust_name varchar(20),
cust_mobile numeric);

insert into cust1 values(123,'Ajay Saxena',8776476487),
(456,'Vijay Bhargav',67646764744),(789,'Kiran Kumar',9876487623);
----creation of order table
create table ord1(ord_id int primary key,cust_id int foreign key references
cust1(cust_id),category varchar(20),
pro_id int UNIQUE,
pro_name varchar(20),
order_date date,
pro_price money);

insert into ord1 values(1001,123,'Home Appliance',1,'Fridge',getdate(),30000),
(1002,456,'Carrier',2,'Bag',getdate(),3000),
(1003,789,'Footwear',3,'Shoe',getdate(),90000);

select cust1.cust_name,ord1.pro_name,ord1.category,ord1.pro_price,
ord1.order_date from cust1 inner join ord1 on Cust1.cust_id=ord1.cust_id;

----TASK 2----
create table pro2(pro_id int primary key,
pro_name varchar(20),
category varchar(20),
pro_price money);

insert into pro2 values(1,'Shoe','Footwear',9000),
(2,'Fridge','Storage',9000),(3,'Bag','Travel',9000);
insert into pro2 values(4,'ABC','DEF',800);

------Creation of order table-----
create table ord2(ord_id int primary key,
pro_id int foreign key references pro2(pro_id),
ordered_date date,
delivered_date date,
tracking_link varchar(200));

insert into ord2 values(101,1,'2023-08-21',getdate(),'http://www.flipkart.com'),
(102,2,'2023-08-20',getdate(),'http://www.amazon.com'),
(103,3,'2023-08-23',getdate(),'http://www.myntra.com');

select pro2.pro_name,pro2.category,pro2.pro_price,ord2.ord_id,ord2.ordered_date,
ord2.delivered_date,ord2.tracking_link from pro2 left join ord2 on
ord2.pro_id=pro2.pro_id;




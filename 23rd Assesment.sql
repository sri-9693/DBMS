--Creating database
create database As1
--Using database
use As1;

--Creating people table (1st Table)
create table people(Aadhar_no bigint primary key,
name varchar(20),age int,gender char(5));

--Insertion of values into people table
insert into people values(123423453456,'Allu Arjun',38,'M'),
                         (547294756527,'Rajamouli',45,'M'),
						 (656217654747,'Anushka',41,'F'),
						 (984864148487,'Kajal Agarwal',38,'F');
-------------------------------------------------------------------------------
--Creating Bank Account Table (2nd Table)
create table BankAccount(Bank_id int primary key,
bank_account_no bigint UNIQUE,bank_name varchar(20),Aadhar_no bigint
foreign key references people(Aadhar_no),IFSC_code varchar(20) UNIQUE);

--Insertion of values into Bank Account Table
insert into BankAccount values(101,76565454756,'HDFC',123423453456,'HDFABC01'),
                              (102,68967865876,'AXIS',123423453456,'AXIDEF01');
							  
insert into BankAccount values(103,76547654654,'SBI',547294756527,'SGF09AB'),
                              (104,76546544876,'HDFC',547294756527,'KILAF09');
							  
insert into BankAccount values(105,87626487647,'AXIS',656217654747,'JHGD095'),
                              (106,85454647476,'HDFC',656217654747,'JHGDH098');
							 
insert into BankAccount values(107,875647647687,'KOTAK',984864148487,'JJHD09'),
                              (108,987764894894,'SBI',984864148487,'GHDT089');
							  

-------------------------------------------------------------------------------
--Creating Salary table (3rd Table)
create table Salary(sal_id int primary key,amount money,bank_id int foreign key
references BankAccount(bank_id),
credited_date date,sal_for_month varchar(10));

--Insertion of values
--Salary for 1st member in two different bank accounts
insert into Salary values(1,20000,101,'2002-01-29','DEC'),
                          (2,30000,102,'2002-01-29','JAN');

--Salary for 2nd member in two different bank accounts
insert into Salary values(3,20000,103,'2002-01-29','DEC'),
                          (4,30000,104,'2002-01-29','JAN');

--Salary for 3rd member in two different bank accounts
insert into Salary values(5,25000,105,'2002-01-29','DEC'),
                          (6,33000,106,'2002-01-29','JAN');

--Salary for 4th member in two different bank accounts
insert into Salary values(7,29000,107,'2002-01-29','DEC'),
                          (8,49000,108,'2002-01-29','JAN');

-------------------------------------------------------------------------------
--Creating Attendence table (4th Table)
create table Attendence(a_id int primary key,login_time time,logout_time time,
working_hours int,attendence_for_day int,Aadhar_no bigint foreign key
references people(Aadhar_no));
--Inserting into attendence

--Day wise attendence for two days for 1st member
insert into attendence values(101,'7:00:00','6:00:00',9,1,123423453456),
                             (102,'7:45:00','6:30:00',8,2,123423453456);

--Day wise attendence for two days for 1st member
insert into attendence values(103,'8:00:00','5:00:00',8,1,547294756527),
                             (104,'7:45:00','6:30:00',9,2,547294756527);

--Day wise attendence for two days for 3rd member
insert into attendence values(105,'6:00:00','4:00:00',9,1,656217654747),
                             (106,'7:30:00','6:30:00',8,2,656217654747);

--Day wise attendence for two days for 4th member
insert into attendence values(107,'10:00:00','5:30:00',5,1,984864148487),
                             (108,'7:45:00','6:30:00',7,2,984864148487);

--------------------------------------------------------------------------------
--Assessment - 2

--Creation of employee table
create table employee(emp_id int UNIQUE,emp_code varchar(10),
emp_name varchar(20),primary key(emp_code,emp_name));

--Insertion of values into employee table
insert into employee values(10,'ABC01','Ajay'),(20,'DEF78','Vijay'),
                           (30,'IJK03','Bhargav');

--Creation of salary table
create table sal(sal_id int primary key,emp_code varchar(10),
emp_name varchar(20),emp_sal money,
constraint abc foreign key(emp_code,emp_name) references 
employee(emp_code,emp_name));

--Insertion of values
insert into sal values(101,'ABC01','Ajay',50000),
                       (102,'DEF78','Vijay',75000),
					   (103,'IJK03','Bhargav',89000);


create database QuanLiHoaDon
go
use database QuanLiHoaDon
go

--tao bang customer
create table Customers
(Cno  char(4) not null primary key ,
name nvarchar(50) not null ,
age int not null ,
Caddress nvarchar(50)
)
go
-- tao bang san pham
create table Products
(Pno char(4) not null primary key,
Pname nvarchar(50) not null ,
DayLimit date not null,
condition varchar(3),
Price int not null
)
go
-- tao bang nhan vien
create table Wokers
(Wno char(4) not null primary key,
Wname nvarchar(50) not null ,
Waddress nvarchar(50) not null,
Wage int not null 
)
go
--tao bang cua hang
create table Stores
(Sno char(2)  not null primary key,
Sname nvarchar(50) not null,
Saddress nvarchar(50) not null 
)
go
-- tao bang hoa don 
create table bill 
(Code char(4) not null primary key,
Cno  char(4) not null,
Pno char(4) not null,
Wno char(4) not null,
Sno char(2)  not null,
DayBuy date not null,
tax int ,
discount int ,
total int ,
constraint FK_Customers foreign key (Cno) references Customers(Cno),
constraint FK_Products foreign key (Pno) references Products(Pno),
constraint FK_Wokers foreign key (Wno) references Wokers(Wno),
constraint FK_Stores foreign key (Sno) references Stores(Sno)
)
go

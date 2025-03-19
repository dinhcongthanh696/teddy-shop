--Tạo database
drop database if exists  TeddyBearOnlineShop
go

create database TeddyBearOnlineShop
go 
use TeddyBearOnlineShop

--Từ dòng này xuống là tạo bảng
create table UserRole(
	id int primary key identity(1,1),
	roleName nvarchar(30) unique not null
)

create table [User](
	id int primary key identity(1,1),
	userName nvarchar(255) not null,
	profilePic nvarchar(255) default 'images/usericon.jpg',
	email nvarchar(255) unique not null,
	[password] nvarchar(255) not null,
	phoneNumber nvarchar(12) unique not null,
	location nvarchar(255),
	createdDate datetime default GETDATE(),
	roleId int foreign key references UserRole(id)
)

create table Attendance(
	id int primary key identity(1,1),
	[status] bit not null,
	userId int foreign key references [User](id),
	updateTime datetime default GETDATE()
)

create table Salary(
	id int primary key identity(1,1),
	salary int not null,
	userId int foreign key references [User](id),
	updateTime datetime
)

create table Setting(
	id int primary key identity(1,1),
	name nvarchar(25) unique not null,
	status bit not null,
	content nvarchar(255),
	createDate datetime default getdate(),
	[description] nvarchar(max)
)

create table ViewCount(
	[date] datetime not null primary key,
	viewCount int 
)

create table Category(
	id int primary key identity(1,1),
	name nvarchar(255) not null unique
)

create table ProductType(
	id int primary key identity(1,1),
	name nvarchar(25) not null unique
)

create table Comment(
	id int primary key identity(1,1),
	content nvarchar(max)
)

create table [Product](
	id int primary key identity(1,1),
	name nvarchar(25),
	categoryId int foreign key references Category(id),
	typeId int foreign key references ProductType(id)
)

create table Rating(
	id int primary key identity(1,1),
	rating int not null,
	createDate datetime default GETDATE(),
	userId int foreign key references [User](id),
	commentId int foreign key references [Comment](id),
	productId int foreign key references [Product](id)
)

create table Size(
	id int primary key identity(1,1),
	name nvarchar(25) not null,
	quantity int,
	price int,
	productId int foreign key references [Product](id)
)

create table ProductImage(
	id int primary key identity(1,1),
	[source] nvarchar(255) not null unique,
	productId int foreign key references [Product](id)
)

create table Cart(
	id int primary key identity(1,1),
	userId int foreign key references [User](id)
)

create table CartDetail(
	id int primary key identity(1,1),
	cartId int foreign key references Cart(id),
	productId int foreign key references [Product](id)
)


create table [Order](
	id int primary key identity(1,1),
	totalCost int not null,
	[status] bit,
	userId int foreign key references [User](id),
	orderDate datetime default GETDATE(),
	arrivedAt datetime
)

create table OrderDetail(
	id int primary key identity(1,1),
	orderId int foreign key references [Order](id),
	productId int foreign key references [Product](id)
)


create table Campaign(
	id int primary key identity(1,1),
	[name] nvarchar(25) not null unique,
	[description] nvarchar(max),
	[status] bit,
	startDate datetime default GETDATE(),
	endDate datetime
)

create table Blog(
	id int primary key identity(1,1),
	title nvarchar(255) not null,
	content nvarchar(max) not null,
	updateDate datetime default GETDATE(),
	[status] bit,
	thumbnail nvarchar(255) not null,
	blogType nvarchar(25),
	campaignId int foreign key references Campaign(id)
)

create table Voucher(
	id int primary key identity(1,1),
	[name] nvarchar(25) not null unique,
	discount int not null,
	[status] bit,
	startDate datetime default GETDATE(),
	endDate datetime,
	campaignId int foreign key references Campaign(id)
)

create table VoucherProduct(
	id int primary key identity(1,1),
	voucherId int foreign key references Voucher(id),
	productId int foreign key references [Product](id)
)

create table UserVoucher(
	id int primary key identity(1,1),
	voucherId int foreign key references Voucher(id),
	userId int foreign key references [User](id)
)


-- 0 is Pending, 1 is Shipping, 2 is Delivered, 3 is Cancelled
ALTER TABLE CartDetail ADD quantity INT DEFAULT 1;
ALTER TABLE OrderDetail ADD quantity INT DEFAULT 1;

ALTER TABLE [Order] ALTER COLUMN status INT 
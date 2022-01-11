drop database PMD
Create database PMD

Create table tblusers
(
SN bigint primary key,
UserName nVarchar(150) unique,
Email nVarchar(150),
Passwords nVarchar(50),
Phone nvarchar(20),
CreatedOn DateTime default SysDateTime()
)



Create table tblAccounts
(
Sn bigint primary key,
userID bigint references tblusers(SN),
Domain nVarchar(100),
CreateOn DateTime default sysDateTime(),
LastUpdated DateTime
)


Create Table TblURLType
(
sn int primary key,
URLTypeName nVarchar(100),
)

insert into TblURLType values(1,'URL')
insert into TblURLType values(2,'AndroidApp')
insert into TblURLType values(3,'IOSApp')
insert into TblURLType values(4,'DesktopApp')


Create table TblURLData
(
SN bigint primary key,
URLtypeID int references tblURLType(SN),
AccountID bigint references tblAccounts(SN),
URLValue nVarchar(150),
SaltText nVarchar(50)
)

Create table tblSecurityType
(
sn int Primary key,
SecurityTypeName nvarchar(50)
)

insert into TblSecurityType values(1,'UserName')
insert into TblSecurityType values(2,'Password')
insert into TblSecurityType values(3,'PinNumber')


Create table TblAccountData
(
SN bigint primary key,
URLID bigint references tblURLData(SN),
SecurityTypeID int references tblSecurityType(SN),
ValueText nvarchar(100),
CreateOn DateTime default sysDateTime(),
UpdateOn DateTime
)



Create table tblPayments
(
Sn bigint primary key,
userID bigint references tblusers(SN),
CardNumber nvarchar(20),
AccountName nvarchar(100),
ExpMonth nvarchar(2),
ExpYear nVarchar(4),
CardTitle nVarchar(100)
)

Create table tblAddressInfo
(
Sn bigint primary key,
userID bigint references tblusers(SN),
AddressName nvarchar(50),
Country nVarchar(100),
States nVarchar(50),
City nVarchar(50),
Street nVarchar(200),
ZipCode nVarchar(10),
)


Create table TblPersonalInfo
(
Sn bigint primary key,
userID bigint references tblusers(SN),
UserFName nVarchar(50),
UserMName nVarchar(50),
UserLName nVarchar(50),
DOB nVarchar(10),
Phone nVarchar(20),
Email nvarchar(100),
)

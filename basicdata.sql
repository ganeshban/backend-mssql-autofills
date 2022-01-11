--Select * from tblusers
--insert into tblusers values (1,'banganesh98@gmail.com','banganesh98@gmail.com','abc123456','7207519966',sysDateTime())

--Select * from tblAccounts
--insert into tblAccounts values(1,1,'Facebook',sysDateTime(),sysDateTime())

--Select * from TblURLData
--insert into TblURLData values(1,1,1,'www.Facebook.com')
--insert into TblURLData values(2,2,1,'www.Facebook.com')

--select * from TblAccountData
--insert into TblAccountData values(1,1,1,'ganesh.ban.9',sysDateTime(),null)
--insert into TblAccountData values(2,1,2,'ganeshBan123~',sysDateTime(),null)
--insert into TblAccountData values(3,2,1,'ganesh.ban.9',sysDateTime(),null)
--insert into TblAccountData values(4,2,2,'ganeshBan123~',sysDateTime(),null)


Select * from tblAccountData ad
inner join TblURLData UD on UD.SN = AD.URLID
inner join tblAccounts a on a.sn = UD.AccountID
inner join tblusers u on u.sn = a.userID
inner join TblURLType UT on UT.sn = UD.URLTypeID
inner join tblSecurityType s on s.sn = ad.SecurityTypeID


Select * from tblAccounts

select * from TblAccountData 



Select A.SN, A.Domain
, (Select top 1 URLTypeName from TblURLtype where SN = (Select top 1 URLtypeID from TblURLData where AccountID = A.SN order by sn) order by Sn) DeviceType
, (Select top 1 URLValue from TblURLData where AccountID = A.SN order by Sn) Link
, (Select top 1 ValueText from TblAccountData where SecurityTypeID = 1 and URLID = (Select top 1 SN from TblURLData where AccountID = A.SN order by sn) order by Sn) Username
, CreateOn
from tblAccounts A
where userID = 1



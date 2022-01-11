-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New User
-- =============================================
Create PROCEDURE ProcAddUser 
	-- Add the parameters for the stored procedure here
	@UserName Varchar(100) = '', 
	@Email Varchar(100) = '', 
	@Password Varchar(100) = '', 
	@Phone Varchar(100) = '', 
	@date DateTime = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @sn as bigint
	set @sn = (Select max(SN) from tblusers) + 1
	insert into tblusers values 
	(@sn,@UserName,@Email,@Password,@Phone,isnull(@date, sysDateTime()))
	Select @SN
END
GO
-------------------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New Account
-- =============================================
Create PROCEDURE ProcAddAccount
	-- Add the parameters for the stored procedure here
	@UserID bigint = null,
	@Domain Varchar(100) = '', 
	@date DateTime = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @SN as bigint
	set @SN = (Select max(SN) from tblAccounts) + 1
	insert into tblAccounts values 
	(@SN, @UserID, @Domain, isnull(@date, sysDateTime()), isnull(@date, sysDateTime()))
	Select @SN
END
GO

-----------------------------------------------------------------------------------------------

-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New Account
-- =============================================
Create PROCEDURE ProcAddURLData
	-- Add the parameters for the stored procedure here
	@DeviceId int = null,
	@AccountID bigint null,
	@URLName nVarchar(200) = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Declare @SN as bigint
	declare @Salt as nvarchar(50)

	set @Salt = dbo.FncGetRandomPassword (10,1,0,1,0,'')

	set @SN = (Select max(SN) from TblURLData) + 1
	insert into TblURLData values 
	(@SN, @DeviceId,@AccountID,@URLName,@Salt)
	Select @SN
END
GO


Select * from sysobjects where xtype = 'u'  order by name
Select * from TblAccountData


-------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New Account
-- =============================================
Create PROCEDURE ProcAddAccountData
	-- Add the parameters for the stored procedure here
	@URlId Bigint = null,
	@UserName nVarchar(200) = null,
	@Password nVarchar(200) = null,
	@Pin nVarchar(20) = null,
	@Date dateTime = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here


	Declare @SN as bigint
	
	if @UserName is not null
	begin
		set @SN = (Select max(SN) from TblAccountData) + 1

		insert into TblAccountData values (@SN, @URlId, 1, @UserName, isnull(@Date, SYSDATETIME()), NULL)		
	end


	if @Password is not null
	begin
		set @SN = (Select max(SN) from TblAccountData) + 1

		insert into TblAccountData values (@SN, @URlId, 2, @Password, isnull(@Date, SYSDATETIME()), NULL)		
	end

	if @Pin is not null
	begin
		set @SN = (Select max(SN) from TblAccountData) + 1

		insert into TblAccountData values (@SN, @URlId, 3, @Pin, isnull(@Date, SYSDATETIME()), NULL)		
	end

END
GO

-------------------------------------------------------------------------------------------------------------

-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New Account
-- =============================================
Create PROCEDURE ProcGetListOfAccount
	-- Add the parameters for the stored procedure here
	@UserID bigint = null

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	Select A.SN, A.Domain
	, (Select top 1 URLTypeName from TblURLtype where SN = (Select top 1 URLtypeID from TblURLData where AccountID = A.SN order by sn) order by Sn) DeviceType
	, (Select top 1 URLValue from TblURLData where AccountID = A.SN order by Sn) Link
	, (Select top 1 ValueText from TblAccountData where SecurityTypeID = 1 and URLID = (Select top 1 SN from TblURLData where AccountID = A.SN order by sn) order by Sn) Username
	, CreateOn
	from tblAccounts A
	where userID = @UserID

END
GO

















select * from TblURLData

exec ProcAddAccountData 3, 'banganesh98@gmail.com',NULL, '1369', Null


Select * from TblAccountData

Delete from TblAccountData where URLID=3



Declare @a as nvarchar(100)

set @a = null

if @a is not null
begin
	print 'username is ' + @a
end
else
begin
	print 'The user Name is null'
end


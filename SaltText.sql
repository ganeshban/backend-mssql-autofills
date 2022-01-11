
-- =============================================
-- Author:		Ganesh Ban
-- Create date: 2021-12-04
-- Description:	Store Procedure for Creating a New Account
-- =============================================
Create PROCEDURE ProcGetRandomPassword
	-- Add the parameters for the stored procedure here
	@Length int = 8,
	@isUpperRequired int = 1 ,
	@isLowerRequired int = 1,
	@isNumberRequired int = 1,
	@isSpecialRequired int = 1,
	@SpecialTextt nVarchar(50) = null
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Declare @UpperTxt as nVarchar(26)
Declare @LowerTxt as nVarchar(26)
Declare @NumberTxt as nVarchar(10)
Declare @SpecialTxt as nVarchar(26)
Declare @AllText as nVarchar(100)
-------------------------------------------
Declare @Start as int
Declare @Output as varchar(100)


Set @UpperTxt = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
Set @LowerTxt = LOWER(@UpperTxt)
Set @NumberTxt = '0123456789'
Set @SpecialTxt = ISNULL(@SpecialTextt,'!@#$%^&*()_=+-/,<.>?;:''"')
Set @AllText = @UpperTxt + @LowerTxt + @NumberTxt + @SpecialTxt


Set @Output =''


if @isUpperRequired =1 
begin
	set @Start = Rand()*Len(@UpperTxt)
	Set @Output = @Output + SUBSTRING(@UpperTxt,@Start,1)
end

if @isLowerRequired = 1 
begin
	set @Start = Rand()*Len(@LowerTxt)
	Set @Output = @Output + SUBSTRING(@LowerTxt,@Start,1)
end

if @isNumberRequired = 1 
begin
	set @Start = Rand()*Len(@NumberTxt)
	Set @Output = @Output + SUBSTRING(@NumberTxt,@Start,1)
end

if @isSpecialRequired =1 
begin
	set @Start = Rand()*Len(@SpecialTxt)
	Set @Output = @Output + SUBSTRING(@SpecialTxt,@Start,1)
end

while len(@Output)<@Length
begin
	set @Start = Rand()*Len(@AllText)
	Set @Output = @Output + SUBSTRING(@AllText,@Start,1)
end

print @output

END
GO




exec ProcGetRandomPassword 10,0,1,1,1





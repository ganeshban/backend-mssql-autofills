Create View ViewRand
as
select RAND() as random

Alter FUNCTION FncGetRandomPassword(
@Length int = 8,
@isUpperRequired int = 0,
@isLowerRequired int = 0,
@isNumberRequired int = 0,
@isSpecialRequired int = 0,
@SpecialTextt nVarchar(50) = null
) RETURNS nVarchar(50)

AS
BEGIN


Declare @UpperTxt as nVarchar(26)
Declare @LowerTxt as nVarchar(26)
Declare @NumberTxt as nVarchar(10)
Declare @SpecialTxt as nVarchar(50)
Declare @AllText as nVarchar(200)
-------------------------------------------
Declare @Start as int
Declare @Output as varchar(200)


Set @UpperTxt = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
Set @LowerTxt = LOWER(@UpperTxt)
Set @NumberTxt = '0123456789'
Set @SpecialTxt = ISNULL(@SpecialTextt,'!@#$%^&*()_-+={[}]|\:;<,>.?/~`')
Set @AllText = ''
set @Output = ''

if @isUpperRequired+@isLowerRequired+@isNumberRequired+@isSpecialRequired=0 
begin
	Set @AllText = @UpperTxt + @LowerTxt + @NumberTxt + @SpecialTxt
end

if @isUpperRequired =1 
begin
	set @AllText = @AllText + @UpperTxt
	set @Start = (Select random*Len(@UpperTxt) from viewRand )
	Set @Output = @Output + SUBSTRING(@UpperTxt,@Start,1)
end


if @isLowerRequired = 1 
begin
	set @AllText = @AllText + @LowerTxt
	set @Start = (Select random*Len(@LowerTxt) from ViewRand )
	Set @Output = @Output + SUBSTRING(@LowerTxt,@Start,1)
end

if @isNumberRequired = 1 
begin
	set @AllText = @AllText + @NumberTxt
	set @Start = (Select Random*Len(@NumberTxt) from ViewRand)
	Set @Output = @Output + SUBSTRING(@NumberTxt,@Start,1)
end

if @isSpecialRequired =1 
begin
	set @AllText = @AllText + @SpecialTxt
	set @Start = (Select Random*Len(@SpecialTxt) from ViewRand)
	Set @Output = @Output + SUBSTRING(@SpecialTxt,@Start,1)
end

while len(@Output)<@Length
begin
	set @Start = (Select Random*Len(@AllText) from ViewRand)
	Set @Output = @Output + SUBSTRING(@AllText,@Start,1)
end

Return @output

END



print dbo.FncGetRandomPassword (5,1,1,1,1,null)


print dbo.FncGetRandomPassword(4,1,0,1,0,'')+'-'+dbo.FncGetRandomPassword(8,1,0,1,0,'')+'-'+dbo.FncGetRandomPassword(4,1,0,1,0,'')

--Select DIFFERENCE('3591a0&QT','0QT')
--Print REPLICATE('Hello - ',7) + space(5) + ' a'
--Select String_Split('hello - there','-')

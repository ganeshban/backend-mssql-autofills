
Alter Proc ProcGetPass(
@Length int = 8,
@isUpperRequired int = 1 ,
@isLowerRequired int = 1,
@isNumberRequired int = 1,
@isSpecialRequired int = 1,
@SpecialTextt nVarchar(50) = null
) 

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
-------------------------------------------------

Set @UpperTxt = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
Set @LowerTxt = LOWER(@UpperTxt)
Set @NumberTxt = '0123456789'
Set @SpecialTxt = ISNULL(@SpecialTextt,'!@#$%^&*()_=+-/,<.>?;:''"~`[{]}\|')

if (@isUpperRequired+@isLowerRequired+@isNumberRequired+@isSpecialRequired) = 0 
begin
	Set @AllText = @UpperTxt + @LowerTxt + @NumberTxt + @SpecialTxt
end

Set @Output =''
set @AllText=''

if @isUpperRequired =1 
begin
	set @AllText = @AllText + @UpperTxt
	set @Start = (Select random*Len(@UpperTxt) from viewRand )
	Set @Output = @Output + SUBSTRING(@UpperTxt,@Start,1)
end


if @isLowerRequired = 1 
begin
	set @AllText = @AllText + @LowerTxt
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


while len(@output)<@Length
begin
	set @Start = (Select Random*Len(@AllText) from ViewRand)
	Set @output = @output + SUBSTRING(@AllText,@Start,1)
end

print @output

END

GO

exec ProcGetPass 15,1,1,1,1,null



-- cau 1
DECLARE @a int, @b int, @s int
SET @a = 1
SET @b = 2
SET @s = @a + @b
print 'Tong la: ' + convert(nvarchar(10),@s)

-- cau 2
DECLARE @i int, @s int
set @i = 2
set @s = 0
	while @i <= 10
begin 
set @s = @s + @i
set @i = @i + 2
end
print 'Tong la: ' + convert(nvarchar(10),@s)


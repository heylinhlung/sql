use QLSinhVien_22662028

--Câu 1: Tạo thủ tục (Store Procedure)
--Nhập vào 2 số @so1, @so2. In ra câu ‘Tổng là: @tong’ với @tong=@so1+@so2
--Gợi ý: biến @ tổng là biến dạng output. Vd: @tong int out dùng khai báo biến @tong
CREATE PROC P_Cau1 @so1 int , @so2 int, @tong int out
AS
SET @tong = @so1 + @so2
return @tong
GO
Declare @kq int
exec P_Cau1 1,2,@kq out
print 'tong la: ' + cast(@kq as nvarchar)

--Câu 2: Tạo thủ tục (Store Procedure)
--Nhập vào số nguyên @n. In ra tổng các số lẻ từ 1 đến @n. Ví dụ: @n=5 thì
--@tongn=(1+3+5)
--Gợi ý:
--+ Sử dụng câu lệnh If
--+ Sử dụng vòng lặp While
--+ Biến @tong là biến dạng output

drop proc P_Cau2

CREATE PROC P_Cau2
    @n int,
    @tongle int OUT
AS
BEGIN
    SET @tongle = 0

    DECLARE @i int
    SET @i = @n

    WHILE @i > 0
    BEGIN
        IF (@i % 2 = 1)
        BEGIN
            SET @tongle = @tongle + @i
        END

        SET @i = @i - 1
    END

    RETURN @tongle
END
GO
Declare @kq_cau2 int
exec P_Cau2 3,@kq_cau2 out
print 'tong la: ' + cast(@kq_cau2 as nvarchar)


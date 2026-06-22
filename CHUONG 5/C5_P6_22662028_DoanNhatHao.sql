-- Phần 2: Sử dụng thủ tục lưu trữ thực hiện các truy vấn dữ liệu trong SQL Server Viết store procedure
-- Bài 1: Nhập vào @MaNV, xuất thông tin các nhân viên theo @MaNV
drop proc P_Cau1
go
CREATE PROC P_Cau1 (@MaNV nvarchar(9))
as
begin
	select * from NHANVIEN where NHANVIEN.MANV like @MaNV
end
go
exec P_Cau1 N'003'

-- Bài 2: Nhập vào @MaDa (Mã đề án), cho biết số lượng nhân viên tham gia đề án đó.
drop proc P_Cau2
go
CREATE PROC P_Cau2 (@MaDA int)
as
begin
	select count(*) as N'so luong nhan vien tham gia de an' from PHANCONG where PHANCONG.MADA like @MaDA
end
go
exec P_Cau2 1

-- Bài 3: Nhập vào @MaDa và @Ddiem_DA(địa điểm đề án), cho biết số lượng nhân viêntham gia đề án có mã đề án là @MaDa và địa điểm đề án là @Ddiem_DA
CREATE PROC chuong5_p6_b3( @MaDA INT ,@Ddiem_DA NVARCHAR(15))
AS
BEGIN
SELECT COUNT(pc.MA_NVIEN) AS N'SO LUONG NVTGIA'
FROM (PHANCONG pc
JOIN DEAN da
ON pc.MADA = da.MADA) join Congviec cv on cv.MADA =PC.MADA AND PC.STT = CV.STT
WHERE pc.MADA = @MaDA
AND da.DDIEM_DA = @Ddiem_DA
END
EXEC chuong5_p6_b3 '10', N'Hà Nội'

-- bai 6
drop proc sp_xuattennv_theonamsinh
create procedure sp_xuattennv_theonamsinh @namsinh int
as
begin
select honv, tenlot, tennv
from nhanvien
where year (ngsinh) = @namsinh
end
go
exec sp_xuattennv_theonamsinh 1984

-- cau 7
create proc P_soluongthannhan @msnv nvarchar(9)
as
begin
select count(*) as soluongthannhan
from thannhan
where MA_NVIEN like @msnv
end
go
exec P_soluongthannhan '001'




--Phan 3- Bài 1: Viét store procedure
-- Thêm vào phòng ban có tên CNTT vàc CSDL QLDA,
-- các giá trị đưọc thếm vào dưói dạng tham số đảu vàc,
-- kiěm tra něu trùng MARHG thì thống báo thếm thát bại.
CREATE PROCEDURE Themphongban
@MAPHG int,
@TENPHG NVARCHAR(15),
@TRPHG NVARCHAR(9),
@NG_NHANCHUC DATE
as
BEGIN
IF EXISTS (SELECT 1 FROM PHONGBAN WHERE MAPHG = @MAPHG)
BEGIN
PRINT N'Thếm thất bại : Mã phòng ban đã tốn tậil';
END
ELSE
BEGIN
INSERT INTO PHONGBAN (MAPHG, TENPHG, TRPHG, NG_NHANCHUC)
VALUES (@MAPHG, @TENPHG,  @TRPHG, @NG_NHANCHUC)
PRINT N'Thếm thành công phòng ban mới! ';
END
end

exec Themphongban 7, N'abc', N'006', '2004-10-23'
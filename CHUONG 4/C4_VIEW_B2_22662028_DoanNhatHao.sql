USE [QLDA]
GO

-- cau 1
CREATE VIEW V_NHANVIEN_B1
AS
SELECT NV.MANV, NV.HONV, nv.TENLOT, NV.PHG
FROM NHANVIEN NV
WHERE NV.PHG = 4
GO

-- cau 2
CREATE VIEW V_NHANVIEN_B2
AS
SELECT MaNV, HoNV, TenNV, Luong
FROM NHANVIEN NV
WHERE NV.LUONG > 30000
go

-- cau 3
CREATE VIEW V_NHANVIEN_B3
AS
SELECT MaNV, HoNV, TenNV, Luong, PHG
FROM NHANVIEN NV
WHERE NV.LUONG > 25000 AND NV.PHG = 4 OR NV.LUONG > 30000 AND NV.PHG = 5
go

-- cau 4
CREATE VIEW V_NHANVIEN_B4
AS
SELECT MaNV, HoNV, TenNV, DCHI
FROM NHANVIEN NV
WHERE NV.DCHI LIKE N'%TP HCM'
go

-- cau 5
CREATE VIEW V_NHANVIEN_B5
AS
SELECT MANV, HoNV, TenNV
FROM NHANVIEN
WHERE HONV like N'N%'
go

-- cau 6
create  view V_NHANVIEN_B6
as
select MaNV, HoNV, TENLOT, TenNV, NgSinh, DChi
from NHANVIEN
where HONV = N'Đinh' AND TENLOT = N'Bá' AND TENNV = N'Tiên'
go

-- cau 7 
create view V_NHANVIEN_B7
as
select MANV, HONV,TENNV,NGSINH
from NHANVIEN
where YEAR(NGSINH) between 1960 and 1965
go

-- cau 8 
create view V_NHANVIEN_B8
as
select MaNV, HoNV, TenNV , year(NGSINH) as NamSinh
from NHANVIEN 
go

-- cau 9
create view V_NHANVIEN_B9
as
select MaNV, HoNV, TenNV , year(GETDATE()) - year(NGSINH) as Tuoi
from NHANVIEN 
go

-- cau 10 
create view V_TruongPhongBan_B10
as
select distinct MaNV, HoNV, TenLot, TenNV
from NHANVIEN nv
inner join PHONGBAN pb on pb.TRPHG = nv.MANV
inner join THANNHAN tn on tn.MA_NVIEN = nv.MANV
go

-- cau 11
create view V_TruongPhongBan_B11
as
select MaNV, HoNV, TenNV, pb.MAPHG
from NHANVIEN nv 
join PHONGBAN pb on pb.TRPHG = nv.MANV
go

-- cau 12
create view V_NHANVIEN_B12
as
select MaNV, HoNV, TenNV, Dchi, pb.TENPHG
from NHANVIEN nv 
join PHONGBAN pb on pb.MAPHG = nv.PHG
where pb.TENPHG like N'Nghiên Cứu'
go

-- cau 13
create view V_DEANOHN_B13
as
SELECT DA.TENDEAN,PB.TENPHG,NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS 'HO TEN TRUONG PHONG',PB.NG_NHANCHUC
FROM DEAN DA
JOIN PHONGBAN PB ON DA.PHONG = PB.MAPHG
JOIN NHANVIEN NV ON PB.TRPHG = NV.MANV
WHERE DA.DDIEM_DA = N'Hà Nội'
go

--14. Tìm tên những nữ nhân viên và tên người thân của họ
create view V_cau14
as
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS 'HO TEN NU NV', TN.TENTN AS 'TEN NGUOI THAN'
FROM NHANVIEN NV JOIN THANNHAN TN ON NV.MANV = TN.MA_NVIEN
WHERE NV.PHAI = N'Nữ'
go

--15. Với mỗi nhân viên, cho biết họ tên nhân viên và họ tên người quản lý trực tiếp của nhân viên đó
/* 15. Họ tên nhân viên và họ tên người quản lý trực tiếp */
create view V_cau15
as
SELECT NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS 'HO TEN NHAN VIEN',QL.HONV + ' ' + QL.TENLOT + ' ' + QL.TENNV AS 'HO TEN NGUOI QUAN LY'
FROM NHANVIEN NV LEFT JOIN NHANVIEN QL ON NV.MA_NQL = QL.MANV
go

--16. Với mỗi nhân viên, cho biết họ tên của nhân viên đó, họ tên người trưởng phòng và họ tên người quản lý trực tiếp của nhân viên đó.
create view V_cau16
as
SELECT 
    NV.HONV + ' ' + NV.TENLOT + ' ' + NV.TENNV AS 'NHAN VIEN',
    QL.HONV + ' ' + QL.TENLOT + ' ' + QL.TENNV AS 'QUAN LY TRUC TIEP',
    TP.HONV + ' ' + TP.TENLOT + ' ' + TP.TENNV AS 'TRUONG PHONG'
FROM NHANVIEN NV
LEFT JOIN NHANVIEN QL ON NV.MA_NQL = QL.MANV
LEFT JOIN PHONGBAN PB ON NV.PHG = PB.MAPHG
LEFT JOIN NHANVIEN TP ON PB.TRPHG = TP.MANV
go

--17. Tên những nhân viên phòng số 5 có tham gia vào đề án "Sản phẩm X" và nhân viên này do "Nguyễn Thanh Tùng" quản lý trực tiếp.
create view V_cau17
as
SELECT NV.TENNV
FROM NHANVIEN NV 
JOIN PHANCONG PC ON NV.MANV=PC.MA_NVIEN
--JOIN CONGVIEC CV ON PC.MADA=CV.MADA
--JOIN DEAN DA ON CV.MADA=DA.MADA
JOIN DEAN DA ON PC.MADA = DA.MADA -- Nối trực tiếp PC với DA
JOIN NHANVIEN QL ON NV.MA_NQL = QL.MANV
WHERE NV.PHG = 5 AND DA.TENDEAN = N'Sản Phẩm x' AND QL.HONV = N'Nguễn' AND QL.TENLOT = N'Thanh' AND QL.TENNV = N'Tùng'
go
--18. Cho biết tên các đề án mà nhân viên Đinh Bá Tiến đã tham gia.
create view V_cau18
as
SELECT DISTINCT DA.TENDEAN
FROM NHANVIEN NV
JOIN PHANCONG PC ON NV.MANV = PC.MA_NVIEN
JOIN DEAN DA ON PC.MADA = DA.MADA
WHERE NV.HONV = N'Đinh' 
AND NV.TENLOT = N'Bá' 
AND NV.TENNV = N'Tiên'
go

-- 19. Cho biết số lượng đề án của công ty
create view V_cau19
as
SELECT COUNT(MADA) AS TongSoDeAn
FROM DEAN
go

-- 20. Cho biết số lượng đề án do phòng 'Nghiên Cứu' chủ trì
create view V_cau20
as
SELECT PB.TENPHG, COUNT(MADA) AS SoLuongDeAn
FROM DEAN DA
JOIN PHONGBAN PB ON DA.PHONG = PB.MAPHG
GROUP BY PB.MAPHG, PB.TENPHG
HAVING PB.TENPHG LIKE N'Nghiên Cứu'
go

-- 21. Cho biết lương trung bình của các nữ nhân viên
create view V_cau21
as
SELECT PHAI, AVG(LUONG) AS Luong_trung_binh
FROM NHANVIEN
GROUP BY PHAI
HAVING PHAI LIKE N'Nữ'
go

-- 22. Cho biết số thân nhân của nhân viên 'Đinh Bá Tiến'
create view V_cau22
as
SELECT COUNT(TN.MA_NVIEN) AS N'ThanNhanCuaDinhBaTien'
FROM THANNHAN TN
JOIN NHANVIEN NV ON NV.MANV = TN.MA_NVIEN
GROUP BY TN.MA_NVIEN, NV.HONV, NV.TENNV, NV.TENLOT
HAVING NV.HONV LIKE N'Đinh' AND NV.TENLOT LIKE N'Bá' AND NV.TENNV LIKE N'Tiên'
go
-- Có 2 thẳng Đinh Bá Tiên :V

-- 23. Với mỗi đề án, liệt kê tên đề án và tổng số giờ làm việc một tuần của tất cả các nhân viên tham dự đề án đó
create view V_cau23
as
SELECT DA.TENDEAN, SUM(PC.THOIGIAN) AS Tong_So_Gio
FROM DEAN DA, PHANCONG PC
WHERE DA.MADA = PC.MADA
GROUP BY DA.TENDEAN
go
-- no sql chua chuan

-- 24. Với mỗi đề án, cho biết có bao nhiêu nhân viên tham gia đề án đó
create view V_cau24
as
SELECT DA.TENDEAN, COUNT(NV.MANV) AS So_Luong_NV
FROM NHANVIEN NV
JOIN PHANCONG PC ON NV.MANV = PC.MA_NVIEN
JOIN CONGVIEC CV ON PC.MADA = CV.MADA
JOIN DEAN DA ON CV.MADA = DA.MADA
GROUP BY DA.TENDEAN
go

-- 25. Với mỗi nhân viên, cho biết họ và tên nhân viên và số lượng thân nhân của nhân viên đó.
create view V_cau25
as
SELECT COUNT(TN.MA_NVIEN) AS N'SL_ThanNhan', NV.HONV +' '+ NV.TENLOT +' '+ NV.TENNV AS N'HoVaTenNV'
FROM NHANVIEN NV
JOIN THANNHAN TN ON NV.MANV = TN.MA_NVIEN
GROUP BY TN.MA_NVIEN , NV.HONV, NV.TENNV, NV.TENLOT
go

-- 26. Với mỗi nhân viên, cho biết họ tên của nhân viên và số lượng đề án mà nhân viên đó đã tham gia.
create view V_cau26
as
select NV.HONV +' '+ NV.TENLOT +' '+ NV.TENNV AS N'HoVaTenNV', COUNT(PC.MA_NVIEN)
FROM NHANVIEN NV
JOIN PHANCONG PC ON NV.MANV = PC.MA_NVIEN
JOIN CONGVIEC CV ON PC.MADA = CV.MADA
JOIN DEAN DA ON CV.MADA = DA.MADA
GROUP BY PC.MA_NVIEN, NV.HONV, NV.TENNV, NV.TENLOT
go
-- 27. Với mỗi nhân viên, cho biết số lượng nhân viên mà nhân viên đó quản lý trực tiếp.
create view V_cau27
as
SELECT COUNT(NV.MANV) as 'soluongnhanvienquanly', NV.HONV +' '+ NV.TENLOT +' '+ NV.TENNV AS N'HoVaTenNVQL'
FROM NHANVIEN NV
JOIN NHANVIEN NVQL ON NV.MANV = NVQL.MA_NQL
GROUP BY NV.MANV, NV.HONV, NV.TENNV, NV.TENLOT
go
-- 28
create view V_cau28
as
SELECT NV.PHG, PB.TENPHG, AVG(NV.LUONG) as 'luongtrungbinhcuaphongban'
FROM PHONGBAN PB 
JOIN NHANVIEN NV ON PB.MAPHG = NV.PHG
GROUP BY NV.PHG , PB.TENPHG
go
-- 29
create view V_cau29
as
SELECT NV.PHG, PB.TENPHG, AVG(NV.LUONG) as 'luongtrungbinhcuaphongban' ,COUNT(NV.MANV) as 'slnhanvien'
FROM PHONGBAN PB 
JOIN NHANVIEN NV ON PB.MAPHG = NV.PHG
GROUP BY NV.PHG , PB.TENPHG
HAVING AVG(NV.LUONG) > 30000
go
-- 30
create view V_cau30
as
SELECT PB.TENPHG, COUNT(DA.TENDEAN) as 'soluongdean'
FROM PHONGBAN PB 
JOIN DEAN DA ON PB.MAPHG = DA.PHONG
GROUP BY PB.TENPHG
go
-- 31
create view V_cau31
as
SELECT PB.TENPHG, COUNT(DA.TENDEAN) as 'soluongdean', NV.HONV +' '+ NV.TENLOT +' '+ NV.TENNV AS N'HoVaTenTP'
FROM PHONGBAN PB 
JOIN DEAN DA ON PB.MAPHG = DA.PHONG
JOIN NHANVIEN NV ON PB.TRPHG = NV.MANV
GROUP BY PB.TENPHG, PB.NG_NHANCHUC, NV.HONV, NV.TENLOT ,NV.TENNV
go
-- 32
create view V_cau32
as
SELECT PB.TENPHG, AVG(NV.LUONG), COUNT(DA.TENDEAN)
FROM PHONGBAN PB
JOIN DEAN DA ON PB.MAPHG = DA.PHONG
JOIN NHANVIEN NV ON PB.MAPHG = NV.PHG
GROUP BY PB.TENPHG 
HAVING AVG(NV.LUONG) > 40000
go
-- 33
create view V_cau33
as
SELECT DDP.DIADIEM, COUNT(DA.TENDEAN) as 'soluongdean'
FROM DEAN DA
JOIN PHONGBAN PB ON DA.PHONG = PB.MAPHG
JOIN DIADIEM_PHG DDP ON PB.MAPHG = DDP.MAPHG
GROUP BY DDP.DIADIEM
go
-- 34
create view V_cau34
as
SELECT DA.TENDEAN, COUNT(CV.TEN_CONG_VIEC) as 'soluongcv'
FROM DEAN DA
JOIN CONGVIEC CV ON DA.MADA = CV.MADA
GROUP BY DA.TENDEAN
go
-- 35. Với mỗi công việc trong đề án có mã đề án là 30, cho biết số lượng nhân viên được phân công .
create view V_cau35
as
SELECT CV.TEN_CONG_VIEC, COUNT(PC.MA_NVIEN) as 'soluongnhanviendcphancong'
FROM CONGVIEC CV 
JOIN DEAN DA ON CV.MADA = DA.MADA
JOIN PHANCONG PC ON CV.MADA = PC.MADA AND CV.STT = PC.STT
GROUP BY CV.TEN_CONG_VIEC, CV.MADA
HAVING CV.MADA like 30
go
-- 36. Với mỗi công việc trong đề án có mã đề án là 'Dao Tao', cho biết số lượng nhân viên được phân công.
create view V_cau36
as
SELECT CV.TEN_CONG_VIEC, COUNT(PC.MA_NVIEN) as 'soluongnhanviendcphancong'
FROM CONGVIEC CV 
JOIN DEAN DA ON CV.MADA = DA.MADA
JOIN PHANCONG PC ON CV.MADA = PC.MADA AND CV.STT = PC.STT
GROUP BY CV.TEN_CONG_VIEC, DA.TENDEAN
HAVING DA.TENDEAN like N'Đào tạo'
go

USE [QLDA]
GO

-- cau 1
CREATE VIEW V_NHANVIEN_B1
AS
SELECT NV.MANV, NV.HONV, nv.TENLOT, NV.PHG
FROM NHANVIEN NV
WHERE NV.PHG = 4
GO
select * FROM V_NHANVIEN_B1

-- cau 2
CREATE VIEW V_NHANVIEN_B2
AS
SELECT MaNV, HoNV, TenNV, Luong
FROM NHANVIEN NV
WHERE NV.LUONG > 30000

-- cau 3
CREATE VIEW V_NHANVIEN_B3
AS
SELECT MaNV, HoNV, TenNV, Luong, PHG
FROM NHANVIEN NV
WHERE NV.LUONG > 25000 AND NV.PHG = 4 OR NV.LUONG > 30000 AND NV.PHG = 5

-- cau 4
CREATE VIEW V_NHANVIEN_B4
AS
SELECT MaNV, HoNV, TenNV, DCHI
FROM NHANVIEN NV
WHERE NV.DCHI LIKE N'%TP HCM'

-- cau 5
CREATE VIEW V_NHANVIEN_B5
AS
SELECT MANV, HoNV, TenNV
FROM NHANVIEN
WHERE HONV like N'N%'

-- cau 6
create  view V_NHANVIEN_B6
as
select MaNV, HoNV, TENLOT, TenNV, NgSinh, DChi
from NHANVIEN
where HONV = N'Đinh' AND TENLOT = N'Bá' AND TENNV = N'Tiên'

-- cau 7 
create view V_NHANVIEN_B7
as
select MANV, HONV,TENNV,NGSINH
from NHANVIEN
where YEAR(NGSINH) between 1960 and 1965

-- cau 8 
create view V_NHANVIEN_B8
as
select MaNV, HoNV, TenNV , year(NGSINH) as NamSinh
from NHANVIEN 

-- cau 9
create view V_NHANVIEN_B9
as
select MaNV, HoNV, TenNV , year(GETDATE()) - year(NGSINH) as Tuoi
from NHANVIEN 

-- cau 10 
create view V_TruongPhongBan_B10
as
select distinct MaNV, HoNV, TenLot, TenNV
from NHANVIEN nv
inner join PHONGBAN pb on pb.TRPHG = nv.MANV
inner join THANNHAN tn on tn.MA_NVIEN = nv.MANV

-- cau 11
create view V_TruongPhongBan_B11
as
select MaNV, HoNV, TenNV, pb.MAPHG
from NHANVIEN nv 
join PHONGBAN pb on pb.TRPHG = nv.MANV

-- cau 12
create view V_NHANVIEN_B12
as
select MaNV, HoNV, TenNV, Dchi, pb.TENPHG
from NHANVIEN nv 
join PHONGBAN pb on pb.MAPHG = nv.PHG
where pb.TENPHG like N'Nghiên Cứu'



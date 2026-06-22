use QLDA

-- dem so luong nv
if OBJECT_ID ('fdemslnv','FN') is not null
	drop function fdemslnv
go
create function fdemslnv()
returns int
as
begin
 return (select count(NHANVIEN.MANV)from NHANVIEN)
end
go
print N'Tong so luong nhan vien: ' + convert(varchar,dbo.fdemslnv())

-- tao ham tra ve max luong ma cong ty tra cho nv
if OBJECT_ID ('fmaxluongnv','FN') is not null
	drop function fmaxluongnv
go
create function fmaxluongnv()
returns int
as
begin
return (select max(NHANVIEN.LUONG) from NHANVIEN)
end
go 
print N'Luong nhan vien cao nhat la: ' + convert(varchar,dbo.fmaxluongnv())

--
if OBJECT_ID ('fbangluongnv','FN') is not null
	drop function fbangluongnv
go
create function fbangluongnv()
returns table
as 
return (select LUONG, MANV from NHANVIEN)
go
select * from fbangluongnv()

--

if OBJECT_ID ('fbangnvphong','FN') is not null
	drop function fbangnvphong
go
create function fbangnvphong(@phong nvarchar(15))
returns table
as
return (select nv.* from NHANVIEN nv join PHONGBAN pb on pb.MAPHG = nv.PHG where pb.TENPHG = @phong)
go
select * from fbangnvphong(N'Điều Hành')
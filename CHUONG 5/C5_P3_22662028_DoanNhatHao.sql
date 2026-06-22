use QLSinhVien_22662028

-- Câu 1: Tạo hàm f_b1_cau1 trả về giá trị vô hướng
-- Tạo hàm nhận tham số đầu vào là giới tính nam hoặc nữ và trả về giá trị là tổng số lượng sinh viên theo giới tính. Xuất thông báo “So luong sinh vien theo gioi tinh la: “ + số lượng sinh viên.


if OBJECT_ID ('f_b1_cau1','FN') is not null
	drop function f_b1_cau1
go

create function f_b1_cau1(@GioiTinh nvarchar(5))
returns int
as
begin
	declare @GT int
	if @GioiTinh = N'nam' or @GioiTinh = N'Nam'
	begin
		set @GT = 0
	end
	else
	begin
		set @GT = 1
	end
	return (select count(*)from SinhVien
		where SinhVien.GioiTinh = @GT)
end
go
print N'Tong so sinh vien theo gioi tinh la la: ' + convert(varchar,dbo.f_b1_cau1(N'Nu'))

-- Câu 2: Tạo hàm f_b1_cau2 trả về giá trị vô hướng 
-- Tạo hàm nhận tham số đầu vào là MaSV và trả về giá trị là giá trị tuổi của Sinh viên này. Xuất thông báo “Tuoi cua sinh vien la: “ + số tuổi sinh viên.

if OBJECT_ID ('f_b1_cau2','FN') is not null
	drop function f_b1_cau2
go
create function f_b1_cau2(@MaSV char(10))
returns int
as
begin
	return  (
		select YEAR(GETDATE()) - YEAR(NgaySinh)
		from SinhVien
		where MaSV = @MaSV
		)
end
go
print 'Tuoi Sinh vien la: ' + convert(varchar,dbo.f_b1_cau2(N'SV001'))

--Câu 3: Tạo hàm f_b1_cau3 trả về giá trị bảng đơn 
--Tạo hàm nhập vào MaLop, trả về bảng gồm thông tin sau: MaLop, TenLop, Khoa.
drop function f_b1_cau3
create function f_b1_cau3(@MaLop char(10))
returns table
as
	return  (
		select * from Lop
		where MaLop =@MaLop
		)
go
select * from f_b1_cau3(N'L001')

-- Câu 4: Tạo hàm đơn f_b1_cau4 trả về giá trị bảng 
-- Tạo hàm nhập vào MaSV, trả về bảng gồm thông tin sau: MaSV, HoTen, Tuoi của sinh viên đó.

drop function f_b1_cau4
create function f_b1_cau4(@MaSV char(10))
returns table
as
	return  (
		select MaSV, HoTen, YEAR(GETDATE()) - YEAR(NgaySinh) as 'Tuoi' from SinhVien
		where MaSV = 'SV001'
		)
go
select * from f_b1_cau4(N'SV001')

Gợi ý câu 5 bt C4_3_MSSV_HOTEN:
--Câu 5: Tạo hàm trả về bảng nhận dữ liệu từ bảng SinhVien
--có MaSV được nhập vào.
--Nếu MaSV Null thì trả về bảng dữ liệu Sinh viên,
--ngược lại trả về dữ liệu Sinh viên ứng với MaSV nhập vào.  
Drop function f_b1_cau5
go
Create Function f_b1_cau5 (@MaSV char(10))
Returns @T_ListSV Table
(
    MaSV char(10),
    MaLop char(10),
    HoTen nvarchar(50),
    NgaySinh datetime,
    GioiTinh nvarchar(5)
)
As
Begin
    IF @MaSV is null
    Begin
        Insert Into @T_ListSV
        (
            [MaSV],
            [MaLop],
            [HoTen],
            [NgaySinh],
            [GioiTinh]
        )
        Select MaSV, MaLop, HoTen, NgaySinh, GioiTinh
        From SinhVien
    End
    Else
    Begin
        Insert Into @T_ListSV
            (
             [MaSV],
             [MaLop],
             [HoTen],
             [NgaySinh],
             [GioiTinh]
            )
        Select MaSV, MaLop, HoTen, NgaySinh, GioiTinh
        From SinhVien
        Where MaSV=@MaSV
    End        
    Return
End
--goi ham
Select * From f_b1_cau5('SV001')
Select * From f_b1_cau5(NULL)

-- bien tau lai tu cau 5
drop function f_b1_cau6
create function f_b1_cau6(@MaSV char(10))
returns table
as
	return  (
		select * from SinhVien
		where @MaSV is null or MaSV = @MaSV
		)
go
Select * From f_b1_cau6('SV001')
Select * From f_b1_cau6(NULL)
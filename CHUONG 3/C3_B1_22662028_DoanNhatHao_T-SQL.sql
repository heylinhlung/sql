create database [QLDA_22662028]
go
/**/
use QLDA_22662028
go
/*tao bang de an*/
CREATE TABLE [DEAN](
    [TENDEAN] [nvarchar](15) NOT NULL,
    [MADA] [int] NOT NULL,
    [DDIEM_DA] [nvarchar](15) NOT NULL,
    [PHONG] [int] NULL
)
go
/*tao bang phong ban*/
CREATE TABLE [PHONGBAN](
    [TENPHG] [nvarchar](15) NOT NULL,
    [MAPHG] [int] NOT NULL,
    [TRPHG] [nvarchar](9) NULL,
    [NG_NHANCHUC] [date] NOT NULL
)
/*tao khoa */
go
alter table [PHONGBAN] add constraint PK_PHONGBAN_MAPHG primary key (MAPHG)
go
alter table [DEAN] add constraint PK_DEAN_MADA primary key (MADA)
go
alter table DEAN add constraint PK_DEAN_PHONG foreign key (PHONG) references PHONGBAN (MAPHG)
go
/*tao bang cong viec*/
CREATE TABLE [CONGVIEC](
    [MADA] [int] NOT NULL,
    [STT] [int] NOT NULL,
    [TEN_CONG_VIEC] [nvarchar](50) NOT NULL,
	constraint PK_CONGVIEC_MADA primary key (MADA,STT),
	constraint FK_CONGVIEC_DEAN_MADA foreign key (MADA) references DEAN (MADA)
)
go
/*NHAP DU LIEU CHO BANG PHONGBAN*/
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Quản Lý', 1, N'006', CAST(N'1971-06-19' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Điều Hành', 4, N'008', CAST(N'1985-01-01' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'Nghiên Cứu', 5, N'005', CAST(N'0197-05-22' AS Date))
INSERT [dbo].[PHONGBAN] ([TENPHG], [MAPHG], [TRPHG], [NG_NHANCHUC]) VALUES (N'IT', 6, N'008', CAST(N'1985-01-01' AS Date))
/*NHAP DU LIEU CHO BANG DEAN*/
INSERT [dbo].[DEAN] ([TENDEAN], [MADA], [DDIEM_DA], [PHONG])
vALUES
    (N'Sản Phẩm x', 1, N'Vũng Tàu', 5),
    (N'Sản Phẩm Y', 2, N'Nha Trang', 5),
    (N'Sản Phẩm Z', 3, N'TP HCM', 5),
    (N'Tin Học Hóa', 10, N'Hà Nội', 4),
    (N'Cáp quang', 20, N'TP HCM', 1),
    (N'Đào tạo', 30, N'Hà Nội', 4)
go
/*NHAP LIEU BANG CONGVIEC*/
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (1, 1, N'Thiết kế sản phẩm X')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (1, 2, N'Thử nghiệm sản phẩm X')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (2, 1, N'Sản xuất sản phẩm Y')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (2, 2, N'Quảng cáo sản phẩm Y')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (3, 1, N'Khuyến mãi sản phẩm Z')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (10, 1, N'Tin học hóa phòng nhân sự')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (10, 2, N'Tin học hóa phòng kinh doanh')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (20, 1, N'Lắp đặt cáp quang')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (30, 1, N'Đào tạo nhân viên Marketing')
INSERT [dbo].[CONGVIEC] ([MADA], [STT], [TEN_CONG_VIEC]) VALUES (30, 2, N'Đào tạo nhân viên thiết kế')
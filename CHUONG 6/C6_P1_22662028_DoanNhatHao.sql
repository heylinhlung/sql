USE [QLDA]

GO

-- cau 1 
Create Trigger trig_LuongNV On NhanVien
For Insert
As
If (Select Luong From Inserted) <= 5000
Begin
Print 'Tien luong toi thieu phai lon hon 5000.'
Rollback Transaction
End

INSERT INTO [dbo].[NHANVIEN]
           ([HONV]
           ,[TENLOT]
           ,[TENNV]
           ,[MANV]
           ,[NGSINH]
           ,[DCHI]
           ,[PHAI]
           ,[LUONG]
           ,[MA_NQL]
           ,[PHG])
     VALUES
           ('Doan','Nhat','Hao','020','2004-10-23','tay ninh','nam',6000,'001',01)
GO

-- cau 2
Create Trigger trig_UNV On NhanVien
For Update
As
If (Select Luong From inserted) <= 5000
Begin
Print 'Tien luong toi thieu phai lon hon 5000.'
Rollback Transaction
End

UPDATE [dbo].[NHANVIEN]
   SET [HONV] = N'Nguyennnnn', [LUONG] = 6000
 WHERE MA_NQL like N'005'
GO

-- cau 3 Tạo Trigger Delete không cho phép xoá nhân viên có mã 005
Create Trigger trig_DNV On NhanVien
For delete
As
If (Select MaNV From deleted) like N'005'
Begin
Print 'khong duoc phep xoa nhan vien ma 005'
Rollback Transaction
End

DELETE FROM [dbo].[NHANVIEN]
      WHERE MaNV like N'005'
GO

-- cau 4 Viết Trigger ràng buộc không được xoá nhân viên ở TP.HCM
Create Trigger trig_DNVhcm On NhanVien
For delete
As
If (Select DCHI From deleted) like N'%HCM%'
Begin
Print 'khong duoc phep xoa nhan vien o tphcm'
Rollback Transaction
End

DELETE FROM [dbo].[NHANVIEN]
      WHERE MaNV like N'001'
GO

-- cau 5 Viết Trigger đếm số lượng nhân viên bị xoá khi thực hiện xoá các nhân viên ở TP.HCM.
Create Trigger trig_CountDNVhcm On NhanVien
For delete
As
If (Select DCHI From deleted) like N'%HCM%'
Begin
 DECLARE @SoLuong INT

    SELECT @SoLuong = COUNT(*)
    FROM deleted
    WHERE DCHI LIKE N'%HCM%'

    PRINT N'Số nhân viên ở TP.HCM bị xóa: ' + CAST(@SoLuong AS VARCHAR(10))
Rollback Transaction
End

DELETE FROM NHANVIEN
WHERE DCHI LIKE N'%HCM%'
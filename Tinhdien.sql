CREATE DATABASE TIENDIEN
GO
--
CREATE TABLE LHSD
(
MALHSD CHAR(5),
DGIA INT,
DMUC NVARCHAR(50),
PRIMARY KEY (MALHSD)
)
GO
--
CREATE TABLE KHACH
(
MAK CHAR(5),
TENK NVARCHAR(50),
DIACHI NVARCHAR(50),
PRIMARY KEY (MAK)
)
GO
--
CREATE TABLE HOADON
(
SOHOADON CHAR(5),
SOHD CHAR(5),
NGAYGHI DATE,
CSCU INT,
CSMOI INT,
SDSD INT,
VUOTDM INT,
TIEND INT,
THUE INT,
TONGTIEN INT,
PRIMARY KEY (SOHOADON)
)
GO
--
CREATE TABLE HOPDONG
(
SOHD CHAR(5),
NGAYKY DATE,
SOCT NCHAR(5),
MALHSD CHAR(5),
MAK CHAR(5),
PRIMARY KEY (SOHD)
)
GO
--
--Tạo khóa ngoại
ALTER TABLE HOPDONG
	ADD CONSTRAINT FK_KHACH
	FOREIGN KEY (MAK)
	REFERENCES KHACH
	GO
--
ALTER TABLE HOPDONG
	ADD CONSTRAINT FK_LHSD
	FOREIGN KEY (MALHSD)
	REFERENCES LHSD
	GO
--
ALTER TABLE HOADON
	ADD CONSTRAINT FK_HOPDONG
	FOREIGN KEY (SOHD)
	REFERENCES HOPDONG
	GO
--
ALTER TABLE HOADON
	ADD CONSTRAINT FK_HD
	FOREIGN KEY(MALHSD)
	REFERENCES LHSD
	GO
---------------------------------------------------------------
--Phần BÀI TẬP
UPDATE LHSD
SET DGIA=CASE
WHEN DMUC=N'Sinh Hoạt' THEN 1900
WHEN DMUC=N'Sản Xuất'  THEN 2300
WHEN DMUC=N'Kinh Doanh'THEN 2500
END
GO
--
UPDATE HOPDONG
SET SOCT ='CT001'
WHERE SOHD='HD001'
GO
--
UPDATE HOADON
SET SDSD=CSCU-CSMOI
GO
--
--UPDATE HOADON
--SET TIEND=SDSD*CASE
--WHEN HOADON.MALHSD=LHSD.MALHSD THEN LHSD.DGIA
--
SELECT KHACH.* FROM HOPDONG JOIN LHSD ON HOPDONG.MALHSD=LHSD.MALHSD JOIN KHACH ON KHACH.TENK=HOPDONG.MAK
WHERE MONTH(NGAYKY)=10 AND YEAR(NGAYKY)=2018
GO
--
SELECT DMUC,COUNT(MAK) AS SOLUONGKHACH FROM KHACH,LHSD
GROUP BY DMUC
GO
--
SELECT TOP 1* FROM HOADON,LHSD 
WHERE DMUC=N'Sinh Hoạt' AND MONTH(NGAYGHI)=10 AND YEAR(NGAYGHI)=2018
ORDER BY SDSD DESC
GO
 -- CHUA RA
 SELECT TENK, COUNT(VUOTDM) AS VUOTDINHMUC FROM KHACH,HOADON
 WHERE VUOTDM>0 AND MONTH(NGAYGHI)<7 AND YEAR(NGAYGHI)=2018
 GROUP BY VUOTDM
 GO
 --
 SELECT KHACH.*,SUM(SDSD) FROM KHACH,HOADON

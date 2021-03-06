CREATE DATABASE THUE_TRO
GO
-- tạo bảng nhà trọ
CREATE TABLE NHATRO
(
DIACHI NVARCHAR(50),
SOLUONGPHONG INT,
CHUTRO NVARCHAR(50),
PRIMARY KEY (DIACHI)
)
GO
-- Tạo bảng phòng trọ
CREATE TABLE PHONGTRO
(
SOPHONG CHAR(3),
DIENTICH INT,
DIACHI NVARCHAR(50),
GIAPHONG INT,
TRANGTHAI NVARCHAR (50),
SONGUOI INT,
PRIMARY KEY(SOPHONG,DIENTICH)
)
GO
--Tạo bảng Khách Thuê
CREATE TABLE KHACHTHUE
(
CMND CHAR(15),
TEN NVARCHAR(50),
AGE INT,
SDT CHAR(12),
SEX BIT,
PRIMARY KEY (CMND)
)
GO
--Tạo bảng hợp đồng
CREATE TABLE HOPDONG
(
MAHD CHAR(5),
DIACHI NVARCHAR(50),
SOPHONG CHAR(3),
CMND CHAR(15),
NGAYTHUE DATE,
DATTRUOC INT,
PRIMARY KEY (MAHD)
)
GO
--Tạo bảng hóa đơn
CREATE TABLE HOADON
(
SOHOADON CHAR(5),
MAHD CHAR(5),
SOPHONG CHAR(3),
DIENTICH INT,
GIAPHONG INT,
SODIENDAU INT,
SODIENSAU INT,
TIENDIEN INT,
SONUOCDAU INT,
SONUOCSAU INT,
TIENNUOC INT,
TIENRAC INT DEFAULT 7,
TONG INT,
PRIMARY KEY (SOHOADON)
)
GO

--Tạo khóa ngoại cho bảng hợp đồng đến nhà trọ
ALTER TABLE HOPDONG
	ADD CONSTRAINT FK_DIACHI
	FOREIGN KEY (DIACHI)
	REFERENCES NHATRO(DIACHI)
	GO
-- Tạo khóa ngoại cho bảng Phòng trọ đến nhà trọ
ALTER TABLE PHONGTRO
	ADD CONSTRAINT FK_SOPHONG
	FOREIGN KEY (DIACHI)
	REFERENCES NHATRO(DIACHI)
	GO
-- Tạo khóa ngoại cho bảng Hợp đồng đến khách thuê
ALTER TABLE HOPDONG
	ADD CONSTRAINT FK_HOPDONG
	FOREIGN KEY (CMND)
	REFERENCES KHACHTHUE(CMND)
	GO
-- Tạo khóa ngoại cho bảng hóa đơn đến hơp đồng
ALTER TABLE HOADON
	ADD CONSTRAINT FK_MAHD
	FOREIGN KEY (MAHD)
	REFERENCES HOPDONG(MAHD)
	GO
-- Tạo khóa ngoại cho bảng hóa dơn đến bảng phòng trọ 
ALTER TABLE HOADON
	ADD CONSTRAINT FK_SOPHONGHD
	FOREIGN KEY (SOPHONG,DIENTICH)
	REFERENCES PHONGTRO(SOPHONG,DIENTICH)
	GO
--
-----------------------------------------------------
-- Thêm dữ liệu bảng Nhà Trọ
INSERT INTO NHATRO
VALUES (N'123 Phạm Tứ',5,N'Nguyễn Anh Tuấn')
INSERT INTO NHATRO
VALUES (N'432 Trường Chinh',7,N'Phạm Thị Chi')
INSERT INTO NHATRO
VALUES (N'44 Tôn Đản',5,N'Nguyễn Thị Hoa')
-- Thêm dữ liệu bảng phòng trọ
--
INSERT INTO PHONGTRO
VALUES ('101',50,N'123 Phạm Tứ',700,N'Chưa Thuê',2)
INSERT INTO PHONGTRO
VALUES ('102',70,N'123 Phạm Tứ',1200,N'Chưa Thuê',4)
INSERT INTO PHONGTRO
VALUES ('103',40,N'123 Phạm Tứ',500,N'Chưa Thuê',3)
INSERT INTO PHONGTRO
VALUES ('01',30,N'432 Trường Chinh',800,N'Chưa Thuê',1)
INSERT INTO PHONGTRO
VALUES ('02',50,N'432 Trường Chinh',1000,N'Chưa Thuê',3)
INSERT INTO PHONGTRO
VALUES ('P1',50,N'432 Trường Chinh',1200,N'Chưa Thuê',4)
INSERT INTO PHONGTRO
VALUES ('P2',70,N'432 Trường Chinh',1400,N'Chưa Thuê',5)
INSERT INTO PHONGTRO
VALUES ('P3',100,N'432 Trường Chinh',1600,N'Chưa Thuê',5)
-- Thêm dữ liệu vào bảng khách thuê
--
INSERT INTO KHACHTHUE
VALUES ('0931837334',N'Trần Hào',24,'0934223388',1)
INSERT INTO KHACHTHUE
VALUES ('0865224565',N'Trần Tèo',18,'0157844664',1)
INSERT INTO KHACHTHUE
VALUES ('0146334555',N'Phạm Thị Nỡ',41,'0123456789',0)
INSERT INTO KHACHTHUE
VALUES ('0144335456',N'Mạc Thị Phước',32,'0944887755',0)
-- Thêm dữ liệu vào bảng Hợp Đồng
--
INSERT INTO HOPDONG
VALUES ('HD1',N'432 Trường Chinh','02','0865224565','20170214',1000)
INSERT INTO HOPDONG
VALUES ('HD2',N'432 Trường Chinh','01','0931837334','20150100',800)
INSERT INTO HOPDONG
VALUES ('HD3',N'123 Phạm Tứ','103','0146334555','20170516',500)
INSERT INTO HOPDONG
VALUES ('HD4',N'123 Phạm Tứ','102','0144335456','20170415',1200)
-- Thêm dự liệu vào bảng Hóa đơn 
--
INSERT INTO HOADON(SOHOADON,MAHD,GIAPHONG)
VALUES ('01','HD1',1200)
INSERT INTO HOADON(SOHOADON,MAHD,GIAPHONG)
VALUES ('02','HD2',1500)
--
---------------------------------------
--Update dữ liệu cho bảng Hóa đơn
--Đặt tiền điện
UPDATE HOADON
SET TIENDIEN =(SODIENSAU-SODIENDAU)*3
--Đặt tiền nước
UPDATE HOADON
SET TIENNUOC=(SONUOCSAU-SONUOCDAU)*7
--Đặt lại giá phòng
UPDATE HOADON
SET GIAPHONG =
CASE
	WHEN DIENTICH =50 THEN 1400
	WHEN DIENTICH =40 THEN 1200
	WHEN DIENTICH =70 THEN 1800
	WHEN DIENTICH =100 THEN 2000
END
--Đặt tổng hóa đơn
UPDATE HOADON
SET TONG =GIAPHONG+TIENDIEN+TIENNUOC+TIENRAC
--

--Update cho bảng phòng trọ
 UPDATE PHONGTRO
SET TRANGTHAI=N'Đã Thuê'
WHERE SOPHONG='02'
--

-----------------------------------------
-- Phần Select truy xuất dữ liệu
SELECT * FROM NHATRO

--

SELECT * FROM HOPDONG

--Truy xuất thông tin 2 bảng phòng trọ và nhà trọ không có điều kiện

SELECT * FROM PHONGTRO,NHATRO

--Truy xuất thông tin 2 bảng phòng trọ và nhà trọ có điều kiện

SELECT * FROM PHONGTRO JOIN NHATRO ON PHONGTRO.DIACHI=NHATRO.DIACHI

-- 1.Truy xuất thông tin phòng trọ có Địa chỉ là 432 Trường Chinh

SELECT * FROM PHONGTRO
WHERE DIACHI=N'432 Trường Chinh'

-- 2.Truy xuất thông tin chủ trọ của địa chỉ 123 Phạm Tứ

SELECT CHUTRO FROM NHATRO
WHERE DIACHI=N'123 Phạm Tứ'

-- 3.Cho biết ngày thuê của phòng trọ có số phòng 101

 SELECT NGAYTHUE FROM HOPDONG 
 WHERE SOPHONG='101'

-- 4.Xem Phòng trọ nào chưa đc thuê và giá phòng dưới 1000

SELECT * FROM PHONGTRO
WHERE TRANGTHAI=N'Chưa Thuê' AND GIAPHONG<1000 

-- 5.Kiểm tra phòng có giá thấp nhất trọ của Phạm Thị Chi

SELECT TOP 1.* FROM PHONGTRO JOIN NHATRO ON PHONGTRO.DIACHI=NHATRO.DIACHI
WHERE CHUTRO = N'Phạm Thị Chi'
 ORDER BY GIAPHONG ASC 

-- 6.Kiểm tra số phòng chưa đc thuê của chủ trọ Phạm Thị Chi

 SELECT	TRANGTHAI,COUNT(*) AS SOPHONG FROM PHONGTRO JOIN NHATRO ON PHONGTRO.DIACHI=NHATRO.DIACHI
 WHERE CHUTRO=N'Phạm Thị Chi'
 GROUP BY TRANGTHAI

-- 7.Kiểm tra nhưng tên của người thuê trọ đã  của quý 1 năm 2018

 SELECT KHACHTHUE.* FROM HOPDONG JOIN KHACHTHUE ON HOPDONG.CMND=KHACHTHUE.CMND
 WHERE MONTH(NGAYTHUE)<4 AND YEAR(NGAYTHUE)=2018

--8.Kiểm tra danh thu theo từng phòng trong năm 2018

 SELECT HOPDONG.SOPHONG,SUM(TONG) AS DOANHTHU FROM  HOADON JOIN HOPDONG on HOADON.MAHD=HOPDONG.MAHD
 WHERE YEAR(NGAYTHUE) =2018
 GROUP BY HOPDONG.SOPHONG
 

 -- 9.Kiểm tra xem phòng nào đã thuê và làm hợp đồng 

SELECT * FROM PHONGTRO LEFT JOIN HOPDONG
ON PHONGTRO.SOPHONG=HOPDONG.SOPHONG

SELECT * FROM PHONGTRO RIGHT JOIN HOPDONG
ON PHONGTRO.SOPHONG=HOPDONG.SOPHONG

-- 10.Gom 2 bảng lại , bảng nào không có trong điều kiện thì để NULL
SELECT * FROM PHONGTRO FULL OUTER JOIN HOPDONG
ON PHONGTRO.SOPHONG=HOPDONG.SOPHONG


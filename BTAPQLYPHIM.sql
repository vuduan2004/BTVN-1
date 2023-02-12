create database QuanLyPhim
--drop database QuanLyPhim

use QuanLyPhim

CREATE TABLE Users1( --drop table Users1
	IdNguoiDung int not null primary key,
	hoTen varchar(255),
	sdt varchar(255),
	gioiTinh varchar(255),
);

INSERT INTO Users1 VALUES (1,'Nguyen Manh Linh','0971968611','Nam'), (2,'Dinh Tien Hoang','0123456789','Nam'), (3, 'Le Dinh Linh', '0987654321', 'Nam')
INSERT INTO Users1 VALUES (4,'Nguyen Van A', '000000000', 'Nam'), (5,'Nguyen Van B', '000000000', 'Nam'), (6,'Nguyen Thi C', '000000000', 'Nu')

CREATE TABLE Category1( --drop table Category1
	IdDanhMuc varchar(255) not null primary key,
	tenDanhMuc varchar(255)
);

INSERT INTO Category1 VALUES ('PH','Phim Hot'),
('PBMCP','Phim Bo Moi Cap Nhat'), ('PHH','Phim Hoat Hinh'), ('DYT','Duoc Yeu Thich')

CREATE TABLE Movie1( --drop table Movie1
	IdPhim varchar(255) not null primary key,
	tenPhim varchar(255),
	theLoai varchar(255),
	IdDanhMuc varchar(255),
	ngaySanXuat int,
	giaPhim int,
	maRap varchar(255),
	foreign key (IdDanhMuc) references Category1(IdDanhMuc)
);

INSERT INTO Movie1 VALUES ('#trolley','TROLLEY','Tam ly - Tinh cam', 'PH', 2022, 80000,'CGV'),
('#rm','RUNNING MAN', 'Hai Huoc', 'PBMCP', 2010, 100000,'CGV'),
('#op','ONE PIECE', 'Hanh Dong', 'PHH', 1999, 130000,'CGV'),
('#nbm','NHA BA NU', 'Tam ly - Hai huoc','PH' ,2022, 150000,'CGV')


CREATE TABLE Rent1( --drop table Rent1
	IdVeThue varchar(255) not null primary key,
	thoiGianThue datetime,
	IdNguoiDung int,
	IdPhim varchar(255),
	IdDanhMuc varchar(255),
	giaThue1Ngay int,
	thoiGianTra datetime,
	foreign key (IdDanhMuc) references Category1(IdDanhMuc),
	foreign key (IdPhim) references Movie1(IdPhim),
	foreign key (IdNguoiDung) references Users1(IdNguoiDung)
);

INSERT INTO Rent1 VALUES ('VT1','2023/02/05 00:00',1, '#op','PHH' ,250000, '2023/02/11 00:00'),
('VT2','2023/02/05 00:00',2, '#nbm', 'PH' , 300000, '2023/02/11 00:00'),
('VT3','2023/02/05 00:00',2, '#rm','DYT', 400000, '2023/02/11 00:00'),
('VT4','2023/02/05 00:00',3, '#trolley', 'PBMCP' , 250000, '2023/02/11 00:00'),
('VT5','2023/02/05 00:00',1, '#nbm', 'PH' , 300000, '2023/02/11 00:00'),
('VT6','2023/02/05 00:00',4, '#nbm', 'PH' , 300000, '2023/02/11 00:00'),
('VT7','2023/02/05 00:00',5, '#nbm', 'PH' , 300000, '2023/02/11 00:00')


SELECT * FROM Users1
SELECT * FROM Category1
SELECT * FROM Movie1
SELECT * FROM Rent1

--a. Lay ra 3 nguoi thue nhieu phim nhat. Hien thi thong tin nhung nguoi thue phim do

SELECT TOP 3 Rent1.IdNguoiDung, COUNT(Rent1.IdNguoiDung) AS soLuongNguoiThue
FROM Rent1
inner join Users1 ON Users1.IdNguoiDung = Rent1.IdNguoiDung
GROUP BY Rent1.IdNguoiDung
ORDER BY soLuongNguoiThue DESC 

--b. Tinh tong doanh thu cua 1 bo phim trong 2 ngay
SELECT DISTINCT Movie1.IdPhim, Movie1.tenPhim, Rent1.giaThue1Ngay*2*(COUNT(Rent1.IdNguoiDung)) AS tongdoanhThu2Ngay
FROM Movie1
inner join Rent1 on Movie1.IdPhim = Rent1.IdPhim

--c. Lay ra top 3 phim duoc thue nhieu nhat trong 1 ngay (VD: ngay 05/02/2023)
SELECT TOP 3 Rent1.IdPhim, COUNT(Rent1.IdPhim) AS soLuongDuocThue
FROM Rent1
GROUP BY Rent1.IdPhim
ORDER BY soLuongDuocThue DESC 

--d. Hien thi danh sach tat ca thong tin phim
SELECT DISTINCT * FROM Movie1
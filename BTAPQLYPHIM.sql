create database QuanLyPhim
--drop database QuanLyPhim

use QuanLyPhim

CREATE TABLE Cinemas (
	maRap varchar(255) not null primary key,
	tenRap varchar(255)
);

INSERT INTO Cinemas VALUES ('CGV','CGV Cinemas')

CREATE TABLE Users1( --drop table Users
	IdNguoiDung int not null primary key,
	hoTen varchar(255),
	sdt varchar(255),
	gioiTinh varchar(255),
	maRap varchar(255)
	foreign key (maRap) references Cinemas(maRap)
);

INSERT INTO Users1 VALUES (1,'Nguyen Manh Linh','0971968611','Nam','CGV'), (2,'Dinh Tien Hoang','0123456789','Nam','CGV'), (3, 'Le Dinh Linh', '0987654321', 'Nam','CGV')

CREATE TABLE Category1( --drop database Category
	IdDanhMuc varchar(255) not null primary key,
	tenDanhMuc varchar(255)
);

INSERT INTO Category1 VALUES ('PH','Phim Hot'),
('PBMCP','Phim Bo Moi Cap Nhat'), ('PHH','Phim Hoat Hinh'), ('DYT','Duoc Yeu Thich')

CREATE TABLE Movie1( --drop table Movie
	IdPhim varchar(255) not null primary key,
	tenPhim varchar(255),
	theLoai varchar(255),
	IdDanhMuc varchar(255),
	ngaySanXuat int,
	giaPhim int,
	maRap varchar(255),
	foreign key (IdDanhMuc) references Category1(IdDanhMuc),
	foreign key (maRap) references Cinemas(maRap)
);

INSERT INTO Movie1 VALUES ('#trolley','TROLLEY','Tam ly - Tinh cam', 'PH', 2022, 80000,'CGV'),
('#rm','RUNNING MAN', 'Hai Huoc', 'PBMCP', 2010, 100000,'CGV'),
('#op','ONE PIECE', 'Hanh Dong', 'PHH', 1999, 130000,'CGV'),
('#nbm','NHA BA NU', 'Tam ly - Hai huoc','PH' ,2022, 150000,'CGV')


CREATE TABLE Rent1( --drop table Rent
	IdVeThue varchar(255) not null primary key,
	thoiGianThue datetime,
	IdNguoiDung int,
	IdPhim varchar(255),
	IdDanhMuc varchar(255),
	soTien int,
	thoiGianTra datetime,
	foreign key (IdDanhMuc) references Category1(IdDanhMuc),
	foreign key (IdPhim) references Movie1(IdPhim),
	foreign key (IdNguoiDung) references Users1(IdNguoiDung)
);

INSERT INTO Rent1 VALUES ('VT1','2023/02/05 00:00',1, '#op','PHH' ,200000, '2023/02/11 00:00'),
('VT2','2023/02/05 00:00',2, '#nbm', 'PH' , 300000, '2023/02/11 00:00'),
('VT3','2023/02/05 00:00',1, '#rm','DYT', 400000, '2023/02/11 00:00'),
('VT4','2023/02/05 00:00',3, '#trolley', 'PBMCP' , 250000, '2023/02/11 00:00')


SELECT * FROM Users1
SELECT * FROM Category1
SELECT * FROM Movie1
SELECT * FROM Rent1

SELECT hoTen, tenPhim, theLoai, soTien, thoiGianThue, thoiGianTra
FROM Users1
inner join Rent1 ON Users1.IdNguoiDung = Rent1.IdNguoiDung
inner join Movie1 ON Rent1.IdPhim = Movie1.IdPhim
WHERE soTien <= 300000
AND theLoai != 'Hanh dong'

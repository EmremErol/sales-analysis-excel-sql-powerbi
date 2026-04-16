CREATE DATABASE SalesAnalysisDB;
USE SalesAnalysisDB;

CREATE TABLE CITIES(
CITYID INT PRIMARY KEY IDENTITY(1,1),
CITYNAME VARCHAR(50) NOT NULL
);

INSERT INTO CITIES (CITYNAME) VALUES
('Ýstanbul'),('Ankara'),('Ýzmir'),('Bursa'),('Antalya'),('Adana'),('Konya'),('Gaziantep'),('Kayseri'),('Mersin'),('Samsun'),('Trabzon'),
('Eskiþehir'),('Diyarbakýr'),('Þanlýurfa'),('Kocaeli'),('Muðla'),('Tekirdað'),('Balýkesir'),('Aydýn');

CREATE TABLE CATEGORIES(
CATEGORYID INT PRIMARY KEY IDENTITY(1,1),
CATEGORYNAME VARCHAR(50) NOT NULL
);

INSERT INTO CATEGORIES (CATEGORYNAME) VALUES
('Ýçecek'),('Atýþtýrmalýk'),('Süt Ürünleri'),('Fýrýn Ürünleri'),('Dondurulmuþ Gýda'),('Temizlik'),('Kiþisel Bakým'),('Elektronik'),
('Kýrtasiye'),('Bebek Ürünleri'),('Ev Ürünleri'),('Bakliyat'),('Makarna'),('Konserve'),('Kahvaltýlýk'),('Tatlý'),('Meyve Sebze'),
('Et Ürünleri'),('Ýçecek Tozu'),('Mutfak Gereçleri');

CREATE TABLE CUSTOMERS(
CUSTOMERID INT PRIMARY KEY IDENTITY(1,1),
CUSTOMERNAME VARCHAR(50) NOT NULL,
CITYID INT NOT NULL,
GENDER VARCHAR(1) NOT NULL CHECK (GENDER IN ('E','K')),
AGE  INT NOT NULL CHECK (AGE > 0),
FOREIGN KEY(CITYID) REFERENCES CITIES(CITYID)
);

INSERT INTO CUSTOMERS (CUSTOMERNAME, CITYID, GENDER, AGE) VALUES
('Ahmet Yýlmaz', 1, 'E', 25),('Ayþe Demir', 2, 'K', 30),('Mehmet Kaya', 3, 'E', 28),('Fatma Çelik', 4, 'K', 35),('Ali Arslan', 5, 'E', 22),
('Zeynep Koç', 6, 'K', 27),('Hasan Þahin', 7, 'E', 40),('Elif Yýldýz', 8, 'K', 24),('Mustafa Aydýn', 9, 'E', 33),('Merve Özkan', 10, 'K', 29),
('Emre Can', 11, 'E', 26),('Seda Kurt', 12, 'K', 31),('Burak Eren', 13, 'E', 38),('Cansu Akýn', 14, 'K', 23),('Onur Polat', 15, 'E', 36),
('Büþra Güneþ', 16, 'K', 28),('Kerem Yalçýn', 17, 'E', 32),('Derya Aslan', 18, 'K', 34),('Oðuzhan Tunç', 19, 'E', 27),('Ece Bulut', 20, 'K', 21);

CREATE TABLE PRODUCTS(
PRODUCTID INT PRIMARY KEY IDENTITY(1,1),
PRODUCTNAME VARCHAR(50) NOT NULL,
CATEGORYID INT NOT NULL,
PRICE DECIMAL(10,2) NOT NULL CHECK (PRICE > 0),
FOREIGN KEY (CATEGORYID) REFERENCES CATEGORIES(CATEGORYID)
);

INSERT INTO PRODUCTS (PRODUCTNAME, CATEGORYID, PRICE) VALUES
('Kola 1L', 1, 35.00),('Patates Cipsi', 2, 28.50),('Süt 1L', 3, 32.00),('Ekmek', 4, 12.00),('Dondurulmuþ Pizza', 5, 85.00),
('Bulaþýk Deterjaný', 6, 40.00),('Þampuan', 7, 55.90),('Kulaklýk', 8, 350.00),('Defter', 9, 18.00),('Bebek Bezi', 10, 210.00),
('Yastýk', 11, 180.00),('Kýrmýzý Mercimek', 12, 45.00),('Spagetti', 13, 26.50),('Konserve Fasulye', 14, 30.00),('Zeytin', 15, 60.00),
('Çikolatalý Puding', 16, 22.00),('Domates', 17, 18.50),('Sucuk', 18, 145.00),('Türk Kahvesi', 19, 75.00),('Tava', 20, 240.00);

CREATE TABLE ORDERS(
ORDERID INT PRIMARY KEY IDENTITY(1,1),
CUSTOMERID INT NOT NULL,
ORDERDATE DATE NOT NULL,
PAYMENTMETHOD VARCHAR(30) NOT NULL,
FOREIGN KEY (CUSTOMERID) REFERENCES CUSTOMERS(CUSTOMERID)
);

INSERT INTO ORDERS (CUSTOMERID, ORDERDATE, PAYMENTMETHOD) VALUES
(1, '2024-01-15', 'Kredi Kartý'),(2, '2024-02-28', 'Nakit'),(3, '2024-03-12', 'Banka Kartý'),(4, '2024-04-25', 'Kredi Kartý'),
(5, '2024-06-09', 'Nakit'),(6, '2024-07-21', 'Kredi Kartý'),(7, '2024-09-03', 'Banka Kartý'),(8, '2024-10-17', 'Nakit'),(9, '2024-12-05', 'Kredi Kartý'),
(10, '2025-01-11', 'Banka Kartý'),(11, '2025-02-26', 'Nakit'),(12, '2025-04-08', 'Kredi Kartý'),(13, '2025-05-19', 'Banka Kartý'),(14, '2025-07-30', 'Nakit'),
(15, '2025-09-14', 'Kredi Kartý'),(16, '2025-11-22', 'Banka Kartý'),(17, '2026-01-07', 'Nakit'),(18, '2026-02-18', 'Kredi Kartý'),(19, '2026-03-27', 'Banka Kartý'),
(20, '2026-04-06', 'Nakit');

CREATE TABLE ORDERDETAILS(
ORDERDETAILID INT PRIMARY KEY IDENTITY(1,1),
ORDERID INT NOT NULL,
PRODUCTID INT NOT NULL,
QUANTITY INT NOT NULL CHECK (QUANTITY > 0),
UNITPRICE DECIMAL(10,2) NOT NULL CHECK (UNITPRICE > 0),
FOREIGN KEY (ORDERID) REFERENCES ORDERS(ORDERID),
FOREIGN KEY (PRODUCTID) REFERENCES PRODUCTS(PRODUCTID)
);

INSERT INTO ORDERDETAILS (ORDERID, PRODUCTID, QUANTITY, UNITPRICE) VALUES
(1, 1, 2, 35.00),(2, 2, 1, 28.50),(3, 3, 3, 32.00),(4, 4, 2, 12.00),(5, 5, 1, 85.00),(6, 6, 2, 40.00),
(7, 7, 1, 55.90),(8, 8, 1, 350.00),(9, 9, 4, 18.00),(10, 10, 1, 210.00),(11, 11, 2, 180.00),(12, 12, 1, 45.00),
(13, 13, 3, 26.50),(14, 14, 2, 30.00),(15, 15, 2, 60.00),(16, 16, 1, 22.00),(17, 17, 5, 18.50),(18, 18, 1, 145.00),(19, 19, 2, 75.00),
(20, 20, 1, 240.00);


INSERT INTO CUSTOMERS (CUSTOMERNAME, CITYID, GENDER, AGE) VALUES
('Deniz Kara', 1, 'K', 26),
('Hakan Özdemir', 2, 'E', 34),
('Gizem Acar', 3, 'K', 29),
('Murat Kýlýç', 4, 'E', 41),
('Selin Ersoy', 5, 'K', 24),
('Tolga Yýldýrým', 6, 'E', 31),
('Nazlý Þimþek', 7, 'K', 27),
('Serkan Taþ', 8, 'E', 36),
('Melis Çetin', 9, 'K', 22),
('Barýþ Yalýn', 10, 'E', 33),
('Hande Uslu', 11, 'K', 30),
('Uður Kaplan', 12, 'E', 39),
('Pelin Doðan', 13, 'K', 28),
('Kaan Turan', 14, 'E', 25),
('Ýrem Öztürk', 15, 'K', 32),
('Volkan Aksoy', 16, 'E', 37),
('Tuðba Arý', 17, 'K', 23),
('Levent Güneþ', 18, 'E', 42),
('Bahar Ekin', 19, 'K', 35),
('Caner Bozkurt', 20, 'E', 29);

INSERT INTO ORDERS (CUSTOMERID, ORDERDATE, PAYMENTMETHOD) VALUES
(1,  '2024-05-11', 'Kredi Kartý'),
(3,  '2024-06-03', 'Banka Kartý'),
(5,  '2024-06-28', 'Nakit'),
(7,  '2024-07-14', 'Kredi Kartý'),
(9,  '2024-08-09', 'Banka Kartý'),
(11, '2024-08-25', 'Nakit'),
(13, '2024-09-16', 'Kredi Kartý'),
(15, '2024-10-02', 'Banka Kartý'),
(17, '2024-10-21', 'Nakit'),
(19, '2024-11-05', 'Kredi Kartý'),

(21, '2024-11-18', 'Banka Kartý'),
(22, '2024-12-01', 'Kredi Kartý'),
(23, '2024-12-12', 'Nakit'),
(24, '2025-01-08', 'Kredi Kartý'),
(25, '2025-01-19', 'Banka Kartý'),
(26, '2025-02-03', 'Nakit'),
(27, '2025-02-17', 'Kredi Kartý'),
(28, '2025-03-06', 'Banka Kartý'),
(29, '2025-03-21', 'Nakit'),
(30, '2025-04-04', 'Kredi Kartý'),

(31, '2025-04-18', 'Banka Kartý'),
(32, '2025-05-09', 'Nakit'),
(33, '2025-05-27', 'Kredi Kartý'),
(34, '2025-06-10', 'Banka Kartý'),
(35, '2025-06-24', 'Nakit'),
(36, '2025-07-13', 'Kredi Kartý'),
(37, '2025-08-01', 'Banka Kartý'),
(38, '2025-08-15', 'Nakit'),
(39, '2025-09-02', 'Kredi Kartý'),
(40, '2025-09-20', 'Banka Kartý');


INSERT INTO ORDERDETAILS (ORDERID, PRODUCTID, QUANTITY, UNITPRICE) VALUES
(21, 1, 3, 35.00),
(21, 2, 2, 28.50),

(22, 3, 2, 32.00),
(22, 4, 3, 12.00),

(23, 5, 1, 85.00),
(23, 6, 1, 40.00),

(24, 7, 2, 55.90),
(24, 9, 4, 18.00),

(25, 10, 1, 210.00),
(25, 12, 2, 45.00),

(26, 8, 1, 350.00),
(26, 13, 3, 26.50),

(27, 11, 1, 180.00),
(27, 15, 2, 60.00),

(28, 14, 2, 30.00),
(28, 16, 3, 22.00),

(29, 17, 6, 18.50),
(29, 4, 2, 12.00),

(30, 18, 1, 145.00),
(30, 19, 2, 75.00),

(31, 20, 1, 240.00),
(31, 6, 2, 40.00),

(32, 1, 2, 35.00),
(32, 3, 1, 32.00),

(33, 2, 3, 28.50),
(33, 7, 1, 55.90),

(34, 5, 2, 85.00),
(34, 10, 1, 210.00),

(35, 12, 4, 45.00),
(35, 13, 2, 26.50),

(36, 8, 1, 350.00),
(36, 19, 1, 75.00),

(37, 11, 2, 180.00),
(37, 17, 5, 18.50),

(38, 14, 3, 30.00),
(38, 4, 4, 12.00),

(39, 15, 2, 60.00),
(39, 18, 1, 145.00),

(40, 20, 1, 240.00),
(40, 9, 5, 18.00),

(41, 6, 3, 40.00),
(41, 16, 2, 22.00),

(42, 3, 2, 32.00),
(42, 19, 2, 75.00),

(43, 1, 4, 35.00),
(43, 5, 1, 85.00),

(44, 7, 2, 55.90),
(44, 10, 1, 210.00),

(45, 2, 2, 28.50),
(45, 12, 3, 45.00),

(46, 11, 1, 180.00),
(46, 14, 2, 30.00),

(47, 17, 8, 18.50),
(47, 4, 3, 12.00),

(48, 8, 1, 350.00),
(48, 20, 1, 240.00),

(49, 15, 1, 60.00),
(49, 18, 2, 145.00),

(50, 13, 4, 26.50),
(50, 6, 2, 40.00);


INSERT INTO ORDERS (CUSTOMERID, ORDERDATE, PAYMENTMETHOD) VALUES
(2,  '2025-10-08', 'Nakit'),
(4,  '2025-10-27', 'Kredi Kartý'),
(6,  '2025-11-14', 'Banka Kartý'),
(8,  '2025-12-03', 'Nakit'),
(10, '2025-12-22', 'Kredi Kartý'),
(12, '2026-01-10', 'Banka Kartý'),
(14, '2026-01-29', 'Nakit'),
(16, '2026-02-11', 'Kredi Kartý'),
(18, '2026-03-05', 'Banka Kartý'),
(20, '2026-03-24', 'Nakit');

INSERT INTO ORDERDETAILS (ORDERID, PRODUCTID, QUANTITY, UNITPRICE) VALUES
(51, 1, 2, 35.00),
(51, 10, 1, 210.00),

(52, 5, 1, 85.00),
(52, 11, 2, 180.00),

(53, 3, 3, 32.00),
(53, 14, 2, 30.00),

(54, 2, 4, 28.50),
(54, 16, 1, 22.00),

(55, 8, 1, 350.00),
(55, 19, 2, 75.00),

(56, 6, 2, 40.00),
(56, 17, 7, 18.50),

(57, 4, 5, 12.00),
(57, 13, 3, 26.50),

(58, 7, 2, 55.90),
(58, 18, 1, 145.00),

(59, 12, 2, 45.00),
(59, 15, 2, 60.00),

(60, 20, 1, 240.00),
(60, 9, 3, 18.00);
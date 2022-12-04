DROP DATABASE IF EXISTS Learn;
CREATE DATABASE Learn;

USE Learn;


---------- Check

DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Semester TINYINT CHECK(Semester = 3) NOT NULL,
	NAME TEXT NOT NULL,
	City TEXT NOT NULL,
);


---------- 去重

DROP TABLE IF EXISTS Food;

CREATE TABLE Food (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Name VARCHAR(50) NOT NULL,
	Price DECIMAL CHECK(Price >= 0) NOT NULL,
);

INSERT INTO Food Values
	('Pizza', 450),
	('Pizza', 450),
	('Pizza', 450);

-- Type 1

SELECT MIN(Id), Min(Name), Min(Price) FROM Food GROUP BY Name;

-- Type 2

SELECT DISTINCT Name, Price FROM Food;


---------- 函数

DROP TABLE IF EXISTS TUser;

CREATE TABLE TUser (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Name VARCHAR(50) UNIQUE NOT NULL,
	Age TINYINT CHECK(Age >= 0),
);

CREATE OR ALTER FUNCTION IsAdult(@Name VARCHAR(50))
RETURNS BIT
AS
BEGIN

	IF EXISTS(
		SELECT *
		FROM TUser
		WHERE Name = @Name And Age >= 18
	)
		RETURN 1

	RETURN 0

END

INSERT INTO TUser Values('Some', 18)

DECLARE @ret BIT
EXEC @ret = IsAdult 'Some'
SELECT @ret


---------- 层次化

DROP TABLE IF EXISTS HIndex;

CREATE TABLE HIndex (
	IdPath HIERARCHYID PRIMARY KEY,
	Sth TEXT
)

INSERT INTO HIndex VALUES
	('/1/', 'Something'),
	('/1/1/', 'Somebody')


---------- Trigger

DROP TABLE IF EXISTS Product;

CREATE TABLE Product(
	Id INT PRIMARY KEY IDENTITY,
	Name VARCHAR(50),
	Price MONEY,
	Quantity INT CHECK(Quantity >= 0)
);

INSERT INTO Product VALUES
	('Pizza', 1000, 15),
	('Bun', 100, 12);

CREATE OR ALTER TRIGGER IncreasePrice
On Product FOR UPDATE AS
BEGIN
	UPDATE Product
	SET Price = Price * 1.2
	WHERE Quantity < 10
END;

UPDATE Product
SET Quantity = 8;


---------- 复合主键 nested I/O

DROP TABLE IF EXISTS Composite;

CREATE TABLE Composite(
	Id INT NOT NULL,
	Comp INT NOT NULL,
	CONSTRAINT PK_Composite_Id_Comp PRIMARY KEY (Id, Comp)
);


---------- 脏读

Select Count(*)
FROM Bank WITH (NOLOCK)


---------- While

CREATE OR ALTER PROCEDURE CountCoins(@Price INT)
AS
BEGIN

DECLARE @C20 INT, @C10 INT, @C5 INT;

SET @C20 = 0;
SET @C10 = 0;
SET @C5 = 0;

	WHILE @Price >= 20
		SET @Price = @Price - 20
		SET @C20 = @C20 + 1

	WHILE @Price >= 10
		SET @Price = @Price - 10
		SET @C10 = @C10 + 1

	WHILE @Price >= 5
		SET @Price = @Price - 5
		SET @C5 = @C5 + 1

	PRINT 'It can be paid with '
		+ TRIM(CAST(@C20 as VARCHAR(50)))
		+ ' 20Coin, '
		+ TRIM(CAST(@C10 as VARCHAR(50)))
		+ ' 10Coin, '
		+ TRIM(CAST(@C10 as VARCHAR(50)))
		+ ' 5Coin.'

END


---------- CLUSTERED

DROP TABLE IF EXISTS TTest;

CREATE TABLE TTest(
	Col1 INT NOT NULL,
	Col2 INT NOT NULL,
	Col3 VARCHAR(50)
);

CREATE CLUSTERED INDEX IX_TTest_Col1 ON TTest (Col1, Col2);


---------- XML

DROP TABLE IF EXISTS TXML;

CREATE TABLE TXML(
	Col1 INT PRIMARY KEY IDENTITY,
	Col2 VARCHAR(10),
	Col3 VARCHAR(50)
);

INSERT INTO TXML VALUES
	('Some', 'Thing'),
	('Body', 'Any');

SELECT * FROM TXML FOR XML AUTO;


---------- TRAN

DROP TABLE IF EXISTS Fill;

CREATE TABLE Fill(
	Id INT PRIMARY KEY IDENTITY,
	Increse INT
);

BEGIN TRAN
DECLARE @index INT
SET @index = 0

WHILE @index < 900
BEGIN
	INSERT INTO Fill VALUES (@index)
	SET @index = @index + 1
END

COMMIT TRAN


---------- 用户账户

CREATE LOGIN [DGYY] WITH PASSWORD=N'123', DEFAULT_DATABASE=[master]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DGYY]
ALTER ROLE [db_datareader] ADD MEMBER [DGYY]


---------- UNION

SELECT NULL FROM SomeTable
UNION
SELECT NULL FROM OtherTable;


---------- CASE WHEN

DROP TABLE IF EXISTS Car;

CREATE TABLE Car(
	Id INT PRIMARY KEY IDENTITY,
	Type VARCHAR(50),
	Color VARCHAR(50)
);

INSERT INTO Car VALUES
	('Audi', 'Black'),
	('BMW', 'Red'),
	('Suzuki', 'Grey'),
	('Aston', 'White');

SELECT TOP(1)
	CASE
		WHEN Car.Color = 'White' Then 'White'
		WHEN Car.Color = 'Black' THEN 'True' ELSE 'False'
	END
FROM Car


---------- OFFSET

DROP TABLE IF EXISTS Offset;

CREATE TABLE Offset(
	Id INT PRIMARY KEY IDENTITY,
	Sth INT
);

DECLARE @index INT
SET @index = 0

WHILE @index < 5
BEGIN
	INSERT INTO Offset VALUES(RAND() * 10)
	SET @index = @index + 1
END

SELECT *
FROM Offset
ORDER BY Id
OFFSET 2 ROWS
FETCH NEXT 3 ROWS ONLY;


---------- BETWEEN

ALTER TABLE TableName
ADD CONSTRAINT CK_Between CHECK (LEN(ColomnName) BETWEEN 1 AND 10)


---------- THROW

CREATE TRIGGER ErrorTrigger
ON TTest INSTEAD OF INSERT AS
BEGIN

	IF 1 = 1
	THROW 60000, 'Error Message!', 1 ;

END


---------- 表变量

DECLARE @TTest TABLE(
	Col1 INT NOT NULL,
	Col2 INT NOT NULL,
	Col3 VARCHAR(50)
);

INSERT INTO @TTest VALUES
	(1, 2, 'Some'),
	(3, 4, 'Thing');

SELECT * FROM @TTest;

DROP TABLE @TTest;


---------- 临时表

CREATE TABLE #TTest(
	Col1 INT NOT NULL,
	Col2 INT NOT NULL,
	Col3 VARCHAR(50)
);

INSERT INTO #TTest VALUES
	(5, 6, 'Body'),
	(7, 8, 'Any');

SELECT * FROM #TTest;

DROP TABLE #TTest;
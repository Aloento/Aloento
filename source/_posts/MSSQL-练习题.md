---
title: MSSQL 练习题
date: 2022-11-30 13:12:10
toc: true
categories:
  - [Database, MSSQL]
tags: [数据库, 习题, SQLServer]
---

最近因为学校的原因，不得不学习 MS SQL 相关内容  
遂记录一些练习题

<!-- more -->

首先我们

```sql
DROP DATABASE IF EXISTS Learn;
CREATE DATABASE Learn;

USE Learn;
```

### Check

创建一个 Student 表，有 ID, Name, Semester, City 字段。
写一个 SQL，只允许插入第三学期的学生。
这意味着用户不能插入第一、第二或第四学期的学生。

> Create one Student table where is ID, Name, Semester, City colums.
> Find the solution that we can insert just the 3rd semester students.
> This mean that the user connot inser Student who are in 1, 2, or 4th semester.

```sql
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Semester TINYINT CHECK(Semester = 3) NOT NULL,
	NAME TEXT NOT NULL,
	City TEXT NOT NULL,
);
```

### 去重

创建一个方法，对同一 record 进行过滤，并只返回一次。
例如，如果我们有 3 个价格为 450 的比萨饼，如果我们 Select，
那么结果将是只有 1 个比萨，而不是 3 个比萨。

> Create one method, what filtering the same record and give back just once.
> For example, if we have 3 pizza with 450 price, if we take a Select,
> then results will be just 1 pizza, not 3 pizza.

```sql
DROP TABLE IF EXISTS Food;

CREATE TABLE Food (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Name VARCHAR(50) NOT NULL,,
	Price DECIMAL CHECK(Price >= 0) NOT NULL,,
);

INSERT INTO Food Values
	('Pizza', 450),
	('Pizza', 450),
	('Pizza', 450);

-- Type 1

SELECT MIN(Id), Min(Name), Min(Price) FROM Food GROUP BY Name;

-- Type 2

SELECT DISTINCT Name, Price FROM Food;
```

### 函数

创建一个阻止 18 岁以下用户的 function。

> Create one function what block the user who are younger as 18 years old.

```sql
DROP TABLE IF EXISTS TUser;

CREATE TABLE TUser (
	ID INT PRIMARY KEY IDENTITY(1, 1),
	Name VARCHAR(50) UNIQUE NOT NULL,
	Age TINYINT CHECK(Age >= 0),
);
```

```sql
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
```

```sql
INSERT INTO TUser Values('Some', 18)

DECLARE @ret BIT
EXEC @ret = IsAdult 'Some'
SELECT @ret
```

### 层次化索引

> Create one hierarchy index.

```sql
DROP TABLE IF EXISTS HIndex;

CREATE TABLE HIndex (
	IdPath HIERARCHYID PRIMARY KEY,
	Sth TEXT
)

INSERT INTO HIndex VALUES
	('/1/', 'Something'),
	('/1/1/', 'Somebody')
```

### Trigger

创建一个触发器，如果产品数量在 10 个以下，则更新价格（+20%）。

> Create one trigger what is update the price(+20%)
> if the products quantity is under 10 pirces.

```sql
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
```

```sql
CREATE OR ALTER TRIGGER IncreasePrice
On Product FOR UPDATE AS
BEGIN
	UPDATE Product
	SET Price = Price * 1.2
	WHERE Quantity < 10
END;
```

```sql
UPDATE Product
SET Quantity = 8;
```

### 复合主键

不是很能理解他到底在说什么，但是答案是复合主键相关

> How can we kill the nested loops operator?
> How can we kill the double I/O problems?

```sql
DROP TABLE IF EXISTS Composite;

CREATE TABLE Composite(
	Id INT NOT NULL,
	Comp INT NOT NULL,
	CONSTRAINT PK_Composite_Id_Comp PRIMARY KEY (Id, Comp)
);
```

### 脏读

> Create one select what is dirty read.

```sql
DROP TABLE IF EXISTS Bank;

CREATE TABLE Bank(
  Id INT PRIMARY KEY IDENTITY(1, 1),
  AccountNum VARCHAR(50),
  Name VARCHAR(50),
  Balance MONEY
)

INSERT INTO Bank VALUES
	('SomeAccountNum', 'SomeName', '80');
```

```sql
BEGIN TRAN;
	UPDATE Bank
	SET Balance = Balance - 45
	WHERE AccountNum = 'SomeAccountNum';
	WAITFOR DELAY '00:00:10';
ROLLBACK TRAN;

SELECT * FROM Bank
WHERE AccountNum = 'SomeAccountNum';
```

```sql
-- Dirty Read
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
BEGIN TRAN;
	SELECT * FROM Bank
	WHERE AccountNum = 'SomeAccountNum';
COMMIT TRAN;
```

或者

```sql
Select Count(*)
FROM Bank WITH (NOLOCK)
```

### While

两个产品。咖啡是 245，披萨是 475。(硬币：20，10，5）如果我们想买这些产品，请计算需要多少硬币。

> You have 2 products. The coffee is 245, the pizza is 475. (Coins: 20, 10, 5)
> Please count how many coins need it if we would like to buy this products.

```sql
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
```

### 聚集索引

> Create two cluster index on your table, on the same table but different columns.

```sql
DROP TABLE IF EXISTS TTest;

CREATE TABLE TTest(
	Col1 INT NOT NULL,
	Col2 INT NOT NULL,
	Col3 VARCHAR(50)
);

CREATE CLUSTERED INDEX IX_TTest_Col1 ON TTest (Col1, Col2);
```

### XML

导出表到 XML。

> Create XML code from your table.

```sql
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
```

### 事务

用事务填充表。

> Create one table with 900 records.

```sql
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
```

### 用户账户

创建新用户并授予其权限。

> Create a new account, which log in via system administrator with data reader persmission.

```sql
CREATE LOGIN [DGYY] WITH PASSWORD=N'123', DEFAULT_DATABASE=[master]
ALTER SERVER ROLE [sysadmin] ADD MEMBER [DGYY]
ALTER ROLE [db_datareader] ADD MEMBER [DGYY]
```

### UNION

合并多个 SELECT 语句的结果集

> How can we use the data of set?

```sql
SELECT NULL FROM SomeTable
UNION
SELECT NULL FROM OtherTable;
```

### CASE WHEN

用 CASE 写一个判断

> Create one new table for cars(Id, type, color). After this,
> select one car from the table and compare this car color on
> the next logical statement the car is Black (True, False) Or White.

```sql
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
```

### OFFSET

> How can we use the data offset?

```sql
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
```

### BETWEEN

```sql
ALTER TABLE TableName
ADD CONSTRAINT CK_Between CHECK (LEN(ColomnName) BETWEEN 1 AND 10)
```

### THROW

> Create one trigger what give for us an error message
> if we cannot insert data in the table.

```sql
CREATE TRIGGER ErrorTrigger
-- 类似 BEFORE
ON TTest INSTEAD OF INSERT AS
BEGIN

	IF 1 = 1
	THROW 60000, 'Error Message!', 1 ;

END
```

### 表变量

```sql
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
```

### 临时表

```sql
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
```

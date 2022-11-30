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

### 检查

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
> For example, if we have 3 pizza with 450 price, if we take a Select, then results
> will be just 1 pizza, not 3 pizza.

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

### 触发器

创建一个触发器，如果产品数量在 10 个以下，则更新价格（+20%）。

> Create one trigger what is update the price(+20%)
> if the products quantity is under 10 pirces.

```sql

```

###

> How can we use the data of set?

```sql

```

### 游标循环

> How can we kill the nested loops operator?

```sql
BEGIN
	DECLARE @a INT, @error INT
    DECLARE @temp VARCHAR (50)
	SET @a = 1
	SET @error = 0

	DECLARE order_cursor CURSOR
    FOR (SELECT [Id] FROM Student)

	OPEN order_cursor
	FETCH NEXT FROM order_cursor INTO @temp

	WHILE @@FETCH_STATUS = 0
		BEGIN
			UPDATE Student
			SET Age = 15 + @a, Some = @a
			WHERE Id = @temp

			SET @a = @a + 1
			SET @error = @error + @@ERROR

			FETCH NEXT FROM order_cursor INTO @temp
		END

		CLOSE order_cursor
		DEALLOCATE order_cursor
END
GO
```

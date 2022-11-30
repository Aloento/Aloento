---
title: MSSQL 练习题
date: 2022-11-30 13:12:10
toc: true
categories:
  - [Database, MSSQL]
tags: [数据库, 习题]
---

最近因为学校的原因，不得不学习 MS SQL 相关内容  
遂记录一些练习题

<!-- more -->

### 第一部分

#### 1.1

创建一个 Student 表，有 ID, Name, Semester, City 字段。
写一个 SQL，只允许插入第三学期的学生。
这意味着用户不能插入第一、第二或第四学期的学生。

> Create one Student table where is ID, Name, Semester, City colums.
> Find the solution that we can insert just the 3rd semester students.
> This mean that the user connot inser Student who are in 1, 2, or 4th semester.

```sql

```

#### 1.2

创建一个方法，对同一 record 进行过滤，并只返回一次。
例如，如果我们有 3 个价格为 450 的比萨饼，如果我们 Select，
那么结果将是只有 1 个比萨，而不是 3 个比萨。

> Create one method, what filtering the same record and give back just once.
> For example, if we have 3 pizza with 450 price, if we take a Select, then results
> will be just 1 pizza, not 3 pizza.

```sql

```

#### 1.3

创建一个阻止 18 岁以下用户的 function。

> Create one function what block the user who are younger as 18 years old.

```sql

```

#### 1.4

创建一个 层次化索引。

> Create one hierarchy index.

```sql

```

#### 1.5

创建一个储存过程或函数，表明我们是否可以在考试中应用（未满限）？

> Create one procedure or function what is show that we can apply on the exam (not full the limit) or not?

```sql

```

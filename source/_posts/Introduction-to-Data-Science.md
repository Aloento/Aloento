---
title: Introduction to Data Science
date: 2024-02-26 10:30:00
toc: true
categories:
  - [DataScience]
  - [Program, Python]
tags: [数据科学, 笔记]
---

~~这年头真的是什么臭鱼烂虾都敢出来教课了~~  
~~你们这帮人除了会照着代码念以外还会干什么~~

本文是这门课的 Lecture 部分，各个 Practice 会独立成文

<!-- more -->

# Introduction

首先我们要了解什么是数据科学  
它的目标是：从数据中提取有用的信息

_我们将 机器学习的算法应用于各种数据，以训练 AI 来完成通常需要人类进行的任务_  
_这些 AI 会产生一些见解，以供用户将其转化为业务价值_

---

![Relations](Relations.jpg)

DS 与 ML 密切相关

- DS 研究如何从原始数据中提取信息
- ML 是 DS 的一种技术，使机器能够自动从过去的数据中学习
- AI 使用指导思想，即让机器模仿人类的思维方式
- DL 是 ML 的子集，它使用多层神经网络计算

---

让我们来看看 DS 的生命周期

1. 商业需求
2. 数据采集
3. 数据处理
4. 数据分析
5. 建模，使用 ML
6. 部署和优化模型

---

我们称数据表的 Columns 为 Features，Rows 为 Samples / Examples / Instances

数据的类型：

- Categorical  
  无序集合，如 City.{Viena, Paris}
- Numerical  
  有序集合，如 Age.{0, 1, 2, 3, ...}

我们偏向于把 Categorical 转化为 Numerical

例如

| Age | City  |
| --- | ----- |
| 20  | Viena |
| 30  | Paris |

转化为

| Age | City_Viena | City_Paris |
| --- | ---------- | ---------- |
| 20  | 1          | 0          |
| 30  | 0          | 1          |

这样我们就可以将 instance 表达为空间中的一个点，如 (20, 1, 0)

---

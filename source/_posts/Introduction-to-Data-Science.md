---
title: Introduction to Data Science
date: 2024-02-26 10:30:00
toc: true
categories:
  - [Data Science]
tags: [数据科学, 笔记]
---

~~这年头真的是什么臭鱼烂虾都敢出来教课了~~  
~~你们这帮人除了会照着代码念以外还会干什么~~

本文是这门课的 Lecture 部分，各个 Practice 会独立成文

<!-- more -->

# Introduction

## 什么是 DS

它的目标是：从数据中提取有用的信息

_我们将 机器学习的算法应用于各种数据，以训练 AI 来完成通常需要人类进行的任务_  
_这些 AI 会产生一些见解，以供用户将其转化为业务价值_

## 关系

![Relations](1Relations.jpg)

DS 与 ML 密切相关

- DS 研究如何从原始数据中提取信息
- ML 是 DS 的一种技术，使机器能够自动从过去的数据中学习
- AI 使用指导思想，即让机器模仿人类的思维方式
- DL 是 ML 的子集，它使用多层神经网络计算

## 生命周期

让我们来看看 DS 的生命周期

1. 商业需求
2. 数据采集
3. 数据处理
4. 数据分析
5. 建模，使用 ML
6. 部署和优化模型

## 数据

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

随后我们可以：

- 把所有数据映射到空间中，称之为 Feature Space
- 使用 Euclidean Distance 来计算两个点之间的距离
- 用来查找相似内容...

## 质量

ML 算法需要干净的数据

原始数据有可能：

- Noise  
  Modicitation of original values
- Outliers (异常 / 离群)  
  与大部分数据有截然不同的特征
- Missing Values
- Duplicates  
  如同一个人使用不同 ID

![Noise](1Noise.jpg)
![Outliers](1Outliers.jpg)

数据缺失可能是由于 未收集（拒绝回答），或不适用（未成年人的收入）导致的  
可以使用以下方法处理：

- 删除
- 估计 Estimation
- 忽略

对于数据量，一般是越多越好，有一个流行的说法是 十倍于特征数量，但是要保证质量

# 有效分析与可视化

## 一般流程

1. 提出问题

   - 目标是什么
   - 如何处理数据
   - 想预测或者估计什么

2. 数据收集

   - 如何抽样
   - 哪些数据是相关的
   - 隐私问题

3. 探索数据

   - 绘图
   - 检查异常
   - 寻找规律

4. 建模

   - 构建
   - 拟合
   - 验证

5. 展示可视化结果

   - 学到了什么
   - 结果的意义
   - 见解

## Anscombe's Quartet

![Anscombe's Quartet](2Anscombe.png)

用来说明在分析数据前先绘制图表的重要性，以及离群值对统计的影响之大

- 左上：线性
- 右上：二次
- 左下：线性，但有离群值，降低了相关性
- 右下：非线，但有离群值，使相关性升高

## 可视化的目的

- 沟通与解释

  1. 展示数据和想法
  2. 解释
  3. 提供支撑
  4. 说服

- 分析与探索

  1. 浏览数据
  2. 评估
  3. 决定如何处理
  4. 决定下一步

## EDA 工作流

Exploratory Data Analysis

1. 从数据构建 DataFrame，所有数据都在其中
2. 清理数据
   - 每一列都描述一个属性
   - 列偏好于数值
   - 列无法进一步拆分（原子性）
3. 探索 Global 属性
   - Histogram 直方图
   - Scatter Plot 散点图
   - Aggregation 聚合
4. 探索 Group 属性
   - Groupby 分组
   - Pivot Table 透视表
   - Box Plot 箱线图
   - Small Multiples 小多图
   - 来比较数据的子集

## 可视化原则

- 图形完整性

  - 避免 Scale Distortion
  - Be Proportional 对比性
  - 包括所有的不确定情况
  - 包含所有的数据

- 简单

  - 避免 3D

- 选择合适的图表

  - 有效感知，用数据表明观点，比如 A 比 B 大 10%

- 合理的颜色

  - 考虑到色盲

# 相似与测距

## 基本概念

距离描述两个数据对象之间的差异性，当两个对象相同时，距离为 0

相似性：1 - 距离

Metric 度量 d 或 距离函数 有以下四个性质：

- 非负性
- 同一性（Identity） $d(x, y) = 0 \Leftrightarrow x = y$
- 对称性（Symmetry）：$d(x, y) = d(y, x)$
- 三角不等式（Triangle Inequality）：$d(x, y) + d(y, z) \geq d(x, z)$  
  通过第三个对象间接计算的距离不会小于直接计算的距离

度量空间 Metric Space 是一个集合，其中定义了一个度量函数

三维欧几里得空间是一个常见的度量空间，其中的距离可以用欧几里得距离度量来计算

## $L_p$ 范数

是一种距离度量，用于衡量向量的大小

$$ Lp (x, y) = \left ( \sum\_{i=1}^{n} |x_i - y_i|^p \right)^{\frac{1}{p}} $$

p = 1 时，称为曼哈顿距离  
p = 2 时，称为欧几里得距离  
p = $\infty$ 时，称为切比雪夫距离

欧几里得距离：$L_2 (x, y) = \sqrt{\sum_{i=1}^{n} (x_i - y_i)^2}$

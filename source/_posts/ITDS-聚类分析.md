---
title: ITDS-聚类分析
toc: true
categories:
  - [Data Science]
tags: [数据科学, 笔记]
date: 2025-03-12 14:55:06
---

Distance, Clustering

<!-- more -->

# 距离与相似度基础

设 $d$ 是距离函数，$s$ 是相似度函数，那么 $s = 1 - d$。

距离 $d$ 的值是度量（Metric），度量满足以下条件：

1. 非负性：Non-negativity $d(x, y) \geq 0$
2. 同一性：Coincidence $d(x, y) = 0 \iff x = y$
3. 对称性：Symmetry $d(x, y) = d(y, x)$
4. 三角不等式：Triangle Inequality $d(x, y) + d(y, z) \geq d(x, z)$

## 三角不等式

假设我们有多个聚类中心，目标是找到某个数据点到最近的中心点。一般情况下，我们需要计算所有的距离，但利用三角不等式可以减少计算：

我们想检查 $c_2$ 是否比 $c_1$ 更接近 x，即

$$
d(x, c_2) < d(x, c_1)
$$

根据三角不等式

$$
d(x, c_2) \geq d(c_1, c_2) - d(x, c_1)
$$

我们可以知道 $d(x, c_2)$ 最小就是 $d(c_1, c_2) - d(x, c_1)$。现在我们要求这个最小值都比 $d(x, c_1)$ 大，这样我们就可以跳过计算：

$$
d(c_1, c_2) - d(x, c_1) \geq d(x, c_1)
$$

则

$$
d(c_1, c_2) \geq 2d(x, c_1)
$$

所以如果 $c_2$ 满足上述条件，则可以跳过计算 $d(x, c_2)$，它不可能比 $c_1$ 更近。

## 常见的距离度量

1. 欧几里得距离（Euclidean Distance）

$$
d(x, y) = \sqrt{\sum_{i=1}^{n} (x_i - y_i)^2}
$$

这是最常见的距离计算方法，适用于数值型数据

2. 曼哈顿距离（Manhattan Distance）

$$
d(x, y) = \sum_{i=1}^{n} |x_i - y_i|
$$

也称为 L1 距离，适用于网格状数据，如城市街道距离

3. 切比雪夫距离（Chebyshev Distance）

$$
d(x, y) = \max |x_i - y_i|
$$

适用于棋盘距离，如国际象棋中的马步

4. 闵可夫斯基距离（Minkowski Distance）

$$
d(x, y) = \left( \sum_{i=1}^{n} |x_i - y_i|^p \right)^{1/p}
$$

当 $p = 1$ 时，是曼哈顿距离；当 $p = 2$ 时，是欧几里得距离，$p \to \infty$ 时，是切比雪夫距离

# 聚类分析

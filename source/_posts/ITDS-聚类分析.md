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

Curse of Dimensionality （维度诅咒），随着维度的增加，数据点之间的距离变得越来越远，这会导致距离度量失效。因此在高维数据中，需要谨慎选择距离度量。

## 汉明距离

Hamming 距离用于计算两个二进制字符串之间的差异：

```txt
x = 1011101
y = 1001001
-----------
差异位数 = 2 = Hamming Distance
```

### 在字符串中的应用

Hamming 距离适用于 **等长** 的二进制数据或字符串，例如：

```txt
x = "karolin"
y = "kathrin"
-----------
差异位数 = 3 = Hamming Distance
```

### 在集合中的应用

假设有两个集合

1. 有 1000 个项目，其中 995 个相同
2. 有 5 个项目，均不相同

这两个集合的汉明距离都是 10，这表明汉明距离不适用于衡量集合的相似性。

> 10 的原因是因为不同的物品在两个集合中需要独立表示

## Jaccard 相似度

Jaccard Similarity 用于计算两个集合之间的相似性：

$$
s(x, y) = \frac{|x \cap y|}{|x \cup y|}
$$

其中：

- $|x \cap y|$ 是两个集合的交集（共同元素）
- $|x \cup y|$ 是两个集合的并集（所有元素）

1. 995 个相同的集合：$s = \frac{995}{1000} = 0.995$
2. 5 个不同的集合：$s = \frac{0}{5} = 0$

## 编辑距离

将一个字符串转换为另一个字符串所需的最小操作数：

1. 插入（Insertion）
2. 删除（Deletion）
3. 替换（Substitution）

Levenshtein 距离

```txt
x = "kitten"
y = "sitting"
```

1. kitten -> sitten (substitute k for s)
2. sitten -> sittin (substitute e for i)
3. sittin -> sitting (insert g at the end)

编辑距离是 3。

# 聚类分析

Clustring Analysis 是用于发现数据集中自然分组的技术，目的是识别数据中的模式或结构，将相似的数据归为一类。使同一组内对象相似度高，不同组间对象相似度低。

聚类并不只是通过可视化数据来观察，实际上大多数有价值的数据都是高维的，无法通过肉眼观察来发现模式，所以我们需要依靠自动化算法来寻找自然分组。

## 聚类的类型

- Hard：每个数据点只能属于一个类别
  - Partitional：将数据集分为 k 个不相交的子集
  - Hierarchical：将数据集分层次地组织为树形结构，为凝聚式（Agglomerative）和分裂式（Divisive）两种
- Fuzzy：每个数据点可以属于多个类别

## 聚类的质量

一个理想的聚类，应该使簇内数据点的距离尽可能小，簇间数据点的距离尽可能大。为了量化聚类质量，我们可以使用以下指标：

- S：计算同一簇内数据点的平均距离
- D：计算不同簇间数据点的平均距离
- D/S：越大越好

例如：

$$
A_1, B_1, C_2, D_1, E_2, F_1, G_2, H_1
$$

S = [(AB + AD + AF + AH + BD + BF + BH + DF + DH + FH) + (CE + CG + EG)] / 13 = 44 / 13 = 3.38

D = [AC + AE + AG + BC + BE + BG + DC + DE + DG + FC + FE + FG + HC + HE + HG] / 15 = 40 / 15 = 2.67

D/S = 2.67 / 3.38 = 0.79

- 聚类通常不存在绝对正确的结果
- 不同的算法可能会产生不同的结果
- 数据分布呈球形时，K-Means 效果最好
- 数据分布不规则时，DBSCAN 效果最好
- D/S 在很多情况下效果不佳，它无法区分不同聚类结构的差异

## K-Means

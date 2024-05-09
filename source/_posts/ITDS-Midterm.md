---
title: ITDS Midterm
toc: true
categories:
  - [Data Science]
tags: [考试, 数据科学]
date: 2024-05-09 22:01:16
---

学不动了

<!-- more -->

# DS & ML

What are the main differences between DS and ML, and how do their goals and functionalities differ even though they are closely linked?

DS 和 ML 之间的主要区别是什么？尽管两者密切相关，但它们的目标和功能有何不同？

DS 是涵盖数据处理、分析、可视化的广泛领域，目的是从数据中提取信息。
ML 是 DS 的子领域，专注算法和模型，使计算机能基于数据学习并作出预测。
DS 注重数据处理流程，而 ML 专注于算法模型。

# Lifecycle

Enumerate the steps involved in the DS lifecycle. Highlight the key tasks and considerations at each stage?

列举 DS 周期中涉及的步骤。在每个阶段突出关键任务和考虑因素是什么？

1. 需求：明确目标
2. 数据采集：公共，私有，第三方
3. 数据处理：清洗，整理
4. 数据分析：统计，可视化
5. 建模：使用 ML
6. 部署：持续监控，优化

# Hamming

Consider two objects represented by binary strings:
A = 110010, B = 101011.
Define and calculate the Hamming distance between A and B.
Can we use the Hamming distance if A and B have different lengths and why?

考虑由二进制字符串表示的两个对象：A = 110010，B = 101011。定义并计算 A 和 B 之间的汉明距离。如果 A 和 B 长度不同，我们可以使用汉明距离吗？为什么？

汉明指两个等长字符串对应位置上不同字符的数量。

```js
A = 110010;
B = 101011;
```

观察得到有三个位不同，所以汉明距离为 3。
如果 A 和 B 长度不同，汉明距离无法计算，无法确保每个位置都有对应的字符进行比较。

# Metric

Under which conditions is a distance measure a metric?
Demonstrate that the Hamming distance is a metric.
Provide explanations and calculations to support each part of the proof.

在什么条件下，一个距离测量是一个度量？证明汉明距离是一个度量。提供解释和计算来支持证明的每个部分。

1. Non-Negative：$d(x, y) \geq 0$
2. Symmetry：$d(x, y) = d(y, x)$
3. Identity：$d(x, y) = 0 \Leftrightarrow x = y$
4. Triangle Inequality：$d(x, y) + d(y, z) \geq d(x, z)$

---

1. 汉明距离是非负的，最小为 0
2. 基于位置的比较导致顺序无关
3. 如果距离为 0 ，则两个字符串相同
4. 设有 A B C 等长字符串。若 A 和 C 在 x 位置上相同，则 $d(A, C)_x = 0$。
   若 A 和 B and/or B 和 C 在 x 位置上不同，最多会使 $d(A, C)$ 增加 1。
   但 $d(A, B) + d(B, C)$ 至少为 1，因此满足三角不等式。

# K-Means

What are the hyper-parameters of K-means clustering and how do we set them?

K-means 聚类的超参数有哪些，我们应该如何设置它们？

1. Cluster Number $k$：聚类数量，使用 Elbow Method 或 Silhouette Score
2. Initial Centroids：初始质心，使用随机选择或 KMeans++
3. Maximum Iterations：最大迭代次数，一般为 300
4. Convergence Tolerance：收敛容差，当质心变化小于阈值时停止迭代，一般为 $10^{-4}$

# Agglomerative

In hierarchical agglomerative clustering, how would you determine the optimal number of clusters without relying on pre-defined stopping criteria?

在层次聚类中，如何在不依赖预定义停止条件的情况下确定最优的聚类数量？

一般使用 Dendrogram 来帮助确定最优聚类数量。

1. 生成树状图
2. 寻找最大的 Merge Distance 增量
3. 在这个点 Cut 树状图
4. 切割点以上的分支数量即为最优数

# DBSCAN

If you set a large value for $\epsilon$ in DBSCAN, what would be the potential consequences on the clustering results?

如果在 DBSCAN 中设置一个较大的 $\epsilon$ 值，这对聚类结果可能有什么影响？

$\epsilon$ 表示 Eps-neighborhood，即邻域半径

1. 导致本应分开的不同簇被合并
2. 噪声点可能被错误地分配到簇中
3. 边界结构 Blurred
4. Overfitting

# Regression

Discuss the difference between simple linear regression and multiple linear regression.

讨论简单线性回归和多元线性回归之间的区别。

简单线性只涉及一个 feature，多元线性涉及多个 feature。
都是使误差平方和最小化，但多元线性可以更全面地分析多个因素对结果变量的综合影响

# Gradient

Describe the process by which gradient descent is employed to refine the parameters of a linear regression model.

描述梯度下降如何被用来优化线性回归模型参数的过程。

1. 线性回归模型参数随机初始化
2. 通常使用 MSE 计算 Loss
3. 为 Loss 的每个参数计算 partial derivative
4. 将参数减去 学习率 \* gradient
5. 重复 2-4 直到收敛

# Regularization

How does regularization help overcome the challenges associated with using polynomial regression models?
Particularly in mitigating overfitting and controlling model complexity?

正则化如何帮助克服使用多项式回归模型所面临的挑战？特别是在减少过拟合和控制模型复杂度方面？

1. Overfitting：向 Loss 增加额外的 Penalty，
   通常是 L1 或 L2，使得模型不能 fit 小波动
2. Complexity：惩罚大的 coefficient，削弱其影响，
   降低复杂度，提高 generalization ability

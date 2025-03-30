---
title: ITDS Midterm
toc: true
categories:
  - [Data Science]
tags: [考试, 数据科学]
date: 2025-05-30 22:01:16
---

学不动了

<!-- more -->

# 2024-04-04

## DS & ML

What are the main differences between DS and ML, and how do their goals and functionalities differ even though they are closely linked?

<details>

DS 和 ML 之间的主要区别是什么？尽管两者密切相关，但它们的目标和功能有何不同？

DS 目标是发掘数据的模式以辅助决策。ML 专注于开发预测模型。
DS 涵盖从数据收集到可视化的多个活动。ML 专注于构建和训练模型。

</details>

## Lifecycle

Enumerate the steps involved in the DS lifecycle. Highlight the key tasks and considerations at each stage?

<details>

列举 DS 周期中涉及的步骤。在每个阶段突出关键任务和考虑因素是什么？

1. Requirements：确定问题，明确目标
2. Acquisition：从各种来源收集相关数据
3. Processing：预处理，执行特征工程
4. Exploration：理解数据结构，寻找模式和关系，可视化
5. Model：使用 ML，评估性能
6. Deployment：部署，持续更新

</details>

## Hamming

Consider two objects represented by binary strings:
A = 110010, B = 101011.
Define and calculate the Hamming distance between A and B.
Can we use the Hamming distance if A and B have different lengths and why?

<details>

考虑由二进制字符串表示的两个对象：A = 110010，B = 101011。定义并计算 A 和 B 之间的汉明距离。如果 A 和 B 长度不同，我们可以使用汉明距离吗？为什么？

两个等长字符串对应位置上不同字符的数量，$d_H(A, B) = \sum_{i=1}^n (A_i \neq B_i)$

```js
A = 110010;
B = 101011;
```

汉明距离为 3。如果 A 和 B 长度不同，汉明距离无法计算，因为没有可以对应的位置。

</details>

## Metric

Under which conditions is a distance measure a metric?
Demonstrate that the Hamming distance is a metric.
Provide explanations and calculations to support each part of the proof.

<details>

在什么条件下，一个距离测量是一个度量？证明汉明距离是一个度量。提供解释和计算来支持证明的每个部分。

1. Non-Negative：任意两点距离非负。汉明距离只是计不同的位数，所以非负
2. Symmetry：B 到 A 与 A 到 B 的距离相同。汉明距离的比较顺序不会影响计数。
3. Identity：仅当两个点相同的时候，距离为 0。两个字符串相同则没有不同的位数。
4. Triangle Inequality：$d(x, y) + d(y, z) \geq d(x, z)$。  
   比如 A = 110010，B = 101011，C = 100111  
   $d(A, B) + d(B, C) = 3 + 2 = 5 \geq d(A, C) = 3$  

因此，汉明距离满足所有度量性质。

</details>

## K-Means

What are the hyper-parameters of K-means clustering and how do we set them?

<details>

K-means 聚类的超参数有哪些，我们应该如何设置它们？

1. Cluster Number $k$：聚类数量，使用 Elbow Method 或者 相关领域知识
2. Initial Centroids：初始质心，使用 K-Means++
3. Maximum Iterations：最大迭代次数，选择足够大的值以确保收敛
4. Convergence Tolerance：收敛容差，选择足够小的值以确保精度

</details>

## Agglomerative

In hierarchical agglomerative clustering, how would you determine the optimal number of clusters without relying on pre-defined stopping criteria?

<details>

在层次聚类中，如何在不依赖预定义停止条件的情况下确定最优的聚类数量？

一般使用 Dendrogram 来帮助确定最优聚类数量。并确定最有意义的分割点。然后使用 internal/external 验证，如 Silhouette Score 或 真实标签 来验证聚类的质量。

</details>

## DBSCAN

If you set a large value for $\epsilon$ in DBSCAN, what would be the potential consequences on the clustering results?

<details>

如果在 DBSCAN 中设置一个较大的 $\epsilon$ 值，这对聚类结果可能有什么影响？

生成更少但更大的簇，可能会合并原本独立的簇，并增加对噪声的敏感性。

</details>

## Regression

Discuss the difference between simple linear regression and multiple linear regression.

<details>

讨论简单线性回归和多元线性回归之间的区别。

SLR 是一条直线：$y = \beta_0 + \beta_1 x + \epsilon$，只有一个自变量和一个因变量。

MLR 是一个线性组合：$y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + ... + \beta_n x_n + \epsilon$，有多个自变量和一个因变量。

</details>

## Gradient

Describe the process by which gradient descent is employed to refine the parameters of a linear regression model.

<details>

描述梯度下降如何被用来优化线性回归模型参数的过程。

迭代地更新模型的参数，沿着 Loss 函数下降最快的方向调整。
它能够有效的优化模型，最小化预测误差并提高模型对数据的拟合程度。

</details>

## Regularization

How does regularization help overcome the challenges associated with using polynomial regression models?
Particularly in mitigating overfitting and controlling model complexity?

<details>

正则化如何帮助克服使用多项式回归模型所面临的挑战？特别是在减少过拟合和控制模型复杂度方面？

1. L1 希望系数 sparsity，将部分系数缩小至 0，减少模型复杂度
2. L2 希望系数较小但不为零，降低无关特征（如噪声）对模型的影响

- 在 Loss 中添加惩罚项，缩小系数的大小，控制模型复杂度，防止模型过拟合，避免噪声影响，提高泛化能力

</details>

# 2024-04-19

# 2024-05-07

# 2024-05-16

# 2024-10-15

# 2024-11-05

# 2024-12-10

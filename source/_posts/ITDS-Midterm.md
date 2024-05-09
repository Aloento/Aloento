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

# Agglomerative

In hierarchical agglomerative clustering, how would you determine the optimal number of clusters without relying on pre-defined stopping criteria?

# DBSCAN

If you set a large value for $\epsilon$ in DBSCAN, what would be the potential consequences on the clustering results?

# Regression

Discuss the difference between simple linear regression and multiple linear regression.

# Gradient

Describe the process by which gradient descent is employed to refine the parameters of a linear regression model.

# Regularization

How does regularization help overcome the challenges associated with using polynomial regression models?
Particularly in mitigating overfitting and controlling model complexity?

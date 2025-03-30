---
title: ITDS Midterm
toc: true
categories:
  - [Data Science]
tags: [考试, 数据科学]
date: 2025-03-30 00:00:00
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

## Learning

What are the key distinctions between supervised and unsupervised learning in ML?

<details>

</details>

## Quartet

What are the similarities and differences between Anscombe’s Quartet and the Unstructured Quartet in statistical analysis?

<details>

</details>

## EDA

What are the fundamental steps in an exploratory data analysis (EDA) workflow, and how does each step contribute to gaining insights into the data’s characteristics?

<details>

</details>

## L1 Norm

Consider two vectors: A = (3, -2, 5) and B = (1, 4, -1)

Provide the formal definition of the L1 norm and calculate the L1 norm between A and B

<details>

</details>

Under which conditions is a distance measure considered a metric? Verify that the L1 norm is a metric (provide proofs to support each condition).

<details>

</details>

## DBSCAN

What are the hyper-parameters of DBSCAN and how do we set them up?

<details>

</details>

## Linkage

How do the complete and single linkage methods differ in agglomerative clustering, and how does this difference affect the formation and structure of clusters in the resulting dendrogram?

<details>

</details>

## Centroids

How does the selection of initial centroids affect the convergence and final clustering results in K-means, and what techniques can be used to minimize this influence?

<details>

</details>

## Linear

Describe the objective function of a simple linear regression and explain how the parameters are chosen to optimize its objective function.

<details>

</details>

## LSE

Explain the concept of least squares estimation and its significance in linear regression modeling.

<details>

</details>

## Polynomial

Describe polynomial regression and discuss its advantages and limitations compared to linear regression models.

<details>

</details>

# 2024-05-16

## Jaccard

You are given the following categorical dataset with features f0, f1, and f2:

| f0  | f1  | f2  |
| --- | --- | --- |
| c   | b   | x   |
| a   | a   | z   |
| c   | c   | y   |
| a   | a   | y   |

Provide the formal definition of Jaccard similarity.

<details>

</details>

What dataset do you obtain by applying 1-hot encoding to all of its features? Specify the column names in the form “attribute value”.

<details>

</details>

Compute J(x1, x2) and J(x3, x4) after one-hot encoding.

<details>

</details>

## Metric

Define the Jaccard distance and prove that it can be used as a metric.

<details>

</details>

## Initialization

What are the initialization methods commonly used in K-means? Discuss their pros and cons.

<details>

</details>

## Convergence

Explain how K-means determines convergence and identifies when the algorithm has finished.

<details>

</details>

## Regression

You are provided with a dataset containing information about the number of hours spent studying (X) and the corresponding scores achieved (Y) by a group of students in a particular exam. Your task is to perform a simple linear regression analysis on this dataset.

| Hours Studied (X) | Exam Score (Y) |
| ----------------- | -------------- |
| 2.5               | 85             |
| 3.0               | 88             |
| 3.5               | 90             |
| 4.0               | 92             |
| 4.5               | 94             |

Calculate the mean, variance, and standard deviation of both X and Y. Reflect on the significance of these statistical measures in understanding the distribution of the data.

<details>

</details>

Plot a scatter plot of the data to visualize the relationship between hours studied and exam scores.

<details>

</details>

Fit a simple linear regression model to the dataset to predict exam scores based on the number of hours studied. Use the least squares method to estimate the regression coefficients β0 and β1.

<details>

</details>

Reflect on the interpretation of the regression coefficients β0 and β1. What do they represent in the context of this problem?

<details>

</details>

Use the fitted regression model to predict the exam score for a student who studies for 5 hours.

<details>

</details>

# 2024-10-15

## Edit

Consider two objects represented by strings: Object A = ”kitten” and Object B = ”sitting”.

Define and calculate the Edit distance between A and B. Can we use the Edit distance if A and B had different lengths and why?

<details>

</details>

## Metric

Demonstrate that Edit distance is a metric

<details>

</details>

## Hierarchical

In hierarchical agglomerative clustering, how would you determine the optimal number of clusters?

<details>

</details>

# 2024-11-05

You are working with a large dataset of 10 million patient records containing medical histories, test results, and diagnoses (as described in the Table below). Only 1% of these patients have been diagnosed with a rare, chronic condition. Your task is to analyze and cluster the data to identify groups with similar health patterns, which could support early detection of the rare condition.

| Feature     | Data Type   | Example Values                |
| ----------- | ----------- | ----------------------------- |
| Patient ID  | Categorical | 00123, 00124                  |
| Age         | Numerical   | 45, 62, 29                    |
| Gender      | Categorical | Male, Female                  |
| BP          | Numerical   | 120/80, 135/90                |
| Cholesterol | Numerical   | 180, 220                      |
| BMI         | Numerical   | 23.5, 27.1                    |
| Smoking     | Categorical | Smoker, Non-smoker            |
| Diabetes    | Categorical | Normal, Prediabetic, Diabetic |

<details>

</details>

## Volume

Explain the benefits and limitations of using the entire 10 million patient records versus a smaller subset, given the 1% prevalence of the rare condition. Discuss how data volume could impact model performance in detecting these rare cases.

<details>

</details>

## Visualizations

Identify at least two visualizations types that would be most effective for finding patterns or anomalies in this medical data.

<details>

</details>

## Clustering

Describe which distance or similarity measure you would select for clustering patient records containing both numerical and categorical features. Justify your choice, considering the imbalanced nature of the data

<details>

</details>

## Hierarchical

Explain how you would use hierarchical clustering to identify health patterns related to the rare condition in this dataset. Discuss how you would evaluate the quality of the resulting clusters and specify which linkage criteria you might choose and why.

<details>

</details>

## Imbalance

Describe a strategy that you could use to address the 1% imbalance of the rare condition within your clustering approach and explain how it helps improve the identification of rare cases?

<details>

</details>

# 2024-12-10

## Quality

What are the common data quality problems that can affect the performance of machine learning models, how can you identify and address these issues in a dataset?

<details>

</details>

## Metric

Consider the following function d(x,y) defined for x,y ∈ R:

$$
d(x, y) = \sqrt{|x - y|} +
\begin{cases}
0 & \text{if } x = y, \\
1 & \text{if } x \neq y.
\end{cases}
$$

Verify whether d(x,y) satisfies the metric properties.

<details>

</details>

## Contrast

How can you formally define contrast in high-dimensional data, and how does it relate to the concentration of pairwise distances?

<details>

</details>

## Quality

<details>

</details>

## Linkage

 How does the choice of linkage method (e.g., single-linkage, complete-linkage, average-linkage) impact the structure and quality of clusters formed by hierarchical clustering?

<details>

</details>

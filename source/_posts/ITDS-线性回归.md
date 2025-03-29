---
title: ITDS-线性回归
toc: true
categories:
  - [Data Science]
tags: [数据科学, 笔记]
date: 2025-03-28 22:18:20
---

Supervised Learning，Linear / Polynomial Regression，Regularization，Feature Scaling

<!-- more -->

# 监督学习

监督学习的核心任务是从已知的输入输出中，学习模式，然后预测新的数据。我们假定输入输出存在映射关系，随后我们去学习一个近似函数来尝试拟合此关系。

- Regression: 预测一个连续的数值输出（连续数值）

$$
y = f(x) = \beta_0 + \sum_{i=1}^n \beta_i x_i + \epsilon
$$

目标是找到最优的 $\beta_0$ 和 $\beta_i$，使得预测值 $y$ 和真实值之间的 $\epsilon$ 误差最小化。

- Classification: 将数据分类到预定义的类别或标签中（离散类别）

$$
y = f(x) = \argmax P(y = c | x)
$$

在给定输入 x 的情况下，输出 y 属于 c 的概率。

# 线性回归

简而言之，线性回归就是找一条最合适的直线，来拟合数据。我们非常熟悉 $y = ax + b$，这就是我们要拟合的函数。而要找到最优的只想，我们需要衡量 预测值 $y_{pred}$ 和 真实值 $y_{true}$ 之间的误差。我们可以使用均方误差（Mean Squared Error, MSE）来衡量：

$$
MSE = \frac{1}{m} \sum_{i=1}^m (y_{pred, i} - y_{true, i})^2
$$

## 梯度下降

随后我们可以使用梯度下降来指导 $a$ 和 $b$ 的更新。它本质上是在：

1. 计算 MSE 对 $a$ 和 $b$ 的偏导数，得到变化方向
2. 沿着偏导数的反方向更新 $a$ 和 $b$ 的值
3. 不断重复，直到误差够小或者最大迭代次数

想象你在一座山上（梯度就是山的坡度），目标是找到最低点（最小损失）。如果你逆着梯度方向走（下坡），你才能到达山谷，让损失最小：

$$
a_{new} = a_{old} - \alpha \frac{\partial MSE}{\partial a}
$$

$$
b_{new} = b_{old} - \alpha \frac{\partial MSE}{\partial b}
$$

其中 $\alpha$ 是学习率，决定了每次更新的步长。学习率过大可能会错过最优解，过小则收敛速度慢或者陷入局部最优。

## 最小二乘法

除了可以使用 MSE，我们还可以使用 Least Squares Estimation，其目标是找到一组参数，使得数据点与拟合曲线的 垂直距离的平方和 最小：

我们首先有误差：

$$
e_i = y_{true, i} - y_{pred, i} = y_{true, i} - (a x_i + b)
$$

随后有：

$$
SSE = \sum_{i=1}^m (y_{true, i} - y_{pred, i})^2 = \sum_{i=1}^m (y_{true, i} - (a x_i + b))^2
$$

即真实值与预测值之间的误差平方和。我们要最小化这个值，我们分别对 $a$ 和 $b$ 求偏导数，令其为 0：

$$
\frac{\partial SSE}{\partial a} = 0 = \sum_{i=1}^m 2 (y_{true, i} - (a x_i + b)) (-x_i)
$$

$$
\frac{\partial SSE}{\partial b} = 0 = \sum_{i=1}^m 2 (y_{true, i} - (a x_i + b)) (-1)
$$

联立求解

$$
w = \frac{\sum (x_i - \bar{x})(y_i - \bar{y})}{\sum (x_i - \bar{x})^2}
$$

$$
b = \bar{y} - w \bar{x}
$$

其中：

- $\bar{x} = \frac{1}{m} \sum x_i$ 是 $x$ 的均值
- $\bar{y} = \frac{1}{m} \sum y_i$ 是 $y$ 的均值

> 直接用误差的和可能会出现 正负误差相互抵消  
> 平方误差确保所有误差都是正的，且对大的误差更敏感

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

# 多项式回归

普通的线性回归不能处理非线性关系，所以我们需要可以画出曲线的模型：

$$
y = \beta_0 + \beta_1 x + \beta_2 x^2 + \ldots + \beta_n x^n + \epsilon = \sum_{i=0}^n \beta_i x^i + \epsilon
$$

其中，n 是多项式的阶数，决定了模型的灵活性和复杂度，越高模型越灵活，但也有可能过拟合。二次多项是 U 形抛物线，三次是 S... 尽管有高次项，但模型仍然是线性的，因为 $\beta$ 是线性求解的。

要拟合多项式，我们仍然可以使用 MSE 或者 LSE，以 MSE 为例，给定一个模型：

$$
y_{pred} = h(x, \theta)
$$

其中，x 是输入，$\theta$ 是参数，有 MSE 误差：

$$
E(\theta) = \frac{1}{2m} \sum_{i=1}^m (y_{pred, i} - y_{true, i})^2
$$

可以看到我们乘了一个 $\frac{1}{2}$，这是为了简化计算，因为我们在求导的时候会有一个 2 的系数。我们可以使用梯度下降来更新参数，我们需要计算 损失函数 对 每个参数 的偏导数：

$$
\frac{\partial E(\theta)}{\partial \theta_j} = \frac{1}{m} \sum_{i=1}^m (y_{pred, i} - y_{true, i}) \frac{\partial h(x_i, \theta)}{\partial \theta_j} = \frac{1}{m} \sum_{i=1}^m (y_{pred, i} - y_{true, i}) x_i^j
$$

除了需要计算并更新每个参数，其他的都与线性回归一致。如果需要将误差可视化，那么我们可以使用 RMS 误差，也就是将 MSE 开平方，这样 y 轴的单位就与数据的 y 的单位一致了。

# 正则化

为了防止过拟合，我们一定要始终使用正则化，它不是对数据进行正则化，而是在 Loss 函数上添加一个惩罚项，使得模型参数不会变的过大。常见的方法有 L1 和 L2 正则化：

- L1 正则化：Lasso Regression，约束参数的绝对值（稀疏，能让部分参数为 0  
  $\sum_{j=1}^n |\theta_j|$

- L2 正则化：Ridge Regression，约束参数的平方（缩小值，但不为 0  
  $\sum_{j=1}^n \theta_j^2$

- Elastic Net：L1 + L2 正则化，结合了两者的优点  
  $\lambda_1 \sum_{j=1}^n |\theta_j| + \lambda_2 \sum_{j=1}^n \theta_j^2$

## 岭回归

普通的线性回归可以最小化 MSE，Ridge Regression 在此基础上添加了一个 L2 正则化项：

$$
RSS = \sum_{i=1}^m (y_{pred, i} - y_{true, i})^2 + \lambda \sum_{j=1}^n \theta_j^2
$$

- 第一项就是 MSE
- 第二项是 L2 惩罚项，让参数更小
- $\lambda$ 是正则化参数，控制惩罚项的强度。越大惩罚越强，模型的系数趋近于 0
- 梯度下降照旧，但是多了 $\lambda \theta_j$ 的项，会让参数逐步变小

# 特征缩放

许多算法对特征尺度敏感，如果它们的数值范围差距过大，可能会导致：

- 梯度下降收敛速度慢：较大的特征值会主导损失函数的变化
- 无法正确学习权重：正则化对不同特征的影响不均匀
- 距离度量异常：距离算法会偏向数值较大的特征

我们可以使用：

- Feature Centering：计算特征的均值，然后所有数据点减去均值，使得特征均值为 0，但不改变反差
- Feature Standardization：计算特征的均值和标准差，然后所有数据点减去均值除以标准差，使得特征均值为 0，标准差为 1
- Feature Normalization：计算特征的最小值和最大值，然后所有数据点减去最小值除以最大值，使得特征范围在 0 到 1 之间

对训练数据进行了正则化，也要记得在预测的时候对输入数据也进行同样的正则化。线性模型的权重会自动适应特征的尺度，比如米与厘米不会影响预测结果。

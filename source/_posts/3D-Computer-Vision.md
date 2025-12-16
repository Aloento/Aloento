---
title: 3D Computer Vision
toc: true
categories:
  - [AI, 3D]
tags: [3D视觉, 考试]
date: 2025-12-16 18:19:27
---

我不中了

<!-- more -->

## Basic Estimation Theory

估计 = 给定很多不完美的观测，用数学找“最合理”的未知参数。

| 项目     | 齐次                        | 非齐次                    |
| -------- | --------------------------- | ------------------------- |
| 方程     | Ax = 0                      | Ax = b                    |
| 目标     | 最小 ‖Ax‖                   | 最小 ‖Ax − b‖             |
| 约束     | ‖x‖ = 1                     | 无                        |
| 解法     | 最小特征值 / SVD            | 正规方程                  |
| 典型任务 | Homography, F, Plane normal | Line fitting, Calibration |

### Solution for homogeneous linear system of equations

齐次线性方程组的解

数学形式 $ A x = 0 $

想象你有很多“约束”，但**它们都指向同一个方向**。

比如：

- 多个点大致在一条直线上
- 每个点都说一句话：“直线法向量应该满足这个关系”

这些约束合起来就是：

> **“找到一个非零向量 x，让 Ax 尽量接近 0”**

**x = 0 永远是解，但没意义**
所以我们强制一个约束：

> **‖x‖ = 1（单位长度）**

---

解：x 是 A 的**最小奇异值（Singular value）对应的奇异向量**。

---

典型例子

**平面拟合 / 直线拟合**

很多 3D 点 ≈ 在一个平面上：$ax + by + cz + d = 0$

→ 对每个点是一条齐次线性方程
→ 堆起来就是 (Ax = 0)
→ 用 **最小特征值（Eigenvalue）解**

### Solution for inhomogeneous linear system of equations

非齐次线性方程组的解

现在不是“全指向 0”，而是：

> 每个观测点说：“结果应该是 b，但我有噪声”

- 你问 100 个人体重
- 每个人都给你一个“差不多”的数
- 不可能完全一致

---

核心思想：**最小二乘**

> 找一个 x，使 **误差平方和最小**

$\min_x |Ax - b|^2$

---

解满足 **正规方程（Normal Equation）**：

$A^T A x = A^T b$

→ 解为：

$x = (A^T A)^{-1} A^T b$

---

几何解释

> Ax 是所有可能结果的一个子空间  
> b 被“投影”到这个子空间上  
> 投影点就是最优解

## Robust Fitting Methods

最小二乘一遇到离群点（outliers）就会崩。

- 你要用很多点拟合一条直线
- 80% 的点在直线附近
- 20% 是错误匹配（完全乱飞）

**普通最小二乘**会被这 20% “拉歪”
**RANSAC 的思想**：

> **与其相信所有点，不如只相信“彼此一致”的点**

RANSAC 的核心思想

> **随机抽最少点 → 建模型 → 看谁支持它 → 重复 → 选支持最多的模型**

### The RANSAC method

Step 1：随机采样（Random Sampling）

- 随机选 **最小样本数** 的点
- 这个数量 = **模型所需的最小点数**

例子：

- 直线：2 点
- Homography：4 点
- Fundamental matrix：7 或 8 点

这一步的假设是：

> “**这一次，抽到的点全是 inliers**”

---

Step 2：模型估计（Model Estimation）

- 用这几个点
- 直接算一个模型（通常是**线性解**）

例子：

- 2 点 → 一条直线
- 4 对点 → 一个 Homography

---

Step 3：一致性检测（Consensus / Inlier Test）

- 用这个模型
- **测试所有数据点**
- 计算误差（distance / reprojection error）

判断规则（口语版）：

> “误差 < 阈值 → inlier
> 误差 ≥ 阈值 → outlier”

---

Step 4：记录支持度（Support）

- 统计：

  > **有多少 inliers 支持这个模型**

- 支持度 = inlier 数量

---

Step 5：重复 + 选择最优

- 重复以上步骤 N 次
- 选择 **inlier 数最多** 的模型

最后一步（很多人漏说，但你要说）：

> **用所有 inliers 再做一次最小二乘精估**

这是为什么 RANSAC 的结果不“粗糙”。

---

**RANSAC 是“在参数空间里做投票”**

- 每一次随机采样 → 提出一个假设
- 每个数据点 → 给“支持 / 不支持”投票
- 得票最多的模型 → 胜出

---

最小样本数

- 由模型决定
- 决定了 RANSAC 的“基本成本”

阈值（Threshold）

- 决定 inlier / outlier
- 太小 → 好点被误删
- 太大 → 坏点混进来

要跑多少次才够？

> “希望至少有一次，抽到的点全部是 inliers”

---

优点

- 对 outliers **极其鲁棒**
- 简单、通用
- 和任何模型都能搭配

缺点

- 随机 → **结果不完全确定**
- 参数（阈值、次数）需要经验
- 只能找到 **一个模型**

但真实数据里可能有多个模型

## Multi-model Fitting

### Sequential RANSAC

### MultiRANSAC

## Camera Models

### Perspective camera

### Orthogonal projection

### Weak-perspective camera

## Calibration of Perspective Camera Using a Spatial Calibration Object

### Estimation of projection matrix

### Decomposition of projection matrix

## Chessboard-based Calibration of Perspective Cameras

### Radial distortion

### Tangential distortion

## Plane-plane Homography

### Panoramic images by homographies

## Estimation of Homography

### Data normalization

## Basics of Epipolar Geometry

### Essential matrix

### Fundamental matrix

### Rectification

## Estimation of Essential and Fundamental Matrices

### Data normalization

### Decomposition of essential matrix

## Triangulation

### Standard stereo vision

### General stereo vision

## Stereo Vision for Planar Motion

## Tomasi-Kanade Factorization

### Multi-view reconstruction by orthogonal camera model

### Multi-view reconstruction by weak-perspective camera model

## Reconstruction by Merging Stereo Reconstructions

### Registration of two point sets by a similarity transformation

## Numerical Optimization

## Numerical Multi-view Reconstruction

### Bundle adjustment

## Reconstruction by Special Devices

### Laser scanning

### Depth camera

### LiDAR

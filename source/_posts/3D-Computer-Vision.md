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

平面拟合 / 直线拟合

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

RANSAC 是“在参数空间里做投票”

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

“RANSAC 只能找一个模型，那如果有多个模型怎么办？”

真实世界里，数据往往不只来自一个模型。

典型例子

- 激光雷达点云：**地面 + 墙 + 桌面**
- 图像直线检测：**多条直线**
- 特征匹配：**多个平面**

**普通 RANSAC：**

- 只能找到 **inliers 最多的那一个模型**
- 其他结构会被当成 outliers 丢掉

| Sequential RANSAC | MultiRANSAC |
| ----------------- | ----------- |
| 找一个，删一个    | 多个一起找  |
| 贪心              | 全局视角    |
| 简单              | 更复杂      |
| 易错              | 更稳健      |

### Sequential RANSAC

一次只找一个模型，找到后把它删掉，再找下一个

---

Step 1：在全部数据上跑 RANSAC

- 得到 **模型 M₁**
- 得到它的 **inliers 集合 I₁**

---

Step 2：移除 inliers

- 从数据集中删除 I₁
- 剩下的点 ≈ 其他模型 + 噪声

---

Step 3：在剩余数据上再跑 RANSAC

- 得到 **模型 M₂**
- 得到 **inliers I₂**

---

Step 4：重复

- 直到：

  - 剩余点太少
  - 或者 RANSAC 再也找不到“足够支持”的模型

---

形象比喻

> 像剥洋葱  
> 一层一层剥  
> 每一层都是一个模型

典型应用

- 多条直线检测
- 多个平面（尤其是 LiDAR / depth 数据）

---

优点

- 非常简单
- 基于标准 RANSAC
- 容易实现、调试

---

致命缺点

> **贪心（greedy）算法**

具体问题：

- 第一个模型如果估计得不好
- 错误的 inliers 被删掉
  → 后面的模型**永远找不到**

### MultiRANSAC

同时寻找多个模型，而不是一个一个删。

> RANSAC 不再只维护一个“最佳模型”，  
> 而是维护 **多个候选模型**，  
> 数据点可以在模型之间“竞争归属”。

1. **大量随机采样**
2. 生成许多模型假设
3. 每个点计算：

   - 它对每个模型的误差

4. 点被分配给：

   - 误差最小的模型

5. 对每个模型：

   - 用自己的 inliers 重新估计

6. 迭代直到稳定

本质类似：clustering + RANSAC

---

优点

- 不容易被早期错误带偏
- 能处理 **模型重叠**
- 适合复杂场景

缺点

- 算法复杂
- 参数多
- 计算量大
- 实现难度高

---

什么时候用 Sequential RANSAC？  
当模型之间分离得比较清楚

什么时候用 MultiRANSAC？  
模型数量未知  
或多个模型规模接近  
或模型有重叠

## Camera Models

相机模型描述的是：3D 点如何变成 2D 像素。

核心变量只有三个：

- **投影方式**
- **是否考虑深度变化**
- **自由度多少**

### Perspective camera

透视 / 针孔相机

> **离相机近的物体看起来大，远的看起来小。**

几何直觉

- 所有光线经过一个点（焦点）
- 3D 点 → 沿射线投影到成像平面

---

$u \sim K ,[R \mid t], X$

含义：

- (X)：世界坐标里的 3D 点
- (R,t)：相机姿态
- (K)：内参（焦距、主点等）

齐次坐标，只有比例意义

核心特性

- **有尺度歧义（scale ambiguity）**
- 深度 (Z) 决定成像大小：
  $u \propto \frac{1}{Z}$

---

优点

- 最真实
- 精确描述真实相机
- 所有 3D 几何理论的基础

缺点

- 参数多（内参 + 外参）
- 非线性
- 数学处理复杂

什么时候用？

> **近距离 / 大景深变化 / 精确 3D 重建**

### Orthogonal projection

正交投影

所有点“垂直”投影到图像平面，不考虑深度。

> 像工程制图
> 或影子在正午阳光下

---

数学直觉

$u = R_{1:2} X + t$

- 只保留 X、Y
- Z **完全被忽略**

核心特性

- **没有透视效应**
- 远近大小完全一样
- 模型最简单

---

自由度

- **5 DoF**

  - 3（旋转）
  - 2（平移）

---

什么时候用？

> **物体非常远、深度变化极小**

例如：

- 卫星影像
- 极远距离拍摄

### Weak-perspective camera

弱透视相机

> **真实透视太复杂，正交又太粗糙。**

折中方案：**Weak-Perspective**

---

核心假设

> **物体深度变化 ≪ 相机到物体的平均距离**

换句话说：

- 所有点的 Z **几乎一样**

---

投影思想

1. 先 **正交投影**
2. 再整体 **缩放**

---

数学直觉

$u = s \cdot R_{1:2}(X - t)$

- (s)：统一尺度因子
- 不再随每个点的 Z 变化

---

| 特性     | 透视 | 弱透视    | 正交 |
| -------- | ---- | --------- | ---- |
| 透视缩放 | ✔    | ✔（统一） | ✘    |
| 深度变化 | ✔    | ✘         | ✘    |
| 非线性   | ✔    | ✘         | ✘    |
| DoF      | 多   | **6**     | 5    |

弱透视 = 缩放正交投影

---

优点

- 线性
- 无尺度歧义
- 易估计
- 闭式解多

缺点

- 近距离或深度变化大时不准

---

什么时候用？

> **人脸、人体、刚体** > **中远距离、相对平坦结构**

Tomasi–Kanade 因式分解就是用它

---

为什么 Tomasi–Kanade 不能用透视？

> 因为透视投影是非线性的，
> 而因式分解需要线性模型。

什么时候弱透视会失败？

> 当物体离相机很近，
> 或深度变化很大时。

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

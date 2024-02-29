---
title: Master Method
date: 2024-02-29 09:30:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

本文是 Design and Analysis of Algorithms 的一部分

~~本节课一上来就给我搞了一个新概念让我措手不及，完全听不懂~~

<!-- more -->

# 前置知识

在学习~~可以手搓魔法阵的~~大师方法之前，我们需要一些前置知识

## 时间复杂度

在 [很久之前](https://aloen.to/Algorithm/Basics-of-Computer-Science/#%E6%97%B6%E9%97%B4%E5%A4%8D%E6%9D%82%E5%BA%A6) 我就写过关于时间复杂度的内容

我们做复杂度分析的时候，考虑的因变量只有问题规模，而不是具体输入  
无论哪种记法，默认是取最坏情况来分析

### 大 O 与 渐进分析

用 大 O 表示的复杂度，就叫渐进复杂度  
我们常说的分析复杂度，其实就是分析渐进复杂度

它忽略了复杂度的常数倍差别，更关心 “算法所需要的资源，随问题规模增长而增长的速度”

且 O 表达的是**低阶于**，即算法的复杂度不会超过这个值
比如，对于一个 O(1) 的算法，你要说它是 O(n) 也没错，只不过你的上限不够**紧致**

所以，$O$ 是上限，$\Omega$ 是下限，$\Theta$ 是上下限相同（即确定就在这一阶）

## 递归分治算法

一个典型的例子就是 [Merge Sort](https://aloen.to/Algorithm/Basics-of-Computer-Science/#%E5%BD%92%E5%B9%B6%E6%8E%92%E5%BA%8F)

让我们来快速复习一下：

1. 把序列一分为二
2. 分别对两个子序列进行归并排序
3. 合并两个有序序列

# Master Method

如果我们想快速计算归并，或者存在**递归的分治算法**的时间复杂度，我们可以使用主定理

## 定义

有递归关系式

$$ T(n) = aT(\frac{n}{b}) + f(n), 其中 a \geq 1, b > 1$$

n 是问题规模，a 是递归子问题数量，b 是问题规模的缩小比例  
$\frac{n}{b}$ 是子问题规模，$f(n)$ 为递归以外的操作（如分治）

那么我们存在三种情况

### 1. 分治主导

存在常数 $\epsilon > 0$，使得

$$ f(n) = O(n^{\log_b(a) - \epsilon}) $$

则

$$ T(n) = \Theta(n^{\log_b(a)}) $$

### 2. 一样耗时

存在常数 $\epsilon \geq 0$，使得

$$ f(n) = \Theta(n^{\log_b(a)} \lg^\epsilon n) $$

则

$$ T(n) = \Theta(n^{\log_b(a)} \lg^{1+\epsilon} n) $$

#### 另可写为

$$ f(n) = \Theta(n^{\log_b(a)}) $$

则

$$ T(n) = \Theta(n^{\log_b(a)} \lg n) $$

### 3. 递归主导

存在常数 $\epsilon > 0$，使得

$$ f(n) = \Omega(n^{\log_b(a) + \epsilon}) $$

且存在常数 $c < 1， n \to \infty$ 时，有

$$ af(\frac{n}{b}) \leq cf(n) $$

则

$$ T(n) = \Theta(f(n)) $$

## 理解

~~_**汗流浃背了吧**_~~

以 $T(n) = 2T(\frac{n}{2}) + n$ 为例

```
                    f(n)
              /               \
        f(n/b)                 f(n/b)
        /    \                 /    \
f(n/b^2)     f(n/b^2)    f(n/b^2)    f(n/b^2)
 /    \       /    \       /    \      /    \
          ......（很多次递归以后）
Θ(1) Θ(1) ... Θ(1) Θ(1) Θ(1) Θ(1) ...
```

递归树被分为两个部分：$f(n)$ 与 $\Theta(1)$

### 本质

它其实在对比这两个部分的时间复杂度：

**是 $\sum f(n)$ 耗时，还是 $\sum \Theta(1)$ 耗时**

所以我们可以将其描述为

$$ T(n) = g \cdot f(n) + k \cdot \Theta(1)$$

由于 g 增长较慢，所以我们可以认为 g 是常数，则有

$$ g \cdot f(n) \to O (f(n)) $$

所以问题来了，k 是多少

---

我们可以发现这个树每一层分叉都是 $a$

每次问题规模缩小为 $\frac{n}{b}$，且 $n = b^{\log_b n}$  
所以这棵树的高度是 $\log_b n$  
这样我们就有 $a^{\log_b n}$ 个叶子节点

所以，有 $\sum \Theta(1) = \Theta(a^{\log_b n})$  
使用换底公式，$\Theta(n^{\log_b a})$

**眼熟吗？**

将 k 代入，得到 $T(n) = g \cdot f(n) + n^{\log_b a}$

### 对比

接下来我们就只需要对比 $f(n)$ 与 $n^{\log_b a}$ 到底谁随着 n 增长的速度更快了

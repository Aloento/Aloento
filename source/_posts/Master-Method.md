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

### 1. 递归主导

存在常数 $\epsilon > 0$，使得

$$ f(n) = O(n^{\log_b(a) - \epsilon}) $$

则

$$ T(n) = \Theta(n^{\log_b(a)}) $$

### 2. 一样耗时

存在常数 $\epsilon \geq 0$，使得

$$ f(n) = \Theta(n^{\log_b(a)} \log^\epsilon n) $$

则

$$ T(n) = \Theta(n^{\log_b(a)} \log^{1+\epsilon} n) $$

#### 另可写为

$$ f(n) = \Theta(n^{\log_b(a)}) $$

则

$$ T(n) = \Theta(n^{\log_b(a)} \log n) $$

### 3. 分治主导

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

由于 $g$ 增长较慢，所以我们可以认为 g 是常数，则有

$$ g \cdot f(n) \to O (f(n)) $$

所以问题来了，$k$ 是多少

### 推导

我们可以发现这个树每一层分叉都是 $a$

每次问题规模缩小为 $\frac{n}{b}$，且 $n = b^{\log_b (n)}$  
所以这棵树的高度是 $\log_b n$  
这样我们就有 $a^{\log_b (n)}$ 个叶子节点

所以，有 $\sum \Theta(1) = \Theta(a^{\log_b (n)})$  
使用换底公式，$\Theta(n^{\log_b (a)})$

**眼熟吗？**

将 $k$ 代入，得到 $T(n) = g \cdot f(n) + n^{\log_b (a)}$

### 对比

接下来我们就只需要对比 $f(n)$ 与 $n^{\log_b (a)}$ 到底谁随着 n 增长的速度更快了

#### 1. $\sum \Theta(1) >$

$k$ 的增长大于 $f(n)$ 的增长  
表示最终处理问题的最小任务占主导

则 $T(n) = \Theta(n^{\log_b (a)})$  
引入 $\epsilon$，仅为了说明增长速度快

#### 2. $=$

表示最小子任务与分割任务的时间复杂度一样  
此时 $f(n) = \Theta(n^{\log_b (a)})$  
因此需要把两个的时间复杂度都算上  
有 $T(n) = \Theta(n^{\log_b (a)} \log n)$

#### 3. $\sum f(n) >$

分治过程占主导，为什么有额外要求呢？

$$c < 1, af(\frac{n}{b}) \leq cf(n), n \to \infty$$

因为不可以让子问题的耗时增长速率大于其本身，但其实是在限制 $g$

### 限制 $g$

我们前文提到，$g$ 被限制速率不可超过 $O(f(n))$，所以认为 $g$ 是常数  
这在 1 / 2 情况中默认不可能超过 $k$，而 3 中我们需要额外限制

#### $g$ 的计算

让我们把 $f(n)$ 加起来

$$
\sum_{j=0}^{\log_b (n) - 1} a^j f(\frac{n}{b^j})
$$

随后我们用变形的 等比数列求和公式 得到

$$
\sum_{i=0}^{k} r^i = \frac{r^{k+1} - 1}{r - 1}
$$

递归树有 $\log_b (n)$ 层，去掉最后一层是 $k = \log_b (n) - 1$，变形公式正好抵消 1

我们发现第三条的规定，就是在限制 $r$ 足够小

~~细节我也看不明白，希望大佬指点~~

# 例题

~~让我们来画点魔法阵~~

## 情况一

$T(n) = 9T(\frac{n}{3}) + n$

$a = 9, b = 3, f(n) = n$

$T(n) = n^{\log_3 (9)} = n^2 > f(n)$

## 情况二

$T(n) = T(\frac{2n}{3}) + 1$

$a = 1, b = \frac{3}{2}, f(n) = 1$

$n^{\log_b (a)} = n^{\log_{\frac{3}{2}} (1)} = n^0 = 1 = f(n)$

$T(n) = 1 \times \log n = \log n$

## 情况三

$T(n) = 3T(\frac{n}{4}) + n \log n$

$a = 3, b = 4, f(n) = n \log n, n \to \infty$

$n^{\log_4 (3)} = n^{0.792} < n < n \log n$

由此判定为情况三，则

$af(\frac{n}{b}) = 3 \frac{n}{4} \log \frac{n}{4} < \frac{3}{4} n \log n = cf(n)$

取 $c = \frac{3}{4}$ 即可

$T(n) = n \log n$

## 不适用

$T(n) = 2T(\frac{n}{2}) + n \log n$

$a = 2, b = 2, f(n) = n \log n, n \to \infty$

$n^{\log_2 (2)} = n < f(n)$

由此判定为情况三，我们尝试验证 $af(\frac{n}{b}) \leq cf(n)$

$af(\frac{n}{b}) = 2 \frac{n}{2} \log \frac{n}{2} = n \log \frac{n}{2} = n \log n - n = n(\log n - 1) \leq c \times n \log n = cf(n)$

则等价于 $\log n - 1 \leq c \log n$

---

我们尝试求解 $\log n - 1 \geq c \log n$

重写为 $(1 - c) \log n \geq 1 \to \log n \geq \frac{1}{1 - c} $

得到 $n \geq 2^{\frac{1}{1 - c}}$

---

这说明对于任何 $c < 1$，都存在一个 $n \geq 2^{\frac{-1}{c - 1}}$，使得 $af(\frac{n}{b}) \geq cf(n)$

所以存在一个 $n$ 的界限，超过后 $g$ 的增长速度将超过 $k$ 的增长速度

导致不能使用主定理

> 注：根据对数法则，$\log \frac{n}{2} = \log n - \log 2$  
> 由于本题讨论计算机领域，默认以二为底，有 $\log = \log_2$  
> 则 $\log 2 = 1$，所以 $\log \frac{n}{2} = \log n - 1$

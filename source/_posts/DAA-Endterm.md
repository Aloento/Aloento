---
title: DAA Endterm
toc: true
categories:
  - [Algorithm]
tags: [考试]
date: 2025-05-7 10:15:33
---

再来！包过！

<!-- more -->

# 最优二叉划分

有以下六个矩阵连乘，找出最优加括号划分，使得乘法次数最少：

| 矩阵 | 规模 (行 × 列) |
| ---- | -------------- |
| A₁   | 25 × 30        |
| A₂   | 30 × 10        |
| A₃   | 10 × 5         |
| A₄   | 5 × 10         |
| A₅   | 10 × 15        |
| A₆   | 15 × 20        |

<details>

首先我们列出维度数组，行在前、列在后；共 n+1 个数：

$$
p_i = (25, 30, 10, 5, 10, 15, 20)
$$

然后我们需要两个动态规划表：

| 记号     | 含义                                                       |
| -------- | ---------------------------------------------------------- |
| $m[i,j]$ | 计算子链 $A_i A_{i+1}\dots A_j$ **最少**需要的乘法次数     |
| $s[i,j]$ | 使得 $m[i,j]$ 取到最小值时 **最后一次相乘** 的分割位置 $k$ |

看不懂没关系，让我们继续分析。表格都是 矩阵数量(6x6) 的正方形上三角矩阵。

| $m[i,j]$ | 1   | 2   | 3   | 4   | 5   | 6   |
| -------- | --- | --- | --- | --- | --- | --- |
| 1        | 0   |     |     |     |     |     |
| 2        | -   | 0   |     |     |     |     |
| 3        | -   | -   | 0   |     |     |     |
| 4        | -   | -   | -   | 0   |     |     |
| 5        | -   | -   | -   | -   | 0   |     |
| 6        | -   | -   | -   | -   | -   | 0   |

我们先填主对角线，一个矩阵不乘自己，所以代价为 0。

然后我们从长度为 2 的子链开始填表格。对于每对相邻矩阵 $A_i A_{i+1}$，只可能有一种括号化：

$$
m[i, i+1] = p_{i-1} \times p_i \times p_{i+1}
$$

| $m[i, i+1]$ | 算式                     | 值   |
| ----------- | ------------------------ | ---- |
| 1, 2        | $25 \times 30 \times 10$ | 7500 |
| 2, 3        | $30 \times 10 \times 5$  | 1500 |
| 3, 4        | $10 \times 5 \times 10$  | 500  |
| 4, 5        | $5 \times 10 \times 15$  | 750  |
| 5, 6        | $10 \times 15 \times 20$ | 3000 |

| $m[i,j]$ | 1   | 2    | 3    | 4   | 5   | 6    |
| -------- | --- | ---- | ---- | --- | --- | ---- |
| 1        | 0   | 7500 |      |     |     |      |
| 2        | -   | 0    | 1500 |     |     |      |
| 3        | -   | -    | 0    | 500 |     |      |
| 4        | -   | -    | -    | 0   | 750 |      |
| 5        | -   | -    | -    | -   | 0   | 3000 |
| 6        | -   | -    | -    | -   | -   | 0    |

同时填上 $s[i, i+1] = i$，因为只有一个分割点。

| $s[i,j]$ | 1   | 2   | 3   | 4   | 5   | 6   |
| -------- | --- | --- | --- | --- | --- | --- |
| 1        | -   | 1   |     |     |     |     |
| 2        | -   | -   | 2   |     |     |     |
| 3        | -   | -   | -   | 3   |     |     |
| 4        | -   | -   | -   | -   | 4   |     |
| 5        | -   | -   | -   | -   | -   | 5   |
| 6        | -   | -   | -   | -   | -   | -   |

我们要继续计算更长的子链，我们要 先定长度 l，再定左端 i，枚举断点 k：

$$
m[i, j] = \min(左 + 右 + 跨越点) = \min_{i \leq k < j} (m[i, k] + m[k+1, j] + p_{i-1} \times p_k \times p_j)
$$

找到最小的 k 后，填入 $s[i,j]$，以 l = 3 为例：

| 区间 | 断点 | 算式                                                                   | 最小值 | s[i,j] |
| ---- | ---- | ---------------------------------------------------------------------- | ------ | ------ |
| 1, 3 | 1, 2 | 1. 0 + 1500 + 25 × 30 × 5 = 5250 <br> 2. 7500 + 0 + 25 × 10 × 5 = 8750 | 5250   | 1      |
| 2, 4 | 2, 3 | 1. 0 + 500 + 30 × 10 × 10 = 3500 <br> 2. 1500 + 0 + 30 × 5 × 10 = 3000 | 3000   | 3      |
| 3, 5 | 3, 4 | 1. 0 + 750 + 10 × 5 × 15 = 1500 <br> 2. 500 + 0 + 10 × 10 × 15 = 2000  | 1500   | 3      |
| 4, 6 | 4, 5 | 1. 0 + 3000 + 5 × 10 × 20 = 4000 <br> 2. 750 + 0 + 5 × 15 × 20 = 2250  | 2250   | 5      |

剩下的也是如此，直到填满整个表格。比如 $m[1, 4]$：

| 分割点 $k$ | 公式                          | 具体代入                | 结果   |
| ---------- | ----------------------------- | ----------------------- | ------ |
| 1          | $m[1,1] + m[2,4] + p_0p_1p_4$ | $0 + 3000 + 25·30·10$   | 10 500 |
| 2          | $m[1,2] + m[3,4] + p_0p_2p_4$ | $7500 + 500 + 25·10·10$ | 10 500 |
| 3          | $m[1,3] + m[4,4] + p_0p_3p_4$ | $5250 + 0 + 25·5·10$    | 6 500  |

最终我们得到

| $m[i,j]$ | 1   | 2    | 3    | 4    | 5    | 6     |
| -------- | --- | ---- | ---- | ---- | ---- | ----- |
| 1        | 0   | 7500 | 5250 | 6500 | 7875 | 10000 |
| 2        | -   | 0    | 1500 | 3000 | 4500 | 6750  |
| 3        | -   | -    | 0    | 500  | 1500 | 3250  |
| 4        | -   | -    | -    | 0    | 750  | 2250  |
| 5        | -   | -    | -    | -    | 0    | 3000  |
| 6        | -   | -    | -    | -    | -    | 0     |

| $s[i,j]$ | 1   | 2   | 3     | 4   | 5   | 6     |
| -------- | --- | --- | ----- | --- | --- | ----- |
| 1        | -   | 1   | **1** | 3   | 3   | **3** |
| 2        | -   | -   | 2     | 3   | 3   | 3     |
| 3        | -   | -   | -     | 3   | 3   | 3     |
| 4        | -   | -   | -     | -   | 4   | **5** |
| 5        | -   | -   | -     | -   | -   | 5     |
| 6        | -   | -   | -     | -   | -   | -     |

然后从 s 表反推括号化：

1. $s[1,6] = 3$，所以 $(A_1 A_2 A_3) (A_4 A_5 A_6)$
2. $s[1,3] = 1$，所以 $(A_1) (A_2 A_3)$
3. $s[4,6] = 5$，所以 $(A_4 A_5) (A_6)$

最后得到 $(A_1 (A_2 A_3)) ((A_4 A_5) A_6)$

这题本质是区间 DP，通过记录最优分割点来还原整体解

</details>

# 网格最大成本寻路

Suppose that you are given a $n \times n$ checkerboard and a checker. You must move the checker from the bottom edge of the board to the top edge of the board according to the following rules. At each step you may move the checker to one of three squares:

1. the square immediately above the current square.
2. the square that is one up and one to the left. (but only if the checker is not already in the leftmost column)
3. the square that is one up and one to the right. (but only if the checker is not already in the rightmost column)

Each time you move from square $x$ to square $y$, you receive $f(x, y)$ dollars. You are given $f(x, y)$ for all pairs $(x, y)$ for which a move from x to y is legal. Give an $O(n^2)$ dynamic programming algorithm that figures out the set of moves that will move the checker from somewhere along the bottom edge to somewhere along the top edge while gathering as many dollars as possible. Your algorithm is free to pick any square along the top edge as a destination in order to maximize the number of dollars gathered along the way.

<details>

带权格子路径题，允许往正上，左上，右上三个方向走，每个格子都有一个价值，目标是从底到顶最大化价值。
这一类题其实挺简单的，本质上是遍历然后比较。

1. 画一个 n x n 的表格，最下面一行是 0 行
2. 0 行的每个格子都初始化为 0
3. 由下到上逐行遍历：
   1. 找出当前格子可能的来向
   2. 计算每个来向的价值
   3. 记录最大值的来向
4. 填到顶行后找最大值
5. 从最大值反向推导路径

</details>

# 最优括号化

Give the dynamic programming solution to the optimal parameterization problem for them matrix product $A_1, A_2, A_3, A_4, A_5$ where the dimensions of $A_3$ are $4 \times 2$, the dimensions of $A_4$ are $2 \times 5$, and the dimensions of $A_5$ are $5 \times 3$. Show all calculations.

# 子序列

Run the dynamic programming algorithm to the longest common subsequence problem of sequences $(a, b, b, d, c, d, b, a)$ and $(a, b, d, c, a, b, c, d, a)$.

# 背包问题

Run the dynamic programming algorithm to the knapsack problem for items:

| i     | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| ----- | --- | --- | --- | --- | --- | --- | --- |
| $w_i$ | 2   | 2   | 5   | 4   | 1   | 3   | 1   |
| $v_i$ | 10  | 50  | 40  | 80  | 70  | 10  | 20  |

and knapsack capacity 11.

# 最大收益

Suppose you are managing a consulting team of expert computer hackers, and each week you have to choose a job for them to undertake. Now, as you can well imagine, the set of possible jobs is divided into those that are low-stress, and those that are high-stress. The basic question, each week, is whether to take on a low-stress job or a high-stress job. If you select a low-stress job for your team in week $i$, then you get a revenue of $l_i > 0$ dollars. If you select a high-stress job, you get a revenue of $h_i > 0$ dollars. The catch, however, is that in order for the team to take on a high-stress job in week $i$, it's required that they do no job in week $i - 1$. On the other hand, it's OK for the team to take a low-stress job in week $i$ even if they have done a job in week $i - 1$.

So, given a sequence of $n$ weeks, a plan is specified by a choice of low, high, none for each of the $n$ weeks, which the property that if high is chosen for week $i > 1$, the none has to be chose for week $i - 1$. (1st week can be high) The value of the plan is determined in the natural way: for each $i$ you add $(h/l/n)_i$ to the value of you chose high in week $i$. Give an efficient dynamic programming algorithm that take values for $l_1, l_2 \cdots l_n$ and $h_1, h_2 \cdots h_n$ and returns a plan of maximum value. Also give the running time of your algorithm.

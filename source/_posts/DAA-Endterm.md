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

## 练习

给出一个动态规划解法，用于求解矩阵乘法 $A_1 A_2 A_3 A_4 A_5$ 的最优加括号问题，其中各矩阵的维度为：

- $A_1$: $10 \times 5$
- $A_2$: $5 \times 15$
- $A_3$: $15 \times 5$
- $A_4$: $5 \times 20$
- $A_5$: $20 \times 10$

# 最优括号化

Give the dynamic programming solution to the optimal parameterization problem for them matrix product $A_1, A_2, A_3, A_4, A_5$ where the dimensions of $A_3$ are $4 \times 2$, the dimensions of $A_4$ are $2 \times 5$, and the dimensions of $A_5$ are $5 \times 3$. Show all calculations.

<details>

本题没有给出完整的矩阵维度，要让矩阵能够相乘，我们假设 A₁ 和 A₂ 的维度分别为 $a \times b$ 和 $b \times 4$，则

$$
p_i = (a, b, 4, 2, 5, 3)
$$

我们有二区间：

| m    | value                       |
| ---- | --------------------------- |
| i,i  | 0                           |
| 1, 2 | $a \times b \times 4 = ab4$ |
| 2, 3 | $b \times 4 \times 2 = b8$  |
| 3, 4 | $4 \times 2 \times 5 = 40$  |
| 4, 5 | $2 \times 5 \times 3 = 30$  |

三区间：

| m    | k     | value                                |
| ---- | ----- | ------------------------------------ |
| 1, 3 | 1     | $0 + b8 + ab2 = ab2 + 8b$            |
|      | 2     | $ab4 + 0 + 4b2 = ab4 + 8b$           |
| 2, 4 | 2     | $0 + 40 + 4b5 = 40 + 4b5$            |
|      | **3** | $b8 + 0 + 2b5 = 18b$                 |
| 3, 5 | **3** | $0 + 30 + 4 \times 2 \times 3 = 54$  |
|      | 4     | $40 + 0 + 4 \times 5 \times 3 = 100$ |

四区间：

| m    | k                 | value                             |
| ---- | ----------------- | --------------------------------- |
| 1, 4 | 1                 | $0 + 18b + ab5 = ab5 + 18b$       |
|      | 2                 | $ab4 + 40 + 4a5 = ab4 + 20a + 40$ |
|      | 3 if $k_{prev}=1$ | $ab2 + 8b + 2a5$                  |
|      | 3 if $k_{prev}=2$ | $ab4 + 8b + 2a5$                  |
| 2, 5 | 2                 | $0 + 54 + 4b3 = 54 + 12b$         |
|      | 3                 | $b8 + 30 + 2b3 = 14b + 30$        |
|      | 4                 | $18b + 0 + 5b3 = 33b              |

五区间：

| m    | k   | value                |
| ---- | --- | -------------------- |
| 1, 5 | 1   | $m[2, 5] + ab3$      |
|      | 2   | $ab4 + 54 + 4a3$     |
|      | 3   | $m[1, 3] + 30 + 2a3$ |
|      | 4   | $m[1, 4] + 5a3$      |

复习公式：

区间 $(1,5)$ 长度 = 5、分割点 $k=2$ 时的动态规划公式：最后一次把矩阵链

$$
A_1A_2\;\Bigl|\;A_3A_4A_5
$$

断在 $k=2$（即 $A_2$ 与 $A_3$ 之间）。

<div>
$$
m[1,5]_2
      = \underbrace{m[1,2]}_{\text{左子链}}
      + \underbrace{m[3,5]}_{\text{右子链}}
      + \underbrace{p_{0},p_{2},p_{5}}_{\text{“外壳”一次乘}}
$$
</div>

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

# 子序列

Run the dynamic programming algorithm to the longest common subsequence problem of sequences $(a, b, b, d, c, d, b, a)$ and $(a, b, d, c, a, b, c, d, a)$.

<details>

最长公共子序列问题，LCS 是衡量序列相似度的指标，允许跳过元素，但不能打乱顺序。

有序列

$$
X = (a, b, b, d, c, d, b, a)
$$

长度为 8

$$
Y = (a, b, d, c, a, b, c, d, a)
$$

长度为 9

递推公式：

设 $c[i][j]$ 为 $X[..i]$ 和 $Y[..j]$ 的最长公共子序列长度

- 如果 $X[i] = Y[j]$，那么 $c[i][j] = c[i-1][j-1] + 1$
- 如果 $X[i] \neq Y[j]$，那么 $c[i][j] = \max(c[i-1][j], c[i][j-1])$

不理解很正常，我们一步步拆解，先从短的来：

先画一个空表格，横轴 Y，纵轴 X，第一行和第一列都初始化为 0：

| x\y |     | a   | b   | d   | ... |
| --- | --- | --- | --- | --- | --- |
|     | 0   | 0   | 0   | 0   | ... |
| a   | 0   |     |     |     |     |
| b   | 0   |     |     |     |     |
| ... | ... |     |     |     |     |

要记住，每个格子只依赖左、上、左上。逐列来看

| j   | Yⱼ  | 比较 X₁ Yⱼ | 用到的旧值                           | $C[1][j]$    | 来源 |
| --- | --- | ---------- | ------------------------------------ | ------------ | ---- |
| 1   | a   | 相同       | $C[0][0] = 0$                        | $0 + 1 = 1$  | ↖︎   |
| 2   | b   | 不同       | 上：$C[0][2]=0$ <br> 左：$C[1][1]=1$ | $max(0,1)=1$ | ←    |
| 3   | d   | 不同       | 上：$C[0][3]=0$ <br> 左：$C[1][2]=1$ | 1            | ←    |

得到

| x\y |     | a   | b   | d   |
| --- | --- | --- | --- | --- |
|     | 0   | 0   | 0   | 0   |
| a   | 0   | 1   | 1   | 1   |
| b   | 0   |     |     |     |

第 1 行就是把首次出现的 1 向右复制。让我们继续：

| j   | Yⱼ  | 比较 X₂ Yⱼ | 用到的旧值                           | $C[2][j]$    | 来源 |
| --- | --- | ---------- | ------------------------------------ | ------------ | ---- |
| 1   | a   | 不同       | 上：$C[1][1]=1$ <br> 左：$C[2][0]=0$ | $max(1,0)=1$ | ↑    |
| 2   | b   | 相同       | $C[1][1]=1$                          | $1 + 1 = 2$  | ↖︎   |
| 3   | d   | 不同       | 上：$C[1][3]=1$ <br> 左：$C[2][2]=2$ | $max(1,2)=2$ | ←    |

得到

| x\y |     | a   | b   | d   |
| --- | --- | --- | --- | --- |
|     | 0   | 0   | 0   | 0   |
| a   | 0   | 1   | 1   | 1   |
| b   | 0   | 1   | 2   | 2   |

让我们简单的总结一下规律：

- 如果 XY 相同，左上角的值 + 1
- 如果 XY 不同，取上、左的最大值

很简单吧，最终我们得到

|     |     | a       | b       | d   | c   | a       | b       | c       | d       | a       |
| --- | --- | ------- | ------- | --- | --- | ------- | ------- | ------- | ------- | ------- |
|     | 0   | 0       | 0       | 0   | 0   | 0       | 0       | 0       | 0       | 0       |
| a   | 0   | **1 ↖** | 1 ←     | 1 ← | 1 ← | 1 ↖     | 1 ←     | 1 ←     | 1 ←     | 1 ↖     |
| b   | 0   | 1 ↑     | **2 ↖** | 2 ← | 2 ← | **2** ← | 2 ↖     | 2 ←     | 2 ←     | 2 ←     |
| b   | 0   | 1 ↑     | 2 ↖     | 2 ↑ | 2 ↑ | 2 ↑     | **3 ↖** | 3 ←     | 3 ←     | 3 ←     |
| d   | 0   | 1 ↑     | 2 ↑     | 3 ↖ | 3 ← | 3 ←     | **3** ↑ | 3 ↑     | 4 ↖     | 4 ←     |
| c   | 0   | 1 ↑     | 2 ↑     | 3 ↑ | 4 ↖ | 4 ←     | 4 ←     | **4 ↖** | 4 ↑     | 4 ↑     |
| d   | 0   | 1 ↑     | 2 ↑     | 3 ↖ | 4 ↑ | 4 ↑     | 4 ↑     | 4 ↑     | **5 ↖** | 5 ←     |
| b   | 0   | 1 ↑     | 2 ↖     | 3 ↑ | 4 ↑ | 4 ↑     | 5 ↖     | 5 ←     | **5** ↑ | 5 ↑     |
| a   | 0   | 1 ↖     | 2 ↑     | 3 ↑ | 4 ↑ | 5 ↖     | 5 ↑     | 5 ↑     | 5 ↑     | **6 ↖** |

沿着 ↖ 箭头一直往上回溯，不记录 ← 和 ↑，只记录 ↖，然后翻转，我们就能得到最长公共子序列了。

$$
LCS = (a, b, b, c, d, a)
$$

</details>

## 练习 1

X = (A, B, C, B, C, D, A, B)
Y = (D, A, A, B, C, B, A, A, B)

答案是 ABCBAB，做吧。

## 练习 2

给出一个动态规划解法，用于解决最长公共子序列问题，两个序列如下：

- X：$(a, b, c, b, a, b, c, b)$
- Y：$(b, a, c, b, b, a, c, c, b)$

# 背包问题

Run the dynamic programming algorithm to the knapsack problem for items:

| i     | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| ----- | --- | --- | --- | --- | --- | --- | --- |
| $w_i$ | 2   | 2   | 5   | 4   | 1   | 3   | 1   |
| $v_i$ | 10  | 50  | 40  | 80  | 70  | 10  | 20  |

and knapsack capacity 11.

<details>

0/1 背包问题，7 个物品不能分割，在不超过容量的情况下使价值最大化。

这一类问题都需要画 $dp[i][w]$ 表，考虑前 i 个物品，在容量为 w 时，获得的最大价值，我们的目标是 $dp[7][11]$。行是物品，列是容量，0 表示不选物品。

| i\w | 0   | 1   | 2   | 3   | 4   | ... | 11  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 0   | 0   | 0   | 0   | 0   | 0   | ... | 0   |
| 1   |     |     |     |     |     |     |     |
| 2   |     |     |     |     |     |     |     |
| ... |     |     |     |     |     |     |     |
| 7   |     |     |     |     |     |     |     |

对于第一个物品，重量 2，价值 10。w = 0 / 1 时背包装不下，而 w >= 2 时可以放下，价值为 10。

| i\w | 0   | 1   | 2   | 3   | 4   | ... | 11  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 1   | 0   | 0   | 10  | 10  | 10  | ... | 10  |

对于第二个物品，重量 2，价值 50。w = 0 / 1 时背包装不下，而 w >= 2 时可以放下，价值为 50。
第二个物品比前一个贵，所以选择第二个物品，否则就放第一个物品。

| i\w | 0   | 1   | 2   | 3   | 4   | ... | 11  |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 2   | 0   | 0   | 50  | 50  | 60  | ... | 60  |

那为什么在 4 列的时候不是 50 呢？因为在 3 的时候我们只能放 2，但是到 4 我们就可以放 1 和 2 了，所以 50 + 10 = 60，我们现在还不能放 2 以后的物品，如 5 或 7。

3 行的时候也是，前面看到放了 1，2，但是在 7 列的时候，我们可以将 1 换成 3，就是 90 了。继续往右，我们又可以把 1 放回去得到 100。

一直填到第七行第十一列，就是最大价值了。

| i\w | 0   | 1   | 2   | 3   | 4   | 5   | 6   | 7   | 8   | 9   | 10  | 11  |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   | 0   |
| 1   | 0   | 0   | 10  | 10  | 10  | 10  | 10  | 10  | 10  | 10  | 10  | 10  |
| 2   | 0   | 0   | 50  | 50  | 60  | 60  | 60  | 60  | 60  | 60  | 60  | 60  |
| 3   | 0   | 0   | 50  | 50  | 60  | 60  | 60  | 90  | 90  | 100 | 100 | 100 |
| 4   | 0   | 0   | 50  | 50  | 80  | 80  | 130 | 130 | 140 | 140 | 140 | 170 |
| 5   | 0   | 70  | 70  | 120 | 120 | 150 | 150 | 200 | 200 | 210 | 210 | 210 |
| 6   | 0   | 70  | 70  | 120 | 120 | 150 | 150 | 200 | 200 | 210 | 210 | 210 |
| 7   | 0   | 70  | 90  | 120 | 140 | 150 | 170 | 200 | 220 | 220 | 230 | 230 |

$dp[7][11] = 230$ 是最终结果。如果要回溯，则看 $dp[7][11]$ 和 $dp[6][11]$ 是否相同，如果不同，则说明第七个物品被选中。被选中后向左上看，没有被选中则向上。所以继续往上看 $dp[6][10]$ 与 $dp[5][10]$，与子序列题目类似。

</details>

## 练习

| i     | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| ----- | --- | --- | --- | --- | --- | --- | --- |
| $w_i$ | 3   | 4   | 1   | 3   | 2   | 1   | 1   |
| $v_i$ | 60  | 10  | 50  | 20  | 40  | 50  | 40  |

and knapsack capacity 11.

# 最大收益

Suppose you are managing a consulting team of expert computer hackers, and each week you have to choose a job for them to undertake. Now, as you can well imagine, the set of possible jobs is divided into those that are low-stress, and those that are high-stress. The basic question, each week, is whether to take on a low-stress job or a high-stress job. If you select a low-stress job for your team in week $i$, then you get a revenue of $l_i > 0$ dollars. If you select a high-stress job, you get a revenue of $h_i > 0$ dollars. The catch, however, is that in order for the team to take on a high-stress job in week $i$, it's required that they do no job in week $i - 1$. On the other hand, it's OK for the team to take a low-stress job in week $i$ even if they have done a job in week $i - 1$.

So, given a sequence of $n$ weeks, a plan is specified by a choice of low, high, none for each of the $n$ weeks, which the property that if high is chosen for week $i > 1$, the none has to be chose for week $i - 1$. (1st week can be high) The value of the plan is determined in the natural way: for each $i$ you add $(h/l/n)_i$ to the value of you chose high in week $i$. Give an efficient dynamic programming algorithm that take values for $l_1, l_2 \cdots l_n$ and $h_1, h_2 \cdots h_n$ and returns a plan of maximum value. Also give the running time of your algorithm.

<details>

低压工作可以连续做，做高压工作前必须休息。

还是一样列出 $dp[i]$ 表，表示到第 i 周的最大收益。我们有三种选择：

1. 选择低压力工作，收益 $l_i$，那么 $dp[i] = dp[i-1] + l_i$（上周收入加这周）
2. 选择高压力工作，收益 $h_i$，那么 $dp[i] = dp[i-2] + h_i$（上周不能工作）
3. 不选择工作，收益 0，$dp[i] = dp[i-1]$

假设 l 是 [1..5]，h 是 [6..10]，n = 5。填表的时候每次都找出最大值：

```python
dp[0] = 0
dp[1] = max(0 + l[1], h[1]) = max(1, 6) = 6

dp[2] = max(
    dp[1],               # 不做
    dp[1] + l[2],        # 做低压
    dp[0] + h[2]         # 做高压（前一周不能做）
) = max(6, 6+2, 0+7) = max(6, 8, 7) = 8
```

以此类推，得到

| i   | l[i] | h[i] | dp[i] | 选择 |
| --- | ---- | ---- | ----- | ---- |
| 0   | -    | -    | 0     | 无   |
| 1   | 1    | 6    | 6     | high |
| 2   | 2    | 7    | 8     | low  |
| 3   | 3    | 8    | 14    | high |
| 4   | 4    | 9    | 18    | low  |
| 5   | 5    | 10   | 24    | high |

反推从最后一行看选择，$dp[5] = dp[3] + h[5]$，所以第五周高，第四周休息，然后从第三周继续推，最后高-休-高-休-高。24 就是最大收益。算法是线性复杂度 O(n)。

为了容易回溯，我们还可以使用三维度 DP，同时计算三种工作的收益：

$dp[i][0] = \max(dp[i-1][0], dp[i-1][1], dp[i-1][2])$（不做工作）
$dp[i][1] = \max(dp[i-1][0], dp[i-1][1], dp[i-1][2]) + l_i$（做低压工作）
$dp[i][2] = dp[i-1][0] + h_i$（做高压工作）

</details>

# 回文

A **palindrome** is a nonempty string over some alphabet that reads the same forward and backward.
Examples of palindromes are **CIVIC**, **NOON**, and **AIBOHPHOBIA** (fear of palindromes).

Give an $O(n^2)$ **dynamic programming algorithm** that determines the **shortest string** which:

- is a **palindrome**, and
- contains a given string $s$ of length $n$ as a **subsequence**.

For example, given the string
$s = \text{TWENTYONE}$,
your algorithm might return the palindrome **TWENTOYOTNEWT**, because:

- it contains $s$ as a subsequence, and
- there is no shorter palindrome that satisfies this condition.

<details>

这种带左右两边状态的题，照样给出 $dp[i][j]$ 表，表示从第 i 个字符到第 j 个字符的最短回文，所有的对角线是自己。

每个格子：

- 如果 $s[i] = s[j]$，那么 $dp[i][j] = s[i] + dp[i+1][j-1] + s[j]$

左右相同，直接将其作为回文的两侧，继续处理中间部分

- 如果 $s[i] \neq s[j]$，那么

```python
dp[i][j] = min(s[i] + dp[i+1][j] + s[i],
               s[j] + dp[i][j-1] + s[j],
               key=len)
```

左右不同，有两种插法：在左边插一个右边的字母，或者在右边插一个左边的字母。我们取最短的结果。

| i\j | T   | W   | E   | N   | T   | Y   | O   |
| --- | --- | --- | --- | --- | --- | --- | --- |
| T   | T   |     |     |     |     |     |     |
| W   |     | W   |     |     |     |     |     |
| E   |     |     | E   |     |     |     |     |
| N   |     |     |     | N   |     |     |     |
| T   |     |     |     |     | T   |     |     |
| Y   |     |     |     |     |     | Y   |     |

看到 T 和 W 不同，则任选 TWT 或 WTW 填入 $d[0][1]$，以此类推

| i\j | T   | W   | E   | N   | T   | Y   | O   |
| --- | --- | --- | --- | --- | --- | --- | --- |
| T   | T   | TWT |     |     |     |     |     |
| W   |     | W   | WEW |     |     |     |     |
| E   |     |     | E   | ENE |     |     |     |
| N   |     |     |     | N   | NTN |     |     |
| T   |     |     |     |     | T   | TYT |     |
| Y   |     |     |     |     |     | Y   | YOY |

接下来看到 $dp[0][2]$，对应子串 $s[0..2]$，即 TWE，T 和 E 不同

```python
dp[0][2] = min(
    s[0] + dp[1][2] + s[0],
    s[2] + dp[0][1] + s[2],
    key=len
) = min(
    "T" + "WEW" + "T",
    "E" + "TWT" + "E",
    key=len
)
```

| i\j | T   | W   | E     | N     | T     | Y     | O     |
| --- | --- | --- | ----- | ----- | ----- | ----- | ----- |
| T   | T   | TWT | TWEWT |       |       |       |       |
| W   |     | W   | WEW   | WENEW |       |       |       |
| E   |     |     | E     | ENE   | ENTNE |       |       |
| N   |     |     |       | N     | NTN   | NTYTN |       |
| T   |     |     |       |       | T     | TYT   | TYOYT |
| Y   |     |     |       |       |       | Y     | YOY   |

简而言之，i 配 下面的，j 配 左边的，然后看哪个更短，都一样就随便选。

| i\j | T   | W   | E     | N       | T       | Y       | O       |
| --- | --- | --- | ----- | ------- | ------- | ------- | ------- |
| T   | T   | TWT | TWEWT | TWENEWT |         |         |         |
| W   |     | W   | WEW   | WENEW   | WENTNEW |         |         |
| E   |     |     | E     | ENE     | ENTNE   | ENTYTNE |         |
| N   |     |     |       | N       | NTN     | NTYTN   | NTYOYTN |
| T   |     |     |       |         | T       | TYT     | TYOYT   |
| Y   |     |     |       |         |         | Y       | YOY     |

最终得到

| i\j | T   | W   | E     | N       | T       | Y         | O           | N             | E             |
| --- | --- | --- | ----- | ------- | ------- | --------- | ----------- | ------------- | ------------- |
| T   | T   | TWT | ETWTE | NETWTEN | TNEWENT | YTNEWENTY | OYTNEWENTYO | NOYTNEWENTYON | TWENOTYTONEWT |
| W   |     | W   | EWE   | NEWEN   | TNEWENT | WENTYTNEW | OWENTYTNEWO | WENOTYTONEW   | WENOTYTONEW   |
| E   |     |     | E     | ENE     | ENTNE   | ENTYTNE   | ENOTYTONE   | ENOTYTONE     | ENOTYTONE     |
| N   |     |     |       | N       | NTN     | NTYTN     | NOTYTON     | NOTYTON       | ENOTYTONE     |
| T   |     |     |       |         | T       | TYT       | OTYTO       | NOTYTON       | ENOTYTONE     |

正确答案不止一个

</details>

# 序列比对

Run the dynamic programming algorithm to the optimal sequence alignment problem for sequences (d, a, a, b, c, b, a, d, c, b) and (b, d, a, c, b, b, d, a, c). Let the gap penalty g = 2, and let the replacement penalty r[x, y] = 3, if x and y are different characters, and 0 otherwise.

<details>

目标：在允许“替换”（mismatch）和“插入／删除”（gap）的前提下，将两个序列排成对齐的形式，使得整体得分（或“相似度”）最高，或编辑代价（编辑距离）最低。

表格与 LCS 类似，但得分不同，我们计算任意一个单元格在

1. 对齐 X 与 Y 的字符：从左上角取值
2. 替换 X 与 Y 的字符：从左上角取值 -3
3. 在 X 插入空白：从左边取值 -2
4. 在 Y 插入空白：从上面取值 -2

> 在哪插不重要，最大就行

情况的最大值并填入

| y\x |      | d     | a     | a     | b     | c     | b     | a     | d     | c     | b     |
| --- | ---- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
|     | 0    | -2←   | -4←   | -6←   | -8←   | -10←  | -12←  | -14←  | -16←  | -18←  | -20←  |
| b   | -2↑  | -3↖   | -5↖←  | -7↖←  | -6↖   | -8←   | -10↖← | -12←  | -14←  | -16←  | -18↖← |
| d   | -4↑  | -2↖   | -4←   | -6←   | -8↑←  | -9↖   | -11↖← | -13↖← | -12↖  | -14←  | -16←  |
| a   | -6↑  | -4↑   | -2↖   | -4↖←  | -6←   | -8←   | -10←  | -11↖  | -13←  | -15↖← | -17↖← |
| c   | -8↑  | -6↑   | -4↑   | -5↖   | -7↖←  | -6↖   | -8←   | -10←  | -12←  | -13↖  | -15←  |
| b   | -10↑ | -8↑   | -6↑   | -7↖↑  | -5↖   | -7←   | -6↖   | -8←   | -10←  | -12←  | -13↖  |
| b   | -12↑ | -10↑  | -8↑   | -9↖↑  | -7↖↑  | -8↖   | -7↖   | -9↖←  | -11↖← | -13↖← | -12↖  |
| d   | -14↑ | -12↖↑ | -10↑  | -11↖↑ | -9↑   | -10↖↑ | -9↑   | -10↖  | -9↖   | -11←  | -13←  |
| a   | -16↑ | -14↑  | -12↖↑ | -10↖  | -11↑  | -12↖↑ | -11↑  | -9↖   | -11↑← | -12↖  | -14↖← |
| c   | -18↑ | -16↑  | -14↑  | -12↑  | -13↖↑ | -11↖  | -13↑← | -11↑  | -12↖  | -11↖  | -13←  |

我们从右下角开始沿着箭头回溯，如果一个格子有两个箭头，任选一个就是一种最优方案。

</details>

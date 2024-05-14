---
title: DDA Endterm
toc: true
categories:
  - [Algorithm]
tags: [考试]
date: 2024-05-14 18:15:33
---

交张白卷上去，不愧是我

<!-- more -->

# 走棋盘

Suppose that you are given a $n \times n$ checkerboard and a checker. You must move the checker from the bottom edge of the board to the top edge of the board according to the following rules. At each step you may move the checker to one of three squares:

1. the square immediately above the current square.
2. the square that is one up and one to the left. (but only if the checker is not already in the leftmost column)
3. the square that is one up and one to the right. (but only if the checker is not already in the rightmost column)

Each time you move from square $x$ to square $y$, you receive $f(x, y)$ dollars. You are given $f(x, y)$ for all pairs $(x, y)$ for which a move from x to y is legal. Give an $O(n^2)$ dynamic programming algorithm that figures out the set of moves that will move the checker from somewhere along the bottom edge to somewhere along the top edge while gathering as many dollars as possible. Your algorithm is free to pick any square along the top edge as a destination in order to maximize the number of dollars gathered along the way.

## 解

https://github.com/juemura/amli/blob/master/Checkerboard.ipynb

# 最优参数

Give the dynamic programming solution to the optimal parameterization problem for them matrix product $A_1, A_2, A_3, A_4, A_5$ where the dimensions of $A_3$ are $4 \times 2$, the dimensions of $A_4$ are $2 \times 5$, and the dimensions of $A_5$ are $5 \times 3$. Show all calculations.

## 解

# 子序列

Run the dynamic programming algorithm to the longest common subsequence problem of sequences $(a, b, b, d, c, d, b, a)$ and $(a, b, d, c, a, b, c, d, a)$.

## 解

# 背包问题

Run the dynamic programming algorithm to the knapsack problem for items:

| i     | 1   | 2   | 3   | 4   | 5   | 6   | 7   |
| ----- | --- | --- | --- | --- | --- | --- | --- |
| $w_i$ | 2   | 2   | 5   | 4   | 1   | 3   | 1   |
| $v_i$ | 10  | 50  | 40  | 80  | 70  | 10  | 20  |

and knapsack capacity 11.

## 解

# 最大收益

Suppose you are managing a consulting team of expert computer hackers, and each week you have to choose a job for them to undertake. Now, as you can well imagine, the set of possible jobs is divided into those that are low-stress, and those that are high-stress. The basic question, each week, is whether to take on a low-stress job or a high-stress job. If you select a low-stress job for your team in week $i$, then you get a revenue of $l_i > 0$ dollars. If you select a high-stress job, you get a revenue of $h_i > 0$ dollars. The catch, however, is that in order for the team to take on a high-stress job in week $i$, it's required that they do no job in week $i - 1$. On the other hand, it's OK for the team to take a low-stress job in week $i$ even if they have done a job in week $i - 1$.

S0, given a sequence of $n$ weeks, a plan is specified by a choice of low, high, none for each of the $n$ weeks, which the property that if high is chosen for week $i > 1$, the none has to be chose for week $i - 1$. (1st week can be high) The value of the plan is determined in the natural way: for each $i$ you add $(h/l/n)_i$ to the value of you chose high in week $i$. Give an efficient dynamic programming algorithm that take values for $l_1, l_2 \cdots l_n$ and $h_1, h_2 \cdots h_n$ and returns a plan of maximum value. Also give the running time of your algorithm.

## 解

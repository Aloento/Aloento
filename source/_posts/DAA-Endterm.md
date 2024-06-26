---
title: DAA Endterm
toc: true
categories:
  - [Algorithm]
tags: [考试]
date: 2024-05-14 18:15:33
---

交张白卷上去，不愧是我

<!-- more -->

# 网格最大成本寻路

Suppose that you are given a $n \times n$ checkerboard and a checker. You must move the checker from the bottom edge of the board to the top edge of the board according to the following rules. At each step you may move the checker to one of three squares:

1. the square immediately above the current square.
2. the square that is one up and one to the left. (but only if the checker is not already in the leftmost column)
3. the square that is one up and one to the right. (but only if the checker is not already in the rightmost column)

Each time you move from square $x$ to square $y$, you receive $f(x, y)$ dollars. You are given $f(x, y)$ for all pairs $(x, y)$ for which a move from x to y is legal. Give an $O(n^2)$ dynamic programming algorithm that figures out the set of moves that will move the checker from somewhere along the bottom edge to somewhere along the top edge while gathering as many dollars as possible. Your algorithm is free to pick any square along the top edge as a destination in order to maximize the number of dollars gathered along the way.

## 解

https://github.com/juemura/amli/blob/master/Checkerboard.ipynb

这题说白了就是让你计算一个矩阵，每次只能往上临近的地方走一格，每走一次有一个 f 方程给你计算收益，让你求出最大收益的路径。

这道题没有给出 f 的定义，所以我们自己定个规则：随机给每个格子填一个值，这个值可大可小，可正可负，走到格子上就把格子的值加到最终收益上。

```ts
import { random } from "lodash";

function makeMatrix(dim: number) {
  const matrix: number[][] = [];

  for (let i = 0; i < dim; i++) {
    matrix.push([]);
    for (let j = 0; j < dim; j++) {
      matrix[i].push(random(-100, 100));
    }
  }

  return matrix;
}
```

<details>
  <summary>打印矩阵的代码</summary>

```ts
function printMatrix(matrix: number[][]) {
  let res = "|X\\Y|";

  for (let i = 0; i < matrix.length; i++) {
    res += i + "|";
  }

  res += "\n|---|";
  for (let i = 0; i < matrix.length; i++) {
    res += "---|";
  }

  res += "\n";

  for (let i = 0; i < matrix.length; i++) {
    res += `|**${i}**|${matrix[i].join("|")}|`;
    res += "\n";
  }

  console.log(res);
}
```

</details>

随后，我们得到矩阵

| X\Y   | 0   | 1   | 2   | 3   | 4   |
| ----- | --- | --- | --- | --- | --- |
| **0** | -60 | 51  | -24 | -4  | -66 |
| **1** | 45  | 12  | 76  | -41 | -22 |
| **2** | -50 | 19  | -79 | 47  | 96  |
| **3** | -74 | -12 | 98  | 54  | 1   |
| **4** | -66 | 16  | 91  | -87 | -20 |

接下来要做的事情就很明显了：计算局部最优的转移过程的累加收益
（说的玄乎，看代码马上就懂了，也就是每次转移都找收益最大的那个来源）

要注意，正向转移是不可能计算的，所以我们每次计算的都是从哪里来的，而不是去哪里。

```ts
function calcDifference(matrix: number[][]) {
  const n = matrix.length;
  // 用来存储每个格子的最大值
  const aggregate: number[][] = Array.from({ length: n }, () =>
    Array(n).fill(0)
  );
  // 用 matrix 填充第一行，因为没有格子可以从上方移动来
  for (let col = 0; col < n; col++) {
    aggregate[0][col] = matrix[0][col];
  }

  // 从第二行开始填充 maxDiff
  for (let row = 1; row < n; row++) {
    // 遍历当前行的每一个格子
    for (let col = 0; col < n; col++) {
      let fromLeft = -Infinity;
      let fromTop = -Infinity;
      let fromRight = -Infinity;

      // 如果当前格子不在第一列，那么可以从左上移动来
      if (col > 0) {
        fromLeft = aggregate[row - 1][col - 1] + matrix[row][col];
      }

      // 从正上方移动来
      fromTop = aggregate[row - 1][col] + matrix[row][col];

      // 如果当前格子不在最后一列，那么可以从右上移动来
      if (col < n - 1) {
        fromRight = aggregate[row - 1][col + 1] + matrix[row][col];
      }

      // 计算当前格子的最大值
      aggregate[row][col] = Math.max(fromLeft, fromTop, fromRight);
    }
  }

  return aggregate;
}
```

我们得到

| X\Y   | 0   | 1   | 2   | 3   | 4   |
| ----- | --- | --- | --- | --- | --- |
| **0** | -60 | 51  | -24 | -4  | -66 |
| **1** | 96  | 63  | 127 | -45 | -26 |
| **2** | 46  | 146 | 48  | 174 | 70  |
| **3** | 72  | 134 | 272 | 228 | 175 |
| **4** | 68  | 288 | 363 | 185 | 208 |

接下来我们追踪最大值的路径，这里我们只需要找到最后一行的最大值，然后从这个最大值开始往上找，将 DP 值最大的一个作为路径的下一个点，直到找到第一行。

```ts
function traceBack(aggregate: number[][]) {
  const n = aggregate.length;
  const path: [number, number][] = [];

  let stopIndex = 0;

  aggregate[n - 1].forEach((val, index) => {
    if (val > aggregate[n - 1][stopIndex]) {
      stopIndex = index;
    }
  });

  path.push([n - 1, stopIndex]);

  let currentCol = stopIndex;

  for (let row = n - 2; row >= 0; row--) {
    let fromLeft = -Infinity;
    let fromTop = -Infinity;
    let fromRight = -Infinity;

    if (currentCol > 0) {
      fromLeft = aggregate[row][currentCol - 1];
    }

    fromTop = aggregate[row][currentCol];

    if (currentCol < n - 1) {
      fromRight = aggregate[row][currentCol + 1];
    }

    if (fromLeft > fromTop && fromLeft > fromRight) {
      currentCol -= 1;
    } else if (fromRight > fromTop && fromRight > fromLeft) {
      currentCol += 1;
    }

    path.push([row, currentCol]);
  }

  return path;
}
```

我们得到路径

| Path | (X, Y) |
| ---- | ------ |
| 4    | 2      |
| 3    | 2      |
| 2    | 3      |
| 1    | 2      |
| 0    | 1      |

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

So, given a sequence of $n$ weeks, a plan is specified by a choice of low, high, none for each of the $n$ weeks, which the property that if high is chosen for week $i > 1$, the none has to be chose for week $i - 1$. (1st week can be high) The value of the plan is determined in the natural way: for each $i$ you add $(h/l/n)_i$ to the value of you chose high in week $i$. Give an efficient dynamic programming algorithm that take values for $l_1, l_2 \cdots l_n$ and $h_1, h_2 \cdots h_n$ and returns a plan of maximum value. Also give the running time of your algorithm.

## 解

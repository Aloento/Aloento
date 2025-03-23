---
title: DAA Midterm Revision
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
date: 2025-03-19 11:14:01
---

~~重修此课喜提 60 元账单~~

<!-- more -->

# Gale-Shapley

算法在 $(n - 1)^2 + 1$ 天内结束

## 习题 1

| Girl |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
| g1   | b3  | b5  | b2  | b1  | b4  |
| g2   | b5  | b2  | b1  | b4  | b3  |
| g3   | b4  | b3  | b5  | b1  | b2  |
| g4   | b1  | b2  | b3  | b4  | b5  |
| g5   | b2  | b3  | b4  | b1  | b5  |

| Boys |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
| b1   | g3  | g2  | g5  | g1  | g4  |
| b2   | g1  | g2  | g5  | g3  | g4  |
| b3   | g4  | g3  | g2  | g1  | g5  |
| b4   | g1  | g3  | g4  | g2  | g5  |
| b5   | g1  | g2  | g4  | g5  | g3  |

[解题方法复习](https://aloen.to/Algorithm/Stable-Marriage-Problem/#%E5%8C%B9%E9%85%8D%E9%A2%98)

## 习题 2

有 n 名男演员和 n 名女演员，其中，有 k 名高个男演员和 k 名金发女演员。每位男演员都更喜欢金发女演员，每位女演员都更喜欢高个男演员。请证明，在稳定匹配中，高个男演员会匹配金发女演员，矮个男演员会匹配非金发女演员。

[题解](https://aloen.to/Algorithm/Stable-Marriage-Problem/#%E9%87%91%E5%8F%91%E9%85%8D%E9%AB%98%E4%B8%AA)

<details>
假设有稳定匹配 (b_矮个, g_金发)，由于男女数量相同，必定有 (b_高个, g_黑发)。但根据规则，高个更喜欢金发，所以 (b_高个, g_金发) 是 rogue copule，与稳定匹配矛盾。
</details>

## 习题 3

证明如果所有女生的偏好列表都相同，那么只存在唯一的稳定匹配。

<details>
假设有两组稳定匹配，A / B，有 (g, b)_A 和 (g, b')_B。由于所有女生的偏好列表相同，所以匹配完全由男生的偏好列表决定。若要让 g 能够与 b' 匹配，则必定所有女生都更喜欢 b' 而不是 b，这就导致在 A 中产生了 (g, b') 的 rogue couple，与 A 的稳定性矛盾。
</details>

## 习题 4

证明不存在任何一种匹配（无论是否稳定），使得所有男生都比使用 Gale-Shapley 算法时的匹配结果更好。

<details>
设有匹配，使得所有男生都获得了比 GS 更好的结果，这意味着每个男生都与他匹配列表中更高的女孩匹配了，所以至少有一个男生与在 GS 算法中拒绝过他的女生匹配。但根据 GS 的规则，算法结束时每个男生都无法与他偏好列表中更高位的女生配对，因为她一定在某个时刻拒绝了他，并跟她更喜欢的男生匹配。所以如果一定要让一个男生获得更好的匹配，那么必定要拆散已经存在的匹配，这就导致另一个男生无法得到他更喜欢的女生。
</details>

## 习题 5

在每个稳定婚姻问题的实例中，是否必定存在一个合适的匹配，其中包含一对 $(b, g)$，使得 $ b $ 在 $ g $ 的偏好列表中排名第一，且 $ g $ 在 $ b $ 的偏好列表中排名第一？

<details>
并不，考虑以下情况 (12 21 21 12)

B_1 -> (G_1, G_2)，B_2 -> (G_2, G_1) 和
G_1 -> (B_2, B_1)，G_2 -> (B_1, B_2)。

有稳定匹配 (B_1, G_1)，(B_2, G_2) 和 (B_1, G_2)，(B_2, G_1)。它们均不同时是双方的第一选择。
</details>

## 习题 6

考虑一个稳定婚姻问题的实例，其中存在一名男生 $ b $ 和一名女生 $ g $，使得 $ b $ 在 $ g $ 的偏好列表中排名第一，且 $ g $ 在 $ b $ 的偏好列表中排名第一。那么，在该实例的任何稳定匹配 $ M $ 中，配对 $ (b, g) $ 是否都属于 $ M $？

<details>
是的。设存在 M'，有稳定匹配 (b, g')，那么一定存在 (b', g)。但由于 g 与 b 都相互最喜欢，则导致 (b, g)是 rogue couple，与稳定性矛盾。
</details>

## 算法实例

```ts
function validateInput(
  boysPreferences: string[][],
  girlsPreferences: string[][]
): void {
  const n = boysPreferences.length;
  if (n !== girlsPreferences.length) {
    throw new Error("男孩和女孩的数量必须相等。");
  }

  const boys = new Set<string>();
  const girls = new Set<string>();
  for (let i = 0; i < n; i++) {
    boys.add(`b${i + 1}`);
    girls.add(`g${i + 1}`);
  }

  for (let i = 0; i < n; i++) {
    const boyPref = boysPreferences[i];
    if (boyPref.length !== n) {
      throw new Error(`男孩 b${i + 1} 的偏好列表长度必须等于总数。`);
    }
    const boyPrefSet = new Set(boyPref);
    if (
      boyPrefSet.size !== n ||
      !Array.from(boyPrefSet).every((g) => girls.has(g))
    ) {
      throw new Error(`男孩 b${i + 1} 的偏好列表不完整或包含重复。`);
    }

    const girlPref = girlsPreferences[i];
    if (girlPref.length !== n) {
      throw new Error(`女孩 g${i + 1} 的偏好列表长度必须等于总数。`);
    }
    const girlPrefSet = new Set(girlPref);
    if (
      girlPrefSet.size !== n ||
      !Array.from(girlPrefSet).every((b) => boys.has(b))
    ) {
      throw new Error(`女孩 g${i + 1} 的偏好列表不完整或包含重复。`);
    }
  }
}

function getIndex(id: string): number {
  return parseInt(id.substring(1)) - 1;
}

function findStableMatching(
  boysPreferences: string[][],
  girlsPreferences: string[][]
): Map<string, string> {
  validateInput(boysPreferences, girlsPreferences);

  const n = boysPreferences.length;
  const boyToGirl = new Map<string, string>();
  const girlToBoy = new Map<string, string>();
  const freeBoys: string[] = [];
  for (let i = 0; i < n; i++) {
    freeBoys.push(`b${i + 1}`);
  }

  // 预处理女孩的偏好排名
  const girlRankings = new Map<string, Map<string, number>>();
  for (let i = 0; i < n; i++) {
    const girl = `g${i + 1}`;
    const ranking = new Map<string, number>();
    for (let j = 0; j < girlsPreferences[i].length; j++) {
      const boy = girlsPreferences[i][j];
      ranking.set(boy, j);
    }
    girlRankings.set(girl, ranking);
  }

  while (freeBoys.length > 0) {
    const boy = freeBoys.shift()!;
    const preferences = boysPreferences[getIndex(boy)];

    for (const girl of preferences) {
      if (!girlToBoy.has(girl)) {
        // 女孩未匹配
        boyToGirl.set(boy, girl);
        girlToBoy.set(girl, boy);
        break;
      } else {
        const currentBoy = girlToBoy.get(girl)!;
        const ranking = girlRankings.get(girl)!;
        const currentRank = ranking.get(currentBoy)!;
        const newRank = ranking.get(boy)!;

        if (newRank < currentRank) {
          // 女孩更喜欢当前男孩
          boyToGirl.delete(currentBoy);
          girlToBoy.delete(girl);
          boyToGirl.set(boy, girl);
          girlToBoy.set(girl, boy);
          freeBoys.push(currentBoy);
          break;
        }
      }
    }
  }

  return boyToGirl;
}

const boysPreferences: string[][] = [
  ["g2", "g4", "g3", "g1", "g5"], // b1 的偏好
  ["g3", "g2", "g1", "g5", "g4"], // b2 的偏好
  ["g2", "g1", "g3", "g5", "g4"], // b3 的偏好
  ["g4", "g3", "g5", "g1", "g2"], // b4 的偏好
  ["g2", "g4", "g3", "g1", "g5"], // b5 的偏好
];

const girlsPreferences: string[][] = [
  ["b2", "b5", "b1", "b3", "b4"], // g1 的偏好
  ["b2", "b3", "b1", "b4", "b5"], // g2 的偏好
  ["b4", "b2", "b5", "b1", "b3"], // g3 的偏好
  ["b3", "b1", "b5", "b2", "b4"], // g4 的偏好
  ["b5", "b3", "b4", "b1", "b2"], // g5 的偏好
];

// 调用稳定匹配算法
const stableMatching = findStableMatching(boysPreferences, girlsPreferences);

// 输出匹配结果
console.log("稳定匹配结果：");
for (const [boy, girl] of stableMatching.entries()) {
  console.log(`${boy} ↔ ${girl}`);
}
```

# Master Method

[复习](https://aloen.to/Algorithm/Master-Method/#%E5%AE%9A%E4%B9%89)

$T(n) = 2T(n/2) + n^3$

$T(n) = T(9n/10) + n$

$T(n) = 16T(n/4) + n^2$

$T(n) = 7T(n/3) + n^2$

$T(n) = 7T(n/2) + n^2$

$T(n) = 2T(n/4) + \sqrt{n}$

# Divide and Conquer

[题解](https://aloen.to/Algorithm/DAA-Midterm-Exam/#Significant-Inversion)

## 习题 1

我们给定一个正整数数组 → $ A[1:n] $

找到满足 $ 1 \leq i \leq j \leq n $ 的索引，使得 $ A[j] - A[i] $ 最大。

朴素算法：  
枚举所有可能的 $ (i, j) $ 组合，并计算 $ A[j] - A[i] $，然后选择其中的最大值  
→ 该算法的时间复杂度为 $ O(n^2) $

改进方法：

- 使用 分治法 得到 $ O(n \log n) $ 时间复杂度的算法
- 进一步优化该算法，使其达到 $ O(n) $ 时间复杂度

## 习题 2

我们给定一个整数数组（可能包含负数） → $ A[1:n] $

找到满足 $ 1 \leq i \leq j \leq n $ 的索引，使得 子数组和 $ A[i] + A[i+1] + \dots + A[j] $ 最大。

朴素算法：  
枚举所有可能的 $ (i, j) $ 组合，计算 子数组和 $ A[i] + A[i+1] + \dots + A[j] $，然后选择其中的最大值  
→ 时间复杂度为 $ O(n^3) $

优化方法：

- 使用 分治法 得到 $ O(n \log n) $ 时间复杂度的算法
- 进一步优化该算法，使其达到 $ O(n) $ 时间复杂度

## 习题 3

我们给定一个包含任意对象的数组 $ A[1:n] $。如果某个对象 $ x $ 在 $ A[1:n] $ 中出现的次数 多于 $ n/2 $ 次，则称其为 多数元素（majority element）。

- 当 $ n = 10 $ 时，至少需要出现 6 次 才能成为多数元素
- 当 $ n = 17 $ 时，至少需要出现 9 次 才能成为多数元素
- 当 $ n = 1 $ 时，唯一的元素即为多数元素

显然，在 $ A[1:n] $ 中最多只能存在 一个 多数元素。

任务：设计 D&C 算法，判断 $ A[1:n] $ 是否包含多数元素。

## 习题 4

我们给定一个长度为 $ n $ 的数列 $ a_1, a_2, \dots, a_n $，假设所有数都互不相同。我们定义一个 逆序对 为满足 $ i < j $ 且 $ a_i > a_j $ 的一对索引 $ (i, j) $。

我们最初将 逆序对计数 作为衡量两个排列之间差异程度的一个指标。然而，有人可能会认为这个度量过于敏感。因此，我们引入一个新的概念，称为 “显著逆序对”，即当满足：

$$
i < j \quad \text{且} \quad a_i > 2a_j
$$

的索引对 $ (i, j) $ 被称为 显著逆序对。

任务：设计一个 $ O(n \log n) $ 的 分治算法 来计算一个序列 $ a_1, a_2, \dots, a_n $ 中的显著逆序对的数量。

## 习题 5

最近点对问题（Closest pair of points in the plane）

我们有一个 平面点集：$\mathcal{P} = \{ p_1, p_2, \dots, p_n \}$ 我们的目标是找到 距离最小的两点对。

朴素解法：

- 枚举所有点对，计算其距离，并找到最小距离。
- 该方法的时间复杂度为： $O(n^2)$

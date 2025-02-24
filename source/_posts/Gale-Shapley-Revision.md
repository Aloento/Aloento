---
title: Gale-Shapley Revision
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
date: 2025-02-19 11:14:01
---

~~我重生了，这一次我一定要夺回属于我的一切~~

<!-- more -->

# 算法实例

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

---
title: Turing Machines
date: 2022-12-15 19:06:00
toc: true
categories:
  - [Algorithm, TM]
tags: [图灵机, 算法, 习题]
---

~~自动寄~~

<!-- more -->

# 删除 010

创建一个图灵机，它复制二进制输入到输出，并删除所有的 010

## 思路

Start：初始状态，负责检查输入符号序列的第一个符号是否为 0

A：如果在 Start 状态检查到输入符号为 0，状态机会转移到 A 状态，并检查输入符号序列的第二个符号是否为 1

B：如果在 A 状态检查到输入符号序列的第二个符号为 1，状态机会转移到 B 状态，并检查输入符号序列的第三个符号是否为 0

Delete：如果在 B 状态检查到输入符号序列的第三个符号为 0，状态机会转移到 Delete 状态，此时会将输入符号序列中的前三个符号删除，并转移到 Start 状态

Copy：如果在 A 或 B 状态检查到输入符号序列的第二个或第三个符号不为 1 或 0，状态机会转移到 Copy 状态，此时会将输入符号序列中的第一个符号复制到结果符号序列，并将输入符号序列和结果符号序列的指针都向右移动一个位置，并转移到 Start 状态

## 代码

| States | Start | End  | Tape Head | Position |
| ------ | ----- | ---- | --------- | -------- |
| Start  | Start | Stop | A0        | 0        |
| A      |       |      | B0        | 0        |
| B      |
| Copy   |
| Stop   |

```tms
// 处理 0 开头，转到 A
[Start; 0; SP]->[A; ANY; ANY; >; S]
// 处理 1 开头，直接复制
[Start; 1; SP]->[Start; ANY; 1; >; >]
// 为空，结束
[Start; SP; SP]->[Stop; ANY; ANY; S; S]

// 在 0 1 _ 时，转 B
[A; 1; SP]->[B; ANY; ANY; >; S]
// 在 0 0 _ 时，写入 0，转 Start
[A; 0; SP]->[Start; ANY; 0; S; >]
// 在 0 0 S 时，写入 0，结束
[A; SP; SP]->[Stop; ANY; 0; S; >]

// 在 0 1 0 时，略过，回到 Start
[B; 0; SP]->[Start; ANY; ANY; >; S]
// 在 0 1 1 时，将 0 复制，转 Copy 1
[B; 1; SP]->[Copy; ANY; 0; S; >]
// 在 0 1 S 时，将 0 复制，转 Copy 1
[B; SP; SP]->[Copy; ANY; 0; S; >]

// Copy 1
[Copy; ANY; SP]->[Start; ANY; 1; S; >]
```

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

# 把 00 变成 \#\#

但是不处理超过 2 个 0 的情况

| States  | Start | End  | Tape Head | Position |
| ------- | ----- | ---- | --------- | -------- |
| Start   | Start | Stop | A0        | 0        |
| Zero1   |
| Zero2   |
| FindOne |
| Trans   |
| Trans2  |
| Stop    |

```tms
// 0 _ 转 Zero1
[Start; 0]->[Zero1; 0; >]
// 1 _ 回到开始
[Start; 1]->[Start; 1; >]
// 为空，结束
[Start; SP]->[Stop; SP; S]

// 0 0 _ 继续计数
[Zero1; 0]->[Zero2; 0; >]
// 0 1 _ 回到开始
[Zero1; 1]->[Start; 1; >]
// 0 S 结束
[Zero1; SP]->[Stop; SP; S]

// 0 0 0 不处理
[Zero2; 0]->[FindOne; 0; >]
// 0 0 1 变换前两个为 #
[Zero2; 1]->[Trans; 1; 2*<]
// 0 0 S 变换前两个为 #
[Zero2; SP]->[Trans; SP; 2*<]

// 第一次写入
[Trans; 0]->[Trans2; #; >]
// 第二次写入
[Trans2; 0]->[Start; #; >]

// 找到下一个 1
[FindOne; 1]->[Start; 1; >]
// 仍然是 0
[FindOne; 0]->[FindOne; 0; >]
// 结束
[FindOne; SP]->[Stop; SP; S]
```

# 011 变 ABCD

| States | Start | End  | Tape Head | Position |
| ------ | ----- | ---- | --------- | -------- |
| Start  | Start | Stop | A0        | 0        |
| Zero   |       |      | B0        | 0        |
| One    |
| Copy   |
| BCD    |
| CD     |
| D      |
| Stop   |

```tms
// 0 _ 计数
[Start; 0; SP]->[Zero; 0; SP; >; S]
// 1 _ 复制
[Start; 1; SP]->[Start; 1; 1; >; >]
// 为空，结束
[Start; SP; SP]->[Stop; SP; SP; S; S]

// 0 1 _ 计数
[Zero; 1; SP]->[One; 1; SP; >; S]
// 0 0 _ 复制 0，回到开始
[Zero; 0; SP]->[Start; 0; 0; S; >]
// 0 S 复制 0，停止
[Zero; SP; SP]->[Stop; SP; 0; S; >]

// 0 1 1 变换，写入 A
[One; 1; SP]->[BCD; 1; A; S; >]
// 0 1 0 复制 0，转 Copy 1
[One; 0; SP]->[Copy; 0; 0; <; >]
// 0 1 S 复制 0，转 Copy 1
[One; SP; SP]->[Copy; SP; 0; <; >]

// 写入 B
[BCD; ANY; SP]->[CD; ANY; B; S; >]
// 写入 C
[CD; ANY; SP]->[D; ANY; C; S; >]
// 写入 D，回到开始
[D; ANY; SP]->[Start; ANY; D; >; >]

// Copy 0
[Copy; 0; SP]->[Start; 0; 0; >; >]
// Copy 1
[Copy; 1; SP]->[Start; 1; 1; >; >]
```

# 多个 1 变一个 1

| States | Start | End  | Tape Head | Position |
| ------ | ----- | ---- | --------- | -------- |
| Start  | Start | Stop | A0        | 0        |
| One    |       |      | B0        | 0        |
| Stop   |

```tms
// 0 复制
[Start; 0; SP]->[Start; 0; 0; >; >]
// 1 复制并计数
[Start; 1; SP]->[One; 1; 1; >; >]
// 为空，停止
[Start; SP; SP]->[Stop; SP; SP; S; S]

// 1 0 复制，回到开始
[One; 0; SP]->[Start; 0; 0; >; >]
// 1 1 找到下一个 0
[One; 1; SP]->[One; 1; ANY; >; S]
// 1 S 停止
[One; SP; SP]->[Stop; SP; SP; S; S]
```

# 11 变 112

| States | Start | End  | Tape Head | Position |
| ------ | ----- | ---- | --------- | -------- |
| Start  | Start | Stop | A0        | 0        |
| One    |       |      | B0        | 0        |
| Two    |
| Stop   |

```tms
// 0 复制
[Start; 0; SP]->[Start; 0; 0; >; >]
// 1 复制并计数
[Start; 1; SP]->[One; 1; 1; >; >]
// 为空，停止
[Start; SP; SP]->[Stop; SP; SP; S; S]

// 1 1 添加 2
[One; 1; SP]->[Two; 1; 1; S; >]
// 1 0 复制并回到开始
[One; 0; SP]->[Start; 0; 0; >; >]
// 1 S 停止
[One; SP; SP]->[Stop; SP; SP; S; S]

// +2s
[Two; ANY; SP]->[Start; ANY; 2; >; >]
```

# 0000... 变 4444...

| States | Start | End  | Tape Head | Position |
| ------ | ----- | ---- | --------- | -------- |
| Start  | Start | Stop | A0        | 0        |
| One    |
| Two    |
| Three  |
| Trans  |
| Stop   |

```tms
// 0，计数
[Start; 0]->[One; 0; >]
// 1，跳过
[Start; 1]->[Start; 1; >]
// 为空，停止
[Start; SP]->[Stop; SP; S]

// 0 0
[One; 0]->[Two; 0; >]
// 0 1 回
[One; 1]->[Start; 1; >]
// 0 S 停止
[One; SP]->[Stop; SP; S]

// 0 0 0
[Two; 0]->[Three; 0; >]
// 0 0 1
[Two; 1]->[Start; 1; >]
// 0 0 S 停止
[Two; SP]->[Stop; SP; S]

// 0 0 0 0，转换
[Three; 0]->[Trans; 4; 3*<]
// 0 0 0 1 回
[Three; 1]->[Start; 1; >]
// 0 0 0 S 停止
[Three; SP]->[Stop; SP; S]

// 4 0 0 4
[Trans; 0]->[Trans; 4; >]
// Stop Trans
[Trans; 4]->[Start; ANY; >]
```

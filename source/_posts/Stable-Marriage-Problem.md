---
title: Stable Marriage Problem
date: 2024-02-13 16:30:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

~~研究生学习开始啦~~

本文是 Design and Analysis of Algorithms 的一部分

这节课介绍了一些著名的问题解决方案及其典型算法，并且还有它们的实践内容

<!-- more -->

# Problem Description

- 有 n 个男人和 n 个女人
- 每个人都有一个 preference list，即对另一性别的人的偏好排序
- 问题：如何匹配男女，使得每个人都能得到满意的匹配？(稳定)

稳定：不存在一对男女，他们之间相互更喜欢。换言之，不存在一对男人和女人，他们都更喜欢对方而不是他们当前的配偶。

如不稳定，则称其为 rogue / vogue couple ~~(为什么要叫这个名)~~

如果我们允许同性恋，那么这个问题就是 Stable Roommates Problem，在这种情况下 **没有** 稳定匹配

## Unisex Case

让我们来看一个不可能进行稳定匹配的例子，它需要与第四个人创造一个三角恋

A -> B / D / C
B -> D / A / C
C -> N/A
D -> A / B / C

C 的喜好无关紧要，因为 C 是每个人的最后选择

### Proof

让我们假设存在稳定匹配：

1. 有 [A, D]
2. 那么另一对必然是 [B, C]
3. 但是 A 相比 D 更喜欢 B，B 相比 C 更喜欢 A
4. 所以 [A, B] 应该是一对
5. 那么 [C, D] 就是另一对
6. 但是 B 相比 A 更喜欢 D，D 相比 C 更喜欢 B
7. ...... 无限循环

所以不存在稳定匹配

但是在 bipartite graph (二分图) 中，我们一定可以找到稳定匹配

# Gale-Shapley Algorithm

也叫 Deferred Acceptance 算法

## Steps

1. 每个男人都向他的首选求婚
2. 每个女人都暂时选择她当前最喜欢的求婚者，拒绝其他人
3. 每个被拒绝的男人向他的下一个选择求婚
4. 重复步骤 2 和 3，直到每个女人都接受了一个求婚者

## Analysis

女人在每一轮接受的求婚都是临时的，这就是为什么此算法又叫 Deferred Acceptance 延迟接受 的原因。

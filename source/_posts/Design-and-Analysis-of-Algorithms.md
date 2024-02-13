---
title: Design and Analysis of Algorithms
date: 2024-02-13 16:30:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

~~研究生学习开始啦~~

这节课介绍了一些著名的问题解决方案及其典型算法，并且还有它们的实践内容

<!-- more -->

# Stable Marriage Problem

## Problem Description

- 有 n 个男人和 n 个女人
- 每个人都有一个 preference list，即对另一性别的人的偏好排序
- 问题：如何匹配男女，使得每个人都能得到满意的匹配？(稳定)

稳定：不存在一对男女，他们之间相互更喜欢。换言之，不存在一对男人和女人，他们都更喜欢对方而不是他们当前的配偶。

## Gale-Shapley Algorithm

也叫 Deferred Acceptance 算法

### Steps

1. 每个男人都向他的首选求婚
2. 每个女人都暂时选择她当前最喜欢的求婚者，拒绝其他人
3. 每个被拒绝的男人向他的下一个选择求婚
4. 重复步骤 2 和 3，直到每个女人都接受了一个求婚者

### Analysis

女人在每一轮接受的求婚都是临时的，这就是为什么此算法又叫 Deferred Acceptance 延迟接受 的原因。

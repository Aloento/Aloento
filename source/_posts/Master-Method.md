---
title: Master Method
date: 2024-02-29 09:30:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

本文是 Design and Analysis of Algorithms 的一部分

~~本节课一上来就给我搞了一个新概念让我措手不及，完全听不懂~~

<!-- more -->

# 前置知识

在学习~~可以手搓魔法阵的~~大师方法之前，我们需要一些前置知识

## 时间复杂度

在 [很久之前](https://aloen.to/Algorithm/Basics-of-Computer-Science/#%E6%97%B6%E9%97%B4%E5%A4%8D%E6%9D%82%E5%BA%A6) 我就写过关于时间复杂度的内容

我们做复杂度分析的时候，考虑的因变量只有问题规模，而不是具体输入  
无论哪种记法，默认是取最坏情况来分析

### 大 O 与 渐进分析

用 大 O 表示的复杂度，就叫渐进复杂度  
我们常说的分析复杂度，其实就是分析渐进复杂度

它忽略了复杂度的常数倍差别，更关心 “算法所需要的资源，随问题规模增长而增长的速度”

且 O 表达的是**低阶于**，即算法的复杂度不会超过这个值
比如，对于一个 O(1) 的算法，你要说它是 O(n) 也没错，只不过你的上限不够**紧致**

所以，$O$ 是上限，$\Omega$ 是下限，$\Theta$ 是上下限相同（即确定就在这一阶）

## 递归分治算法

一个典型的例子就是 [Merge Sort](https://aloen.to/Algorithm/Basics-of-Computer-Science/#%E5%BD%92%E5%B9%B6%E6%8E%92%E5%BA%8F)

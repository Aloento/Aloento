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

这类问题无法使用 greedy 或者 induction (or recursion) 算法解决，所以我们需要

# Gale-Shapley Algorithm

也叫 Deferred Acceptance 算法

## Steps

1. 每个男人都向他的首选求婚
2. 每个女人都暂时选择她当前最喜欢的求婚者，拒绝其他人
3. 每个被拒绝的男人向他的下一个选择求婚
4. 重复步骤 2 和 3，直到每个女人都接受了一个求婚者

我们将每一轮定义为一天  
女人在每一轮接受的求婚都是临时的，这就是为什么此算法又叫 Deferred Acceptance 延迟接受 的原因。

## Theorem 1: 在 $n^2 + 1$ 天内结束

### 反证

让我们来看看算法还未终止时必须发生的一件事情：  
某个男孩从他的名单上划掉一个女孩

为什么？因为算法如果没有终止，那么某个女孩至少有两位追求者  
那至少有一个人会被拒绝，则他会把她划掉

因此，如果算法没有在 $n^2 + 1$ 次内终止，那么总共会有 $n^2 + 1$ 次划掉  
但是，每个人最多只能划掉 n 次，所以最多可以有 $n^2$ 次划掉  
我们有了矛盾。最后一天只有接受，没有拒绝

$n^2 + 1$ 并不是算法的最坏情况，所以让我们来计算

### 最坏 $(n - 1)^2 + 1$

让我们来举一个最坏的情况：每个男孩都会被拒绝 n - 1 次  
~~总不能被拒绝 n 次吧，那不是就没人要了~~

总求婚数 = 总拒绝数 + 总接受数  
则  
$$ 总求婚数\_{直到第 n - 1 天} = 男孩的数量 \times 每个男孩的求婚数 = n \times (n - 1) $$
得到  
$$ 总求婚数 = n \times (n - 1) + 1 = n^2 - n + 1 $$

在第一天，每个男人都会求婚，则进行了 n 次求婚  
随后的每一天，都只会有 **一个** 男人求婚（这也是为什么总求婚数可以计算总天数的原因）

所以我们可以据此求出总天数：  
$$ 总天数 = 总求婚数 - 第一天求婚的次数 + 第一天 = [n^2 - n + 1] - n + 1 = n^2 - 2n + 2 $$

所以，在最坏的情况下，$\Omega (n^2)$ 天内中止  
（算法所需的时间至少与参与者数量的平方成正比）

_大 $O$ 记号提供了一个上界，表示运行时间的增长速率不会快于某个特定的函数_  
_大 $\Omega$ 记号提供了一个下界，表示运行时间的增长速率至少是某个特定函数_

## Lemmas

1. 当男孩结婚时，他已经遍历了所有更喜欢的女孩

2. 如果一个男孩到头来也没结婚，那么他一定遍历过了所有女孩

3. 每个女孩都会嫁给 **追求过** 她的男孩中最喜欢的那个

4. 如果一个女孩被追求过，那么她一定会结婚

## Theorem 2: 在算法中，每个人都会结婚

在有以上 Lemmas 后，我们可以反证这个定理

- 假设一个男孩 B 没有结婚
- 但是在 L2 中说明了他遍历了所有女孩
- 但是根据 L4，每个女孩都会结婚
- 由于男孩的数量等于女孩的数量
- 因此每个人都会结婚

## Theorem 3: 算法总是产生稳定匹配

为了自相矛盾，假设有一对 rogue [B, G]  
运行算法，有 [B, G1] 和 [B1, G]

如果 [B, G1]，但是 B 更喜欢 G  
则根据 L1，B 一定追求过 G，G 拒绝了

但根据 L3，G 一定接受了比 B 更好的男孩  
所以 G 比 B 更喜欢 B1  
意味着 [B, G] 不是 rogue couple

~~（我怎么看不懂呢，这个 不是 到底是怎么推出来的）~~

## Theorem 4 / 5: 算法会产生 求婚 / 被求婚 方的 最佳 / 悲观 匹配

定义：

- 最佳伴侣是他 / 她从可能的伴侣中最喜欢的
- 悲观伴侣是他 / 她从可能的伴侣中最不喜欢的

Boy optimal / Girl optimal

男性主动求婚，女性被动选择，持续优化直至男性满足，导致女性最坏结果

Uniqueness：如果两种情况下算法得到相同的匹配结果，那么这个结果就是唯一的稳定匹配

## Max Magnitude $\theta (2^n)$
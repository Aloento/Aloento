---
title: NLP-Transformers
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-11-06 18:18:54
---

~~Attention is all you need~~

<!-- more -->

# 介绍

最早的有影响力的 seq2seq 模型是 RNN，但后来的发展是通过发明 *transformers* 实现的，这是一种使用注意力机制作为完整层（full-fledged layers）的新型架构，而不是作为辅助 RNN 组件。

新架构的主要构建块是：

- 作为软字典查找的注意力
- 自注意力层，和
- transformer 模块

# 直观感受

经典数据库查询（宠物店）：

查询：Key **=** "cat"

| Key（动物） | Value（价格） |
| ----------- | ------------- |
| cat         | 1             |
| dog         | 2             |
| cat         | 3             |
| parrot      | 4             |

| Key（动物） | Value（价格） | 选择权重 |
| ----------- | ------------- | -------- |
| cat         | 1             | 1        |
| dog         | 2             | 0        |
| cat         | 3             | 1        |
| parrot      | 4             | 0        |

Output = $1 \cdot 1 + 2 \cdot 0 + 3 \cdot 1 + 4 \cdot 0 = 4$

**软**数据库查询（宠物店）：

查询：Key **~** "cat"

| Key（动物） | Value（价格） | 选择权重 |
| ----------- | ------------- | -------- |
| cat         | 1             | **0.4**  |
| dog         | 2             | **0.15** |
| cat         | 3             | **0.4**  |
| parrot      | 4             | **0.05** |

Output = $1 \cdot 0.4 + 2 \cdot 0.15 + 3 \cdot 0.4 + 4 \cdot 0.05 = 2.1$

# 数学公式

回顾一下，注意力机制提供了基于查询的 $\langle \mathbf{x}_1,\dots, \mathbf{x}_n\rangle$ 向量序列的聚合：给定一个 $\mathbf{x^*}$ 查询向量，它们计算一个相关性分数序列

$$\mathbf{s} = \langle s(\mathbf{x}_1, \mathbf{x}^*),\dots, s(\mathbf{x}_n, \mathbf{x}^*) \rangle$$

并返回加权和

$$\mathop{\mathrm{softmax}}(\mathbf{s})\cdot \langle \mathbf{x}_1,\dots, \mathbf{x}_n\rangle$$

作为根据相关性分数对 $\mathbf{x}_i$ 进行总结或聚合的结果。

$s(\cdot, \cdot)$ 评分函数有所不同，我们看到一个选项是使用缩放点积：

$$s(\mathbf{x}_i, \mathbf{x}^*) = \frac{\mathbf{x}_i\cdot \mathbf{x}^*}{\sqrt{d}}$$

其中 $d$ 是 $\mathbf{x_i}$ 和 $\mathbf{x^*}$ 的维数。

基于这个模式，transformer 注意力机制做了一个关键的改变：将 $\langle \mathbf{x}_1,\dots, \mathbf{x}_n\rangle$ 视为一个 *字典*，其中有 $\mathcal K(\cdot)$ 和 $\mathcal V(\cdot)$ 映射，将每个 $\mathbf{x}_i$ 映射到相应的 $\mathcal K(\mathbf{x}_i)$ 键和 $\mathcal V(\mathbf{x}_i)$ 值。

假设还有一个 $\mathcal Q(\cdot)$ *查询* 映射，它将 $\mathbf{x}^*$ 映射到 $\mathcal K$(.) 的范围（“key-space”），评分可以重新表述为计算查询和键之间的点积相似度分数

$$s(\mathbf{x}_i, \mathbf{x}^*) = \frac{\mathcal K (\mathbf{x}_i)\cdot \mathcal Q (\mathbf{x}^*)}{\sqrt{d}}$$

（$d$ 现在是“key-space”的维数），检索到的值将是加权和

$$\mathop{\mathrm{softmax}}(\langle s(\mathbf{x}_1,\mathbf{x}^*),\dots,s(\mathbf{x}_n,\mathbf{x}^*) \rangle)\cdot \mathcal V(\langle \mathbf{x_1},\dots,\mathbf{x}_n)\rangle$$

# Scaling

然而，这种注意力机制存在一个问题。假设所有序列的每个向量元素都来自标准正态分布 $\mathcal{N}(0, 1)$。它们的点积 $\sum\limits_{d}\mathbf{x}_i\cdot\mathbf{x}_i^*$ 将具有 $\mathcal{N}(0, d)$ 的分布，其中 $d$ 是向量的维数。为了将输出缩放回标准正态分布，点积被缩放为 $\frac{1}{\sqrt{d}}$。

![Dot-product attention](dotprodattn.png)

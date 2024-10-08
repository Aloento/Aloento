---
title: NLP-Classification-SequenceTagging
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-10-05 20:04:00
---

分类和序列标注

<!-- more -->

# 文本分类

## 文本分类任务

文本分类任务是从给定的 $C=\{c_1,\dots,c_n\}$ 类别/分类标签集中为 $d$ 文本/文档 分配适当的标签。

代表性的例子包括

- **情感分析**：根据文档表达的情感进行分类。标签集示例：

  - { positive, negative, ambigous }
  - { admiration, amusement, annoyance, approval, ..., sadness, surprise }

- **垃圾邮件检测**：SPAM，二分类决定消息是否为未经请求的邮件
- **作者身份检测**：从指定的作者集中确定谁写了文本
- **作者特征检测**：作者是男性还是女性，他们的年龄等
- **主题/话题检测**：文档属于预定义列表中的哪个 主题/话题，例如，在国会图书馆分类系统中 { 医学, 农业, 科学, 美术, ... }
- **体裁检测**：Genre，确定文本的体裁，例如，从集合 { 科幻, 冒险, 爱情故事, 悬疑, 历史, 西部 } 中分配标签

## 方法

- **手工设计的基于规则的系统**：例如，使用精心设计的与类别正相关或负相关的词列表。

  这些系统可以达到良好的性能，但需要大量的手工工作，并且难以维护和适应。

- **机器学习方法**：在包含标记文档的监督数据集上学习的模型：
  $\{\langle d_i, c_i \rangle\}_{i\in \{1, \dots, N\}}$

  方法范围从线性机器学习方法如逻辑回归（logistic regression）到深度神经网络。

# 词袋表示法

Bag of words

许多基于机器学习的分类方法需要将输入表示为固定长度的数值向量。对于长度不一的文本，一个常见的方法是使用词袋表示法：

- 使用词汇表 $V=\{w_1,\dots,w_N\}$ 对输入文本进行分词
- 并将它们表示为 $|V|=N$ 维的词频向量，即，对于一个文档 $d$，$BOW_V(d)=\langle c_{1,d}, \dots, c_{N,d}\rangle$，其中每个 $c_{i,d}$ 是 $w_i$ 在 $d$ 中的出现次数

一个简单的例子：

![bow](bow.jpg)

## 词袋表示法的改进

基本的 BOW 表示法可以通过几种方式进行改进，可能最重要的三种是：

- 从 BOW 向量中省略**stopword**（非信息词）的计数。什么算作停用词取决于任务和领域，但通常会考虑（某些）功能词，例如限定词作为停用词
- 向 BOW 表示中添加一些词序列计数，例如，**bigram**或**三元组**计数
- 根据词的信息量对词进行加权：最广泛使用的方法是根据**词频**和**逆文档频率**（term frequency-inverse document frequency）进行加权

## TF-IDF 方案

TF-IDF 加权方案的基本假设是，出现在大部分训练文档中的词不如只出现在少数文档中的词信息量大。因此，TF-IDF 向量相应地通过文档频率来折扣 word counts（term frequencies）。一个简单但广泛使用的变体：

$$TF{\text -}IDF(d)=\langle tf_{1,d}\cdot idf_1, \dots, tf_{N,d}\cdot idf_N\rangle$$

其中 $tf_{i,d}$ 只是 $w_i$ 在 $d$ 中的出现次数，而

$$idf_i = \log\frac{\mathrm{\# of \space all \space documents}}{\mathrm{\# of \space documents \space containing} \space w_i  }$$

## 二进制词袋表示法

词袋表示法的一种有趣的简化是仅指示单词的存在或不存在：

$$BOW_{bin}(d)=\mathop{\mathrm{sign}}(BOW(d))$$

其中 $\mathop{\mathrm{sign}}$ 函数的应用是逐元素的，即，

$$BOW_{bin}(d)=\langle \mathop{\mathrm{sign}}(c_{1,d}), \dots, \mathop{\mathrm{sign}}(c_{N,d})\rangle$$

事实证明，在许多情况下，这些更简单且占用内存更少的表示法可以代替正常的 BOW 向量使用，而不会有明显的性能差异。

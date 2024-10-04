---
title: NLP-NGram-LM
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-10-04 23:28:19
---

基于 N-gram 的语言模型

<!-- more -->

# 语言模型

## 什么是语言模型？

回想一下，在形式语言理论中，语言 $\mathcal L$ 只是某个字母表 $\Sigma$ 的子集 $\Sigma^*$。

相反，统计语言模型切换到语言生成的*概率视图*，并为来自词汇 $V$ 的任意序列 $\langle w_1,\dots, w_n\rangle \in V^*$ 分配一个概率

$$P(\langle w_1,\dots, w_n\rangle)$$

使得

$$\sum_{\mathbf{w}\in V^*} P(\mathbf{w}) = 1$$

## 词汇表

传统上，语言模型的词汇表由完整的单词组成，例如，

$V$ = {*the*, *be*, *to*, *of*, $\dots$}

但最近基于子词和字符的语言模型也被广泛使用，词汇表如
{ *\_don'*, *t*, *\_un*, *related*, $\dots$} 或 {*a, b, c, d, e, f*, $\dots$}

本章讨论基于单词的语言建模技术 — 字符和子词级别建模技术将是第 9 和第 11 讲的主题。

## 为什么语言模型有用？

概率语言模型对于大量的自然语言处理应用非常重要，其目标是生成合理的词序列作为输出，其中包括

- 拼写和语法检查，

- 预测输入，

- 语音转文字，

- 聊天机器人，

- 机器翻译，

- 摘要生成

## 使用连续概率建模

使用链式法则，令token序列 $\mathbf{w} = \langle w_1,\dots, w_n\rangle$ 的概率可以重写为

$$P(\mathbf w)= P(w_1)\cdot P(w_2 \vert w_1 )\dots \cdot P(w_n\vert w_1,\dots, w_{n-1})$$

也就是说，对于一个完整的语言模型，只需指定

- 对于任何 $w\in V$ 单词，概率 $P(w)$ 表示它将是序列中的第一个单词，以及
- 对于任何 $w\in V$ 和 $\langle w_1,\dots,w_n\rangle$ 部分序列，单词 $w$ 的*连续概率*，即
  $$P(w ~\vert ~ w_1,\dots,w_n)$$

## 起始和结束符号

基于链式法则的序列概率公式

- 需要一个单独的、无条件的子句来表示起始概率，并且

- 没有解决在某个点*结束*序列的概率。

这两个问题都可以通过在词汇表中添加显式的 $\langle start \rangle$ 和 $\langle end \rangle$ 符号来解决，并假设语言的所有序列都以这些符号 开始/结束。通过这个技巧，起始/结束 概率可以重写为条件形式 $P(w \vert \langle start \rangle)$ 和 $P(\langle end \rangle \vert \mathbf{w})$

## 语言模型树结构

使用 起始/结束 符号，语言模型分配的词序列及其连续概率可以排列成树结构：

![lm_tree](lm_tree.jpg)

## 文本生成

使用语言模型，可以基于模型的生成概率分布生成新的文本。

在前一张幻灯片所示的树结构中，我们寻找权重（对数概率）之和较大的分支。穷举搜索是不可行的，众所周知的策略包括

- 贪婪搜索，

- 集束搜索，以及

- 随机集束搜索

一个简单的集束搜索示例，$K=5$：

![beam_search](beam_search.jpg)

## 评估

语言模型的评估可以是

- **外在的**: 模型在拼写检查、语音转文字系统等组件中的表现如何，或者

- **内在的**: 分配的概率与测试语料库中的文本对应得有多好？

最广泛使用的内在评估指标是语料库的 **困惑度**。
语言模型 $\mathcal M$ 在序列 $\mathbf w = \langle w_1,\dots, w_n\rangle$ 上的困惑度为

<div>
$$\mathbf{PP}_{\mathcal M}(\mathbf w) = \sqrt[n]{\frac{1}{P_{\mathcal M}(\mathbf w)}}$$
</div>

使用链式法则，困惑度可以重写为

$${\sqrt[n]{\frac{1}{P_{\mathcal M}(w_1)}\cdot \frac{1}{P_{\mathcal M}(w_2 \vert w_1 )}\dots\cdot \frac{1}{P_{\mathcal M}(w_n\vert w_1,\dots, w_{n-1})}}}$$

这正是语料库中所有单词条件概率倒数的*几何平均值*。

换句话说，困惑度衡量的是，对于语言模型来说，语料库中的单词（续词）平均而言有多“出乎意料”。

取困惑度的对数，通过一些简单的代数运算可以得到结果

$$-\frac{1}{n} \left(\log P_{\mathcal M}(w_1) + \sum_{i=2}^n\log P_{\mathcal M}(w_i \vert w_1,\dots, w_{i-1})\right)$$

这就是每个单词的平均交叉熵和负对数似然。

一个简单的推论是：通过最小化平均交叉熵或最大化平均对数似然，也可以最小化模型在训练数据上的困惑度。

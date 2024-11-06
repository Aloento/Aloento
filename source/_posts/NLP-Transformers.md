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

## 直观感受

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

## Scaling

然而，这种注意力机制存在一个问题。假设所有序列的每个向量元素都来自标准正态分布 $\mathcal{N}(0, 1)$。它们的点积 $\sum\limits_{d}\mathbf{x}_i\cdot\mathbf{x}_i^*$ 将具有 $\mathcal{N}(0, d)$ 的分布，其中 $d$ 是向量的维数。为了将输出缩放回标准正态分布，点积被缩放为 $\frac{1}{\sqrt{d}}$。

![Dot-product attention](dotprodattn.png)

# Attention as a layer

所述的注意力机制可以用作独立层来转换输入向量序列 $\mathbf{I} = \langle \mathbf{i}_1,\dots, \mathbf{i}_n \rangle$：

给定另一个序列 $\mathbf{X} = \langle \mathbf{x}_1,\dots, \mathbf{x}_m \rangle$ 和 $\mathcal K(\cdot),\mathcal V(\cdot),\mathcal Q(\cdot)$ 映射，对于每个输入 $\mathbf{i_k}$，我们可以计算相应的 $\mathcal Q(\mathbf{i}_k)$ 查询，并使用它与 $\mathcal K$ 和 $\mathcal V$ 来 *关注* $\mathbf{X}$ 并计算相应的注意力响应 $\mathbf{o}_k$。

结果是一个 $\mathbf{O}=\langle \mathbf{o}_1,\dots,\mathbf{o}_n \rangle$ 输出序列，整体上是输入 $\mathbf{I}$ 的层输出。

## 注意力层类型

根据层关注的位置（$\mathbf{X}$ 的来源），我们可以区分自注意力层和交叉注意力层。

- 在 ***自注意力*** 层中，从输入生成的查询用于查询输入本身：$\mathbf{X}=\mathbf{I}$
- 在 ***交叉注意力*** 层中，查询的是外部向量序列，例如，在编码器-解码器 transformer 架构中，由编码器创建的序列

至于映射 $\mathcal K(\cdot),\mathcal V(\cdot),\mathcal Q(\cdot)$，这三者通常都实现为*线性投影*，具有学习到的权重矩阵 $W_K, W_V, W_Q$。

## 多头注意力

为了能够关注输入的多个方面，transformers 中的注意力层包含几个并行的注意力“头”，每个头都有不同的 $W_K, W_V, W_Q$ 三元组：

![transformer_attention_heads_qkv](transformer_attention_heads_qkv.jpg)

头输出被组合成一个层输出：

![mhead2](mhead2.jpg)

![Multi-head attention layer](mha.png)

# Transformer 模块

transformers 的构建块是由注意力和简单的分段前馈层组成的 *transformer 模块*。最简单的变体只包含一个自注意力层：

![transformer_resideual_layer_norm_2](transformer_resideual_layer_norm_2.jpg)

## 编码器

编码器由 $N$ 个相同的层组成，这些层具有自注意力和逐元素（element-wise） FFN 模块，以及残差连接。编码序列（上下文）是最后一个编码器层的输出。每个自注意力都是双向的。

![Transformer Encoder](transformer_encoder.png)

## 解码器

解码器由 $N$ 个相同的层组成，这些层具有自注意力、交叉注意力和 FFN 模块，以及残差连接。交叉注意力将编码序列作为键和值，而查询来自解码器。每个自注意力是单向的，交叉注意力是双向的。

![Transformer Decoder](transformer_dec.png)

## 嵌入和位置编码

Transformers 是为符号序列（例如文本）发明的，因此使用嵌入层将输入标记转换为向量表示。然后将此嵌入添加到位置编码向量中，该向量用于向模型传达位置信息。

![Transformer input embeddings](transformer_posenc.png)

![Sinusoid (正弦) positional encoding](positional.png)

![Sinusoid positional encoding](posenc1.png)

![Dot-product of positional encodings](posenc2.png)

## Seq2seq Transformer

![transformer_full](transformer_full.jpg)

原始的 *全 transformer 模型* 是一个完全由 transformer 块构建的 Seq2seq 编码器-解码器 模型。在推理过程中，解码器部分逐步预测，类似于 RNNs 消耗已经预测的输出，但在训练过程中，它只需要通过教师强制进行一次前向传递。

## 训练

通过向解码器添加分类头，可以在两个序列上训练模型。给定完整的输入序列，解码器被训练来预测输出序列中的下一个元素。

为了生成完整的序列，模型以自回归（auto-regressive）方式使用。模型的输出用作下一步的输入。然而，单个错误预测将导致错误的级联。为避免这种情况，模型通过教师强制进行训练。

## 掩码

掩码用于防止模型关注某些元素。Transformers 中主要有两种类型的掩码：

- 填充（Padding）掩码
- 前瞻（Look-ahead）掩码（因果 causal 掩码）

![GPT-2 中的因果掩码](diagram_bartpost_gpt2.jpg)

## 编码器风格和解码器风格的模型

某些应用只需要模型处理单个序列（例如语言建模）。在这种情况下，不需要交叉注意力和两个模块。我们只使用编码器或解码器（没有交叉注意力）。当存在双向信息时，使用编码器风格的模型，而对于因果问题，则使用解码器风格的模型。因此，两者之间的唯一区别是因果掩码。

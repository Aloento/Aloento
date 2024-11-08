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

# 上下文嵌入

## 词嵌入的局限性

传统的基于共现矩阵的词向量和第一代神经词嵌入有几个重要的局限性：

- *上下文独立性:* 一个表面形式只有一个表示。例如，*bank* 在以下句子中的嵌入是相同的：

  *I went to my bank to withdraw some money.* （我去银行取了一些钱）

  *We explored the river bank.* （我们探索了河岸）

  尽管这两个意思显然是不同的

- *单词是黑箱:* 单词有内部结构：它们由字符组成，可以由几个词素组成，但 Word2vec、GloVe 等忽略了单词的内部结构

- *对未见过或罕见单词没有有用的表示:* 由于单词被视为黑箱，这些模型无法为训练语料库中未出现或非常罕见的单词生成有用的表示

- *良好的覆盖需要巨大的模型尺寸:* 一个单词只有在明确包含在模型的词汇表中时才会获得有意义的表示，但内存消耗通常是覆盖词汇表的线性函数

利用内部单词结构、处理 OOV 单词和减少词汇量的问题已通过以下方法有效解决：

- fastText 嵌入，尤其是
- 子词嵌入

但这些嵌入仍然是*静态的*，即将相同形式的标记映射到相同的嵌入向量。

NLP 领域最近最重要的发展之一是*上下文嵌入*的出现，与之相反，上下文嵌入可以根据上下文的不同来改变相同表面形式的嵌入，以反映语言差异。

## Contextual embeddings

*上下文嵌入* 是由深度网络（通常是基于 LSTM 或自注意力机制）生成的单词或子词表示，这些网络在自监督的、广泛的语言建模目标上进行（预）训练。

与静态嵌入不同，这些表示不能简单地以查找表的形式存储和部署，因为它们是根据每个标记的上下文*动态*计算的：对于一个 $\mathbf{w} = \langle w_1,\dots ,w_n \rangle$ 输入标记序列，网络生成一个嵌入序列

$$E(\langle w_1,\dots ,w_n \rangle) = \langle E_\mathbf{w}(w_1),\dots,E_\mathbf{w}(w_n)\rangle$$

由于这种动态特性，网络本身必须用作 *特征提取模块*。

在 NLP 中，生成上下文嵌入的网络的预期用途类似于传统 NLP 中处理管道的角色：它们应该生成对下游任务有用的特征向量，实际上，希望只需要少量的进一步处理（例如，以浅层神经网络的形式）就能构建有用的 NLP 模型。

巨大的区别在于，上下文嵌入可以通过*自监督方式*学习，而不需要昂贵的监督训练集。

## ELMo

ELMo（来自语言模型的嵌入，Embeddings from Language Models），第一个历史上重要的上下文嵌入模型，通过两个标准的单向语言建模任务学习词表示。

该架构首先使用字符级卷积生成上下文无关的嵌入，然后使用前向和后向双向 LSTM 层（它们的数量 $n$ 是一个可变的超参数）通过权重共享的 softmax 层预测下一个/上一个标记。

![elmo](elmo.jpg)

在第一近似（approximation）中，上下文相关的嵌入是模型生成的所有 $2n +1$ 个中间表示（$2n$ 个基于上下文的 LSTM 和一个静态字符的表示）。

尽管这些向量可以一起被视为“完整的”ELMo 表示，但对于实际的下游 NLP 任务，ELMo 的创建者实际上建议不要使用这种非常高维的表示，而是使用这些向量的低维组合。他们建议的解决方案是

- 简单地连接顶层 LSTM 层（前向和后向）的输出
- 在监督任务上学习 ELMo 表示的任务特定线性组合

## FLAIR

FLAIR 是一种与 ELMo 密切相关的上下文嵌入模型，但

- 完全由循环*字符级*语言模型（一个前向和一个后向）组成
- 从 LSTM 隐藏状态在标记的第一个和最后一个字符（从后向 LM 的第一个字符和从前向 LM 的最后一个字符）生成标记级嵌入

FLAIR 嵌入在序列标注任务中被证明非常有用，使用它们的浅层模型目前在命名实体识别（NER）和词性标注（POS-tagging）中排名第二。

![flair](flair.jpg)

## 基于 Transformer 的上下文嵌入

Transformer 架构最初用于翻译（2017 年），但从 2018 年开始，开发了一系列基于 Transformer 的模型来生成上下文嵌入。最重要的研究领域是：

- 寻找有助于学习高质量表示的自监督任务
- 架构改进，特别是找到更高效的注意力变体
- 如何为下游任务 adapt/fine-tune 预训练的 representation 网络

## GPT

GPT（Generative Pre-Training）是一种基于 BPE 的，仅使用解码器的 transformer 模型，使用传统的“预测下一个标记”语言建模目标进行训练。上下文嵌入只是顶层 transformer 模块的输出。

与 ELMo 类似，GPT 的主要目标是提供一个有用的预训练“特征提取”模块，可以针对监督的 NLP 任务进行微调。微调意味着在监督下游任务上以端到端的方式更改预训练的 GPT 权重。

![gpt](gpt.jpg)

## BERT

下一个具有高度影响力的模型是谷歌的 BERT（Bidirectional Encoder Representations from Transformers），其主要创新是

- 使用了两个新的自监督目标，而不是传统的语言建模
  - 掩码语言模型（masked language modeling）以及
  - 下一句预测（next sentence prediction, NSP）和

- 相应的架构变化：该模型基于 *transformer 编码器* 架构

### 掩码语言模型

目标是猜测随机掩码的标记：

![bert1](bert1.jpg)

### 下一句预测

第二个目标是判断两句话在训练语料库中是否相互跟随或是随机抽取的：

![bert2](bert2.jpg)

## 微调上下文嵌入

预训练语言模型生成的上下文嵌入不一定适用于具体的下游任务（分类、语义搜索等），因此可以通过*微调*预训练权重来提高性能。

微调可以通过以下方式进行：

- 在更能代表目标领域的语料库上使用*无监督任务*（这些任务通常与预训练任务相同）
- 在与目标任务相同或相关的*监督任务*上进行，例如语义搜索的相似性排序

## 后续趋势

更新的模型在 NLP 任务中不断刷新最先进的技术，但通常伴随着*参数数量的增加*和*更大的数据集*：

虽然最初的 ELMo 模型有 9360 万个参数，但 GPT-3 有 1750 亿个参数，数据集的规模从 8 亿个标记增加到 3000 亿个标记。

## 知识蒸馏

模型规模的巨大增加导致了对*知识蒸馏* （distillation）方法的深入研究，以便能够基于原始模型生成更小、更高效的模型，而不会显著损失性能。

一个很好的例子是*DistilBERT*，这是一个经过蒸馏的 BERT 版本，旨在模仿 BERT 的输出。DistilBERT 保留了 BERT 97% 的性能，但参数减少了 40%，推理速度提高了 39%。

## 稀疏注意力变体

提高效率的另一种方法是减少自注意力层中的注意力范围，因为在全注意力中，计算点积的数量与输入标记的数量成平方关系。线性替代方案包括：

- *全局注意力*: 一组全局标记关注整个序列；
- *随机注意力*: 对于每个查询，计算一组 $r$ 个随机键，该查询关注这些键；
- *窗口注意力*: 仅关注固定半径内的局部邻居。

Big Bird 上下文嵌入模型结合了所有这些线性注意力类型，以显著增加输入标记的数量，而不会显著改变内存需求：

![bigbird](bigbird.jpg)

## 少样本学习、单样本学习和零样本学习

一个有趣的方向是尝试直接使用模型，而不在下游任务上添加层和进行梯度更新。一些最近的模型，最重要的是 GPT-3，在各种下游任务中表现出令人惊讶的效果，这些任务在输入中进行了说明。有三种学习设置：

- ***零样本学习***：输入仅包含监督任务的简短描述和一个具体的输入实例提示，例如“将英语翻译成法语：cheese =$>$ ”
- ***单样本学习*** 和 ***少样本学习***：除了简短的任务描述外，输入还包含一个或几个训练示例，然后是提示

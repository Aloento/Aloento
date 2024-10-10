---
title: NLP-StaticNeuralEmbeddings
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-10-08 21:04:05
---

静态嵌入式神经网络

<!-- more -->

# 词向量和神经网络

LSI 和 LSA 的成功表明，基于分布的词向量表示对于 NLP 任务非常有用。在神经网络 NLP 模型中，连续的、密集的词表示尤其重要，因为它们

- 可以用作信息丰富且经济的表示，而不是简单地对词进行独热编码
- 可以帮助减少模型参数的数量
- 可以通过神经网络从文本语料库中以自监督的方式学习

一个由神经网络学习到的词向量的最早实例之一可以在 @bengio2003neural 的语言模型中找到：

![neural_lm](neural_lm.png)

$C$ 是一个嵌入层，将词汇索引映射到实数向量：

$$C: [0, |V|-1]  \rightarrow \mathbb R^d$$

（静态）词嵌入的维度通常在 50 到 600 之间。

从技术上讲，嵌入层可以通过多种方式实现，例如，作为一个以独热编码词索引为输入的密集层（在这种情况下，词向量表示为层的权重矩阵），或者作为一个表示为数组的查找表等。

关于 [@bengio2003neural] 中嵌入层的重要经验教训：

- 嵌入是*静态的*：相同类型的标记在不同上下文中具有相同的嵌入
- 使用端到端训练的词嵌入层的模型比传统的 *n*-gram 语言模型表现更好
- 使用词共现频率矩阵的前几个主成分作为词特征向量，而不是训练的嵌入，没有同样的性能优势
- 使用神经网络学习词嵌入是一种扩展训练语料库的可行方法

# Word2vec

## 区别特征

Word2vec，由 [@mikolov2013efficient] 引入，也是一个神经网络家族，从语料库中学习有用的分布式词表示，但具有几个新颖的特征：

- 它是一个专用架构：**表示学习** 是其唯一目标

- 它基于一种新的基于语料库的自监督预测任务

- 架构被故意保持非常简单，以便能够在具有大词汇量的巨大语料库上进行训练

## Skipgrams

Word2vec 基于 *skipgrams*，它是 $n$-grams 的推广：虽然 $n$-gram 是文本的*连续*、长度为 $n$ 的子序列，但 skipgrams 可以包含一定数量的“jumps”：如果基本序列是 $\langle w_1, \dots ,w_N \rangle$，那么具有最多 $k$ 跳距的 $n$ 长度 skipgrams 集合是

<div>
$$
\{\langle w_{i_1} ,\dots ,w_{i_n}\rangle~|~ i_1<\dots<i_n\in[1, N],
  i_n - i_1  \leq  n -1 + k \}
$$
</div>

可以有额外的限制，例如对单个跳跃的数量和长度的限制。

## Word2vec 任务

Word2vec 任务具体基于长度为 $2c$ 的 skipgrams，在中心有一个单词跳跃。有两种任务变体及其相关的模型架构：

- **CBOW**: Continuous Bag of Words 预测 skipgram 中心的缺失词
- **SkipGram**: 给定 缺失/跳过 的词，预测 skipgram 的元素。与 CBOW 任务不同，每个 skipgram 对应一个分类示例，SkipGram 任务为每个 skipgram 生成多个 $\langle$ 中心词，skipgram 中的词 $\rangle$ 示例

skipgram 任务的简单示例：

![http://mccormickml.com/2016/04/19/word2vec-tutorial-the-skip-gram-model/](skipgram.jpg)

## 架构

![w2v_arch](w2v_arch.jpg)

虽然 SkipGram（右）只是将 $E(\cdot)$ 嵌入映射应用于其一个词输入，CBOW（左）嵌入输入 skipgram 中的所有词并计算它们的和。

在将输入投影到词嵌入空间后，这两种架构都仅使用一个带权重矩阵 $W \in \mathbb R^{|V|\times d}$ 的线性投影和一个最终的 softmax 层来生成词汇表中所有词的预测概率：

$$CBOW(\langle w_{t-c},\dots ,w_{t+c} \rangle) = \mathop{\mathrm{softmax}}(W\sum_{i}E(w_i))$$

$$SkipGram(w_t) = \mathop{\mathrm{softmax}}(W_{}E(w_t))$$

这两种模型都使用标准的负对数似然损失和 SGD 进行训练，但在示例采样方面有一些有趣的差异。

值得注意的是，投影矩阵 $W \in \mathbb R^{|V|\times d}$ 也可以看作是词汇表在相同 $R^d$ 空间中的 $E'(\cdot)$ 嵌入。使用这种表示法，两个模型对于特定单词 $w_j$ 的 logits（线性输出）可以简单地写成：

$$CBOW_{linear}[\langle w_{t-c}, \dots ,w_{t+c} \rangle](w_j) = \sum_{i}E(w_i) \cdot E'(w_j),$$

$$SkipGram_{linear}[w_t](w_j) = E(w_t) \cdot E'(w_j)$$

如这种表示法所示，最小化负对数似然训练目标是一种增加输入嵌入和正确预测嵌入的点积的方法。

由于这种表示法所显示的对称性，可以选择*绑定两层的权重*，使得对所有 $w\in V$ 都有 $E(w) = E'(w)$。

尽管这种方法经常被采用，但通常也会保持它们的不同，并且仅使用输入嵌入 $E(\cdot)$ 的向量作为最终结果，或者将它们结合起来，例如取它们的平均值。

## 数据点生成和采样

对于 CBOW 变体，我们只需将 $c$ 半径的上下文窗口滑动通过语料库，并在每一步生成一个

$$\langle \langle w_{t-c}, \dots ,w_{t-1}, w_{t+1}, \dots ,w_{t+c} \rangle, w_t \rangle$$

$\langle$ 输入，正确输出 $\rangle$ 数据点。

对于 SkipGram，过程更为复杂，因为在每一步中，实际使用的上下文窗口半径 $r$ 是从 $[1, c]$ 区间内随机选择的，并且为每个 $w_i\in \langle w_{t-r}, \dots ,w_{t-1}, w_{t+1}, \dots ,w_{t+r}\rangle$
单词生成一个 $\langle w_t, w_i\rangle$ 数据点。其效果是离目标词越近的词被采样的概率越高。

## 避免 full softmax

由于对一个 $|V|$ 长度的向量计算全 softmax 对于大 $V$ 来说是昂贵的，Word2vec 实现通常使用更便宜的输出层替代方案。

一种解决方案是 **hierarchical softmax**，它基于一个二叉树，其叶子是词汇表中的单词。网络的线性输出对应于内部节点，分配给一个单词 $w$ 的概率可以通过仅计算路径上 $o$ 输出的 $\sigma(o)$ 值来计算。使用平衡树，这个技巧将训练期间 softmax 计算的复杂度从 $\mathcal O(|V|)$ 降低到 $\mathcal O({\log |V|})$，并且通过巧妙的树结构可以进一步减少。

## Hierarchical softmax

![hierarchic_softmax](hierarchic_softmax.jpg)

说明：如果路径上的线性输出是 $o(w_2, 1), o(w_2, 2), o(w_2, 3)$，那么分配给 $w_2$ 的概率可以计算为 $(1-\sigma(o(w_2,1)))(1-\sigma(o(w_2,2)))\sigma(o(w_2,3))= \sigma(-o(w_2,1))\sigma(-o(w_2,2))\sigma(o(w_2,3))$。

## 负采样

另一种替代方案是 **负采样**。这涉及将 SkipGram 任务重新表述为一个二元分类问题。

- 我们将语料库中的早期 SkipGram $\langle$ 中心词，背景词 $\rangle$ 数据点视为正例

- 并且通过从代表整个语料库的噪声分布中采样，为每个中心词生成一定数量的负例“假背景词”

负采样技巧使得简化网络架构成为可能，达到

$$SGNS(w_{t}, w_{c}) = \sigma(E_t(w_t)\cdot E_c(w_c))$$

其中 $E_t(\cdot)$ 是目标（中心）词嵌入，而 $E_c(\cdot)$ 是背景词嵌入。对于从 $P_n$ 噪声分布中采样的 $k$ 个负样本，每个真实 $\langle w_t, w_c\rangle$ 数据点的负对数似然损失将是

$$- [ \log SGNS(w_{t}, w_{c}) + \sum_{\substack{i=1 \\ w_i \sim P_n}}^k \log(1 - SGNS(w_{t}, {w_i}))]$$

## Word2vec 作为矩阵分解

在 Word2Vec 成功之后，许多研究调查了它与基于计数的矩阵分解方法的关系，结果发现它们密切相关：SGNS 目标等价于分解基于词共现的 $M$ 矩阵，其元素为

$$m_{ij} = \max(0, PMI(w_i, w_j )- \log k)$$

其中 $PMI(w_i,w_j)$ 是 $w_i$ 和 $w_j$ 的 $\log\left(\frac{P(w_i, w_j)}{P(w_i)P(w_j)}\right)$ *点互信息*，$k$ 是负样本的数量。

## Pointwise Mutual Information

PMI 衡量单词在彼此上下文中出现的频率与它们独立出现的频率相比的差异。上下界由 $w_i$ 和 $w_j$ 从不 ($P(w_i, w_j) = 0$) 或总是 ($P(w_i, w_j) = P(w_i)$ 或 $P(w_i, w_j) = P(w_j)$) 共现的情况提供：

$$-\infty \leq PMI(w_i, w_j) \leq \min(-\log(p(w_i)), -\log(p(w_j)))$$

PMI 公式中的 $\frac{P(w_i, w_j)}{P(w_i)P(w_j)}$ 比例可以基于目标词-上下文词共现计数估计为

<div>
$$\frac{C(w_i, w_j)C(\mathrm{\langle target~word, context~word\rangle~pairs~in~corpus})}{C(w_i)C(w_j)}$$
</div>

在一个大型维基百科片段中，PMI 分数最高和最低的三组二元组：

 | 单词 1 | 单词 2 | PMI  |
 |--------|---------|------|
 | puerto | rico    | 10.03|
 | hong   | kong    | 9.72 |
 | los    | angeles | 9.56 |
 | $\cdots$ | $\cdots$ | $\cdots$ |
 | to     | and     | -3.08|
 | to     | in      | -3.12|
 | of     | and     | -3.70|

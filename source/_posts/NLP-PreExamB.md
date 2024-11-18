---
title: NLP-PreExamB
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP, 考试]
date: 2024-11-16 18:22:06
---

~~论文加考试，要死了~~

<!-- more -->

# B1 注意力机制

## Seq2seq 基础

S2S 是基于 RNN 的，将一个任意长度的序列，变成另一个任意长度的序列。

它由 编码器 和 解码器 组成。

编码器输出一个固定长度的向量，其维度是隐藏层的大小。
一般是编码器最后的状态（单向 RNN），或者是平均或最大池化（双向 RNN）。

## 瓶颈问题

这会导致问题，如果信息量太大，而隐藏层向量太小，会导致信息丢失。

为了解决此问题，我们需要注意力机制。

## RNN 网络中的注意力

解码器使用自身当前状态，与 编码器 的各个时间步的隐藏状态 进行比较，计算出每个输入的权重，它表示了每个输入对当前输出的重要性。

随后，用权重 对编码器所有隐藏状态进行加权求和，得到一个上下文向量。

解码器结合上下文与自身的隐藏状态，生成更好的输出。

## 注意力的属性

所以，注意力有

- 权重分配：通过计算 Query 和 Key 的相似度，得到每个 Key 的权重。

- 上下文向量：根据权重，对 Value 进行加权求和。

- 可反向传播：注意力机制是可微的。

其中

Query：当前输入 或 当前解码器状态。

Key：信息的摘要，编码器的隐藏状态。

Value：信息的实际内容，通常与 Key 相同。

# B2 注意力作为层和 Transformer 架构

## 点积注意力

前面提到了 “比较”，而使用点积是最简单有效计算权重的方法。

简单来说，将 $Q · K_i$ ，相似性越高，点积越大。

为了避免过大的点积，我们可以将结果除以 $\sqrt{d_k}$，其中 $d_k$ 是 Key 的维度。

然后对所有 Key 的点积进行 softmax，得到一个权重向量，表示了每个 Key 对当前 Query 的重要性。

最后，将 $Value_i$ 与权重相乘，然后求和，得到上下文向量。

## 缩放的作用

我们只需要将点积除以 $\sqrt{d_k}$，就能稳定计算结果，避免点积过大过小。

当 $Q$ 和 $K$ 的维度很大时，点积的值会很大，导致 softmax 的梯度很小，使得训练困难。

## 多头注意力

简而言之，让模型在多个视角下观察输入。
比如，对于翻译任务，一个头关注主语，一个关注宾语，一个关注动词。

首先，用线性变化生成多组 $Q$、$K$ 和 $V$，一组对应一个头，每个头都有自己的权重。

并行计算权重，然后将结果拼接，再次进行线性变换，得到最终结果。

## 自注意力

而自注意力，主要是捕捉元素之间的依赖关系。

简单来说，这次的 Query、Key 和 Value 都是出自同一个输入序列。

比如 I Love AI. 我们分别查询：

I 与 I, Love, AI 的关系，得到一个权重。
Love 与 I, Love, AI 的关系，得到一个权重。
AI 与 I, Love, AI 的关系，得到一个权重。

然后对所有权重进行加权求和，得到一个上下文向量。

## 交叉注意力

CrossAttention 也就是前面说的给 编码器 和解码器 之间建立联系的注意力。

Query 是解码器当前状态，Key 和 Value 是编码器的隐藏状态。

解码器逐步生成每个单词，每次生成时，都会用交叉注意力参考编码器的隐藏状态。

# B3 使用 RNN 和 Transformer 的上下文嵌入

## Transformer 架构

它包含：

- 注意力机制
  - 自注意力 （双向）
  - 多头注意力 （可选）
- 位置编码 （可选）
- Feedforward
- 残差归一

### 编码器

> 输入序列 -> 输入嵌入-> 位置编码 -> 编码器 [6...12] -> 输出

> 每个编码器：上一个输出 -> 多头自注意 -> 残差归一 -> 前馈 -> 残差归一 -> 输出

编码器的输入是源序列（比如需要翻译的文本）

### 解码器

> 输出序列 -> 输出嵌入 -> 位置编码 -> 解码器 [6...12] -> 输出

> 每个解码器：上一个输出 -> **掩码**多头自注意 -> 残差归一 -> 多头**交叉**注意力 -> 残差归一 -> 前馈 -> 残差归一 -> 输出

解码器的输入：

- 训练时：教师强制（比如翻译 I Love AI. 输入为 "我爱"）
- 推理时：模型已经生成的部分

## 位置编码

由于输入的每个词都会被转换为向量表示，导致模型无法区分词的位置。
位置编码通过将位置信息添加到向量中，解决这个问题。

我们使用 sin 和 cos 函数，它们的周期性与它们不同频率的组合，
使得每个位置的编码都是唯一的，并且有助于模型理解单词之间的距离关系。

## 掩码

控制模型在处理数据时的可见性。

padding 掩码：在对较短句子进行填充后，将填充的数据位置标记为 0，使模型不会关注这些 [PAD]。

Look-ahead 掩码：在训练解码器时，确保模型不会看到未来的信息，使其只基于已经生成的单词进行预测。

## 推理和训练

训练时使用教师强制，计算损失，反向传播，梯度下降

推理则前向传播，逐步生成单词，直到生成结束标记。

## ELMo

Embeddings from Language Models，第一个上下文嵌入模型。
它与 Word2Vec 不同，能够判断多义词。

- 首先它使用 CNN 将单词转为向量
- 然后使用双向 LSTM，将单词的前后文结合起来
- 将多层 LSTM 的输出加权和

## GPT 训练目标

Generative Pre-Training 仅使用解码器，目标是预测下一个单词。
它不能像 BERT 一样考前后文，它只考虑前文。

与 ELMo 类似，它提供一个预训练的“特征提取”模块

## BERT

Bidirectional Encoder Representations，用于生成上下文嵌入。
它能够考虑单词的前后文，更好的理解单词的含义。

它使用了 Masked Language Model，它随机隐藏一些单词，然后让模型猜。

还使用了 Next Sentence Prediction，它随机给模型两个句子，让模型判断这两个句子是否相邻。

# B4 对话系统

## 对话系统的类型

- task-oriented：帮助用户完成特定任务
- open-domain：用于娱乐或其他目的

或者

- 用户发起：如问答系统
- 系统控制：系统主动发起，如日历提醒
- 混合：用户和系统都可以发起

## 一般对话需求

- Grounding：确认理解对方所说内容，建立一个共同语境。

  一个人说出新内容，另一个人确认，有不明白的地方，再次确认。

- Adjacency pairs：问与答，请求与回应等。

  是话语与响应的相关性。

- Pragmatic inferences：根据对话的上下文，推断对方的意图。

  假设对方是有理性的，说的话是有意义，真实，清晰的。

## 开放对话系统

基于规则，比如模式匹配。（古老）

基于检索或生成，比如知识库和GPT。（现代）

## 任务导向对话系统

在确定任务后，用槽值填充，它类似于表单，系统通过提问每一个槽位，填充信息并执行。

## 对话状态系统

与任务导向系统相比，它广泛使用机器学习。

### 对话状态系统组件和使用语言模型的实现

- Dialog State Tracker
  使用 BERT 来选择对话状态。根据历史，跟踪用户目标和信息。

- Dialog Policy
  使用强化学习，根据对话状态，选择下一步的动作。

- NUL
  使用机器学习来识别用户的领域，意图，槽值。

- NLG
  使用Transformer来生成自然语言响应。
  
## 简化的任务导向对话系统

使用单一S2S模型，如SimpleTOD，来完成所有任务，减少复杂性和错误。

## 模式引导系统

它使用预定义的schema graph来生成对话。

## 对话系统的评估

- attractive：继续对话的意愿
- 有多像人类
- 上下文的连贯性
- 流畅性
- 有多少车轱辘话
- 任务成功率
- 填充正确率
- 用户满意度

等

# B5 LLM 推理

## 通用推理参数

- topP
  将元素概率从大到小排列，然后从大到小加起来，加到 P 为止。

- topK
  保留最大的 K 个元素。

- 采样
  比如 greedy，beam search，random sampling

- logit 偏置
  使模型更倾向于选择某些词。

- 温度
  文本多样性

## 边缘推理

在资源有限的设备上，量化到 4 bit，优化 CPU 向量操作，内存映射

## 高效推理

使用 GPU 等进行推理，问题是内存带宽

- 缓存
  保存先前计算的键和值对，重用它们
  高内存占用
  低 GPU 利用率，因为 batch size 不能很大

- Flash
  并行，将 Q·K 矩阵分块
  高 GPU 利用率
  复杂，高内存占用

Softmax 耗时，所以用 Flashdecoding 并行计算

处理并发可以使用分页缓存，预填充，将多个小序列合并为一个序列，以及将长序列分割为多个序列。

## 辅助生成

先用一个小模型生成草稿，然后大模型修正草稿。

## 推测解码

- 有限状态机引导
  类似于根据 schema 生成

- 分类器引导
  比如区分特定风格的文本，小模型生成多个候选，分类器打分

- 专家引导
  和分类器类似，专家模型根据其领域，对生成的文本进行打分和反馈

## 水印

水印用于溯源和检测。

- Red list
  生成过程中，有一组不允许的词，从绿名单中采样

- soft mark
  在绿名单上加偏置，比 red list 更好

水印一般用概率检验。

# B6 LLM 对齐

## 对齐在 AI 中的作用

确保模型符合人类期望，和道德标准。

## 指令跟随模型

- 有帮助的：真正尝试执行所描述的任务
- 诚实的：提供准确的信息，包括在适当情况下表达不确定性
- 无害的：不具有攻击性、歧视性，也不推荐或帮助危险或不道德的行为

## 合成指令数据集

通过生成并收集大量正确的AI 问答，来训练模型。

## 监督微调

在特定数据集上进一步训练。

## 人类反馈强化学习

Reinforcement Learning from Human Feedback

通过人类对答案的打分，通过强化学习，如 Proximal Policy Optimization，微调模型

## 聊天模型

指令微调不支持多轮对话，所以需要聊天模型。
我们直接使用历史对话数据（而不是一问一答），来训练模型。

# B7 提示与答案工程

## LLM 提示基础

提示词应该 详细、具体 和 精确，它可以包括一些描述，约束，示例，步骤等。

## 提示挖掘与改写

挖掘，是从数据中提取有效提示词，以便模型能够更好的生成答案。

假设我们有一个需要从 France is the capital of Paris 中提取国家和首都之间关系的任务

- 中间词提示
  可以使用提示词 [x] is the capital of [y] ，来提取

- 依存关系提示
  可以使用提示 capital of [x] is [y] ，来提取

而改写，就是生成多个提示，并选择最佳的。

## 基于梯度的提示优化

我想要莎士比亚风格的诗，但是我不知道怎么描述。

初始提示可能是：请写一首关于爱情的诗。
随后我们可以使用梯度下降，来优化提示：请写一首关于爱情的莎士比亚风格的诗。

## 提示生成模型

一类专门生成提示词的模型。通常使用 T5 或 Transformer。

## 前缀微调

添加一小段前缀，来让模型生成更好的答案。

比如，你让AI生成一个故事，是一个悬疑故事，那么你可以在前面加上：请写一个悬疑故事。
然后我们使用训练数据，使 AI 看到 "悬疑" 后，能够生成类似的故事。
最后，每次你让 AI 生成故事时，都加上这个前缀，它就会生成更好的悬疑故事。

## 答案工程

也就是对回答进行调优。

- 定义输出格式
  比如，你要求 AI 回答问题时，只说 "是" 或 "否"。

- 映射输出
  比如，它回答 这是真的，我们可以映射为 "是"。

- 优化答案
  根据具体情况进一步优化，比如需要专业回答，那么 天气有点冷 可以改为 温度较低。

## 提示集成

你同时准备多个提示词，然后让模型分别回答，最后综合回答，得到全面准确的答案。

## 基于推理结构的提示

为复杂问题提供一个清晰的思路，一步步解决问题

- Chain-of-Thought
  因为 xxx, 并且 yyy, 所以 zzz

- Self-consistency
  尝试多个解决问题的方法，然后选择最一致的结果

- Self-ask
  AI 自己问自己问题，然后回答

- Knowledge-generating
  比如先写出标准数学公式，然后再进行代入计算

- Tree / Graph of-thought
  通过多条路径，如果不通，则回到上一步，选择另一条路径

- 程序辅助
  比如使用 Python 代码，来协助 AI 解决问题

# B8 嵌入模型与向量搜索

## 向量相似性搜索在增强 LMs 中的作用

它就像是一个搜索引擎，帮助 AI 找到最相关的信息。

## 近似最近邻搜索

首先它将知识文本转换为向量，构建索引，储存起来，
当需要查找信息的时候，把问题转为向量，然后计算问题向量与所有文本向量之间的相似性，
找到最相似的文本，然后用这个文本来回答问题。

## 局部敏感哈希

通过 Binning 分箱，将数据分为多个桶，搜索时先找到相似的桶，然后再在桶内搜索。

## [product] Quantization 量化

将复杂数据转为简单数据，比如将浮点数转为整数，减少计算量。

我们使用 Product 量化，将向量拆分成多个子向量，然后对每个子向量进行量化，然后组合。

## KD 树与优先搜索

KD 树是一个多层分类系统，将数据按不同特征分层。

比如，高的在左，低的在右，然后再按颜色分，再按大小分，等等。

当需要查找的时候，使用优先搜索，找到最近的点。

优先搜索总是先找最有可能包含答案的节点，
然后计算当前位置与最有可能包含答案的节点的距离，
并将其设置为初始距离限制，
然后递归地搜索其他节点，直到找到最近的点。

## 图索引

通过连接相似的节点，形成网络。

小世界是一种特殊的图，你可以通过很少的中间节点找到任何一个节点。

Navigable SW 直接沿着相似的边查找
Hierarchical NSW 在小世界中增加层次结构，减少搜索时间

## 嵌入模型

一个专门将数据转为向量的模型。
比如 Word2Vec，BERT，TF-IDF 等。

其中，我们有句子嵌入，和指令嵌入等。

# B9 检索与工具增强的 LLMs

## 增强 LMs 概述

我们需要额外的工具来给 AI 提供知识，减少 hallucination。

一种是直接将内容填到提示词中，另一种就是嵌入空间向量。

## 检索增强生成

Retrieval-Augmented Generation

- 将用户问题转为查询，关键词
- 使用向量数据库或搜索引擎检索
- 将收集到的信息聚合
- 生成答案

## 假设文档嵌入

AI 为问题生成一个假设答案，然后用这个假设答案去搜索

## RAG 微调模型

Retrieval-Augmented Language Model

使用 检索器（查文档），编码器（文档和输入一起编码），生成器（生成答案） 三个模块。
关键是在训练时，同时优化三个模块。

Retrieval-Enhanced Transformer

增强的 Transformer，检索使用 BERT，然后用在编码器中用 交叉注意力 整合检索信息。

## 自我独白模型

通过 Chain-of-Thought 来进行多次生成，完成复杂任务，如 AutoGPT。

Think, Reason, Plan, Reflect, Act

## 工具微调的可能性

引导模型调用外部工具，按成功率排序，将最好的结果纳入数据集。

# B10 高效注意力机制

## 稀疏注意力

传统注意力需要计算输入序列每个元素之间的权重，这会导致计算量过大。

所以我们将全局注意力转为多个小矩阵，比如行和列两个方向的矩阵。

## 因式分解

其中，有固定注意力，每个位置只关注固定数量的其他位置，适合文本。

跨步注意力，跳跃选择位置，每个位置只关注间隔一定步长的其他位置，适合图像。

## 位置嵌入类型

Extrapolation 是指模型的泛化能力，比如模型是用短句训练的，但是要它生成长句。

传统方法使用 Sinusoidal，
sin 和 cos 函数，将位置信息嵌入到向量中。

## ALiBi

Attention with Linear Biases，引入相对位置偏差。

它根据 Q 与 K 的距离，静态添加一个非学习的偏置。

## RoPe

Rotary Positional Embedding，
将 Sinusoida 嵌入到每个 Q 和 K 上

## 位置插值

也就是将长序列，映射到短序列上。

假设模型支持的最大序列长度为 512，位置信息是线性分布的，例如：
位置编码：[0, 1, 2, ..., 511]

扩展到 2048 的上下文窗口，PI 会根据比例映射新位置：
新位置编码：[0, 0.25, 0.5, ..., 511.75]

## 闪电注意力

按块逐步计算注意力得分和上下文向量，避免了直接存储整个注意力矩阵。
并且让每块分别计算 softmax，减少了内存占用。

# B11 LLM 的蒸馏与量化

## 蒸馏设置与训练目标

## 权重量化算法

## 模型尺寸增加对量化误差的影响

# B12 参数高效微调方法

## 高效适应的优势

## 适配器

## 瓶颈适配器

## 低秩适应

## P*-微调

## 内在维度与模型尺寸的关系

# B13 专家混合

## MoE 的属性

## 现代 MoE 架构在深度学习中的应用

## 基于 MoE 的语言模型

## MoE 适配器

## 快速前馈层

# B14 数据集与自举

## LM 训练步骤所需的数据集类型

## 不同数据源的特征

- 网络
- 艺术
- 专业等

## 使用 LLMs 自举训练
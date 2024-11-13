---
title: NLP-Zoo
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-11-12 18:20:35
---

模型介绍 ~~神 TM 动物园~~

<!-- more -->

# LLM Zoo

我们已经看到了动物园中的一些居民...

![sesame](sesame.jpg)

但还有更多！我们将看看一些最重要的语言模型。

（注意：大多数模型在发布时在许多 NLP/NLU 数据集上达到了最先进的水平。我们不会在每个模型下提到这一点。）

# BERT 家族

## BERT

提醒一下：[BERT](https://github.com/google-research/bert) 是一种基于**transformer encoder**架构的上下文（子）词表示。它在两个自我监督任务上进行了训练：

- 掩码语言模型（MLM）
- 下一句预测（NSP）

它有几种尺寸：

- 基础版：12 个 Transformer 块，110M 参数
- 大型版：24 个 Transformer 块，340M 参数

BERT 催生了一整个模型家族，它们保留了架构并通过微调细节寻求改进。

## 超参数

Hyperparameters，BERT 带来了两个新的训练任务，但 NSP 被证明太简单了。

- ALBERT 用句子顺序预测替代了它
- RoBERTa 完全放弃了这个任务

[RoBERTa](https://github.com/facebookresearch/fairseq/tree/main/examples/roberta) 证明了训练*更长时间*和使用*更多数据*的重要性。

- 数据大小：16GB $\rightarrow$ 160GB
- 批量大小：256 $\rightarrow$ 8K
- 训练步骤：100K（相对）$\rightarrow$ 500K
- 动态掩码：`[MASK]`标记的位置每次运行都会改变

这些变化在各种任务上带来了$3-4\%$的改进（例如在 SQuaD 上减少了$60\%$的错误率）。

## 跨距

Spans，BERT 的掩码方案（`[MASK]`替换单个标记）使其在生成任务中难以使用（例如在问答中填充答案）：

*奥克尼群岛上最古老的定居点是什么？*

- `最古老的定居点是[MASK]。`
- `最古老的定居点是[MASK] [MASK]。`
- ...

（Skara Brae 实际上是 4 个标记：`S ##kara B ##rae`）

另一个问题是被掩码的标记被假定为条件独立的。

[SpanBERT](https://github.com/facebookresearch/SpanBERT)

- 掩码随机长度的跨距（平均 3.8 个标记）
- 基于跨距周围的标记预测它们：$\mathbf{y}_i = f(\mathbf{x}_{s-1}, \mathbf{x}_{e+1}, \mathbf{p}_{i-s+1})$
- 引入了跨距边界目标 $\mathcal{L}_{SBO}$，使得

$$
\mathcal{L}(x_i) = \mathcal{L}_{MLM}(x_i) + \mathcal{L}_{SBO}(x_i) = -\log P(x_i|\mathbf{x}_i) - \log P(x_i|\mathbf{y}_i)
$$

[XLNet](https://github.com/zihangdai/xlnet)

- 完全不使用`[MASK]`标记或 MLM
- **自回归** autoregressive 训练任务在**排列**序列上（仍然是双向上下文）
- 可以建模上下文和目标之间的依赖关系

## 性能

训练类似 BERT 的模型速度慢且占用大量内存。[ALBERT](https://github.com/google-research/albert)通过以下方式解决了这些问题：

1. 将$V \times H$嵌入矩阵分解为两个矩阵：
   $V \times E$ 和 $E \times H$；
   （$V$：词汇表，$H$：隐藏层大小，$E$：嵌入大小；在 BERT 中，$E = H$）

2. 层之间的权重共享

结果模型的参数比相应的 BERT 模型少 18 倍，训练速度快约 1.7 倍。然而，更大的模型（xxlarge）在性能上超过了 BERT Large （如果它们能收敛的话...）。

## 新技术

DeBERTa 通过技术创新改进了常规 BERT：

1. **解耦注意力**（disentangled）机制为每个标记分配两个向量：
   - 内容
   - 位置
2. *相对位置编码*
3. 在 softmax 层之前引入*绝对位置*

它在 SuperGLUE 中表现优于人类基线（90.3 对 89.8）。

# 全栈模型

## T5

**文本到文本转换 Transformer**通过以下方式解决 NLP 任务：

1. 将它们转换为带提示的 seq2seq 问题
2. 用解码器替换 BERT 上的分类器头

它的训练方式为：

1. **去噪** Denoising 目标：丢弃 15\%的标记（类似于 MLM；优于自回归目标）
2. 多任务预训练
3. 在单个 NLP 任务上进行微调

最大的模型有 110 亿参数，并在 1 万亿个标记上进行了训练。

# 解码器模型

## GPT 家族

GPT 家族是最著名的大型语言模型（LLM）。它们由[OpenAI](https://openai.com/)创建，规模不断增加：

| 模型                                       | 参数量 | 语料库 | 上下文长度 |
| ------------------------------------------ | ------ | ------ | ---------- |
| [GPT-1](https://huggingface.co/openai-gpt) | 110M   | 1B     | 512        |
| [GPT-2](https://huggingface.co/gpt2)       | 1.5B   | 40GB   | 1024       |
| GPT-3                                      | 175B   | 300B   | 2048       |
| InstructGPT                                | 175B   | 77k    | 2048       |
| GPT-4                                      | ?      | ?      | 8192^\*^   |

^\*^GPT-3.5 和 GPT-4 的详细信息尚不可用。有一些估计，但[许多](https://tooabstractive.com/how-to-tech/difference-between-gpt-1-gpt-2-gpt-3-gpt-4/)甚至无法正确描述之前的模型。

## GPT-1

最初，GPT 被设计为一个自然语言理解（NLU）框架，类似于 ELMo 或 BERT：

- 它是第一个推广预训练 + 微调方法用于 NLP 任务的模型
- 自回归预训练**并非**出于文本生成的动机

结果：

- GPT-1 在测试的 12 个任务中有 9 个达到了最先进的水平
- 它展示了一些零样本能力

## GPT-2

更大的模型尺寸带来了更好的零样本性能：

![LM 任务上的零样本性能](gpt2_zero_shot_lm.png)

![NLP 任务上的零样本性能](gpt2_zero_shot_nlp.png)

## GPT-3

架构和训练的变化：

- 交替使用密集和稀疏（dense and sparse）注意力层
- 采样训练（并非使用所有训练数据）

在几个任务上的少样本性能非常接近最先进水平。

问题：

- 防止基准测试的记忆化
- 输出中的偏见（性别、种族、宗教）
- 训练期间的高能耗（通过相对较小的训练语料库缓解）

## InstructGPT

增加了指令支持。

- RLHF（之前提到过）
- 与增加预训练分布对数似然的更新混合，以防止模型退化
- 1.3B 的 InstructGPT 比 175B 的 GPT-3 更受欢迎
- API prompts 比 FLAN 或 T0 数据集更好
- 降低了毒性（toxicity），但没有减少偏见（bias）

## GPT-4

更大、更好、多模态（视觉）。在考试中表现达到人类水平（前 10\%）。

指令：

- 对考试没有帮助
- 扭曲（Skews）了**置信度校准**（calibration）（答案的对数似然与实际表现的相关性）

两种安全方法：

- RLHF
- 基于规则的奖励模型（RBRMs）

## 其他模型家族

GPT 并不是唯一的 LLM 模型“家族”。还有一些竞争对手，包括开源和闭源的。

1. 闭源
    - [Claude](https://claude.ai/)（版本 3）
    - Google 的 [Gemini](https://gemini.google.com/)
2. 开源
    - Meta 的 Llama（版本 [3.2](https://ai.meta.com/blog/llama-3-2-connect-2024-vision-edge-mobile-devices/)）
    - [Mistral](https://docs.mistral.ai/)（版本 0.3）
    - 阿里巴巴的 [Qwen](https://huggingface.co/Qwen)（版本 2.5）

## 其他模型

仅解码自回归模型已成为事实上的 LLM 标准，并且提出了许多其他模型。以下是一些值得注意的例子。

- **Megatron**
  - GPT（8.3B）和 BERT（3.9B）版本。训练于 174GB 文本
  - 引入了**模型并行**（parallelism）
- **Gopher**
  - 280B，训练于 *MassiveText*，但仅在 2350B 中的 300B 标记上（12.8\%）
  - 使用**相对位置编码**，允许对比训练期间看到的更长序列进行推理
- **GLaM**
  - 一个稀疏模型，具有 1.2T 参数，训练于 1.6T 标记
  - 使用**专家混合**（Mixture of Experts）层与 transformer 层交错
  - 每个标记仅激活模型的 8\%（96.6B）
    训练成本是 GPT-3 的 $\frac{1}{3}$
- **LaMDA**
  - 137B，训练于 1.56T 标记
  - 一个专门用于对话的模型；训练语料库的 50\% 由对话组成
  - 针对质量、安全性和基础性（“基础指标”）进行微调
  - 端到端模型，包括调用外部 IR 系统以确保基础性
- **FLAN**
  - 基于 LaMDA。使用**数据集成**方法进行指令微调，来自 62 个 NLP 数据集
  - 比 LaMDA、GPT-3 或 GLaM 更好的零样本性能
- **PaLM**
  - 最大的模型之一：540B 参数，训练于 780B 文本
  - 使用**Pathways**技术在 2 个 Pods 中的 6144 个 TPU v4 芯片上训练
  - 不连续的改进：在某个模型大小之后准确性急剧跳跃（而不是连续的幂律）
  - 突破性表现。在几个任务上，它比
    - 平均人类表现
    - 监督系统
    更好

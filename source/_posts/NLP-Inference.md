---
title: NLP-Inference
toc: true
categories:
 - [AI, NLP]
tags: [笔记, AI, NLP]
date: 2024-11-08 16:30:28
---

推理，生成，水印

<!-- more -->

# 介绍

随着语言模型变得越来越大，关于如何有效地使用它们、如何使它们的答案更加多样化（“创造性”），以及如何防止它们生成有害内容的问题也随之而来。我们将讨论以下主题：

- 标准LLM推理方法和参数
- “边缘”和服务器推理
- 辅助推理和推测
- 引导文本生成
- 推理时模型“适应”
- 水印

# 标准LLM推理

## 回顾：采样

- **贪婪解码**：总是选择最可能的标记 $w_t = \arg\max_{w} P(w|w_{t-c}, \ldots, w_{t-1})$
- **随机采样**：从分布 $P(w|w_{t-c}, \ldots, w_{t-1})$ 中采样
- **束搜索**：在每一步保留 $b$ 个最可能的序列
- **随机束搜索**：从 $b$ 个最可能的序列中采样

## 概率分布

Softmax 用于将模型的 logits 转换为概率分布。为了从最可能的标记中提取概率质量（从而使模型更加“创造性”和不那么重复），我们可以使用温度缩放：

$$
P(w|w_{t-c}, \ldots, w_{t-1}) = \frac{\exp(\textit{logits}(w) / T)}{\sum_{w'} \exp(\textit{logits}(w') / T)}
$$

其中 $T$ 是温度参数。

### Top-k 采样

计算整个词汇表的 softmax 是昂贵的，低评分的标记通常不有趣，因此在每一步几乎限制词汇表到前 $k$ 个标记是可行的。这称为 top-$k$ 采样。

### Top-p 采样

核采样，或 top-$p$ 采样，以不同的方式限制词汇表：它保留最可能标记的最小集合，其组合概率质量达到（并超过）阈值 $p$。

给定以下标记和概率集：

**苹果** (0.3), **香蕉** (0.2), **樱桃** (0.15), **枣** (0.1), **接骨木** (0.1), **无花果** (0.1), **葡萄** (0.05)

一个 top-$p$ 采样，$p=0.6$ 将保留 **苹果**、**香蕉** 和 **樱桃**。

## Logit 偏置

我们还可以对模型的 logits 进行偏置，以偏向某些标记。这可以用来防止模型生成有害内容，或者使其生成更符合某种风格的内容。例如，意图分类将受益于对类别标签标记添加较大的正偏置，同时抑制其他标记的概率。

更复杂的情况包括“存在”和“频率”惩罚，其中前者对当前文本中出现的标记施加固定惩罚，而后者随着出现次数的增加逐步减少偏置。

应用的公式因实现而异，但惩罚通常使用指数形式。

## Beam 大小，最佳 N

束大小 $b$ 是束搜索的一个超参数。它是每一步保留的序列数量。较大的束大小将导致更多样化的输出，但也会显著减慢推理速度。束根据其累积概率对序列进行排序，并且可以在推理结束时选择最佳的 N 个序列。

更激进的方法包括完全重启，其中推理从头开始重复 N 次，并选择最佳序列。

# 高效和边缘推理

## CPU 推理

在 CPU 上进行推理通常速度较慢且内存有限。为了克服这些限制，当前的边缘计算库将模型的权重量化为 4-bit 整数（从 32 位浮点数）。这显著提高了速度并减少了内存占用。

llama.cpp 是一个流行的在 $C^{++}$ 上运行的 LLM CPU 推理库（也有 Rust 变体）。它优化了使用基于 CPU 的高级向量操作。显著成就包括在桌面 CPU、树莓派模型、Apple Silicon、安卓手机上运行 7B GPT 模型，并且还支持桌面混合 CPU-GPU 推理。

最新版本使用 `mmap` 兼容的内存映射来按需从磁盘加载和卸载权重。

## 高效 GPU 推理

使用 GPU 进行推理时，除了内存容量外，限制因素是内存带宽，因为逐个生成标记需要大量的内存访问操作。

- 为了克服这一点，可以进行**缓存**，我们将先前计算的键和值对保存在内存中，并在下一个标记生成时重用它们

- 这样，每个批次中的查询大小通常为 $1$，由于内存限制，批次大小通常较低（低于 GPU 中的处理单元数量）--> **低 GPU 利用率**

- **Flash 解码** 将 $QK$ 乘积计算并行化到序列长度上，softmax 和输出在并行处理完成后计算

### Flash 解码 vs 仅缓存

关于两者区别的：

![缓存和迭代解码](https://crfm.stanford.edu/static/img/posts/2023-10-13-flashdecoding/parallelization.gif)

![Flash 解码](https://crfm.stanford.edu/static/img/posts/2023-10-13-flashdecoding/parallelization_kv.gif)

## Softmax 问题

计算注意力分数中的 softmax 也可能成为瓶颈。LLM 通常使用“最大值”技巧来防止指数溢出（$\exp{x_i}\rightarrow\exp{x_i - \max{x}}$），但这包括一个最大值计算，这很难并行化。 Flashdecoding++ 使用了一个经验技巧。它使用基于 activation statistics 的 fixed global constant 来防止溢出，因此 softmax 的元素可以并行计算。如果方法遇到溢出，它将使用实际最大值重新计算 softmax，但这种情况的发生概率应小于 1%。

Flashdecoding++ 还通过双缓冲升级了通用矩阵乘法（General Matrix Multiplication，GEMM），以解决低批次大小下的内存延迟问题，并根据给定的 LLM 和批次大小启发式地选择最佳实现。

![Softmax 计算类型](stable_softmax.png)

### 最大注意力值

![最大注意力值](attn_score_distrib.png)

## 处理并发请求

给定一个集中式推理服务器，我们通常期望尽可能少的延迟并行处理大量请求。高性能推理包括两个阶段：

- **预填充**：处理用户提示，计算并缓存 K 和 V。这可以在单次传递中完成，并且可能比生成的输出序列更长。这还包括生成第一个输出标记

- **解码**：这是生成下一个标记并计算下一个 K 和 V 的迭代过程。这不能并行化，但可以重用缓存中的 K 和 V。我们只需要为每次传递计算一个 Q

### Flashdecoding++

![解码器推理从预填充和解码阶段需要完全不同的计算方法](flashdecpp.png)

## 并发请求的问题

- **Monolithic KV 缓存**：长序列的 KV 缓存可能导致内存碎片化，从而减慢推理速度并导致内存使用效率低下

- **短序列**：短序列无法利用变压器的输入大小，因此传统上填充它们是一种解决方案，但在内存和计算方面是浪费的

- **不同的预填充和解码时间**：我们可以估计给定请求的预填充时间，但解码时间难以预测。这可能导致处理队列中的阻塞和气泡效应

- **次优的 GPU 利用率**：使用正确的批次与序列长度比率对于高效的 GPU 利用率至关重要。我们无法控制传入请求的长度

### 解决缓存问题

缓存分页是一种高效的方法，受虚拟内存管理的启发，解决了各种缓存问题，例如**内存碎片化**、**未知的解码长度**、**共享序列前缀**。

Pages（小的固定大小内存块）用于存储 KV 缓存，以使逻辑上连续的序列存储在非连续的物理内存中。然后利用 PagedAttention，这是一种基于页面的间接部分注意力（可以以类似于 flashdecoding++ 的方式并行化）。vLLM 是一个实现此方法的框架。

## 内存问题

![内存问题 预分配但未使用和碎片化的序列可能会占用 5-15% 的 GPU 内存](paged_attn_fragment.png)

### vLLM 虚拟化

![虚拟化缓存处理](vllm.png)

### 逻辑 vs 物理内存

![逻辑 vs 物理内存](paging.png)

## Solving cache problems

这种方法允许动态内存分配和解码长度变化的释放，以及在序列之间共享缓存，并消除具有相同提示或束搜索输入的重复项。

共享前缀在聊天模型中非常常见（通常每个用户与相同的系统提示交互）。Hydragen 提出了进一步的优化，不仅用于缓存，还用于 QK 乘积计算。通过分别计算前缀和序列其余部分的 QK 乘积（可能在单独的传递中），节省了计算，并且前缀在 GPU 工作内存中从页面中读取一次。

### Hydragen

![Hydragen 的前缀和后缀单独计算](hydragen.png)

## Piggybacking 和连续批处理

可以将小的输入序列组合在一起，形成一个较长的序列，并使用掩码等方法在多个分区上计算注意力。这样，我们可以在一次传递中计算多个解码标记。这称为 continuous batching 或 piggybacking。

混合预填充和解码批处理也是可能的，其中一部分用于计算 KV 缓存，而另一部分用于生成标记。这对于消除解码期间的气泡效应非常有用（长序列处理必须完成后才能开始下一个任务，从而导致 GPU 利用率低下）。

## Microbatching

将长序列拆分为较小的部分并并行处理，同时将尽可能多的解码任务填充到连续批处理中（解码最大化微批处理）是解决不同序列长度引起的气泡问题的好方法。然而，不同请求的解码时间以及预填充和解码处理时间的总体差异可能会导致微批处理无法解决的气泡。

DeepSpeed-FastGen 还测量了最佳 GPU 吞吐量曲线，并使用此启发式方法找到适合给定 LLM、批处理大小和 GPU 的上下文长度。这通常只有几百个标记。

### Sarathi 解决的气泡效应

![Sarathi 的高效微批处理解决的气泡效应](sarathi.png)

### GPU 利用率

![不同上下文长度的 GPU 利用率曲线，超过约 400 个标记后吞吐量没有优势](splitfuse_saturation.png)

## 混合预填充和解码

每个任务还有不同的限制特征：

- 预填充是计算受限的
- 解码是内存受限且延迟关键的

对它们进行联合优化通常会导致干扰（你不能同时优化内存访问和计算）。解决方案：将它们解耦，通过另一个抽象层将逻辑预填充和解码请求映射到不同的物理资源（GPU）。

根据当前负载和预期的解码长度，将 GPU 分配给预填充或解码任务（像这样的解决方案开发了一个长度预测模型来实现这一点）。

### 解耦(Decoupled)预填充和解码

![通过使用单独的资源进行预填充和解码，我们可以分别优化这两个任务](tetrinfer.png)

# 辅助推理和推测

## Assisted inference

辅助推理或推测推理是一种方法，其中我们的大型自回归模型由一个较小的“草稿”或“助手”模型引导。其思路是自回归地运行助手模型并生成几个标记的序列，然后运行原始模型进行单步推理。这样，原始模型在单次传递中评估助手的整个“推测”（我们检查每个新添加标记的输出，而不仅仅是最后一个）。可能的结果是：

- 助手模型第一个标记错误 $\rightarrow$ 原始模型将纠正该标记
- 助手模型某些标记正确 $\rightarrow$ 原始模型接受这些标记并纠正第一个错误标记
- 助手模型所有标记正确 $\rightarrow$ 原始模型接受整个序列并生成下一个标记

![验证助手的输出。黑色为验证，绿色为接受，红色为拒绝，蓝色为纠正](speculative_decoding.png)

[视频资源](https://huggingface.co/datasets/huggingface/documentation-images/resolve/main/blog/assisted-generation/gif_4_1080p.mov)

## 预测多少个标记？

- 给定 speculate 标记的数量 $\gamma$
- 助手模型在给定序列上的标记接受率 $\beta$
- 模型的一般预期接受率 $\alpha = \mathbb{E}[\beta]$
- 单次运行的成本系数 $\frac{T_{\text{assistant}}}{T_{\text{original}}}$

模型总是生成 $1$ 到 $\gamma+1$ 个标记。平均接受的标记数量为 $\frac{1-\alpha^{\gamma+1}}{1-\alpha}$。生成一个标记的预期成本为 $(c\gamma + 1)T_{\text{original}}\cdot\frac{1-\alpha}{1-\alpha^{\gamma+1}}$。总改进为 $\frac{1-\alpha^{\gamma+1}}{(c\gamma + 1)(1-\alpha)}$。

在有足够内存进行预测且 $\alpha > c$ 的情况下，我们选择最大化改进的整数 $\gamma$。

## 预测解码结果

给定一个标准 LLM，例如 Chincilla(70B) 和一个 4B 的助手模型，使用 $\gamma=3$ 且 $c=0.13$ 时，预期接受率约为 $\alpha=0.7$。这种方式的改进约为 $1.82$（推理速度提高 1.82 倍）。

T5 模型也可以通过这种方法改进，例如在英语到德语翻译中，XXL (11B) 模型可以由小型 (60M) 模型辅助。这里的预期接受率约为 $\alpha=0.75$，改进约为 $3.4$，使用 $\gamma=7$。

采样通常会降低接受率，但改进仍然显著。

## 进一步方向

- **分块解码和验证**：先前的研究表明，通过小规模的微调，可以为模型附加多个输出头，不仅预测下一个标记，还预测接下来的 $k$ 个标记。然后我们可以假设这些 $k$ 个标记是由助手模型生成的，并使用原始输出作为验证器。算法类似于上面描述的，但使用具有多个输出的单个模型

- **重用**：辅助可以来自先前生成的标记，例如提示本身、缓存的历史记录、其他用户的会话等。然后由原始模型进行验证

### 分块解码头

![分块解码创建多个输出头，预测第 $k$ 个下一个标记，它们作为弱训练的助手，而 $k=1$ 是原始验证器](block_decode.png)

### 重用标记

![重用先前生成的标记（和 KV 缓存）的三种简单情况](reference_cases.png)

# 引导文本生成

Logit 偏置值可以根据辅助评分函数动态设置。这可以用来引导模型生成更符合特定用例的文本，或限制模型的输出风格。

这还可以包括有限状态机，其中模型的输出词典根据机器的当前状态受到限制。如果我们根据例如给定的正则表达式构建 FSM，我们可以保证模型生成的文本与正则表达式一致。

## 基于 FSM 的引导

![基于 FSN 的引导系统在一个小词汇表上。黑色标记是不允许的](fsm_sample.png)

## 分类器引导

分类器也是可行的引导工具，其中输出 logits 被偏向所需的类别，使用辅助分类器。这被证明在避免有害文本方面是有用的。对所有词汇元素进行此操作是不可行的，因此选择了一组得分最高的标记进行重新评分。

小型专家语言模型和专家+反专家对也可以用来输出一个 logit 分布，然后用于引导。在专家+反专家对的情况下，我们取两个模型 logits 的差值，并将其用作引导信号。

## 专家引导

![使用小型专家和反专家模型的专家引导。专家 logit 差值用作引导信号](expert_guide.png)

## 推理时模型“适应”

代理微调是一种有前途的方法，它利用专家和反专家模型，其中专家是一个小型微调模型，反专家是代理的原始未调版本。通过这种方式，可以进行指令微调和各种对齐方法（过滤有害响应等），以及提高模型在下游任务中的性能。代理微调在“沟通风格”类任务中表现出色，同时在事实性和连贯性方面也有所改善。

代理微调的突出特点是它是*模型无关的*（仅限于词汇表）、*便携且可重用的*、*硬件高效的*（无需对大型模型进行微调，这将非常昂贵），并且*可组合的*，因为可以同时使用多个专家和反专家。

### Proxy-tuning

![代理微调设置（类似于专家引导和无分类器引导）](proxy_tune.png)

### 代理微调结果

![代理微调在各种任务上的结果。对于对齐任务，改进显著。使用微调代理比使用代理微调的大模型更有益](proxy_tune_res.png)

# 水印

## 为什么需要水印？

随着大型语言模型（LLM）的性能不断提高，对模型输出的可追溯性和可检测性的需求也在增加。水印是一种在模型输出中嵌入独特模式的方法，其特点是：

- 对模型性能影响微乎其微（人类无法察觉）
- 验证简单且快速
- 无需了解模型参数即可验证
- 在相对较小的标记集上工作
- 不易移除（部分移除或修改仍可检测）
- 无需重新训练模型

## 硬性红名单策略

红绿名单策略是一种简单的水印方法。在推理的每一步中，我们选择一组不允许生成的红名单标记（其余为绿名单标记）。这样，我们可以通过以下步骤在模型输出中嵌入独特模式：

1. 取最后一个标记 $t-1$，并使用哈希函数生成随机种子
2. 使用该种子生成随机数，将词汇表分为红绿两半
3. 使用 LLM 的 logits 从绿名单中采样一个标记

### 检测硬性红名单水印

一种基线检测方法是从以下事实出发：在不知道红名单标记的情况下，生成长度为 $T$ 的序列而不违反红名单的概率是 $\left(\frac{1}{2}\right)^T$。即使是短序列，这个概率也非常低。

一种更复杂的方法是对以下零假设使用 z 检验：文本序列是在不知道红名单规则的情况下生成的。

假设绿名单标记的数量为 $G$，其期望值为 $0.5T$，方差为 $0.25T$，我们可以计算 z 分数为：

$$z = 2(G-0.5T)/\sqrt{T}$$

如果 $z$ 超过给定阈值，我们就拒绝零假设。作者建议使用 $z>4$ 作为拒绝标准，因为在这种情况下，误报率为 $3\cdot10^{-5}$，并且我们可以检测到所有包含 $16$ 个或更多标记的水印。

考虑到对手的标记翻转会在最坏情况下导致 $t$ 和 $t+1$ 处的违规，因为哈希函数依赖于前一个标记。

这意味着对于 $T=1000$ 的标记，修改 $200$ 个标记最多会导致 $400$ 次违规，对于这种情况，$z$ 分数仍然约为 $6.3$。

通常，移除水印需要修改至少 $25\%$ 的标记。

## 低熵序列

从硬性水印的角度来看，Low entropy 序列（模型输出高度可预测的地方）是有问题的。

首先，人类也很有可能生成相同的序列（例如在 Barack 之后跟随 Obama）。对这些序列进行水印是适得其反的。

其次，硬性水印通常会破坏这些序列，因为高概率的标记可能会落入红名单。

## 软性水印

解决低熵序列水印问题的一种方法是软性水印，其中绿名单标记仅相对于红名单标记获得小的（而不是完全的）优势。

我们在应用 softmax 之前在绿名单的 logits 上加上一个小的 $\delta$。这样，当熵高时，绿名单标记获得相对较高的优势，但在熵低的情况下，即使是红名单中的单个最佳标记（$p\sim1$）也不会有劣势。

作为另一种扩展，我们可以选择词汇表的一部分 $\gamma$ 作为绿名单标记。这是一个通常保持在 $0.5$ 的超参数。

### 检测软性水印

检测软性水印比检测硬性水印更困难。z 检验仍然适用：

$$z = (G-\gamma T)/\sqrt{T\gamma(1-\gamma)}$$

误报率仍然很低，但对于低熵序列，检测率会下降。

在给定标记生成时，最大偏离分布的最坏情况困惑度增加为 $(1+(e^\delta-1)\gamma)P_{\text{original}}$（对于 $\delta=2$ 和 $\gamma=0.5$ 约为 $4$）。

### 软性水印侵蚀 erosion

当 logit 分布集中在少数几个标记上时，水印较弱。

对于平均熵序列，水印在 $T=200$ 个标记中仍然有 $98.4\%$ 的检测率，$\gamma=0.5$ 和 $\delta=2$。

对于低熵序列，检测率会下降。这种情况发生在重复的特定文本和记忆的序列中，模型基本上再现了它之前见过的完全相同的文本。

可以通过在 z 检验中仅包括 n-gram 的第一次出现，或使用更多的先前标记来计算哈希函数来解决重复文本的问题（因此红名单对于所有较短的 n-gram 不会相同）。

## 私有水印

从检测器的决策中推断水印方法是可能的，通过提交 $|V|^h$ 个标记到检测器，其中 $h$ 是哈希函数中使用的标记数量。为了对抗解密，我们可以使用更大的 $h$，但这也会引入检测困难，因为翻转一个标记可能会影响接下来的 $h$ 个标记，并平均破坏 $0.5h$ 个标记。

使用更复杂的方法也是可行的，这些方法依赖于当前标记和前 $h$ 个标记中的一个，其中错误率降低到 $1/h$。

使用具有秘密密钥的加密哈希函数（如 AES 或 SHA3）也可以实现私有水印。这样，攻击者在不知道密钥的情况下无法检测到水印。

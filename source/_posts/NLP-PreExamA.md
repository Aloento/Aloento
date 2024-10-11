---
title: NLP-PreExamA
toc: true
categories:
  - [AI, NLP]
tags: [笔记, AI, NLP, 考试]
date: 2024-10-11 20:41:56
---

期中考试，人已死

<!-- more -->

# A1 语言结构和语法

Linguistic structure and grammars (Linguistic structure, representation levels, grammars, parsing task, generation task, relation to NLP pipelines)

## 语言结构

### 表示层次

phonological 也就是类似于字母表，音素音标的最小单元，通常本身没有意义

随后它们可以构成 morphological，也就是词根，词缀，词尾等，这些构成了词，是有意义的最小单位

词可以构成句子，这就是 syntactic，但是光满足语法要求不能说明句子有意义

所以我们有 semantic，去解释句子的意义和指代的对象等

### 语法

grammar 指导你如何构建句子，如何解析句子

同时也包括 phonological，也就是发音的规则，声调，哪些音可以拼在一起等

当然也包括 morphological，比如进行时过去时之类的

## 解析任务

基本上来说就是判断一个句子是否符合语法规则

然后再分析它们的结构，找出句子表达的意义

## 生成任务

有两种，一种是很傻的无条件生成，也就是不管句子是否有意义，直接按语法规则生成

另一种是有条件生成，生成满足一定需求的句子，也就是有意义的句子

## 与NLP管道的关系

在那时我们还没有 transformer 和端到端模型，所以我们需要一步一步的去拆解和分析句子

也就是我们在管道中执行人为设计的算法，帮助计算机理解句子

# A2 传统NLP管道中的元素和任务

Elements and tasks in the traditional NLP pipeline (Structure/order of the pipeline, tokenization, sentence splitting, morphology, POS tagging, syntactic parsing, NER, coreference resolution, entity linking, WSD, semantic role labeling, semantic parsing)

## 管道的结构/顺序

实际上PPT中有一个重要的内容没有提到，那就是管道的第一步：预处理

预处理基本就是删除特殊字符，然后统一大小写，去除停用词 the a an 等

随后遵循以下步骤：

先分词，然后拆句子，标词性（POS），解析句法，找命名实体，合并相同指代，链接实体，消除歧义，标语义角色，最后解析语义

## 分词

简而言之就是将句子拆成一个个词，具体怎么拆看需求，同时还可以有规范化的过程

对于如何处理缩写，数字，特殊表达，还有多个词组成的词等，都有不同的处理方式

更进一步的细节看下面专门的章节

## 句子切分

有的时候我们的输入是一大段话，所以我们需要将其拆成一个个句子

这个过程也不是那么简单，比如句号后面的 Mr. Mrs. Dr. 等不应该拆开

## 形态学分析

其实也就是把词再拆开，比如动词的时态，名词的复数等

我们可以通过这个方式确定一个词的格式是否正确

然后我们就能进行时态标注一类的任务了

stem 通常不完整，而 lemma 是完整的，比如 produc 和 produce

## 词性标注

Part-of-speech tagging，简称 POS，就是给每个词标标记角色

none (名词)，verb (动词)，adj (形容词), adv (副词), pron (代词), prep (介词), conj (连词), interj (感叹词), det (限定词), num (数词), art (冠词), aux (助动词), modal (情态动词), cop (系动词), part (分词), punct (标点符号), sym (符号)

## 句法解析

其实也就是通常意义上的语法了，基于 constituent 的解析就是找出句子中谁是 NP(noun phrase)，VP(verb phease)等

更重要的是 dependency parsing，找出句子中的依赖关系，比如主谓宾关系

具体的后面会有专门的章节

## 命名实体识别

就是找出句子中的专有名词，比如人名，地名，机构名等，还有时间，日期等

## 指代消解

就是把指向相同对象的指代词标记出来

比如，我的姐姐，她...，这里的她就是指代消解的对象

## 实体链接

就是把命名实体链接到知识库中的实体，比如把北京这个词指向百科中的北京

## 词义消歧

就是找出一个词在句子中的具体含义，比如 bank 是银行还是河岸

## 语义角色标注

也就是谁做了什么，对谁做了什么，在哪里，什么时候

句法解析主要关注语法，而角色标注关注的是含义

## 语义解析

这就是一个合并任务了，把前面的步骤整合起来，找出句子的含义

# A3 经典（全词）分词

Classical (whole-word) tokenization (Tokenization task definition, whitespace splitting, regular expressions, and regex cascades, lexers)

## 分词任务定义

## 空白分割

## 正则表达式和级联

## 词法分析器

# A4 编辑距离和子词分词

Edit distance and subword tokenization (Edit distance, subword tokenization, Byte Pair Encoding, WordPiece, SentencePiece)

## 编辑距离

## 子词分词

## 字节对编码

## WordPiece

## SentencePiece

# A5 一般语言建模

Language modeling in general (Language model, continuation probabilities, role of start and end symbols, text generation, LM evaluation)

## 语言模型

## 续接概率

## 起始和结束符号的作用

## 文本生成

## 语言模型评估

# A6 基于N-gram的语言建模

N-gram-based language modeling (Estimating sequence and word probabilities, N-gram models, markov models, Smoothing)

## 序列和词概率估计

## N-gram模型

## 马尔可夫模型

## 平滑

# A7 使用经典方法进行文本分类

Text classification with classical methods (Classification tasks, bag of words, TF-IDF, naive Bayes, discriminative methods)

## 分类任务

## 词袋模型

## TF-IDF

## 朴素贝叶斯

## 判别方法

# A8 使用经典方法进行序列标注

Sequence tagging with classical methods (Sequence tagging tasks, IOB tagging, supervised methods, HMM, Viterbi algorithm, MEMM, CRF, optimization and inference, generative and discriminative models)

## 序列标注任务

## IOB标注

## 监督方法

## 隐马尔可夫模型

## 维特比算法

## 最大熵马尔可夫模型

## 条件随机场

## 优化和推理

## 生成模型和判别模型

# A9 依存句法解析

Dependency parsing (Dependency grammar, projectivity, transition-based parser, graph-based parsers, non-projective parsing)

## 依存语法

## 投射性

## 基于转换的解析器

## 基于图的解析器

## 非投射性解析

# A10 基于词汇资源和潜在语义分析的词汇语义学

Lexical semantics based on lexical resources and LSA (Word senses and dictionaries, lexical relations, word vectors, latent semantic analysis)

## 词义和词典

## 词汇关系

## 词向量

## 潜在语义分析

# A11 Word2vec和GloVe

Word2vec and GloVe (CBOW and Skipgram tasks, neural embeddings, training architectures, negative sampling, GloVe algorithm)

## CBOW和Skipgram任务

## 神经嵌入

## 训练架构

## 负采样

## GloVe算法

# A12 评估词嵌入和基于内部词结构的嵌入

Evaluating word embeddings and embeddings based on internal word structure (Intrinsic evaluations, extrinsic evaluations, subword [fastText] embeddings)

## 内在评估

## 外在评估

## 子词[fastText]嵌入

# A13 使用RNN进行语言建模和序列处理

Language modeling and sequence processing with RNNs (Four types of sequence processing, sequence tagging, bidirectional RNNs, sequence encoding, sequence generation, seq2seq tasks, LSTM architecture)

## 四种类型的序列处理

## 序列标注

## 双向RNN

## 序列编码

## 序列生成

## seq2seq任务

## LSTM架构
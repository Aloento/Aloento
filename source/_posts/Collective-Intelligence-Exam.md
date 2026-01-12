---
title: Collective Intelligence Exam
toc: true
categories:
  - [AI, CI]
tags: [集体智能, 考试]
date: 2025-12-20 21:01:00
---

我为什么会有这么多课

<!-- more -->

## 2024-12-18 A

### 1. Iterated Prisoner’s Dilemma

**Question**
What is the rational strategy in the _Iterated Prisoner’s Dilemma_ game when the number of iterations is **K**?
Explain your answer.

当多轮囚徒困境（迭代次数为 **K**）中，什么是理性的策略？请解释你的答案。

<details>

1, 什么是囚徒困境（Prisoner’s Dilemma, PD）

这是一个**两人博弈**，每一轮中，每个玩家都有两个选择：

- **C（Cooperate，合作）**
- **D（Defect，背叛）**

经典收益关系满足：

| 你的选择 | 对方选择 | 你的收益  |
| -------- | -------- | --------- |
| C        | C        | 中等（R） |
| D        | C        | 很高（T） |
| C        | D        | 很低（S） |
| D        | D        | 很低（P） |

并且满足不等式：

$$
T > R > P > S
$$

**单轮囚徒困境的结论**：
不管对方做什么，**D（背叛）都是理性选择**（支配策略）。

---

2, 什么是“迭代”囚徒困境（Iterated PD）

- 同一对玩家 **重复玩 K 轮**
- 每一轮的选择都会影响**未来轮次**
- 总收益 = 所有轮次收益之和

关键区别：

> 单轮 PD → 没有未来
> 迭代 PD → **有未来惩罚 / 回报**

---

3, “理性策略”是什么意思？

在博弈论中，“理性”通常指：

- 玩家 **完全理性**
- 知道游戏结构
- 知道对方也是理性的（**共同知识**）
- 目标是 **最大化自身总收益**

---

题目中的关键信息隐含了一个**极其重要的条件**：

**K 是已知的、有限的**

核心结论：

当囚徒困境的迭代次数 **K 是已知的有限值** 时，理性的策略是 **每一轮都选择背叛（Always Defect）**。

---

Step 1：从最后一轮开始（Backward Induction，逆向归纳）

第 K 轮（最后一轮）

- **这是最后一次**
- 没有未来惩罚或奖励
- 等价于 **单轮囚徒困境**

在单轮 PD 中：

- 背叛（D）严格支配合作（C）

**理性玩家在第 K 轮一定会背叛**

---

Step 2：倒数第二轮（第 K−1 轮）

双方都知道：

- 第 K 轮 **必然是 D**
- 所以第 K−1 轮的选择 **不会影响未来行为**

那么第 K−1 轮也等价于单轮 PD
理性选择仍然是 **D**

---

Step 3：不断向前推

同样的逻辑适用于：

- 第 K−2 轮
- …
- 第 1 轮

最终结论：

> **在每一轮中，合作都无法带来未来收益，因此理性选择始终是背叛。**

---

| 情况                    | 结论                 |
| ----------------------- | -------------------- |
| **K 已知且有限**        | Always Defect        |
| **K 无限 / 不确定**     | 合作策略可能是理性的 |
| **进化博弈 / 群体博弈** | 合作可稳定存在       |

**本题明确是“已知 K”的理论博弈论问题**

当囚徒困境的迭代次数 K 是已知且有限时，理性的策略是在每一轮都选择背叛。

这是因为可以使用逆向归纳法：在最后一轮中，背叛是严格占优策略；而既然最后一轮无法被未来惩罚影响，那么前一轮的合作也无法带来额外收益，因此理性选择仍然是背叛。该推理递归地适用于所有轮次。

**Q：那为什么现实中人会合作？**

A：因为现实中通常 **K 不确定、存在声誉、重复博弈不完全信息或进化选择**，不满足本题假设。

</details>

### 2. Game Theory – Symmetric Two-Person Game

Analyze the following game:

分析以下博弈：

|       | A     | B     |
| ----- | ----- | ----- |
| **A** | 5 , 5 | 1 , 5 |
| **B** | 5 , 1 | 0 , 0 |

Answer the following:

请回答下列问题：

- Is there a dominant strategy for the players?

  - If yes, which one and why?
  - If not, explain why.

是否存在占优策略？

- 如果存在，是哪一个？为什么？
- 如果不存在，请解释原因。

- Is **A** an _evolutionarily stable strategy (ESS)_? Explain your answer.

- 策略 **A** 是否为进化稳定策略（ESS）？请解释你的答案。

<details>

先读表：它到底表示什么？

表里每个格子是 **(行玩家收益 , 列玩家收益)**。

|       | A     | B     |
| ----- | ----- | ----- |
| **A** | 5 , 5 | 1 , 5 |
| **B** | 5 , 1 | 0 , 0 |

- 你是“行玩家”，对方是“列玩家”
- 你选 A/B，对方也选 A/B
- 例子：你选 A、对方选 B → 你得 **1**，对方得 **5**

因为题目说 **symmetric（对称）**，所以双方地位一样，矩阵也对称（你看 (A,B) 是 1,5；(B,A) 是 5,1）。

---

什么是占优策略（Dominant Strategy）？

对某个玩家来说，如果一个策略 **不管对方怎么选**，都能让自己的收益 **至少不差**，并且在某些情况下 **更好**，那它就是（弱）占优策略；如果对所有情况下都更好，则是严格占优。

做题方法：固定对方选择，对比你两种策略的收益

只需要比较“你自己”的数字（每格的第一个数）。

---

检查：行玩家是否有占优策略？

情况一：对方选 A（看第一列）

- 你选 A：收益 = 5（格子 A,A 的第一个数）
- 你选 B：收益 = 5（格子 B,A 的第一个数）

结论：在对方选 A 时，A 和 B **一样好**。

情况二：对方选 B（看第二列）

- 你选 A：收益 = 1（格子 A,B 的第一个数）
- 你选 B：收益 = 0（格子 B,B 的第一个数）

结论：在对方选 B 时，A **更好**（1 > 0）。

合并两种情况

- 对方选 A：A = B
- 对方选 B：A > B

所以：**A 从不比 B 差，并且有时更好**

行玩家的 **A 是弱占优策略（weakly dominant）**。

---

列玩家是否也有占优策略？

因为是对称博弈，你其实可以直接说“对称所以列玩家同理”。

现在看列玩家的收益（每格的第二个数）。

情况一：行玩家选 A（看第一行）

- 列选 A：收益 = 5（A,A 第二个数）
- 列选 B：收益 = 5（A,B 第二个数）

一样好。

情况二：行玩家选 B（看第二行）

- 列选 A：收益 = 1（B,A 第二个数）
- 列选 B：收益 = 0（B,B 第二个数）

A 更好（1 > 0）。

列玩家同样：**A 弱占优**。

---

进化稳定策略 ESS 是进化博弈里的概念：把策略看成“物种/行为类型”。

如果一个群体几乎全都用策略 A，突然出现少量“突变者”用 B：

- 如果突变者 **无法在收益上占便宜**（无法扩散），那 A 就是稳定的。

---

令收益函数为 $u(\text{你的策略}, \text{对手策略})$)$。

A 是 ESS 当且仅当满足其一：

1. **严格打败突变者：**

   $$
   u(A,A) > u(B,A)
   $$

2. 如果打平（=），则看第二层“对突变者时谁更强”：
   $$
   u(A,A) = u(B,A) \ \text{且} \ u(A,B) > u(B,B)
   $$

这就是“先看在 A-群体中突变者能不能占便宜；如果占不到（打平），再看互相遇到突变者时谁更吃亏”。

---

我们只看行玩家收益（对称博弈足够）。

- $u(A,A) = 5$
- $u(B,A) = 5$

所以第一条不是 “>”，而是 **相等**，进入第二条。

再算：

- $u(A,B) = 1$
- $u(B,B) = 0$

比较：

$$
u(A,B)=1 > 0 = u(B,B)
$$

满足第二条，所以 **A 是 ESS**。

</details>

### 3. Foraging by Ants

In the ant foraging model, consider the grid below.

在蚂蚁觅食模型中，考虑下面的格子布局。

- The agent is in the **middle cell (X)**.
- The agent is heading **North-East**.
- Numbers represent **pheromone levels**.

- 代理位于**中间格（X）**。
- 代理朝向**东北（North-East）**。
- 数字表示**信息素浓度（pheromone levels）**。

Write **in each cell** the probability that the agent’s **next step** will go to that cell.

请在**每个格子中**写出代理**下一步**移动到该格子的概率。

| 12  | 10         | 15  |
| --- | ---------- | --- |
| 20  | X </br> 33 | 25  |
| 5   | 11         | 42  |

<details>

</details>

### 4. Attractors

**Question**
What is an **attractor**?

什么是**吸引子（attractor）**？

- Be as precise as possible.
- Give examples of **at least two different types** of attractors.

- 请尽量精确地描述。
- 举出**至少两类不同类型**吸引子的例子。

### 5. Replicator Dynamics

Consider the payoff matrix:

考虑以下收益矩阵：

|       | A   | B   | C   |
| ----- | --- | --- | --- |
| **A** | 3   | 1   | 4   |
| **B** | 4   | 3   | 1   |
| **C** | 1   | 4   | 3   |

Let:

- $x_A = $ proportion of players using strategy A
- $x_B = $ proportion of players using strategy B
- $x_C = $ proportion of players using strategy C

设：

- $x_A$ = 使用策略 A 的个体比例
- $x_B$ = 使用策略 B 的个体比例
- $x_C$ = 使用策略 C 的个体比例

Using **replicator dynamics**, write the following equations:

使用**复制者动力学**，写出以下方程：

$$
\frac{dx_A}{dt} =
$$

$$
\frac{dx_B}{dt} =
$$

$$
\frac{dx_C}{dt} =
$$

<details>

</details>

## 2024-12-18 B

### 1. Axelrod’s Tournament

**Question**
What was the **winning strategy** in Axelrod’s Tournament of Iterated Prisoner’s Dilemma games?

**问题**
在 Axelrod 的迭代囚徒困境锦标赛中，哪个策略获胜？

- How did it work?
- Explain its basic behavior.

- 它是如何运作的？
- 解释其基本行为特征。

<details>

</details>

### 2. Game Theory – Symmetric Two-Person Game

Analyze the following game:

分析以下博弈：

|       | A     | B     |
| ----- | ----- | ----- |
| **A** | 6 , 6 | 2 , 3 |
| **B** | 3 , 2 | 1 , 1 |

Answer:

请回答：

- Is there a dominant strategy? Why or why not?
- Is **A** an evolutionary stable strategy? Explain.

- 是否存在占优策略？请说明理由。
- 策略 **A** 是否为进化稳定策略？请解释。

<details>

</details>

### 3. Foraging by Ants

- Agent is in the **middle cell (X)**.
- Heading **South-East**.
- Numbers represent pheromone levels.

- 代理位于**中间格子（X）**。
- 朝向**东南（South-East）**。
- 数字表示信息素浓度。

Write the probability that the agent’s **next step** goes to each cell.

写出代理**下一步**移动到每个格子的概率。

| 12  | 10         | 15  |
| --- | ---------- | --- |
| 20  | X </br> 33 | 25  |
| 5   | 10         | 65  |

<details>

</details>

### 4. Stigmergy

**Question**
What is **stigmergy**?

什么是**刺激耦合（stigmergy）**？

- Explain the basic concept.
- Give examples.

- 解释其基本概念。
- 举例说明。

<details>

</details>

### 5. Replicator Dynamics

Consider the payoff matrix:

考虑以下收益矩阵：

|       | A   | B   | C   |
| ----- | --- | --- | --- |
| **A** | 4   | 2   | 5   |
| **B** | 5   | 4   | 2   |
| **C** | 2   | 5   | 4   |

Let:

- $x_A$, $x_B$, $x_C$ be the proportions of strategies A, B, and C.

设：$x_A, x_B, x_C$ 为策略 A、B、C 的比例。

Write the replicator dynamics equations:

写出复制者动力学方程：

$$
\frac{dx_A}{dt} =
$$

$$
\frac{dx_B}{dt} =
$$

$$
\frac{dx_C}{dt} =
$$

<details>

</details>

## 2025-01-03 A

### 1. Iterated Prisoner’s Dilemma

**Question**
In the _Iterated Prisoner’s Dilemma_ game, will the strategy called **Tit-For-Tat (TFT)** beat the strategy called **ALLD**?
Why?

在多次囚徒困境中，策略 **以牙还牙（TFT）** 能否战胜 **始终背叛（ALLD）**？为什么？

<details>

</details>

### 2. Game Theory – Symmetric Two-Person Game

Analyze the following game:

分析以下博弈：

|       | A     | B     |
| ----- | ----- | ----- |
| **A** | 4 , 4 | 1 , 5 |
| **B** | 5 , 1 | 0 , 0 |

Answer the following:

请回答下列问题：

- Is there a **dominant strategy** for the players?

  - If yes, which one and why?
  - If not, why?

- 对玩家是否存在**占优策略**？

  - 如果存在，是哪一个？并说明理由。
  - 如果不存在，说明原因。

- Is there a **mixed strategy Nash equilibrium**?

  - If yes, what is it?
  - Explain your answer.

- 是否存在**混合策略纳什均衡**？

  - 若存在，是什么？
  - 解释你的答案。

<details>

</details>

### 3. Foraging by Ants

In the ant foraging model:

- The agent is in the **middle cell (X)**.
- The agent is heading **North-East**.
- Numbers indicate **pheromone levels**.

- 代理位于**中间格子（X）**。
- 代理朝向**东北（North-East）**。
- 数字表示信息素浓度。

Write in **each cell** the probability that the agent’s **next step** will take it to that cell.

请在每个格子中写出代理下一步移动到该格子的概率。

| 10  | 15        | 15  |
| --- | --------- | --- |
| 10  | X </br> 5 | 20  |
| 10  | 5         | 10  |

<details>

</details>

### 5. Replicator Dynamics

Consider the payoff matrix:

考虑以下收益矩阵：

|       | A   | B   | C   |
| ----- | --- | --- | --- |
| **A** | 5   | 1   | 2   |
| **B** | 2   | 5   | 1   |
| **C** | 1   | 2   | 5   |

Let:

- $x_A = $ proportion of players using strategy A
- $x_B = $ proportion of players using strategy B
- $x_C = $ proportion of players using strategy C

设：

- $x_A$ = 使用策略 A 的比例
- $x_B$ = 使用策略 B 的比例
- $x_C$ = 使用策略 C 的比例

Using **replicator dynamics**, write the following equations:

使用复制者动力学，写出以下方程：

$$
\frac{dx_A}{dt} =
$$

$$
\frac{dx_B}{dt} =
$$

$$
\frac{dx_C}{dt} =
$$

<details>

</details>

## 2025-01-03 B

### 1. Iterated Prisoner’s Dilemma

**Question**
What strategy will win if **ALLC** plays against **TFT** in the Iterated Prisoner’s Dilemma?
Explain.

如果 **始终合作（ALLC）** 与 **以牙还牙（TFT）** 对弈，哪种策略会胜出？请解释。

<details>

</details>

### 2. Game Theory – Symmetric Two-Person Game

Analyze the following game:

分析以下博弈：

|       | A     | B     |
| ----- | ----- | ----- |
| **A** | 6 , 6 | 1 , 3 |
| **B** | 3 , 1 | 2 , 2 |

Answer:

请回答：

- Is there a **dominant strategy**? Why or why not?
- Is there a **mixed strategy Nash equilibrium**?

  - If yes, what is it?
  - Explain your answer.

- 是否存在占优策略？请说明理由。
- 是否存在混合策略纳什均衡？

  - 若存在，是什么？
  - 解释你的答案。

<details>

</details>

### 3. Foraging by Ants

- The agent is in the **middle cell (X)**.
- The agent is heading **South-East**.
- Numbers represent pheromone levels.

- 代理位于中间格（X）。
- 代理朝向东南（South-East）。
- 数字代表信息素浓度。

Write the probability that the agent’s **next step** goes to each cell.

写出代理下一步移动到各格子的概率。

| 11  | 6          | 11  |
| --- | ---------- | --- |
| 5   | X </br> 12 | 6   |
| 21  | 5          | 22  |

<details>

</details>

### 5. Replicator Dynamics

Consider the payoff matrix:

考虑以下收益矩阵：

|       | A   | B   | C   |
| ----- | --- | --- | --- |
| **A** | 40  | 20  | 5   |
| **B** | 5   | 40  | 20  |
| **C** | 20  | 5   | 40  |

Let:

- $x_A$, $x_B$, $x_C$ be the proportions of strategies A, B, and C.

设：$x_A, x_B, x_C$ 分别为策略 A、B、C 的比例。

Write the replicator dynamics equations:

写出复制者动力学方程：

$$
\frac{dx_A}{dt} =
$$

$$
\frac{dx_B}{dt} =
$$

$$
\frac{dx_C}{dt} =
$$

<details>

</details>

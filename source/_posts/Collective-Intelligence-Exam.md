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

## 四、为什么？——一步一步推理（这是得分关键）

### Step 1：从最后一轮开始（Backward Induction，逆向归纳）

这是**博弈论中最重要的推理方法之一**。

#### 第 K 轮（最后一轮）

- **这是最后一次**
- 没有未来惩罚或奖励
- 等价于 **单轮囚徒困境**

👉 在单轮 PD 中：

- 背叛（D）严格支配合作（C）

✅ **理性玩家在第 K 轮一定会背叛**

---

### Step 2：倒数第二轮（第 K−1 轮）

双方都知道：

- 第 K 轮 **必然是 D**
- 所以第 K−1 轮的选择 **不会影响未来行为**

👉 那么第 K−1 轮也等价于单轮 PD
👉 理性选择仍然是 **D**

---

### Step 3：不断向前推

同样的逻辑适用于：

- 第 K−2 轮
- …
- 第 1 轮

最终结论：

> **在每一轮中，合作都无法带来未来收益，因此理性选择始终是背叛。**

---

## 五、用一句话总结逻辑链（考试非常加分）

> Because the game has a known finite horizon, rational players apply backward induction. Since defection is optimal in the last round, and future behavior is unaffected in earlier rounds, defection becomes optimal in every round.

---

## 六、为什么这听起来“违反直觉”？

你可能听说过：

- Tit-for-Tat
- Cooperation emerges
- Axelrod Tournament

⚠️ 但注意：

| 情况                    | 结论                 |
| ----------------------- | -------------------- |
| **K 已知且有限**        | Always Defect        |
| **K 无限 / 不确定**     | 合作策略可能是理性的 |
| **进化博弈 / 群体博弈** | 合作可稳定存在       |

👉 **本题明确是“已知 K”的理论博弈论问题**

---

## 七、笔试标准答案（你可以直接背）

### 英文标准版（安全满分）

> When the number of iterations K is known and finite, the rational strategy in the Iterated Prisoner’s Dilemma is to defect in every round.
>
> This follows from backward induction: in the last round, defection strictly dominates cooperation, since there is no future punishment or reward. Knowing this, players will also defect in the previous rounds, and this logic applies recursively to all rounds.

---

### 中文标准版（口语 / 笔试）

> 当囚徒困境的迭代次数 K 是已知且有限时，理性的策略是在每一轮都选择背叛。
>
> 这是因为可以使用逆向归纳法：在最后一轮中，背叛是严格占优策略；而既然最后一轮无法被未来惩罚影响，那么前一轮的合作也无法带来额外收益，因此理性选择仍然是背叛。该推理递归地适用于所有轮次。

---

## 八、如果老师追问（提前防守）

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

### 4. Stigmergy

**Question**
What is **stigmergy**?

什么是**刺激耦合（stigmergy）**？

- Explain the basic concept.
- Give examples.

- 解释其基本概念。
- 举例说明。

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

## 2025-01-03 A

### 1. Iterated Prisoner’s Dilemma

**Question**
In the _Iterated Prisoner’s Dilemma_ game, will the strategy called **Tit-For-Tat (TFT)** beat the strategy called **ALLD**?
Why?

在多次囚徒困境中，策略 **以牙还牙（TFT）** 能否战胜 **始终背叛（ALLD）**？为什么？

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

## 2025-01-03 B

### 1. Iterated Prisoner’s Dilemma

**Question**
What strategy will win if **ALLC** plays against **TFT** in the Iterated Prisoner’s Dilemma?
Explain.

如果 **始终合作（ALLC）** 与 **以牙还牙（TFT）** 对弈，哪种策略会胜出？请解释。

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

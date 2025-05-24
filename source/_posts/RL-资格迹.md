---
title: RL-资格迹
toc: true
categories:
  - [AI, RL]
tags: [笔记, AI, RL]
date: 2025-05-24 12:19:25
---

Eligibility Traces

<!-- more -->

# 核心问题

想象你在训练一只小狗学会坐下，每次它坐下时，你都会给它奖励。但有时它做得好时你没及时奖励，等过了几秒你才给它奖励。这个“奖励延迟”就像资格迹在做的事。

在强化学习中，我们也会遇到这种情况：一个动作导致奖励，但这个奖励不是马上就来，而是延迟出现。资格迹的作用就是“记住”之前做过哪些状态-动作组合，以便奖励到来时，能反过来让之前的“行为”也能被更新。

## N-step TD

它有两个问题：

- 延迟：需要等 n 步才能更新
- 内存：需要记录 n 步的信息才能更新

我们需要优化它：与其固定用某个 n 值，不如把多个 n-step 的结果加权平均

## Compound Update

复合更新：

$$
\frac{1}{2} G_{t:t+2} + \frac{1}{2} G_{t:t+4}
$$

> 用一半权重的 2 步回报（2-step return）
> 再加上一半权重的 4 步回报（4-step return）
> 把它们合起来当成“学习的目标值”

- 你可以混合多个不同步数的 TD 回报（甚至无限多），前提是：

  - 每个回报的权重是正的
  - 所有权重加起来是 1

# $\lambda$ Returns

λ-return 是 n-step return 和 compound update 的一个推广和统一表达方式。它是一种将所有 n-step return 按权重加权平均得到的更新目标。

$$
G_t^\lambda = (1 - \lambda) \sum_{n=1}^{\infty} \lambda^{n-1} G_{t:t+n}
$$

- 你不只用一个固定的 n（比如 3 步）
- 而是把所有可能的 n 步（从 1 到 ∞）都用上
- 每个 n-step return 的权重是：

  $$
  (1 - \lambda)\lambda^{n-1}
  $$

- 权重总和为 1（图右下角有 ∑ = 1）

你可以通过 λ 来控制是更偏向“短期”还是“长期”：

| λ 的值    | 结果                             |
| --------- | -------------------------------- |
| λ = 0     | 完全使用 1-step TD（TD(0)）      |
| λ = 1     | 退化为 Monte Carlo（全轨迹回报） |
| 0 < λ < 1 | 同时结合了短期和长期的优点       |

> λ-return 就是用 λ 这个参数，把所有 n-step 回报“平均融合”起来，既能快速更新（TD 风格），又能利用长远信息（MC 风格）。

## 离线

Off-line λ-return algorithm：

$$
\mathbf{w}_{t+1} = \mathbf{w}_t + \alpha \left[ G_t^\lambda - \hat{v}(S_t, \mathbf{w}_t) \right] \nabla \hat{v}(S_t, \mathbf{w}_t)
$$

- $\mathbf{w}_t$：当前的权重向量（比如神经网络的参数）
- $G_t^\lambda$：我们前几页讲的 λ-return，作为目标值
- $\hat{v}(S_t, \mathbf{w}_t)$：当前估计值（对状态 $S_t$ 的预测）
- $\alpha$：学习率（步长）
- $\nabla \hat{v}(S_t, \mathbf{w}_t)$：对当前权重的梯度

> 用 λ-return 和当前估计值的误差，乘上梯度，来更新权重。
> 离线版本，要等到整个 episode 跑完，才能计算 λ-return 和更新参数。

- λ-return 比 n-step TD 整体表现更稳定，误差也更低
- n-step TD 的表现对 n 非常敏感

## 前向视角

Forward View 是一种“理论上的思考方式”：当我们在某个状态 $S_t$ 的时候，去“向前看”它未来可能得到的所有奖励，并决定如何组合这些奖励来估算当前状态的价值。

在 λ-return 中，我们正是根据这个 forward view 来构造回报的：

- 比如 1-step 回报，只看一步
- 2-step 回报，看两步
- ...
- 最终的 λ-return，就是把所有这些 n-step 回报加权平均，形成一个“综合未来”的看法

所以 λ-return 就是用 forward view 把未来奖励按比例融合，从而评估当前状态的价值。虽然 forward view 的思想很清晰，但实际做不到“真的看到未来”。

# 资格迹

正因如此，我们需要 Eligibility Traces 来帮助我们，它是一种短期记忆机制，用来记录过去哪些状态或特征“有资格”被更新。

- `zₜ` 是资格迹向量：
- 它的大小（维度）和 `wₜ`（权重向量）一样
- 每一个分量表示：这个特征最近出现过多少、重要程度是多少

| 记忆种类           | 变量 | 描述                                       |
| ------------------ | ---- | ------------------------------------------ |
| 长期记忆           | `wₜ` | 学到的“经验总结”，整个系统生命周期不断积累 |
| 短期记忆（资格迹） | `zₜ` | 记录“最近的经历”，在 episode 期间慢慢消失  |

- `wₜ` 是你脑子里学会的技能
- `zₜ` 是你刚练过的动作——现在还热着，值得给它更多学习信号

```txt
Eligibility trace zₜ
        ↓（影响）
Weight vector wₜ
        ↓（决定）
Estimated value vₜ
```

即：资格迹影响权重向量的更新，而权重向量决定我们对当前状态价值的估计。

## 更新

在每个 episode 的开始，资格迹向量 `z₋₁` 会被设为 0。

$$
\mathbf{z}_{-1} = 0
$$

我们刚开始时没有任何记忆。

- 每一步的更新公式

$$
\mathbf{z}_t = \gamma \lambda \mathbf{z}_{t-1} + \nabla \hat{v}(S_t, \mathbf{w}_t)
$$

- 资格迹 = 上一时刻的资格迹 × 衰减系数（γλ） + 当前的梯度

每一步：

- 旧的资格迹会逐渐衰减（靠 λ 控制）
- 同时又会加入当前新的特征或状态的影响

在线性函数逼近的情况下，这个梯度就是当前状态的特征向量 $\nabla \hat{v}(S_t, \mathbf{w}_t) = \mathbf{x}_t$。

## 权重

资格迹 `zₜ` 决定了“权重向量 `wₜ` 中哪些部分最近参与过”，也就是说：

- 如果某个特征最近经常出现，它的 `zₜ` 值就大
- 它就更“有资格”在这一步被强化学习到

可能触发学习（reinforcing）的事件是：

$$
\delta_t = R_{t+1} + \gamma \hat{v}(S_{t+1}, \mathbf{w}_t) - \hat{v}(S_t, \mathbf{w}_t)
$$

这个叫做 TD 误差（Temporal Difference error）
表示“实际获得的奖励 + 下一步的预测值” 和 “当前预测值”之间的差异。

- 如果差值大，说明我们预测错了，应该调整权重

权重更新公式：

$$
\mathbf{w}_{t+1} = \mathbf{w}_t + \alpha \, \delta_t \, \mathbf{z}_t
$$

解释：

- 学习率 `α` 控制更新步长
- 更新方向取决于资格迹 `zₜ`（表示最近谁参与过）
- 更新幅度取决于 TD 误差 `δₜ`（预测偏差）

谁最近出现得多（zₜ 大），谁在这一步预测错得多（δₜ 大），谁就被多更新。

## 后向视角

Backward View 是实际实现 TD(λ) 的核心方法。在实际训练时，我们没法“看到未来”，所以从现在往回看过去的状态。

1. 每次更新使用当前的 TD 误差 δₜ

   $$
   \delta_t = R_{t+1} + \gamma \hat{v}(S_{t+1}) - \hat{v}(S_t)
   $$

   但重点是我们不只用它来更新当前状态，而是用它乘以资格迹 z，来更新“所有参与过的状态”。

2. 资格迹帮助我们“向后分配误差”

   - 从 $S_t$ 开始，向过去的状态 $S_{t-1}, S_{t-2}, \dots$ 发出“更新信号”
   - 谁之前参与得多（资格迹 $z$ 大），谁就被更新得多

TD(λ) 是向后看的算法：每一时刻我们根据当前的 TD 误差，把它按资格迹的大小分配给之前的状态。

## n 步截断

一个很常用的近似技巧 n-step truncated λ-return：

1. 理想情况：off-line λ-return 很好，但实际很难用

   - 离线 λ-return 需要整条轨迹结束后才能计算出回报
   - 所以只能在 episodic（有终点）任务中使用
   - 而且得等到 episode 结束才能更新，不适合在线学习或长期任务

2. 在持续任务中，λ-return 根本没法完整知道，因为它需要看无限多个 n-step 回报：

   - 比如：状态永远不会终止（比如一个机器人一直在走）
   - 那你就永远算不出完整的 λ-return

3. 但远处的回报影响也会变弱

   - 因为 λ-return 是指数衰减的（权重是 λⁿ），所以离当前状态太远的奖励，影响本来也不大，可以忽略它们

4. 所以我们做一个近似处理：截断

   - 只计算前 n 步的 λ-return，忽略后面很小的部分，即“只保留前几步”。

截断版本的 λ-return 适用于 online 学习

$$
G_{t:h}^\lambda = (1 - \lambda) \sum_{n=1}^{h - t} \lambda^n G_{t:t+n} + \lambda^{h - t} G_{t:h}^1
$$

- 我们不看直到终点，而是只看到一个有限时间点 h
- 把 n-step 回报截断到 $n = h - t$，即“从时间 $t$ 往后看 $h - t$ 步”
- 最后那一项是截断时的 n-step return，作为“最终估值”

# Online λ-return

1. 截断参数 $n$ 的权衡（Tradeoff）

   我们之前讲了，n-step truncated λ-return 是对完整 λ-return 的近似，那么：

   - 大 n：

     - 越接近完整 λ-return
     - 越准确，但更新要等更久才能做（延迟）

   - 小 n：

     - 能更快做出更新（实时）
     - 但信息不够完整，更新不够准

2. 能不能两者兼得？

   - 像离线 λ-return 一样准确
   - 又想像在线更新一样快速响应

   这个办法就是：每来一个新数据，就重新计算之前所有的更新

   - 每一个时间步，新的奖励或状态被观察到
   - 从 episode 开始到现在，把之前所有时间点的 λ-return 重新计算一遍
   - 因为现在有更多信息了，所以之前的更新也可以做得更准确

$$
\mathbf{w}_{t+1} = \mathbf{w}_t + \alpha \left[ G_{t:h}^\lambda - \hat{v}(S_t, \mathbf{w}_t) \right] \nabla \hat{v}(S_t, \mathbf{w}_t)
$$

当前的权重向量 $\mathbf{w}_t$ 用 λ-return（截断版）和当前估计的差值（TD 误差）乘以梯度进行更新。

- $G_{t:h}^\lambda$：是 n-step 截断的 λ-return
- $\nabla \hat{v}(S_t, \mathbf{w}_t)$：是当前状态的梯度（特征向量）
- $\alpha$：学习率

假设你现在在第 5 步，得到了 $R_5$，那你就可以：

- 回头把第 0 步到第 4 步的 λ-return 再算一遍（因为现在知道更远的奖励了）
- 然后用这些新算出来的 λ-return 来重新更新它们的权重
- 计算开销大，每一步都要重新计算所有之前的 λ-return 并更新权重。

## True Online TD(λ)

真正可行、效率高的实现方法

- 保留 λ-return 的精度和理论基础
- 又实现像 backward view 那样高效的更新
- 通过资格迹 zₜ 来实现递推式计算

所以我们有：

1. 线性逼近形式：

   $$
   \hat{v}(s, \mathbf{w}) = \mathbf{w}^\top \mathbf{x}(s)
   $$

   我们用一个向量 `x(s)` 表示状态的特征，估值就是用权重 `w` 点乘它。
   这是强化学习中最常用的函数逼近形式。

2. 权重更新公式：

   $$
   \mathbf{w}_{t+1} = \mathbf{w}_t + \alpha \delta_t \mathbf{z}_t + \alpha \left( \mathbf{w}   _t^\top \mathbf{x}_t - \mathbf{w}_{t-1}^\top \mathbf{x}_t \right) \left( \mathbf{z}_t -   \mathbf{x}_t \right)
   $$

   - `δₜ` 是 TD 误差：

     $$
     \delta_t = R_{t+1} + \gamma \hat{v}(S_{t+1}) - \hat{v}(S_t)
     $$

   - `zₜ` 是资格迹向量
   - 第二项是修正项，用于让更新过程严格等价于 λ-return，让我们不需要重新回顾所有时间步，也能“忠实”模拟完 整 λ-return 的更新效果

3. 资格迹更新公式（Dutch trace）

   $$
   \mathbf{z}_t = \gamma \lambda \mathbf{z}_{t-1} + \left(1 - \alpha \gamma \lambda \mathbf{z}_    {t-1}^\top \mathbf{x}_t \right) \mathbf{x}_t
   $$

   加入了一个修正系数，Dutch trace，它能更好地保持数值稳定性和理论等价性，是 True Online TD(λ) 独有的更 新方式。

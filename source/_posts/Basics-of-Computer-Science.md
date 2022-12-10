---
title: Basics of Computer Science
date: 2022-12-07 15:37:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

~~我是真没搞明白这老师在干什么~~  
所以我按着她的板书，自己搓了一遍  
她写的那个字，就跟狗爬的一样

<!-- more -->

# Algorithmic problems, modelling

theory of computation, modelling tools, examples

## What is it good for

- Create efficient algorithms
- Programming language research
- Efficient compiler design and construction

## Branches of ToC

### Automata theory

- is the study of abstract computational devices
- formal framework for designing and analyzing computing devices
- we will discuss Turing Machines.

### Computability Theory

- defines whether a problem is "solvable" by any abstract machines
- some problems are computable, some are not (e.g. travelling salesman problem)

### Complexity Theory

- studying the cost of solving problems
- cost = resources (e.g. time, memory)
- running time of algorithms varies with inputs and usually grows with the site of inputs
- we will discuss how to measure complexity

## Modlling

Problem -> (Model) -> Mathematica Frame -> (Algorithm) -> Solution

### Tools of modelling

- sets
- function
- number systems, coding
- graphs

### Graph definition

G=(V,E) where V is finite and not empty set, V = edges, E = vertices

### Graph Representations

- drawing
- edge and vertex list
- adjacency matrix

### Examples of graph models

#### Complicated intersection traffic lights

![traffic lights](0.png)

Translates to graph coloring problem and maximal independent set problem too

#### King Arthur and the knights of the Round Table

#### Noblemen and Noble Maidens

# Turing Machines

definition, construction, properties, transition functions

## What is a Turing Machine

- TMS are abstract models for real wuiputers having an infinite memory
  (in the form of a tape) and a reading head
- has finite number of internal states
- has distinguished starting and final states (termination : accept / reject)
- has transition functions (Tt) (graphs)

---

- TM accepts the initial content of the tape if it terminates in an accepting
  state. Otherwise TM rejects it.
- TM terminates, if there is no rule with watching conditions
  for certain state and input symbols
- TM is ND (non-deterministic), if such a state and set of input symbols
  exist, for which there are multiple rules defined.
  (= from the same set of starting state and input symbols the TM has multiple outcomes)

---

- NDTM accepts the initial content of the tape if there is
  a sequence of transition functions that accepts it.

Thesis: For All NDTM Exsist equivalent DTM

## Defining a Turing Machine

- defining the number of tapes & head
- defining the tape alphabets
- defining the net of state, initial and terminating states,
  accepting and rejection terminal states

From an already existing machine it is possible to head the followings:

- number of heads
- set of states constructed from the states mentioned in the TFS

Universal TM : TM, which can simulate All other TM

Church - Turing thesis:
A function (problem) can be effectively solved <=> it is computable with a TM

The same problems can be solved by a TM and modern computers

# Complexity of algorithms

measuring complexity, complexity classes

算法会消耗时间和内存，复杂度就是衡量消耗的指标

## 时间复杂度

时间复杂度主要是循环导致的，我们不必把它想得太复杂  
下面列出的时间复杂度越来越大，执行的效率越来越低

### 常数阶 O(1)

```ts
let i = 1;
i = i + 1;
```

说白了就是没有循环，即便它有几百万行

### 对数阶 O(logN)

```ts
let i = 1;
while (i < n) {
  i = i * 2;
}
```

我们可以看到，每次循环都会把 i 乘 2  
设循环 x 次后，i 大于 n  
则 2^x > n，即 x > log2(n)

### 线性阶 O(N)

```ts
for (let i = 0; i < n; i++) {
  console.log(i);
}
```

这个就更好理解了，循环 n 次  
它的前进速度明显就没有之前乘 2 的那个快了

### 线性对数阶 O(NlogN)

```ts
for (let i = 1; i < n; i = i * 2) {
  for (let j = 0; j < n; j++) {
    console.log(j);
  }
}
```

名字看的很奇怪，但实际上  
把 O(logN) 的代码，再循环 N 次  
那它的时间复杂度就是 `n * logn` 了

当然你也可以把 O(N) 的代码，再循环 logN 次  
就像上面的例子一样

### 平方阶 O(N^2)

```ts
for (let i = 0; i < m; i++) {
  for (let j = 0; j < n; j++) {
    console.log(j);
  }
}
```

`n * n` 不就是 `n^2` 吗  
把 O(N) 的代码，再循环 N 次  
比之前那个还好理解

当然也可以是 `m * n`  
那时间复杂度就是 O(MN) 了

---

其他的还有

- K 次方阶 O(N^k)
- 指数阶 O(2^N)  
  一般是递归算法
- O(3^N)
- etc.

### 计算

T(n) 算法的执行次数  
T(n) = O(f(n))

1. 嵌套循环  
   由内向外分析，并相乘

   ```ts
   // O(n)
   for (let i = 0; i < n; i++) {
     // O(n)
     for (let j = 0; j < n; j++) {
       console.log(j); // O(1)
     }
   }
   ```

   时间复杂度为 `O(n * n * 1) = O(n^2)`

2. 顺序执行  
   你可以把它们的时间复杂度相加  
   在不要求精度的情况下可以直接等于其中最大的时间复杂度

   ```ts
   // O(n)
   for (let i = 0; i < n; i++) {
     console.log(i);
   }

   // O(n^2)
   for (let i = 0; i < n; i++) {
     for (let j = 0; j < n; j++) {
       console.log(j);
     }
   }
   ```

   时间复杂度为 `O(n + n^2)` 或者不要求精度 `O(n^2)`

3. 条件分支  
   时间复杂度等于所有分支中最大的时间复杂度  
   说人话就是：最麻烦的那个情况

   ```ts
   if (n > 10) {
     // O(n)
     for (let i = 0; i < n; i++) {
       console.log(i);
     }
   } else {
     // O(1)
     console.log(n);
   }
   ```

   时间复杂度为 `O(n)`

## 空间复杂度

很显然，时间复杂度并没有真正计算算法实际的执行时间  
那么空间复杂度一样也不是真正的占用空间

### O(1)

```ts
let i = 1;
i = i + 1;
```

代码中的变量所分配的空间，都不随数据量的变化而变化  
所以空间复杂度为 O(1)

### O(N)

```ts
let arr = [];
for (let i = 0; i < n; i++) {
  arr.push(i);
}
```

看到数组就表明，空间是随着 n 增大而增大的  
所以空间复杂度为 O(N)

### 计算

所以说的简单一点

- 如果 n 增大，程序占用的空间不变，则空间复杂度为 O(1)
- 如果 n 增大，程序占用的空间成线性增长，那么空间复杂度就是 O(N)
- 如果 n 增大，程序占用的空间成平方增长，那么空间复杂度就是 O(N^2)

以此类推
当然也有 O(N + M), O(logN)等

# Sorting algorithms and their complexity

selection sort, bubble sort, insertion sort and optimization, their analysis, theorem about maximum complexity case runtime steps

我们按时间复杂度区分，并介绍十大常用的排序算法  
由于这门课并不教怎么写代码，所以我们只需要了解它是怎么工作的就行了

~~学计算机不学写代码，行吧，当数学课上~~

## O(N)

它们都是非比较算法，不适合大量或大范围数据

### 计数排序

Counting Sort  
每个桶只存储单一键值  
`O(N + K)`

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/countingSort.gif)

对于给定的输入，统计每个元素出现的次数，然后依次把元素输出

### 桶排序

Bucket Sort 每个桶存储一定范围的数值  
它需要调用其他的排序算法来完成排序  
所以它的实际时间复杂度受到其使用的排序算法的影响  
`O(N * K)`

基本思路是，把数据分到有限数量的桶里，然后对每个桶内部的数据进行排序  
最后将各个桶内的数据依次取出，得到结果

让我们看一个例子  
假设我们有 20 个数据，要分成 5 个桶

```ts
function bucketSort(arr: number[], bucketSize: number) {
  // 创建大小为 bucketSize 的桶数组
  const bucket: number[][] = [];

  // 初始化桶数组
  for (let i = 0; i < bucketSize; i++) {
    bucket[i] = [];
  }

  // 获取数组中的最大值和最小值
  const max = Math.max(...arr); // 194
  const min = Math.min(...arr); // 13

  // 计算桶的范围
  // (194 - 13 + 1) / 5 = 36.4
  const range = (max - min + 1) / bucketSize;

  // 将数据放入对应的桶中
  for (let i = 0; i < arr.length; i++) {
    // 计算数据应该放入的桶的索引
    // 比如 63：floor(63 - 13) / 36.4) = 1
    const index = Math.floor((arr[i] - min) / range);
    bucket[index].push(arr[i]);
  }

  // 使用其他算法，对桶内的数据进行排序
  for (let i = 0; i < bucketSize; i++) {
    bucket[i].sort((a, b) => a - b);
  }

  // 将桶内排好序的数据依次取出，得到有序序列
  const result: number[] = [];
  for (let i = 0; i < bucketSize; i++) {
    for (let j = 0; j < bucketSize; j++) {
      result.push(bucket[i][j]);
    }
  }

  return result;
}
```

### 基数排序

Radix Sort  
根据键值的每位数字来分配桶
O(d(n+r))，其中 d 是基数，n 是要排序的数据个数，r 是每个关键字的基数

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/radixSort.gif)

将所有待比较数值统一为同样的数位长度，数位较短的数前面补零  
然后，从最低位开始，依次进行一次排序  
这样从最低位排序一直到最高位排序完成以后，数列就变成一个有序序列

## O(NlogN)

### 希尔排序

Shell Sort，也称递减增量排序  
是插入排序的一种更高效的改进版本，它会优先比较距离较远的元素

先将整个序列，分割成若干个子序列，分别进行插入排序  
待整个序列基本有序时，再对整体进行插入排序

### 归并排序

Merge Sort，是一种分治算法  
将两个或两个以上的有序表合并成一个新的有序表

1. 把长度为 n 的序列分成两个长度为 n/2 的子序列
2. 对这两个子序列分别采用归并排序（递归）
3. 将两个排序好的子序列合并成一个最终的排序序列

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/mergeSort.gif)

### 快速排序

Quick Sort  
应该算是在冒泡排序基础上的递归分治法

1. 随便选择一个元素
2. 将比这个元素小的放在左边，比这个元素大的放在右边
3. 对左右两边的元素重复第二步，直到各区间只有一个元素

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/quickSort.gif)

### 堆排序

Heap Sort

1. 构建一个大顶堆，此时，整个序列的最大值就是堆顶的根节点
2. 将其与末尾元素进行交换，此时末尾就为最大值
3. 然后将剩余的 n-1 个元素重新构建成一个堆，这样会得到 n 个元素的次小值
4. 如此反复执行，便能得到一个有序序列了

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/heapSort.gif)

## O(N^2)

### 冒泡排序

Bubble Sort  
比较相邻的元素，如果第一个比第二个大，就交换他们两个，一直向上冒泡

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/bubbleSort.gif)

### 选择排序

Selection Sort  
也就是每次找到最小的元素，放到前面，重复

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/selectionSort.gif)

### 插入排序

Insertion Sort  
像打扑克时整理手牌一样，将每张牌插入到合适的位置

![动图演示](https://raw.githubusercontent.com/hustcc/JS-Sorting-Algorithm/master/res/insertionSort.gif)

# Basic graph algorithms

graph searches (BFS, DFS, Dijsktra), tree traversals, longest path problems

## 深度优先搜索

![节点进行深度优先搜索的顺序](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1f/Depth-first-tree.svg/300px-Depth-first-tree.svg.png)

## 广度优先搜索

![节点进行广度优先搜索的顺序](https://upload.wikimedia.org/wikipedia/commons/thumb/1/1b/Breadth-first_tree.svg/300px-Breadth-first_tree.svg.png)

## 遍历

前序遍历：根结点 ---> 左子树 ---> 右子树  
是从最上层往下走

中序遍历：左子树 ---> 根结点 ---> 右子树  
是从最左边往右走

后序遍历：左子树 ---> 右子树 ---> 根结点  
是从最下层往上走

层次遍历：只需按层遍历即可

## Dijsktra

求 V0 到 V5 的最短路径

![Dijkstra](https://raw.githubusercontent.com/2cats/Dijkstra/master/sample.jpg)

首先，我们将 V0 设为原点，并初始化每个顶点到原点的距离为无穷大

```ts
/**
 * 每个顶点到原点的距离
 */
let dist: Record<string, number> = {
  V0: 0,
  V1: Infinity,
  V2: Infinity,
  V3: Infinity,
  V4: Infinity,
  V5: Infinity,
};

/**
 * 获取两个顶点之间的权重
 */
declare function weight(node1: string, node2: string): number;
```

接下来，我们要不断迭代更新每个顶点到原点的最短距离，
直到所有顶点的最短距离，都被更新为最终值。

在每次迭代中，我们首先找到所有未被更新的顶点中，距离原点最近的顶点，
然后更新它到原点的最短距离，并根据新的距离，更新其他顶点，到原点的距离。

所以，我们找到距离 V0 最近的点，V1，距离是 1，然后用这个值来更新其他点到原点的距离

```ts
dist.V1 = 1;

dist.V2 =
  Math.min(dist.V2, dist.V1 + weight(V1, V2)) =
  Math.min(Infinity, 1 + 2) =
    3;

dist.V3 =
  Math.min(dist.V3, dist.V1 + weight(V1, V3)) =
  Math.min(Infinity, 1 + 7) =
    8;

dist.V4 =
  Math.min(dist.V4, dist.V1 + weight(V1, V4)) =
  Math.min(Infinity, 1 + 5) =
    6;
```

我们再次找到距离源点最近的顶点，V2

```ts
dist.V4 = Math.min(dist.V4, dist.V2 + weight(V2, V4)) = Math.min(6, 3 + 1) = 4;
```

# Graph diagnostics

## connectivity, absolute winner, complete node, logical formulas

## graph coloring (vertex and edge coloring)

# Packing and covering problem

## generalization of the problem

## interval packing, dominating sets

## suboptimal algorithms, bin packing problem, First Fit algorithm

# Algebraic algorithms

## divisibility, Euclidean algorithm

## faster multiplication and division of large numbers

# 背包问题

---
title: Basics of Computer Science
date: 2022-12-07 15:37:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

~~我是真没搞明白这老师在干什么~~  
所以我按着她的大纲，自己搓了一遍

<!-- more -->

# 复杂度

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

# 十大排序算法

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
是插入排序的一种更高效的改进版本

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

### 堆排序

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

---
title: Basics of Computer Science
date: 2022-12-07 15:37:00
toc: true
categories:
  - [Algorithm]
tags: [算法, 笔记]
---

~~我是真没搞明白这老师在干什么~~

<!-- more -->

# 复杂度

算法会消耗时间和内存，复杂度就是衡量消耗的指标

## 时间复杂度

时间复杂度主要是循环导致的，我们不必把它想得太复杂  
下面列出的时间复杂度越来越大

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

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

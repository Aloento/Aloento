---
title: Algo Midterm Tips
date: 2024-03-25 15:30:00
toc: true
categories:
  - [Algorithm]
tags: [考试]
---

The Midterm Exam for Design and Analysis of Algorithms

<!-- more -->

# [Gale-Shapley](https://aloen.to/Algorithm/Stable-Marriage-Problem/)

- 如果存在一对男女，不存在于当前匹配中，但是相互之间更喜欢，为 vogue ，导致不稳定匹配
- 同性恋没有稳定匹配

## 性质

1. 在 $(n - 1)^2 + 1$ 天内结束
2. 男孩结婚时已遍历所有更喜欢的
3. 结束时男孩未结婚，则已遍历全部
4. 女孩嫁给追求过她中最喜欢的
5. 被追求过的女孩一定结婚
6. 每个人都会结婚
7. 总是产生稳定匹配
8. 求婚方优化

## 不同偏好

男生喜欢金发，女生喜欢高个，证金发匹配高个

假设有 (高个 b，黑发 g)，则有 (矮个 b'，金发 g')  
则 g' 更喜欢 b，因为高个，(b, g') 是 vogue couple  
矛盾，得证

## 相同偏好

全部女生相同偏好，证明只有一个稳定匹配

假设 A 有 (g, b)，B 有 (g, b')  
匹配完全由男生决定，无论 g 与谁匹配，其他女生相对偏好不变  
由于 g 同时出现在 A 和 B 中，说明至少有一个匹配她得到了更喜欢的  
因为如果 g 能在 B 中与 b' 匹配，那么在 A 中与 b 匹配的女生会更喜欢 b'  
导致 vogue ，违反稳定匹配条件，得证

## 最优解

证明使用 GS 使全部的男孩都得到最好匹配

假设有匹配使男孩得到更优解，他与更喜欢的女生匹配  
由 GS 性质可得，结束时每个男生都已遍历所有更喜欢的  
因为女生已经与更喜欢的男生配对，或拒绝了他  
因此如果有更优解，表明至少有一位男性与在 GS 中拒绝他的女性配对  
这导致 vogue ，因为至少有一个女孩可以与她更喜欢的配对，得证

# [Master Method](https://aloen.to/Algorithm/Master-Method/)

- 递归：$ T(n) = n^{\log_b(a)} > f(n) $

- 一样：$ T(n) = n^{\log_b(a)} \log n $

- 分治：$ af(\frac{n}{b}) \leq cf(n), c < 1, n \to \infty, T(n) = f(n) $

# [递归分治](https://aloen.to/Algorithm/%E5%88%86%E8%80%8C%E6%B2%BB%E4%B9%8B/)

## 并规

```ts
Inv(A, low, high):
  if low < high:
    mid := (low + high) / 2

    left := Inv(A, low, mid)
    right := Inv(A, mid + 1, high)

    merge := Merge(A, low, mid, high)

    return left + right + merge

Merge(A, low, mid, high):
  leftI := low
  rightI := mid + 1
  arrayI := low

  inversion := 0
  temp := []

  while leftI <= mid && rightI <= high:
    if A[leftI] <= A[rightI]:
      temp[arrayI] := A[leftI]
      leftI++
    else:
      temp[arrayI] := A[rightI]
      rightI++
      inversion += mid - leftI + 1
    arrayI++

  while leftI <= mid:
    temp[arrayI] := A[leftI]
    leftI++
    arrayI++

  while rightI <= high:
    temp[arrayI] := A[rightI]
    rightI++
    arrayI++

  for i := low; i <= high; i++:
    A[i] := temp[i]

  return inversion
```

## 快速选择

```ts
Select(A, low, high, k):
  if low < high:
    pivot := Partition(A, low, high)
    pos := pivot - low + 1

    if k == pos:
      return A[pivot]
    else if k < pos:
      return Select(A, low, pivot - 1, k)
    else:
      return Select(A, pivot + 1, high, k - pos)

Partition(A, low, high):
  pivot := A[high]
  i := low - 1

  for j := low; j < high; j++:
    if A[j] <= pivot:
      i++
      Swap(A, i, j)

  Swap(A, i + 1, high)

  return i + 1
```

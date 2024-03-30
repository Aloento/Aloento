---
title: DAA Midterm Exam
date: 2024-03-25 15:30:00
toc: true
categories:
  - [Algorithm]
tags: [考试]
---

The Midterm Exam for Design and Analysis of Algorithms  
~~直接一套连招被送走，我真的是命苦~~

<!-- more -->

# Gale-Shapley

| Boys |            |        |        |        |     |
| ---- | ---------- | ------ | ------ | ------ | --- |
| b1   | ~~g2~~     | **g4** | g3     | g1     | g5  |
| b2   | ~~**g3**~~ | **g2** | g1     | g5     | g4  |
| b3   | ~~**g2**~~ | ~~g1~~ | ~~g3~~ | g5     | g3  |
| b4   | ~~**g4**~~ | **g3** | g4     | g1     | g2  |
| b5   | ~~g2~~     | ~~g4~~ | ~~g3~~ | **g1** | g5  |

| Girl |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
| g1   | b2  | b5  | b1  | b3  | b4  |
| g2   | b2  | b3  | b1  | b4  | b5  |
| g3   | b4  | b2  | b5  | b1  | b3  |
| g4   | b3  | b1  | b5  | b2  | b4  |
| g5   | b5  | b3  | b4  | b1  | b2  |

## Solution

| Day | g1         | g2                 | g3                 | g4                 | g5  |
| --- | ---------- | ------------------ | ------------------ | ------------------ | --- |
| 1   | -          | ~~b1~~, b3, ~~b5~~ | b2                 | b4                 | -   |
| 2   | -          | b3                 | b2                 | ~~b4~~, b1, ~~b5~~ | -   |
| 3   | -          | b3                 | ~~b2~~, b4, ~~b5~~ | b1                 | -   |
| 4   | b5         | ~~b3~~, b2         | b4                 | b1                 | -   |
| 5   | b5, ~~b3~~ | b2                 | b4                 | b1                 | -   |
| 6,7 | b5         | b2                 | b4                 | b1                 | b3  |

(g1, b5), (g2, b2), (g3, b4), (g4, b1), (g5, b3)

# Stable Marriage

If it is true, give a short explanation. Otherwise, give a counterexample.

## Existence

In every instance of the Stable Marriage Problem, there is a suitable matching containing a pair $(b, g)$ such that $b$ is ranked first on the preference list of $g$ and $g$ is ranked first on the preference list of $b$.

### Solution

False, consider the following case:

| Boys |     |     |
| ---- | --- | --- |
| b1   | g1  | g2  |
| b2   | g1  | g2  |

| Girl |     |     |
| ---- | --- | --- |
| g1   | b2  | b1  |
| g2   | b1  | b2  |

(b1, g2), (b2, g1) is the only stable matching.

b2 and g1 are both first on each other's preference list.  
But we cannot find a pair where b1 and b2 are each other's first preference.  
So it's not true for **every** instance.

## Belonging

Consider an instance of the Stable Marriage Problem in which there exists a boy $b$ and a girl $g$ such that $b$ is ranked first on the preference list of $g$ and $g$ is ranked first on the preference list of $b$. Then every stable marriage $M$ for this instance, the pair $(b, g)$ belongs to $M$.

### Solution

True. If $b$ and $g$ rank each other first, then any pairing where they are not matched would be unstable. Because if either $b$ or $g$ where matched with someone else, they would both prefer to be matched with each other, leading to an unstable pairing. So, in any stable pairing $M$, $b$ and $g$ must be matched.

# Master Method

## $T(n) = 4T(n/2) + n$

$a = 4, b = 2, f(n) = n, n^{\log_{b} a} = n^2$

## $T(n) = 6T(n/3) + n^2$

$a = 6, b = 3, f(n) = n^2, n^{\log_{b} a} = n^{\log_{3} 6} \approx n^{1.63} < n^2$

$af(n/b) = 6(n/3)^2 = \frac{2}{3}n^2$

$c = \frac{2}{3} < 1$

$T(n) = n^2$

## $T(n) = 8T(n/2) + n^3$

$a = 8, b = 2, f(n) = n^3, n^{\log_{b} a} = n^3 = f(n)$

$T(n) = n^3 \log n$

# Significant Inversion

Recall the problem of finding the number of inversions: we are given a sequence of n numbers $a_1, a_2, \cdots, a_n$, which we assume are all distinct, and we define an inversion to be a pair $i < j$ such that $a_i > a_j$. We motivated the problem of counting inversions as a good measure of how different two orderings are. However, one might feel that this measure is too sensitive. Let's call a pair a significant inversion if $i < j$ and $a_i > 2a_j$. Give an $O(n \log n)$ divide and conquer algorithm to count the number of significant inversions in a sequence of n pairwise distinct numbers $a_1, a_2, \cdots, a_n$.

## Solution

```ts
function mergeAndCount(arr, left, mid, right):
    temp = []
    invCount = 0
    i = left
    j = mid + 1
    k = 0

    // Count significant inversions for the split part
    for i from left to mid:
        while j <= right and arr[i] > 2 * arr[j]:
            j += 1
        invCount += (j - (mid + 1))

    i = left
    j = mid + 1

    // Merge the two halves
    while i <= mid and j <= right:
        if arr[i] <= arr[j]:
            temp.append(arr[i])
            i += 1
        else:
            temp.append(arr[j])
            j += 1
        k += 1

    // Copy the remaining elements of left half, if there are any
    while i <= mid:
        temp.append(arr[i])
        i += 1
        k += 1

    // Copy the remaining elements of right half, if there are any
    while j <= right:
        temp.append(arr[j])
        j += 1
        k += 1

    // Copy back the merged elements to original array
    for i from 0 to k-1:
        arr[left + i] = temp[i]

    return invCount
```

# Largest Contiguous Sum

Give a $O(n \log n)$ time divide and conquer algorithm to find a contiguous subarray within a one-dimensional array $A[1 : n]$ of real numbers which has the largest sum, i.e., find indices $1 \leq i \leq j \leq n$ such that
$$ A[i] + A[i+1] + \cdots + A[j] $$
is as large as possible.

## Solution

```ts
function maxCrossingSum(
  arr: number[],
  l: number,
  m: number,
  h: number
): number {
  let sum = 0;
  let left_sum = Number.MIN_SAFE_INTEGER;
  for (let i = m; i >= l; i--) {
    sum = sum + arr[i];
    if (sum > left_sum) {
      left_sum = sum;
    }
  }

  sum = 0;
  let right_sum = Number.MIN_SAFE_INTEGER;
  for (let i = m + 1; i <= h; i++) {
    sum = sum + arr[i];
    if (sum > right_sum) {
      right_sum = sum;
    }
  }

  return Math.max(left_sum + right_sum, left_sum, right_sum);
}

function maxSubArraySum(arr: number[], l: number, h: number): number {
  if (l === h) {
    return arr[l];
  }
  let m = Math.floor((l + h) / 2);
  return Math.max(
    maxSubArraySum(arr, l, m),
    maxSubArraySum(arr, m + 1, h),
    maxCrossingSum(arr, l, m, h)
  );
}
```

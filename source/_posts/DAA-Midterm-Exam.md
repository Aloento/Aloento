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
function mergeAndCount(left: number[], right: number[]): [number[], number] {
  let i = 0,
    j = 0,
    inversions = 0;
  const sorted: number[] = [];

  while (i < left.length && j < right.length) {
    if (left[i] <= 2 * right[j]) {
      sorted.push(left[i]);
      i++;
    } else {
      // Since left[i] > 2 * right[j], all remaining elements in left are also inversions.
      inversions += left.length - i;
      sorted.push(right[j]);
      j++;
    }
  }

  // Append any remaining elements (no further inversions can be found here)
  while (i < left.length) sorted.push(left[i++]);
  while (j < right.length) sorted.push(right[j++]);

  return [sorted, inversions];
}
```

# Largest Contiguous Sum

Give a $O(n \log n)$ time divide and conquer algorithm to find a contiguous subarray within a one-dimensional array $A[1 : n]$ of real numbers which has the largest sum, i.e., find indices $1 \leq i \leq j \leq n$ such that
$$ A[i] + A[i+1] + \cdots + A[j] $$
is as large as possible.

## Solution

```ts
function findMaxCrossingSubarray(
  A: number[],
  low: number,
  mid: number,
  high: number
): [number, number, number] {
  let leftSum = -Infinity;
  let sum = 0;
  let maxLeft = mid;
  for (let i = mid; i >= low; i--) {
    sum += A[i];
    if (sum > leftSum) {
      leftSum = sum;
      maxLeft = i;
    }
  }

  let rightSum = -Infinity;
  sum = 0;
  let maxRight = mid;
  for (let j = mid + 1; j <= high; j++) {
    sum += A[j];
    if (sum > rightSum) {
      rightSum = sum;
      maxRight = j;
    }
  }

  return [maxLeft, maxRight, leftSum + rightSum];
}

function findMaximumSubarray(
  A: number[],
  low: number,
  high: number
): [number, number, number] {
  if (high === low) {
    return [low, high, A[low]]; // Base case: only one element
  } else {
    const mid = Math.floor((low + high) / 2);
    const [leftLow, leftHigh, leftSum] = findMaximumSubarray(A, low, mid);
    const [rightLow, rightHigh, rightSum] = findMaximumSubarray(
      A,
      mid + 1,
      high
    );
    const [crossLow, crossHigh, crossSum] = findMaxCrossingSubarray(
      A,
      low,
      mid,
      high
    );

    if (leftSum >= rightSum && leftSum >= crossSum) {
      return [leftLow, leftHigh, leftSum];
    } else if (rightSum >= leftSum && rightSum >= crossSum) {
      return [rightLow, rightHigh, rightSum];
    } else {
      return [crossLow, crossHigh, crossSum];
    }
  }
}
```

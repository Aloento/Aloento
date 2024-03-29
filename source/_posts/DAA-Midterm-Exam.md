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

| Boys |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
| b1   | g2  | g4  | g3  | g1  | g5  |
| b2   | g3  | g2  | g1  | g5  | g4  |
| b3   | g2  | g1  | g3  | g5  | g3  |
| b4   | g4  | g3  | g4  | g1  | g2  |
| b5   | g2  | g4  | g3  | g1  | g5  |

| Girl |     |     |     |     |     |
| ---- | --- | --- | --- | --- | --- |
| g1   | b2  | b5  | b1  | b3  | b4  |
| g2   | b2  | b3  | b1  | b4  | b5  |
| g3   | b4  | b2  | b5  | b1  | b3  |
| g4   | b3  | b1  | b5  | b2  | b4  |
| g5   | b5  | b3  | b4  | b1  | b2  |

# Stable Marriage

If it is true, give a short explanation. Otherwise, give a counterexample.

## Existence

In every instance of the Stable Marriage Problem, there is a suitable matching containing a pair (b, g) such that b is ranked first on the preference list of g and g is ranked first on the preference list of b.

## Belonging

Consider an instance of the Stable Marriage Problem in which there exists a boy b and a girl g such that b is ranked first on the preference list of g and g is ranked first on the preference list of b. Then every stable marriage M for this instance, the pair (b, g) belongs to M.

# Master Method

## $T(n) = 4T(n/2) + n$

## $T(n) = 6T(n/3) + n^2$

## $T(n) = 8T(n/2) + n^3$

# Significant Inversion

Recall the problem of finding the number of inversions: we are given a sequence of n numbers a1, a2, ..., an, which we assume are all distinct, and we define an inversion to be a pair i < j such that ai > aj. We motivated the problem of counting inversions as a good measure of how different two orderings are. However, one might feel that this measure is too sensitive. Let's call a pair a significant inversion if i < j and ai > 2aj. Give an $O(n \log n)$ divide and conquer algorithm to count the number of significant inversions in a sequence of n pairwise distinct numbers a1, a2, ..., an.

# Largest Contiguous Sum

Give a $O(n \log n)$ time divide and conquer algorithm to find a contiguous subarray within a one-dimensional array $A[1 : n]$ of real numbers which has the largest sum, i.e., find indices $1 \leq i \leq j \leq n$ such that
$$ A[i] + A[i+1] + \cdots + A[j]$$
is as large as possible.

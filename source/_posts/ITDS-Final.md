---
title: ITDS Final
toc: true
categories:
  - [Data Science]
tags: [考试, 数据科学]
date: 2025-05-05 14:13:32
---

~~赶紧毕业吧~~

<!-- more -->

# 2024-12-10

## Missing Values

Explain how would you pre-process the data if you would like to use linear classification/regression methods and the data would contain only categorical/nominal attributes. What could we do with missing values in this case?

<details>

解释如果您希望使用线性分类/回归方法，并且数据仅包含分类/名义属性，您将如何预处理数据。在这种情况下，我们可以如何处理缺失值？

Class 用 One-Hot，有序类别还能用 Label Encoding。
缺失值可以用众数（Mode Imputation）填充，或者用模型（如 KNN）填充。

</details>

## Evaluation

Explain how internal and external evaluation of clusters work.

<details>

解释聚类的内部评估和外部评估是如何工作的。

内部：不依赖真实标签，簇内相似度是否高、簇间差异是否大，如 Silhouette Score
外部：依赖已有的真实标签，与聚类结果进行比较

</details>

## Regularized LR

Write down the objective function for regularized linear regression. Explain, under which values (high or small) of the regularization hyper-parameter, the resulting model will overfit or underfit.

<details>

写出正则化线性回归的目标函数。解释在正则化超参数的高值或低值下，模型会过拟合还是欠拟合。

Ridge: $\sum_{i=1}^{n}(y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p}\beta_j^2$

$\lambda$ 大：简单，欠拟合
$\lambda$ 小：复杂，过拟合

</details>

## Error

What is the relation between the prediction error on the test set and the model complexity?

<details>

测试集上的预测误差与模型复杂度之间有什么关系？

U 形关系：模型太简单或太复杂，误差都高。最佳复杂度在中间。

</details>

## Binary

What is a possible way to classify color images of animals to three different classes using binary classification methods? How would you represent the data? How would you do cross-validation in this case (i.e. how would you select the folds)?

<details>

使用二元分类方法将动物的彩色图像分类为三个不同类别的一种可能方法是什么？您将如何表示数据？在这种情况下，您将如何进行交叉验证（即，您将如何选择折叠）？

One-vs-Rest，将三类问题拆分为三个二元分类器，每个分类器负责识别某一类别。
转换为数值特征，如 CNN。
使用 Stratified k-fold CV，确保每个类的比例相同。

</details>

# 2024-12-27

## Metric

Verify if $\mathbf{d(x,y)} = \max(|x - y|, 1)$ a distance measure for two binary strings $x$ and $y$ of equal length satisfies the properties of a metric.

<details>

验证 $\mathbf{d(x,y)} = \max(|x - y|, 1)$ 是否满足作为两个等长二进制字符串 $x$ 和 $y$ 的距离度量的性质。

1. 非负，因为绝对值和 max 都是非负的
2. 对称，因为 $|x - y| = |y - x|$
3. 等价，不满足，因为 $d(x,x) = 1$，而不是 0

所以不满足度量的性质。

</details>

## Linkage

Provide a scenario or a dataset where complete linkage clustering would be less effective and justify your reasoning.

<details>

提供一个 complete linkage 聚类效果较差的场景或数据集，并说明您的理由。

具有不同密度或非球状簇的数据集。
因为 complete 产生紧凑，球状的簇。

</details>

## Equation

Given the following equation: $\sum_{i=1}^{n}(y_i - \hat{y}_i)^2 + \lambda \sum_{j=1}^{p}\beta_j^2$, what do the components of this equation represent? Discuss the impact of using very small and very large values of $\lambda$.

<details>

给定以下方程：$ \sum*{i=1}^{n}(y_i - \hat{y}\_i)^2 + \lambda \sum*{j=1}^{p}\beta_j^2 $，该方程的各部分代表什么？讨论使用非常小和非常大的 $\lambda$ 值的影响。

1. 第一项：训练误差，在训练集上的拟合程度
2. L2 正则化项，控制模型复杂度
3. $\lambda$ 大：模型简单，欠拟合
4. $\lambda$ 小：模型复杂，过拟合

</details>

## Multi-Class

How can logistic regression be modified to perform multi-class classification?

<details>

如何修改逻辑回归以执行多类分类？

One-vs-Rest：每个类别训练一个二元分类器，预测“该类 vs 其他”
Softmax 回归：将所有类别的概率归一化为 1

</details>

## k-Fold

Explain the concept of k-fold cross-validation and describe the steps involved in performing it.

<details>

解释 k 折交叉验证的概念，并描述执行它所涉及的步骤。

一种模型评估方法，用于更可靠地估计模型在未见数据上的表现。

1. 将数据集平均分成 k 个子集
2. 选择一个子集作为验证集，其他 k-1 个子集作为训练集
3. 训练模型并在验证集上评估性能
4. 重复 k 次，计算平均值

</details>

# 2025-5-13

1. In supervised learning, what is assumed about the relationship between input and output?

   - There is no relationship.
   - Output is random and unrelated to input.
   - The input is a function of the output.
   - There is a true functional relationship $f : \mathcal{X} \rightarrow \mathcal{Y}$.

<details>

4. 输入和输出之间存在一个固定但未知的函数关系

</details>

2. What is a primary risk of setting $K = 1$ in KNN?

   - Underfitting.
   - Slow inference.
   - High bias.
   - High variance.

<details>

4. 1 时，KNN 仅根据最近的一个邻居做出预测，过拟合 → 泛化差 → 高方差

</details>

3. In KNN, how the proximity in continuous feature spaces is computed?

   - $L_1$ norm.
   - Hamming distance.
   - $L_2$ norm.
   - Cosine distance.

<details>

3. KNN 通常使用欧几里得距离（$L_2$ 范数）来计算连续特征空间中的邻近度。

</details>

4. How does increasing the value of K in KNN typically affect model behavior?

   - It reduces both bias and variance.
   - It increases variance and decreases bias.
   - It decreases variance and increases bias.
   - It has no effect on model generalization.

<details>

3. 增大 K，考虑更多邻居，平滑稳定，减少方差。模型对局部不敏感，增加偏差。

</details>

5. Which of the following characterizes the fundamental distinction between classification and regression?

   - Classification models learn a mapping to a probability distribution over discrete categories, whereas regression models learn a mapping to a continuous-valued function.
   - Both tasks model continuous outputs but differ in their feature extraction techniques.
   - Classification involves fitting continuous target variables with discrete output models, while regression discretizes continuous inputs.
   - Regression aims to partition the input space into finite regions, while classification fits a continuous response surface.

<details>

1. 分类是预测类别，回归是预测连续数值

</details>

6. $p(y = C \mid x) = \frac{1}{1 + \sum_{c=1}^{C-1} \exp(\beta_c^T x)}$
   The equation represents:

   - The probability of class C in a softmax function used for multi-class classification.
   - The probability of class C in a one-vs-rest logistic regression model.
   - The probability of class C in a multinomial logistic regression model with class C as the reference class.
   - The posterior probability of the most likely class in a Naive Bayes classifier.

<details>

3. 该公式表示：给定输入 𝑥，属于参考类别 C 的概率。其他类用 $\beta_c^T x$ 表示对比该参考类的相对对数几率。

</details>

7. In logistic regression, the log-odds are modeled as:

   - $p = x / \beta$
   - $y = \beta_0 + \beta_1 x$
   - $\log(\text{odds}) = \beta_0 + \beta_1 x$
   - odds = $x^2$

<details>

3. 在逻辑回归中，我们建模的是事件发生的对数几率

</details>

8. In Weighted KNN, how are the votes from neighbors typically weighted?

   - Neighbors closer to the query point contribute more weight.
   - Each neighbor contributes equally, regardless of distance.
   - Weights are assigned randomly to each neighbor.
   - Only the single closest neighbor contributes to the prediction.

<details>

1. 离得近的邻居影响更大

</details>

9. What type of model is KNN considered?

   - Semi-parametric.
   - Parametric.
   - Non-parametric.
   - Deterministic.

<details>

3. 没有固定数量的参数

</details>

10. Which of the following is a benefit of standardizing features in KNN?

    - Ensures distance metrics are meaningful.
    - Reduces variance.
    - Reduces overfitting.
    - Improves interpretability.

<details>

1. KNN 使用距离来判断邻居，数值大的特征会主导距离计算

</details>

11. What does the sigmoid function return values between?

    - $[0, 1]$
    - $[-1, 1]$
    - $[0, \infty)$
    - $(-\infty, \infty)$

<details>

1. Sigmoid 函数的输出范围是 $[0, 1]$，适合二分类问题。

</details>

12. The output of logistic regression is interpreted as:

    - Distance from hyperplane.
    - Number of features.
    - Probability of belonging to class 1.
    - Logarithm of class frequencies.

<details>

3. sigmoid 函数的输出属于类别 1 的概率。

</details>

13. What is a potential drawback of LOOCV (Leave-One-Out Cross-Validation)?

    - High variance.
    - Overfitting.
    - High computation cost.
    - Uses too little data.

<details>

3. LOOCV 是将每个样本单独作为验证集，其余作为训练集。缺点是计算成本高

</details>

14. In k-fold cross-validation, what happens in each iteration?

    - Train on $k-1$ folds, validate on 1 fold.
    - Train on one fold, test on the rest.
    - Train on all data, test on one fold.
    - Train on $k$ folds, validate on separate test data.

<details>

1. 每次迭代都在 k−1 个子集上训练，在剩下 1 个子集上验证

</details>

15. What is the Bayes Error Rate?

    - Maximum possible error.
    - Theoretical minimum error.
    - Error of the Bayes classifier on training data.
    - Error when using nearest neighbors.

<details>

2. 理论最小错误率

</details>

16. What does the ROC AUC score measure in a classification model?

    - The proportion of correctly predicted labels for each class.
    - The trade-off between true positive rate and false positive rate across all thresholds.
    - The accuracy of the model at a specific threshold.

<details>

2. ROC AUC 衡量模型在所有可能的分类阈值下，真正率（TPR）与假正率（FPR）之间的权衡表现。AUC 值越高，说明模型在区分正负样本上的能力越强。

</details>

17. What is the main goal of cross-validation?

    - Reduce training time.
    - Reduce the number of parameters.
    - Estimate model performance on unseen data.
    - Maximize feature usage.

<details>

3. 通过多次划分训练/验证集，评估模型在未见数据上的表现

</details>

18. Which task is best framed as a classification problem?

    - Forecasting daily closing prices of a stock.
    - Mapping images of digits to numerical labels.
    - Predicting average monthly rainfall in mm.
    - Estimating a car’s resale value based on mileage.

<details>

2. 将图像分为离散的类别

</details>

19. Why might the F1-score be misleading on an imbalanced dataset?
    - It only considers the majority class.
    - It is undefined when recall is 1.
    - It assumes equal importance of precision and recall.
    - It does not account for true negatives.

<details>

3. 它平均考虑了 Precision 和 Recall，无法体现实际任务中的偏重需求。

</details>

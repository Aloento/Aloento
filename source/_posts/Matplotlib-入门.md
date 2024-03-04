---
title: Matplotlib 入门
date: 2024-03-03 15:30:00
toc: true
categories:
  - [Data Science]
  - [Python]
tags: [数据科学, 笔记, Matplotlib]
---

本文是 Introduction to Data Science 的一部分

~~你们就照着文档念吧，谁照着念能念的过你们啊，活爹~~

<!-- more -->

# 快速开始

实际上这玩意就是一个 Python 版的 Matlab 绘图库  
对于有 Matlab 经验的人来说基本就是换个地方写一样的东西

接下来的每一个代码块都默认附加在上一个代码块的后面

## 导入

```python
# 启用 Jupyter 嵌入绘制的魔术命令
%matplotlib inline

import matplotlib as mpl
# 真要用的也就只有 plt
import matplotlib.pyplot as plt
# 怎么能少了数据源呢
import numpy as np
```

其中，`inline` 会嵌入静态图片，`notebook` 会嵌入交互式图片

## 尝试

```python
# 生成数据
x = np.linspace(0, 10, 200)
# 绘制图形
plt.plot(x, np.sin(x))
plt.plot(x, np.cos(x))
# 显示图形
plt.show()
```

## 保存

```python
# 生成一个空白图形并将其赋给 fig 对象
fig = plt.figure()
# 绘制实线
plt.plot(x, np.sin(x), '-')
# 保存矢量图
fig.savefig('my_figure.svg')
# 查看所有支持的格式
fig.canvas.get_supported_filetypes()
```

## 两种绘图方式

### MATLAB 风格

对于一般的绘图来说，这种方式更加直观简单

```python
# 创建一个图形
plt.figure()
# 创建一个子图
plt.subplot(2, 1, 1)
# 绘制第一个子图
plt.plot(x, np.sin(x))
# 创建第二个子图
plt.subplot(2, 1, 2)
# 绘制第二个子图
plt.plot(x, np.cos(x))
```

创建子图：subplot(rows: 子图行数, columns: 子图列数, subplot_number: 子图序号)

绘制图形：plot(x: x 轴数据, y: y 轴数据, format: 格式字符串)

### 面向对象风格

对于复杂的绘图来说，这种方式更加灵活

```python
# 创建一个图像网格
fig, ax = plt.subplots(2)
# 绘制第一个子图
ax[0].plot(x, np.sin(x))
# 绘制第二个子图
ax[1].plot(x, np.cos(x))
```

subplot**s** 会返回一个包含所有子图的数组

# 基本图形

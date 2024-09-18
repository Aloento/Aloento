---
title: Matplotlib 入门
date: 2024-03-03 15:30:00
toc: true
categories:
  - [Data Science]
  - [Program, Python]
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

绘制图形：plot(x: x 轴数据, y: y 轴数据, ...)

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

## 线图

```python
# 使用 range
plt.plot(range(1, 10))
# 使用 numpy
plt.plot(range(10, 1, -1), np.arange(1, 10))
```

plot(y: y 轴数据, ...)  
x 会自动使用 0 到 len(y) - 1 的整数

### 使用 OOP

```python
# 创建图像
fig = plt.figure()
# 创建坐标轴
ax = plt.axes()
# 创建等长数据序列
x = np.linspace(0, 5, 20)
# 绘制 sin
ax.plot(x, np.sin(x))
# 绘制 cos
ax.plot(x, np.cos(x))
```

linspace(start: 起始值, stop: 结束值, num: 生成的数据个数)  
该函数会返回一个包含 num 个元素的等差数列

多次调用 plot 会在同一张图上绘制多个图形

## `plot`

```python
plot(
    x: x 轴数据,
    y: y 轴数据,
    linestyle: 线条风格,
    linewidth: 线宽,
    color: 颜色,
    marker: 为线图添加散点，指定点的形状,
    markersize: 点大小,
    markeredgecolor: 点边框颜色,
    label: 图例标签,
    alpha: 透明度
)
```

### 颜色

plot 会自动循环使用颜色，但是也可以手动指定

```python
# 短颜色编码（rgbcmyk）
plt.plot(x, 2*x+1, color = "g")
# 灰度，从0到1
plt.plot(x, 2*x+2, color = "0.6")
# HEX
plt.plot(x, 2*x+3, color = "#FFEE22")
# RGB元组，从0到1
plt.plot(x, 2*x+4, color = (0.8, 0.7, 0.1))
# CSS 颜色名
plt.plot(x, 2*x+5, color = "chartreuse")
```

### 线条风格

plot(..., linestyle: 线条风格)

#### 使用名称

```python
# 实线
plt.plot(x, 2*x, linestyle = "solid")
# 虚线
plt.plot(x, 2*x+1, linestyle = "dashed")
# 点线
plt.plot(x, 2*x+2, linestyle = "dotted")
# 点划线
plt.plot(x, 2*x+3, linestyle = "dashdot")
```

#### 使用符号

```python
# 实线
plt.plot(x, 2*x, linestyle = "-")
# 虚线
plt.plot(x, 2*x+1, linestyle = "--")
# 点线
plt.plot(x, 2*x+2, linestyle = ":")
# 点划线
plt.plot(x, 2*x+3, linestyle = "-.")
```

---

我们还可以把颜色和线条风格合并在一起

```python
# 绿色虚线
plt.plot(x, 2*x, "g--")
# 蓝色点线
plt.plot(x, 2*x+1, ":b")
```

### 图例

虽然 plot 提供了 label 参数，但需要 legend() 才能显示

```python
x = range(0, 10)
y = np.cos(x)

# 蓝线
plt.plot(
  x,
  y,
  linestyle = '-.',
  linewidth = 1,
  color = 'blue',
  marker = 'o',
  markersize = 10,
  markeredgecolor = 'r',
  label = 'Cos',
  alpha = 0.5
)

y2 = np.sin(x)

# 红线
plt.plot(
  x,
  y2,
  linestyle = '--',
  linewidth = 1,
  color = 'red',
  marker = 'x',
  markersize = 10,
  markeredgecolor = 'b',
  label = 'Sin',
  alpha = 0.5
)

plt.legend()
```

### 标题标签

```python
x = np.linspace(0, 10, 200)
plt.plot(np.sin(x))

plt.title('Sine Curve')
plt.xlabel('Radian')
plt.ylabel('Magnitude')
```

### 范围

```python
plt.plot(np.sin(x))

# X 设置在 50 到 175
plt.xlim(50, 175)
# Y 设置在 -0.5 到 1
plt.ylim(-0.5, 1)
```

如果将参数反转，可以实现坐标轴的翻转

```python
plt.plot(np.sin(x))

# X 设置在 175 到 50
plt.xlim(175, 50)
# Y 设置在 1 到 -0.5
plt.ylim(1, -0.5)
```

### axis

我们还可以通过 `axis: [xmin, xmax, ymin, ymax]` 函数一次性设置

```python
plt.plot(np.sin(x))

# X 设置在 175 到 50
# Y 设置在 -0.5 到 1
plt.axis([175, 50, -0.5, 1])
```

它还支持自动调整

- `axis('tight')` 会自动调整到数据的最小范围
- `axis('equal')` 会使 x 和 y 与屏幕宽高比一致
- `axis('scaled')` 会使 x 和 y 的单位长度相等，不会调整到数据的最小范围
- `axis('square')` 会使 x 和 y 的单位长度相等，并且调整到数据的最小范围
- `axis('off')` 会关闭坐标轴

可以使用 `plt.axis?` 查看更多信息

## 散点图

~~今天做 quiz 的时候居然在一个非常简单的问题上选错了，不能再摆了~~

散点图在观察数据分布的时候非常有用

```python
x = range(1, 11)
# 传入 "o" 以便绘制散点图
plt.plot(x, x, "o")
```

还可以使用 `scatter` 函数，其提供了更多可以自定义的特性

```python
plt.scatter(x, x)
```

### 形状

Matplotlib 支持很多点的形状

```python
# 随机数生成器
rand = np.random.RandomState(42)

# 绘制随机点
for marker in ['o', '.', ',', 'x', '+', 'v', '^', '<', '>', 's', 'd']:
    plt.plot(rand.rand(5), rand.rand(5), marker, label = "marker = '{}'".format(marker))

plt.legend()
# 避免图例与数据重叠
plt.xlim(0, 1.8)
```

### 透明度

点太多会重叠，不便于观察

```python
x = rand.rand(200)
y = rand.rand(200)

# 绘制散点图
plt.scatter(x, y, alpha = 0.5)
```

### 颜色与大小

```python
x = rand.rand(100)
y = rand.rand(100)

colors = rand.rand(100)
sizes = 1000 * rand.rand(100)

# 绘制散点图
plt.scatter(x, y, c = colors, s = sizes, alpha = 0.5)
# 添加颜色条
plt.colorbar()
```

## 条形图

PPT 专用图形

```python
x = range(1, 6)
y = [1, 4, 6, 8, 4]

plt.bar(x, y)
```

还可以是水平的

```python
plt.barh(x, y)
```

### 分组

```python
member = ['A', 'B', 'C', 'D']
jan = [30, 40, 50, 60]
feb = [35, 45, 55, 65]
mar = [40, 50, 60, 70]
# 设置每个柱状图的宽度
width = 0.2

# 绘制柱状图
plt.bar(range(4), jan, width = width, label = 'Jan')
plt.bar(np.arange(4) + width, feb, width = width, label = 'Feb')
plt.bar(np.arange(4) + width * 2, mar, width = width, label = 'Mar')

# 添加图例
plt.legend()

# 设置刻度
plt.xticks(np.arange(4) + width, member)
# 设置 y 轴标签
plt.ylabel('Revenue')

# 显示网格
plt.grid()
# 显示图形
plt.show()
```

### 堆叠

```python
# 绘制堆叠柱状图
plt.bar(np.arange(4), jan, label = 'Jan')
plt.bar(np.arange(4), feb, bottom = jan, label = 'Feb')
plt.bar(np.arange(4), mar, bottom = np.array(jan) + np.array(feb), label = 'Mar')

# 添加图例
plt.legend()

# 设置刻度
plt.xticks(np.arange(4), member)
# 设置 y 轴标签
plt.ylabel('Revenue')

# 显示网格
plt.grid()
# 显示图形
plt.show()
```

bottom 让数据在上一个数据的基础上偏移  
np.array 便于元素级别（向量化）运算

## 直方图

```python
x1 = np.random.normal(0, 0.4, 1000)
x2 = np.random.normal(-3, 1, 1000)
x3 = np.random.normal(2, 2, 1000)

kwargs = dict(histtype='stepfilled', alpha=0.5, density=True, bins=40)

plt.hist(x1, **kwargs)
plt.hist(x2, **kwargs)
plt.hist(x3, **kwargs)
```

### 参数

```python
plt.hist(
  x: 数据,
  bins: 柱数,
  range: 上下边界,
  density: 频数转换成频率,
  weights: 每个数据的权重,
  cumulative: 计算累计频数或频率,
  bottom: 基准线,
  histtype: 柱状图类型 _bar_ / barstacked / step / stepfilled,
  align: 边界对齐方式 left / _mid_ / right,
  orientation: 方向 _vertical_ / horizontal,
  rwidth: 柱宽,
  log: 是否对 y 轴取对数,
  color: 颜色,
  label: 图例标签,
  stacked: 有多个数据时是否堆叠 默认水平
)
```

### 二维数据

二维直方图在两个维度进行切分，来查看数据的分布

```python
x = np.random.randn(1000)
y = np.random.randn(1000)

plt.hist2d(x, y, bins=30, cmap='Blues')
plt.colorbar()
```

## 饼图

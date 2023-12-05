---
title: Numerical Methods II - Part 2
date: 2023-12-03 21:50:00
toc: true
categories:
  - [Math, Matlab]
tags: [习题, 数学, 数值方法]
---

时隔一年，老师添加了一点新题，所以又来更新一下。

<!-- more -->

# Numerical Integral, Matrices of Geometrical Transforms

## 近似计算定积分

Write an M-file for using quadrature formulas.  
The name of the function be: numint

- Input arguments: integrand (as a string),  
  the endpoints of the interval (a, b),  
  number of divisors (n),  
  type of the quadrature (rectangle, trapezoid, simpson)

- Output argument: the result of the integral.

```matlab
% 7.1 近似计算定积分
% 积分（字符串）
% 区间 (a, b) 的端点
% 除数 (n)
% 正交类型（矩形、梯形、辛普森形）
function integralResult = numint(integrand, b, a, n, method)
arguments
    % 检查integrand是否为字符串
    integrand (1,1) string

    % 检查a和b是否为数值，且a小于b
    b (1,1) double {mustBeNumeric}
    a (1,1) double {mustBeNumeric, mustBeLessThan(a, b)}

    % 检查n是否为正整数
    n (1,1) double {mustBeInteger, mustBePositive}

    % 检查method是否为有效的字符串选项
    method (1,1) string {mustBeMember(method, ["rectangle", "trapezoid", "simpson"])}
end

    % 将字符串形式的被积函数转换为函数句柄
    f = str2func(integrand);

    % 根据所选的方法计算积分
    switch method
        case 'rectangle'
            integralResult = rectangleMethod(f, a, b, n);
        case 'trapezoid'
            integralResult = trapezoidMethod(f, a, b, n);
        case 'simpson'
            integralResult = simpsonMethod(f, a, b, n);
        otherwise
            error('Unknown method. Please choose rectangle, trapezoid, or simpson.');
    end

end

% 首先计算每个小区间的宽度 h，然后遍历每个小区间
% 计算每个区间中点的函数值，并将所有这些值累加起来
% 最后，将累加的和乘以小区间的宽度，得到积分的近似值
% 这个方法在处理高度振荡或非常不规则的函数时可能不够精确
% 在这种情况下，可能需要更多的区间（即更大的 n）
function result = rectangleMethod(f, a, b, n)
    % 计算每个小区间的宽度
    h = (b - a) / n;

    % 初始化积分结果
    integralSum = 0;

    % 对每个小区间进行迭代
    for i = 1:n
        % 计算当前小区间的中点
        x_mid = a + (i - 0.5) * h;

        % 计算函数在中点的值并累加
        integralSum = integralSum + f(x_mid);
    end

    % 计算最终的积分近似值
    result = h * integralSum;
end

% 首先计算每个小区间的宽度 h
% 然后，我们初始化积分和为区间两端点处函数值的平均值
% （这是因为在梯形法中，区间两端的点只被计算一次）
% 接着，我们遍历每个小区间的内部点，将这些点处的函数值累加到积分和中
% 最后，将累加的和乘以小区间的宽度，得到积分的近似值
% 这种方法比矩形法更精确，尤其是在函数比较平滑的情况下
% 然而，对于高度振荡或非常不规则的函数，它仍然可能不够精确
function result = trapezoidMethod(f, a, b, n)
    % 计算每个小区间的宽度
    h = (b - a) / n;

    % 初始化积分结果
    integralSum = 0.5 * (f(a) + f(b));

    % 对每个小区间的内部点进行迭代
    for i = 1:(n-1)
        x = a + i * h;
        integralSum = integralSum + f(x);
    end

    % 计算最终的积分近似值
    result = h * integralSum;
end

% 我们首先确保 n 是一个正的偶数。然后，我们计算每个小区间的宽度 h
% 接着，我们初始化积分和为区间两端点处函数值的和
% 在遍历每个小区间的内部点时，我们根据这些点是奇数位置还是偶数位置
% 分别乘以 4 或 2（这是辛普森法的特点）
% 最后，将累加的和乘以 h/3，得到积分的近似值
function result = simpsonMethod(f, a, b, n)
    % 确保n为偶数
    if mod(n, 2) ~= 0
        error('n must be a positive even integer.');
    end

    % 计算每个小区间的宽度
    h = (b - a) / n;

    % 初始化积分结果
    integralSum = f(a) + f(b);

    % 对每个小区间的内部点进行迭代
    for i = 1:n-1
        x = a + i * h;
        if mod(i, 2) == 0
            integralSum = integralSum + 2 * f(x);
        else
            integralSum = integralSum + 4 * f(x);
        end
    end

    % 计算最终的积分近似值
    result = (h / 3) * integralSum;
end
```

## 原点 affine 变换

Write an M-file, what gives the matrix of any affin transform with fixed point in Origin  
The name of the file: affin1

- Input arguments: The images of points (0, 1) and (1, 0).
- Output argument: The matrix of the transform.
- If someone calls the function without input arguments give them an opportunity for the graphical input.

```matlab
% 7.2 计算具有原点固定点的 affine 变换矩阵
% 输入参数:
%   imageOf01 - 点 (0, 1) 变换后的图像
%   imageOf10 - 点 (1, 0) 变换后的图像
% 输出参数:
%   A - 变换的矩阵
function A = affin1(imageOf01, imageOf10)
    if nargin == 0
        % 如果没有输入参数，通过图形界面获取输入
        disp('请图形化输入点 (0, 1) 和 (1, 0) 变换后的图像');
        [x1, y1] = ginput(1); % 获取点 (0, 1) 变换后的图像
        [x2, y2] = ginput(1); % 获取点 (1, 0) 变换后的图像
        imageOf01 = [x1; y1];
        imageOf10 = [x2; y2];
    end

    % 验证输入参数
    if ~isequal(size(imageOf01), [2, 1]) || ~isequal(size(imageOf10), [2, 1])
        error('输入参数的大小必须是 2x1');
    end

    % 计算 affine 变换矩阵
    A = [imageOf10, imageOf01];

    % 输出变换矩阵
    disp('Affine 变换矩阵为:');
    disp(A);
end
```

```matlab
% 输入示例
A = affin1([2; 3], [4; 1])
```

## 三角变换

Write an M-file, what gives the matrix of any affin transform.  
The name of the m-file: affin2

- Input arguments: a triangle (with the coordinates of the edges) and the image of the triangle (also with the edges)
- Output argument: The matrix of the transform.
- Give an opportunity for graphical input (as in the previous exercise)
- Draw a figure in both cases.

```matlab
% 7.3 计算基于一个三角形及其映射后的三角形的仿射变换矩阵
%
% 使用方法:
% A = affin2(triangle, image_triangle)
% 其中 triangle 和 image_triangle 是包含三角形顶点坐标的 3x2 矩阵
% 如果没有给出参数，则使用图形输入
function A = affin2(triangle, image_triangle)
    if nargin == 0
        % 没有输入参数，使用图形输入
        disp('点击以定义原始三角形的顶点：');
        triangle = ginput(3);
        disp('点击以定义映射后三角形的顶点：');
        image_triangle = ginput(3);
    end

    if size(triangle, 1) ~= 3 || size(image_triangle, 1) ~= 3
        error('两个三角形都必须有 3 个顶点。');
    end

    % 构造变换矩阵
    % 添加一行 1 以处理仿射变换
    T = [triangle, ones(3, 1)];
    T_image = [image_triangle, ones(3, 1)];

    % 求解变换矩阵
    A = T_image' / T';

    % 绘制原始三角形和变换后的三角形
    figure;
    plot([triangle(:,1); triangle(1,1)], [triangle(:,2); triangle(1,2)], 'b-o');
    hold on;
    plot([image_triangle(:,1); image_triangle(1,1)], [image_triangle(:,2); image_triangle(1,2)], 'r-o');
    legend('原始三角形', '变换后的三角形');
    title('三角形的仿射变换');
    hold off;
end
```

```matlab
% 输入示例
triangle = [0, 0; 1, 0; 0, 1];
image_triangle = [2, 3; 4, 1; 5, 5];
A = affin2(triangle, image_triangle)
```

# 等边三角形

Give 3 points in the plane. Two of them, P (2; 3) and Q (4; 2), lie on different sides of an equilateral triangle.
The third point, S (3; 3), is the centroid of the triangle.
Use MATLAB to find the vertices of a triangle (by adding the coordinates of the vertices) and make an illustration for the exercise.

\text{Side length} = \sqrt{(x_Q - x_P)^2 + (y_Q - y_P)^2}

R = \frac{\text{Side length}}{\sqrt{3}}

```matlab
% 定义点 P, Q 和 S
P = [2, 3];
Q = [4, 2];
S = [3, 3];

% 计算三角形的边长
side_length = sqrt((Q(1) - P(1))^2 + (Q(2) - P(2))^2);

% 计算外接圆的半径
R = side_length / sqrt(3);

% 计算三角形的顶点
% 我们已经有两个顶点（P 和 Q），我们需要找到第三个顶点（R）

% 计算 PQ 的中点
mid_PQ = (P + Q) / 2;

% 计算中点到质心的向量
vec_mid_to_centroid = S - mid_PQ;

% 计算 PQ 的垂直向量
perpendicular = [vec_mid_to_centroid(2), -vec_mid_to_centroid(1)];

% 归一化垂直向量
perpendicular = perpendicular / norm(perpendicular);

% 计算第三个顶点
R_vertex = S + R * perpendicular;

% 检查 R_vertex 是否与 S 在 PQ 的同一侧
% 如果不是，反转方向
if dot(R_vertex - mid_PQ, vec_mid_to_centroid) < 0
    R_vertex = S - R * perpendicular;
end

% 绘制三角形
figure;
hold on;
grid on;
axis equal;

% 绘制点
plot(P(1), P(2), 'ro');
plot(Q(1), Q(2), 'ro');
plot(S(1), S(2), 'bo');
plot(R_vertex(1), R_vertex(2), 'go');

% 绘制三角形的边
plot([P(1), Q(1)], [P(2), Q(2)], 'r');
plot([P(1), R_vertex(1)], [P(2), R_vertex(2)], 'r');
plot([Q(1), R_vertex(1)], [Q(2), R_vertex(2)], 'r');

% 添加注释
text(P(1), P(2), ' P');
text(Q(1), Q(2), ' Q');
text(S(1), S(2), ' S (质心)');
text(R_vertex(1), R_vertex(2), ' R');

title('具有顶点 P, Q 和 R 的等边三角形');
xlabel('X 轴');
ylabel('Y 轴');
hold off;
```

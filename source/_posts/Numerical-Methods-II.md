---
title: Numerical Methods II
date: 2022-12-10 19:07:00
toc: true
categories:
  - [Math, Matlab]
tags: [习题, 数学, 数值方法]
---

很多很好玩的数值方法  
是 Matlab 苦手，所以很多高血压代码

<!-- more -->

# Machine Numbers

## 机器数转十进制

Our first M-file computes the value of a machine number.

Let us choose fl1 as name of function and of course as name of the file also.
We give a vector as input parameter. The last coordinate of vector gives the
characteristic of machine number (in tenary numeral system). We store the signed
mantissa in the other coordinates.

The output argument be the real number what is represented by our machine number.

- The first bit of mantissa we can use for storing the sign of the number.
  (Originally this bit is surely 1.) When the number is positive, then the signbit be 0,
  in case of negative numbers we use 1 as first bit.
- We don’t have to know the parameters of machine number set for converting
  the number. The length of mantissa can be read from input data. And we
  assume that the bounds of characteristic are such that our carachteristic be allowed.
- Before starting computation let us check whether the given data can be a
  machine number or not. (All but last coordinates are from set {0,1} and last is an integer.)

```matlab
% 1. 机器数转十进制
% 第一位是正负号
% 中间是二进制
% 最后一位是指数位
function dec = fl1(vector)
arguments
    % 限定输入必须是一维数组
    vector (1,:)
end
    isaninteger = @(x) isfinite(x) & x == floor(x);

    % 判断 最后一位是整数
    if  ~isaninteger(vector(end))
        % 如果不是，将返回值标记为无效
        dec = nan;
        return
    end

    % 对数组内容进行验证，起始 到 倒数第二位
    for n = vector(1:end-1)
        %  只能是二进制
        if ~(n == 0 || n == 1)
            dec = nan;
            return
        end
    end

    % 初始化赋值
    dec = 0;
    % 从 第二位 到 倒数第二位
    for n = 2:length(vector)-1
        if vector(n) == 1
            % 二进制转十进制算法
            dec = dec + 1/(2^(n-1));
        end
    end

    % 位移，应用指数位
    dec = dec * 2^vector(end);

    % 检查正负号
    if vector(1)
        dec = -dec;
        return
    end
end
```

## 在数轴上展示机器数

Let us write anothe M-file, called fl2. It displays the elements of a given machine
number set on the real axis. Compute the number of elements and the following
parameters: M∞, ε0, ε1. (They will be the output arguments of the function)

The function waits 3 (integer) number as input.
They are the parameters of the set: t, k1, k2.

- Let us check whether the input parameters are appropriate.
  (t ∈ N+ and k1, k2 ∈ Z, and of course k1 < k2)
- For the computation we can call our first function (fl1)
- The set is symmetric. We can use this property for the faster computation.

```matlab
% 1. 在数轴上展示机器数，输出最大最小值，和与1的偏差
function [max, min, diff] = fl2(digits, bottomExp, topExp, draw)
% M∞, ε0, ε1
arguments
    % 限定它们只能是一位数字
    digits (1,1)
    bottomExp (1,1)
    topExp (1,1)
    % 布尔值，可选参数，默认为真
    draw (1,1) = 1
end
    isaninteger = @(x) isfinite(x) & x == floor(x);

    % 最大位数必须大于零 且 是整数
    % 低指数 小于或者等于 高指数，同时是整数
    if ~(digits > 0 && isaninteger(digits)) ...
        || bottomExp > topExp ...
        || ~isaninteger(bottomExp) ...
        || ~isaninteger(topExp)
        max = nan;
        return
    end

    mn = [];
    % 遍历出全部位数的机器数可能性
    % n 从 1 开始枚举 到 最大位数
    for n = 1:digits
        % 括号里面是十进制数组，长度为 2^n
        % 如 [0, 1, 2, 3]，-1 的原因是从 0 开始
        % de2bi 会把数组里面的每一个数都转换成二进制
        % 矩阵 m 有 2^n 行 n 列
        % 这样写的好处是写起来简单，问题是会产生大量重复内容
        m = de2bi(0:(2^n)-1);

        % 按行遍历矩阵，取出每一个二进制结果
        for k = 1:size(m, 1)
            % 遍历所有的指数大小可能性，同样会产生大量重复内容
            for e = bottomExp:topExp
                % 把二进制结果转换为机器数，并储存
                % 这种持续变换矩阵大小的行为效率低下，但是写起来简单
                mn = [mn, fl1([0, m(k, :), e])];
            end
        end
    end

    % 将所有重复项排除，此方法会自动从小到大排序
    mn = unique(mn);
    max = mn(end);
    min = mn(1);

    % 找出 1 的位置，并且取出它的下一位，算出误差
    diff = mn(find(mn == 1) + 1) - 1;

    % 对称
    mn = [-mn, mn];
    if draw
        plot(mn, repelem(0, length(mn)), "o")
    end
end
```

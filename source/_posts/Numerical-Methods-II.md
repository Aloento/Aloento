---
title: Numerical Methods II
date: 2022-12-10 19:07:00
toc: true
categories:
  - [Math, Matlab]
tags: [习题, 数学, 数值方法]
---

很多很好玩的数值方法

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

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

## 十进制转机器数

The third function finds the machine number what representates the given real number.

The name be fl3. The function waits the real number and parameters of set of
machine numbers (t, k1, k2.) as input. And gives back a vector with t+1 coordinates.
The last coordinate be the characteristic and the firs t stores the signed
mantissa. (As in case of input argument of function fl1).

- The first bit of mantissa is the sign-bit as in exercise 1.
  The value of sign is 0 when number is positive and 1 when it is negative.
- Check the input arguments whether they are appropriate.
  And the real number whether can representate in machine number set. (ε0 ≤ |r| ≤ M∞)

```matlab
% 1. 十进制转机器数
function vector = fl3(digits, bottomExp, topExp, dec)
    % fl2 自带检查了所以这里就不再重复检查
    [max] = fl2(digits, bottomExp, topExp, 0);

    % min <= dec <= max 防止溢出
    if isnan(max) || ~((-max <= dec) && (dec <= max))
        vector = nan;
        return
    end

    sgn = 0;
    % 记录十进制正负
    if sign(dec) == -1
        sgn = 1;
    end

    % 取十进制绝对值
    dec = abs(dec);
    % 抹掉小数，把整数位转换成二进制
    int = fix(dec);
    bin = [];
    % 只有整数不为零的情况才需要转换
    if int
        bin = de2bi(int);
    end

    % 整数二进制的长度就是未标准化的机器数的指数
    % 我们可能得到这样两种情况：111.2222... 和 0.1111...
    % 只有第一种情况我们需要把整数位全部位移到小数位上
    % 这时候就产生了指数位（指数位是可以为零的）
    power = length(bin);
    % 0.小数部分 * 2^(1:位数) 再取它 除以二 的余，并且抹掉小数
    % 乘2取整，顺序排列，不断的在小数位上乘2
    bin = [bin, fix(rem(rem(dec,1) * pow2(1:digits), 2))];

    if power
        % 强行截断超出部分，只留超出的第一位，进行舍零入一
        bin = bin(1:digits + 1);
    end

    % 是否需要进位
    over = 0;
    % 只有当整数向后位移的情况才可能超出
    if power
        over = bin(end);
    end

    % 逆向遍历数组
    for n = digits:-1:1
        if over
            % 是 1 则变成 0，继续进位
            if bin(n)
                bin(n) = 0;
            else
                % 如果是 0 则 停止进位
                bin(n) = 1;
                over = 0;
            end
        else
            break
        end
    end

    % 我们不需要考虑溢出的情况，因为最开始就已经检查过范围了
    vector = [sgn, bin(1:digits), power];
end
```

## 机器数相加

Let us write a function for addition between machine numbers.

Let us call the file to fl4. It waits for two vectors as input. (They are representate
the machine numbers as before). The output be a vector with the machine number of the sum.

- Use machine-addition. The double conversion is not acceptable. (To compute
  the real numbers belongs to inputs, summing them and reconverting to
  machin number is not allowed.)
- Check the inputs. (They have to have same length and have to be machine numbers)
- If one of the numbers is negative (the first bit is 1) then in real the operation
  is a substraction.

```matlab
% 1. 机器数相加
function vector = fl4(a, b)
arguments
    a (1,:)
    b (1,:)
end

    % 检查合法性，但是并没有检查完整
    if ~isvector(a) || ~isvector(b) || length(a) ~= length(b)
        vector = nan;
        return
    end

    % 取出两个的指数位
    ac = a(end);
    bc = b(end);
    % 目标指数
    char = ac;

    % 取出两个的二进制数据
    abin = a(2:end - 1);
    bbin = b(2:end - 1);
    % 二进制长度
    len = length(abin);

    % 如果两个指数不相等
    if ac ~= bc
        diff = ac - bc;

        if ac > bc
            % align
            % A 大所以扩大 B
            for n = 1:diff
                bbin = [0, bbin];
            end

            bbin = bbin(1:len);
        else
            for n = 1:-diff
                abin = [0, abin];
            end

            % 目标指数转为大的那个
            char = bc;
            abin = abin(1:len);
        end
    end

    % fliplr 将数组从左向右翻转
    % 当使用 bi2de 或者 de2bi 时
    % 第一位是 least significant bit 最低有效位
    % 最后一位是 most significant bit 最高有效位
    % 所以是小端序的，我们必须反转它
    ad = bi2de(fliplr(abin));
    bd = bi2de(fliplr(bbin));

    % 处理符号
    if a(end - 1)
        ad = -ad;
    end

    if b(end - 1)
        bd = -bd;
    end

    % 相加并转回二进制
    dres = ad + bd;
    bin = fliplr(de2bi(abs(dres)));
    % 新结果与原始数据长度差
    dlen = length(bin) - len;
    % 增加指数位
    char = char + dlen;

    if length(bin) > len
        % 如果太长了就截断，我们不改变机器数的长度
        bin = bin(1:len);
    elseif length(bin) < len
        % 如果不足，就在后面补 0
        for n = 1:-dlen
            bin = [bin, 0];
        end
    end

    % 处理符号
    sgn = 0;
    if sign(dres) == -1
        sgn = 1;
    end

    % 基本上只是简单实现了两个机器数的加减
    % 没有判断两个输入的合法性
    % 也没有判断是否溢出
    % 而且实际还用的是十进制加减
    % 总的来说不是很合格
    vector = [bin, sgn, char];
end
```

# Gaussian Elimination

## 计算高斯消去

Write an M-file to compute Gaussian Elimination.
The name of the file be gaussel1

- Input parameters: the coefficient matrix (A) and the right-side vector (b) of LES.
- Output argument: the solution vector x
- Use the Matlab row-operations for organisation of algorithm.
- If GE can’t be solved without row or coloumn swap write an error message
  and terminate the program.
- In case of underdetermined LES give a base solution and warn the user of this.
- In case the user asked it, display the matrices A(i) during computation.
- To checking our function we can use the exercises from numerical I.

+1 We can prepare our function to accept LES with multiple right sides.

```matlab
% 2. 计算高斯消去
function x = gaussel1(A, b, display)
arguments
    A
    % 右向量，只能有一列
    b (:,1)
    display (1,1) = 0
end

    [ARow, ACol] = size(A);
    BRow = size(b, 1);

    if ~ismatrix(A) || ARow ~= BRow
        error("ValidationException");
    end

    % 方程个数小于未知量个数的方程组
    % 此时有无穷多组解，展示一个基本解
    if(ARow < ACol)
        warning('A is underdetermined, the basic solution with at most m nonzero components is')
        disp(A\b)
    % 超定是方程个数大于未知量个数的方程组，且列满秩
    % 一般是不存在解的矛盾方程，只能求一个最接近的解
    elseif(ARow > ACol && rank(A) == ACol)
        % 显示一个使用最小二乘法，且 norm(A*x-b) & norm(x) 最小
        % 线性方程的最小范数最小二乘解，指示它是离原点最近的解，但仍然进行GJ
        warning('A is overdetermined, the minimum norm least-squares solution is')
        disp(lsqminnorm(A, b))
    end

    M = [A, b];
    [rows, cols] = size(M);
    % 主元容差，主要是为了控制精度问题，如 magic(4)
    % https://ww2.mathworks.cn/help/matlab/ref/rref.html#mw_5f53d9c8-72e8-42cc-bda8-ef84cf56ba93
    tolerance = eps * max(rows, cols) * norm(M, inf);

    % Gauss-Jordan
    r = 1;
    for c = 1:cols
        % 找出当前列中，绝对值最大的数字，及其所在的行
        % 使用部分主元消去法可减少（但会不消除）计算中的舍入误差
        % 主元位置：行中最左边的非零元素
        [num, target] = max(abs(M(r:end, c)));
        % 加上 r 的原因是因为上面 max 判断的是被截断的矩阵
        target = r + target - 1;

        if (num <= tolerance)
            % 跳过当前列，将近似零的项直接变成零
            % 这可以防止使用小于容差的非零主元元素进行运算
            M(r:end, c) = zeros(rows - r + 1, 1);
            if display
                disp(M)
            end
        else
            % 交换最大行与当前行
            M([target, r], c:end) = M([r, target], c:end);
            if display
                disp(M)
            end

            % 标准化最大行（把主元变成1）
            M(r, c:end) = M(r, c:end) / M(r, c);
            if display
                disp(M)
            end

            % 消除当前的列（消元），但是要除开当前行
            erow = [1:r - 1, r + 1:rows];
            M(erow, c:end) = M(erow, c:end) - M(erow, c) * M(r, c:cols);
            if display
                disp(M)
            end

            % 检查是否完成行遍历
            if (r == rows)
                break;
            end

            r = r + 1;
        end
    end

    x = M(:, end);
end
```

## Whole Pivoting

Extend the previous m-file (but save as a new name for example gaussel2) with
steps of partial and whole pivoting method.

- Using partial or whole pivoting could be choosen by user
  (for example according to a boolean input parameter), but if the partial pivoting is stucked
  then automatically switch to whole pivoting method. If we used whole pivoting despite user has choosen partial pivoting, then inform user about the switch
- Give an opportunity for displaying matrices A(i) during computation. Don’t
  forget that pivoting method can be changed the matrix so we have to display
  it after row and coloumn swap.
- Don’t forget that the pivoting method can be changed the solution.

```matlab
% 2. 完全交换，注释看前面一个
function x = gaussel2(A, b, display)
arguments
    A
    b (:,1)
    display (1,1) = 0
end

    M = [A, b];
    [rows, cols] = size(M);
    xOrd=(1:length(b))';
    tolerance = eps * max(rows, cols) * norm(M, inf);

    % Whole Pivoting
    r = 1;
    for c = 1:cols - 1
        % 找出行列最大值
        [maxc, rowI] = max(abs(M(r:end, c:end - 1)));
        [num, colI] = max(maxc);
        row = rowI(colI) + c - 1;
        col = colI + c - 1;

        if (num <= tolerance)
            M(r:end, c) = zeros(rows - r + 1, 1);
            if display
                disp(M)
            end
        else
            % 交换列
            M(r:end, [col, c]) = M(r:end, [c, col]);
            if display
                disp(M)
            end

            % 交换行
            M([row, r], c:end) = M([r, row], c:end);
            if display
                disp(M)
            end

            % 交换X
            oldOrd = xOrd(c);
            xOrd(c) = xOrd(col);
            xOrd(col) = oldOrd;

            % 标准化
            M(r, c:end) = M(r, c:end) / M(r, c);
            if display
                disp(M)
            end

            % 消元
            erow = [1:r - 1, r + 1:rows];
            M(erow, c:end) = M(erow, c:end) - M(erow, c) * M(r, c:cols);
            if display
                disp(M)
            end

            if (r == rows)
                break;
            end

            r = r + 1;
        end
    end

    % 调换回正常顺序
    x = M(xOrd, end);
end
```

## 求逆矩阵

Apply Gaussian elimantion for computing inverse of an square matrix.
The name of function: gaussel3

- Check input argument(s) before computing
- Compute the determinant of matrix.  
  If you have written the function gaussel1 such that it accepts multiple
  right-sides, then you can call it during computation.

```matlab
% 2. 求逆矩阵
function x = gaussel3(A)
    [row, col] = size(A);
    if row ~= col
        error("A is not a square matrix")
    end

    % 判断是否是奇异矩阵，如果是则不可逆
    if det(A) == 0
        warning("A is singular matrix")
    end

    A = [A, eye(row)];

    for c = 1:row
        % 在消元操作之前选择一个最大的元素作为主元
        % 这样可以避免主元为零的情况，从而提高精度
        [~, maxI] = max(abs(A(c:row, c)));
        % 得到原来矩阵A中的行索引
        maxI = maxI + c - 1;

        % 将矩阵A的第maxI行作为主元行，并将主元行转化为单位矩阵
        % （主元行中的第c个元素是1，其余元素都是0）
        % 这样一来，矩阵A的第maxI行就成为了消元的基准行
        % 在后续的消元操作中，其他行都需要根据这一行进行消元
        A(maxI, :) = A(maxI, :) / A(maxI, c);

        temp = A(c, :);
        % 将矩阵A的主元行移动到第c行，使得在后续的消元操作中
        % 只需要对矩阵A的第c行以下的部分进行消元
        A(c, :) = A(maxI, :);
        A(maxI, :) = temp;

        for j = 1:row
            if(j ~= c)
                % 消元操作，使得矩阵A的第j行的第c个元素变为0
                A(j, :) = A(j, :) - A(j, c) * A(c, :);
            end
        end
    end

    x = A(:, row + 1:size(A, 2));
end
```

# QR-decomposition

## Gram-Schmidt

Write an M-file for QR-decomposition using Gram-Schmidt orthogonalization. Let
us call the function to: gramschmidt

- Input parameter: a square matrix (A)
- Output arguments: an orthogonal matrix (Q) and an upper triangular matrix (R),
  such that satisfy A = Q·R
- To check existence of decomposition (the columns of A have to be linear
  independent) we can use any included function of Matlab.
- The included functions can be used for computing norms,
  but we can compute via definition also.

```matlab
% 3. Gram-Schmidt正交法
% 选择一组线性无关的向量。然后通过计算每个向量与之前所有向量的投影
% 并将这些投影从原始向量中减去，来逐步构造出一组正交向量
% 1. 对于矩阵A的每一列，计算该列向量在之前处理的所有基向量上的投影分量
% 2. 减去投影分量，得到一个正交化的基向量
% 3. 更新正交矩阵Q和上三角矩阵R
function [Q, R] = gramschmidt(A)
    [m, n] = size(A);

    if (m ~= n)
        error("A should be a square matix")
    end

    if (rank(A) ~= size(A, 2))
        % 加了这个 magic 就过不了了
        warning("the columns of A have to be linear independent")
    end

    Q = zeros(m);
    R = zeros(m);

    % 从最左侧的列向量向右
    for col = 1:n
        a = A(:, col);
        q = a;

        % 减去 A 中当前列向量在之前已找到的基向量上的投影分量
        for b = 1:col-1
            % 计算给定列向量a在已处理的基向量Q的第b列上的投影分量
            r = Q(:, b)' * a;
            % 减去当前列向量在之前处理的基向量上的投影分量
            q = q - r * Q(:, b);
            % 记录对应 R 矩阵中的元素值
            R(b, col) = r;
        end

        % 对当前基向量进行正交化
        q = q / norm(q);

        % 更新结果
        Q(:, col) = q;
        R(col, col) = a' * q;
    end

end
```

## Householder

Write an M-file to give the matrix of a Householder transformation, from a known
point and its image. The name of function let be: householder

- Input parameters: the coordinatas of the point and its image (P, P') Point
  P (and ofcourse P' also) can be from Rn where n is not predetermined.
- Output argument: the matrix of Householder-transformation
- Take care of choosing sign during transformation (the parameter σ effects
  the stability of the method)

```matlab
% 3. Householder 变换主要就是那个公式，没有什么别的
function H = householder(P, Prem)
arguments
    P (:,1)
    Prem (:,1) % P'
end
    % 解题参考 NumSampleTest1SolutionsP1 213

    if (size(P) ~= size(Prem))
        error("Size P not equal to Size ImgP")
    end

    u = P - Prem;
    v = u / norm(u);

    % H(v) = I - 2 * v * v'
    H = eye(size(P, 1)) - 2 * (v * v');
end
```

## 点映射

The third function will asking data via graphical input. (It works for 2D points)
Display points and the hyperspace of reflection. Ask for another point (also via
graphical input) and apply the transformation to the new point. The function
householder can be called during the algorithm.
the name of function: hhgraph

```matlab
% 3. 交互点映射
function hhgraph()
    clf;
    hold on;

    ax = gca;
    ax.XAxisLocation = "origin";
    ax.YAxisLocation = "origin";

    button = questdlg("Click a point", "First Step", "OK", "Cancel", "OK");
    if strcmpi(button, "Cancel")
        return;
    end

    [PointX, PointY] = ginput(1);
    plot(PointX, PointY, "rd")

    R = distance(PointX, PointY, 0, 0);
    viscircles([0, 0], R);

    button = questdlg("Click another point", "Second Step", "OK", "Cancel", "OK");
    if strcmpi(button, "Cancel")
        return;
    end

    [PointX2, PointY2] = ginput(1);
    plot(PointX2, PointY2, "rd")

    syms x y u;
    % 圆的标准方程
    c = x ^ 2 + y ^ 2 - R ^ 2;
    % 计算点 (x,y) 到第二个点（PointX2,PointY2）之间的欧几里得距离
    d = (x - PointX2) ^ 2 + (y - PointY2) ^ 2;
    % 求出第二个点（PointX2,PointY2）在反射变换后的位置，以确定反射变换矩阵 H
    h = d + u * c;

    % 前两个参数表示 h 关于 x 和 y 的一阶导数，它们用来求解 h 关于 x 和 y 的根
    % 这些根是 h 关于 x 和 y 的极值点，它们决定了反射变换后第二个点的位置
    % 第三个参数表示 h 关于 u 的一阶导数，它用来求解 h 关于 u 的根
    % 这个根是 h 关于 u 的极值点，它决定了反射变换矩阵 H 的值
    res = solve(diff(h, x) == 0, diff(h, y) == 0, diff(h, u) == 0);
    x = res.x;
    y = res.y;

    % 它们的值分别是第二个点反射变换后的两个可能位置与原点之间的欧几里得距离
    d1 = (x(1) - PointX2) ^ 2 + (y(1) - PointY2) ^ 2;
    d2 = (x(2) - PointX2) ^ 2 + (y(2) - PointY2) ^ 2;

    % 选择更小的那一个作为反射变换后第二个点的位置
    % 反射变换后第二个点的最终位置应该是离原点最近的那一个
    if (d1 <= d2)
        PointX2 = x(1);
        PointY2 = y(1);
    else
        PointX2 = x(2);
        PointY2 = y(2);
    end

    plot(PointX2, PointY2, "rd")
    H = householder([PointX, PointY]', [PointX2, PointY2]');

    button = questdlg("Click new point", "Third Step", "OK", "Cancel", "OK");
    if strcmpi(button, "Cancel")
        return;
    end

    [PointX3, PointY3] = ginput(1);
    plot(PointX3, PointY3, "rd")

    res = (H * [PointX3, PointY3]')';
    plot(res(1), res(2), "rd")
end
```

## Householder QR 分解

Write an M-filet to realize QR-decomposition with Householder algorithm. Let
us call our function to: hhalg

- Input parameter: a square matrix (A)
- Output arguments: an orthogonal matrix (Q) and an upper triangular matrix (R),
  such that satisfy A = Q·R
- The previous functions can be called.

```matlab
% Householder QR 分解
function [Q, R] = hhalg(A)
    [m, n] = size(A);
    if (m ~= n)
        error("A should be a square matix")
    end

    % 预分配，减少动态内存分配，提高性能
    % 反射变换矩阵、正交矩阵和上三角矩阵
    H = eye(m);
    Q = eye(m);
    R = A;

    for col = 1:n
        % x = aₖ
        x = R(col:m, col);

        % 跳过已满足条件不需要反射的部分
        % 非零矩阵元素的数目
        % 这是因为反射变换的作用是将向量 x 的第一个元素变为正数
        if ~nnz(x(2:end))
            continue
        end

        % v = aₖ - βeₖ，其中 eₖ 为单位正交基
        v = x;
        % β=‖x‖取值保持与x(1)一致，β 是向量 x 的模长
        v(1) = v(1) + sign(x(1)) * norm(x);
        v = v / v(1);

        % 反射变换：I - 2*u*conj(u) 可整理得下式
        % 随着逐列推进，Householder 反射变换部分占右下部分越来越小
        % (v * v') / (v' * v) 表示反射变换矩阵 H 的右下角部分
        h = eye(m - col + 1) - 2 * (v * v') / (v' * v);
        H(col:m, col:m) = h;

        % 使用反射变换矩阵 H 更新正交矩阵 Q 和上三角矩阵 R
        R = H * R;
        Q = Q * H';

        % 将预分配的内存重置
        H(col:m, col:m) = eye(m - col + 1);
    end
end
```

# Iterative solutions of LES

## Jacobi 迭代

Write an M-file for Jacobi iteration. The file name be: jacobi

- Input parameters: The matrix of LES A and a vector for the right-side: b
- Output argument: the approximation of the solution vector: x
- We can use the vectorial form of the iteration

```matlab
% 4. Jacobi迭代
function [x, k, index] = jacobi(A, b, ep, itMax)
arguments
    A
    b (:,1)
    ep (1,1) = 1e-5
    itMax (1,1) = 100
end

    % 求线性方程组的雅可比迭代法，其中，
    % A为方程组的系数矩阵；
    % b为方程组的右端项;
    % ep为精度要求，缺省值为1e-5;
    % itMax 为最大迭代次数，缺省值为100;
    % x为方程组的解;
    % k为迭代次数;
    [row, col] = size(A);
    bRow = length(b);

    %当方程组行与列的维数不相等时，停止计算，并输出出错信息。
    if row ~= col
        error('The rows and columns of matrix A must be equal');
    end

    % 当方程组与右端项的维数不匹配时，停止计算，并输出出错信息。
    if col ~= bRow
        error('The columns of A must be equal the length of b');
    end

    % 迭代次数
    k = 0;
    % 上一次迭代的结果
    x = zeros(row, 1);
    % 当前迭代的结果
    y = zeros(row, 1);
    % index为指标变量，index=0表示迭代失败，index=1表示收敛到指定要求
    index = 1;

    % A = U + L + D
    % Ax = b
    % (U + L + D)x = b

    % Dx = -(U + L)x + b
    % Dx = -(A - D)x + b
    % x = -D^-1 * (U + L) * x + D^-1 * b

    % x(k+1) = Bj x(k) + cj
    % Bj = -D^-1 (L + U)
    % cj = D^-1 * b
    while 1
        for r = 1:row
            y(r) = b(r);

            for j = 1:row
                if j ~= r
                    % 用当前的 x 来更新 y
                    y(r) = y(r) - A(r, j) * x(j);
                end
            end

            % A 中第 r 行第 r 列的元素过小，导致无法更新 y，无法进行下一次迭代
            if abs(A(r, r)) < 1e-10 && k == itMax
                index = 0;
                return;
            end

            % 更新迭代解
            y(r) = y(r) / A(r, r);
        end

        k = k + 1;
        if norm(y - x, inf) < ep
            break;
        end

        x = y;
    end
end
```

## Gauss Seidel

Write an M-file for Gauss-Seidel iteration. The file name be: gaussseid

- As in previously at Jacobi iteration.

```matlab
% 4. 用 Gauss Seidel 迭代法解线性方程组 Ax=b
% A为方程组的系数矩阵
% b为方程组的右端项
%epsilon：近似解的误差
%Max：迭代的最大次数
function x = gaussseid(A, b, epsilon, Max)
arguments
    A
    b (:,1)
    epsilon (1,1) = 1e-5
    Max (1,1) = 1000
end

    [row, col] = size(A);
    bRow = length(b);

    %当方程组行与列的维数不相等
    if row ~= col
        error('The rows and columns of matrix A must be equal');
    end

    % 当方程组与右端项的维数不匹配
    if col ~= bRow
        error('The columns of A must be equal the length of b');
    end

    %迭代初始值
    x = zeros(bRow, 1);
    %diag(A)是取出对角元的向量，对该向量再作用diag()函数表示以该对角元向量生成对角矩阵
    D = diag(diag(A));
    %将矩阵分裂为A=D-L-U
    %下三角
    L = -tril(A, -1);
    %上三角
    U = -triu(A, 1);

    %G-S迭代法的迭代公式 Xk+1 = (D-L)^(-1) * U * Xk + (D - L)^(-1) * b
    B = (D-L) \ U;
    g = (D-L) \ b;

    %开始迭代Xk+1 = B * x + g
    %最大迭代次数
    for k=1:Max
        %计算Xk+1用y存放
        y=B*x + g;

        %相邻两次迭代之间相差小于阈值
        if norm(x-y) < epsilon
            break;
        end

        %存放单步结果用于判断收敛
        x = y;
    end
end
```

# Iterative solution of non-linear equations, Interpolation

## 二分法

Write an m-file for bisection method and call the file: bisect

- Input arguments: the function f (we want to find one of the zeros). Give it
  as a string (the variable can be denoted by x or we can give the notation
  as another parameter. We will need the ends of the starting interval (a, b),
  the number of steps (n).
- Output arguments: the appropriate approximation of root: x^∗
  and the error estimation ε.
- Before start we have to check the interval (is there a root inside?)
- To evaluate function we can use function eval

```matlab
% 5. 二分法
% x 根
% tolerance 迭代误差
function [x, tolerance] = bisect(f, a, b, k_max)
arguments
    % 一元标量函数 如 f = @(x) x^2-1
    f (1,1) function_handle
    % 起始区间
    a (1,1)
    % 结束区间
    b (1,1)
    % 最大迭代数
    k_max (1,1) = 200
end

    % 第一次迭代的 root 估计
    % 接下来会持续更新 c 也就是每一次迭代的值
    c = (a + b) / 2;

    % 如果是f(x)的根，直接返回根的估计值
    if f(c) == 0
        x = c;
        return
    end

    % 第一次迭代时，函数在左区间和中点的值
    % 同样，这两个值在接下来会持续更新
    fa = f(a);
    fc = f(c);

    % bisection iteration
    for k = 1:k_max

        % 为 0 就是已经找到根了
        if fc == 0
            break;
        % 两个y相乘为正就说明还在x轴上方
        elseif (fa * fc > 0)
            % 向右收敛
            a = c;
            % 无需重复计算
            fa = fc;
        else
            % 如果小于零就说明有一个y在x轴下方了
            % 这时向左收敛
            b = c;
        end

        % 更新区间中点（估计的根）
        c = (a + b) / 2;

        % 更新 y 轴结果
        fc = f(c);

    end

    % 结果
    x = c;
    % 误差
    tolerance = b - a;

end
```

# Least Squares Method, Generalised inverse

## 最小二乘法

Write an m-file for approximation with least squares method.
The name of file: lsmapprox

- Input arguments: order of polynomial (n), nodes of approximation (in a
  vector), vector of function values in nodes
- Output argument(s): the coefficients of the polynomial
- Let us draw a picture to illustrate the approximation. (We can use the
  included function polyval)

```matlab
% 6. 最小二乘法计算拟合多项式系数
% Polynomial curve fitting
% 返回 p 向量保存多项式系数，由最高次向最低次排列
function p = lsmapprox(x, y, n)
arguments
    % x，y为拟合数据向量
    x
    y
    % 拟合多项式次数
    % 如 1 为 一次函数
    n (1,1)
end

    if ~isequal(size(x), size(y))
        error("x, y require the same dimensionality")
    end

    % 但实际上我们需要的是列向量
    x = x(:);
    y = y(:);

    % 使用一维向量 x 构造具有 n + 1 列 和 m = length(x) 行 的
    % 范德蒙（Vandermonde）矩阵 V = [x^n ... x^2 x ones(size(x))]
    % p(x) = p1·x^n + p2·x^(n-1) + ... pn·x + pn + 1
    V(:, n + 1) = ones(length(x), 1, class(x));
    for j = n:-1:1
        % TIMES (.*) 执行按元素相乘
        V(:, j) = x .* V(:, j + 1);
    end

    % 然后我们把 V 进行 QR 分解，然后再使用 \ 除法进行求解，随后得到多项式系数p
    [Q, R] = qr(V, 0);
    % p = V\y
    p = R \ (Q' * y);

    % 返回行向量
    p = p';

    % 绘图
    y1 = polyval(p, x);
    plot(x, y, 'o', x, y1, '-')

end
```

## 广义逆矩阵

Write an m-file to find the generalised inverse of a given matrix.
The name of file: geninv

- Input argument: the matrix (A).
- Output argument: The generalised inverse (A+)
- Use the rank factorisation if the matrix is not fullranked. For the matrix
  operations we can use the included functions of Matlab (eg.: rank, inv,
  instead of solving LES we can use the command G=F\A, etc.)

```matlab
% 6. 求矩阵的广义逆矩阵
% 当 A 不是 fullranked （列满秩）的时候，逆不唯一
% A ∈ C^(m * n) 若存在 C 满足 AXA = A XAX = X 则 X 是 A 的广义逆矩阵
function APlus = geninv(A)
    r = rank(A);

    % 如果 A 不是 fullranked，则使用 秩分解
    % rank factorization 来计算GINV
    if r == size(A, 1)
        % Moore-Penrose 伪逆
        APlus = pinv(A);
    else
        % A = U * S * V'
        % 奇异值分解得到的矩阵 U、奇异值矩阵 S 和 V 的转置矩阵
        [U,S,V] = svd(A);
        SPlus = zeros(size(A));
        % 将 S 的逆矩阵插入到秩分解中
        SPlus(1:r, 1:r) = inv(S(1:r, 1:r));
        APlus = V * SPlus * U';
    end
end
```

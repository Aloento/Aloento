---
title: Embodied Intelligence
toc: true
categories:
  - [AI, EI]
tags: [具身智能, 考试]
date: 2025-11-24 14:43:20
---

~~期末备考，我不中了~~

<!-- more -->

## Embedded Systems（嵌入式系统）

### Main Building Blocks and Their Relationship with the Environment（主要构建块及其与环境的关系）

#### Sensor（传感器）

> the purpose of a sensor is to detect a certain event, process or change in the environment and produce a corresponding output signal.  
> 传感器的目的是检测环境中的特定事件、过程或变化，并产生相应的输出信号。

- 传感器负责观察环境
- 采集物理量（光、温度、声音、压力等）
- 输出与事件变化对应的信号
- 在人类类比中：眼睛、耳朵、皮肤等感官

#### Actuator（执行器）

> Actuators are elements … whose purpose is to interact with the environment based on the computational unit’s commands.  
> 执行器是……其目的是根据计算单元的命令与环境进行交互的元素。

- 执行器根据控制命令改变环境
- 形式通常是各种电机、线性驱动器等
- 在人类类比中：肌肉

#### Computational Unit（计算单元）

> The main computational unit … where the signal processing, decision making, intervening signal generation and communication is done. ‘Human brain’.  
> 主要计算单元……在这里进行信号处理、决策制定、干预信号生成和通信。“人类大脑”。

- 系统的大脑
- 负责信号处理、决策、通信
- 控制传感器数据处理并下达执行命令

#### Relationship with the Environment（与环境的关系）

> An embedded system is a system that mostly has an intensive information-changing connection with its environment…  
> 嵌入式系统是一个与其环境有密集信息变化连接的系统……

- 嵌入式系统与环境之间有**密集的信息交换关系**
- **Sensors** 从环境接收信息
- **Computational Unit** 分析信息、做决策
- **Actuators** 回馈影响环境
- 这构成一个持续闭环：**感知 → 处理 → 作用 →（改变的）环境再被感知**

这是典型的**mechatronic closed loop**。（机电闭环）

### Control Loops（控制回路）

> “Generalized control loop：Process – Sensor – Actuator”（即过程、传感器、执行器构成循环）

一个控制回路就是一个“自动调节系统”，不断执行下面四步：

1. **Process（被控制的对象）**
2. **Sensor（测量过程）**
3. **Computational Unit / Controller（处理和决策）**
4. **Actuator（执行动作）**

---

Generalized 通用控制回路结构：

在一个控制回路里，传感器负责测量当前状态；信号进入处理前会经过 signal conditioning；计算单元进行处理后输出控制信号给执行器；执行器改变过程；改变后的过程再被传感器测量，这样形成闭环

---

A/D: Analog to digital conversion  
D/A: Digital to analog conversion

- 传感器输出的是**模拟信号**，计算机只能处理数字信号，因此必须 **A/D 转换**
- 执行器大多需要模拟电压/电流，因此控制器输出的数字信号必须 **D/A 转换**

Sensors → A/D → Controller → D/A → Actuator

---

Signal Processing 在控制回路中就是“大脑”，在这里进行过滤、分析、控制算法、决策等智能操作

---

Canonical 标准控制回路包含：

- **Controller**（控制器）
- **Plant**（被控对象）
- **Feedback**（反馈）
- 信号：

  - xb（base signal）
  - xc（control signal）
  - xr（regulated/controlled signal）
  - xf（feedback signal）
  - xd（disturbance）

> “在标准控制回路中，控制器根据参考信号与反馈信号之间的差异生成控制信号。控制信号作用于 plant（被控对象），plant 产生输出 xr。传感器测量输出并产生反馈 xf，再返回控制器形成闭环。若外界出现干扰 xd，控制系统通过反馈自动补偿。”

---

如果输入给控制系统的信号质量差或含有噪声，最终控制结果也会很差。这就是 Garbage in garbage out (GIGO) 原则。

### Signal（信号）

> Signal can be anything. Physical state changes during time.

信号就是“随时间变化的物理量”。

> 例子：电压、温度、声音、光强等。

Signal = Information + Noise

> Information: useful part  
> Noise: unwanted disturbance

信号里有有用信息，也不可避免包含噪声。  
“为什么需要滤波？” → 因为要去掉噪声。

---

信号在通信系统中从哪里来？

> Transmitter → Channel → Receiver（噪声混入在 Channel）

信号从发送端传输到接收端，在通道里受到噪声干扰。

---

信号的类型：

按数学可预测性分类

- **Deterministic（确定性）**：能精确用数学表达
- **Stochastic（随机/非确定性）**：有不确定性

按统计性质分类

- Ergodic：时间平均 = 集合平均
- Not ergodic：不能预测

> 平稳、统计规律可掌握的叫“遍历”；过于随机的叫“非遍历”。

按表示方式

- **Analog（模拟）**：连续变化
- **Digital（数字）**：离散值

> 模拟信号连续且无限取值；数字信号离散，有具体的数值。

按时间特性

- Periodic（周期）
- General periodic
- Quasiperiodic（准周期）
- Transient（瞬态）
- Not periodic（非周期）

> 周期信号会重复；非周期信号不重复；瞬态信号只在短时间出现。

按时间/幅度离散性分类

- Discrete in time （采样信号）
- Discrete in amplitude （量化信号）
- Discrete in time and amplitude（数字信号）

> 数字信号是“时间和幅度都离散”。

#### Types of Signals Based on the Time/Value Quantization（基于时间/数值量化的信号类型）

Discrete in Time

- 只在特定时间点取样
- 每个样本仍然可以是**连续的模拟值**

> 每 1 ms 采集一次传感器值（但值可任意连续）

---

Discrete in Amplitude

- 时间可以连续
- 但信号的数值只能取几个离散等级
  （例如量化后的电压只能取 0.1、0.2、0.3 ……）

> 幅度离散信号：数值被量化成有限等级，但时间是连续的。

---

Discrete in Time and Amplitude

- 既不连续采样
- 数值也只能是离散等级
- 典型例子：所有计算机数字信号（0/1、ADC 输出）

> 数字信号：时间与幅度都离散的信号，是计算机处理的主要形式。

#### Signal Preprocessing Methods（信号预处理方法）

> “Signal conditioning: the manipulation of an analog signal in such a way that it meets the requirements of the next stage for further processing. amplification, filtering, converting, range matching, isolation.”  
> “信号调理：对模拟信号进行处理，使其满足后续处理阶段的要求。包括放大、滤波、转换、量程匹配和隔离等操作。”

Amplification（放大）

- 原始传感器信号通常很弱
- 必须放大才能让 A/D 转换器或控制器能准确读到

---

Filtering（滤波）

- 去除噪声
- 强调有用成分

---

Converting（转换）

可能包括：

- 模拟量 → 模拟量（如电压转电流）
- 传感器输出格式转换
- 信号单位转换

---

Range Matching（量程匹配）

- 不同设备对信号幅度有不同要求  
  例如：  
  A/D 输入范围 0–3.3V  
  但传感器输出可能是 0–10V 或 0–0.1V  
  所以必须调整量程。

---

Isolation（隔离）

- 防止高压、高噪声损坏微控制器
- 通常通过光耦合、隔离放大器实现
- 在工业系统中很常见

#### Filter Types（滤波器类型）

四种基础滤波器：
**Low-pass, High-pass, Band-pass, Band-stop（或 Band-reject）**

---

Low-pass Filter（低通滤波器）

> “Low-pass filter: low frequencies are passed, high frequencies are attenuated.”  
> 低频能通过，高频被削弱（常用于去噪、去抖动）。

---

High-pass Filter（高通滤波器）

> “High-pass filter: high frequencies are passed, low frequencies are attenuated.”  
> 高频能通过，低频被削弱（用于检测快速变化、边缘检测）。

---

Band-pass Filter（带通滤波器）

> “Band-pass filter: only frequencies in a frequency band are passed.”  
> 只允许某一段频率范围通过，其它全部削弱（常用于信号分离）。

---

Band-stop Filter / Band-reject Filter（带阻 / 陷波滤波器）

> “Band-stop filter: only frequencies in a frequency band are attenuated.”  
> 阻止一段特定频率通过（比如去掉 50Hz 电源噪声）。

---

> “Ripples: fluctuations in the pass band or stop band.”

Ripples（波纹）是通带或阻带中的幅度起伏。

> “Transition region: region between passband and stopband.”

Transition Region（过渡带）是从允许通过到需要衰减的中间区域。

---

Famous filter types

- **Butterworth**：no ripple in pass and stop band, slow cutoff  
  无波纹，但截止最慢。
- **Chebyshev I**：no ripple in stop band, moderate cutoff  
  通带有波纹，阻带无波纹，截止中等。
- **Chebyshev II**：no ripple in pass band, moderate cutoff  
  通带无波纹，阻带有波纹，截止中等。
- **Elliptic**：ripple in pass and stop band, fast cutoff  
  通带和阻带都有波纹，但截止最快（最陡峭）。

### Microprocessor as the Computational Unit of the Embedded Systems（微处理器作为嵌入式系统的计算单元）

- 微处理器是系统的**主计算单元**
- 在这里完成 **信号处理（signal processing）**
- **决策（decision making）**
- 生成控制信号（intervening signal generation）
- 以及 **通信（communication）**
- 在系统中，它的角色相当于 **“大脑（Human brain）”**

微处理器是夹在感知与动作中间、负责“理解 → 计算 → 命令”的核心部分。

---

微处理器做的四类任务：

1. Signal Processing （信号处理）
2. Decision Making （决策）
3. Intervening Signal Generation （生成控制信号）
4. Communication （通信）

#### Most Used Peripherals（最常用的外围设备）

> “Most widely used protocols in embedded systems:  
> UART, SPI, I2C, CAN bus, ModBus, FLEXRAY”

- **Timers（定时器）**（用于 PWM、时序控制）
- **PWM 单元**（Pulse Width Modulation）
- **ADC（模数转换器）**
- **DAC（数模转换器）**
- **Communication modules（通信模块）**

---

UART（通用异步收发器）

- 最简单的串行通信方式
- 常用于电脑 → 微控制器通信
- 一次传一位，成本低

---

SPI（串行外设接口）

- 高速
- 主从结构
- 常用于传感器、显示屏、存储芯片

---

I2C（双线通信）

- 两根线（SDA + SCL）
- 同一总线上可挂很多设备
- 速率比 SPI 低但更简洁

---

CAN bus（控制器局域网）

- 汽车行业最重要的通信总线
- 稳定、抗干扰、可多节点

---

ModBus

- 工业领域最经典协议
- PLC、传感器都在用

---

FlexRay

- 新一代车载高速通信
- 用于自动驾驶与安全系统

---

ADC DAC

Timers（定时器）

> 定时器用于计时、产生 PWM、测量信号时序。

PWM Unit（脉宽调制单元）

> PWM 是用来模拟模拟量、控制电机和灯光的常用外设。

#### I/O – Purpose and Usage（输入/输出 - 目的和用法）

> I/O 的目的就是让微处理器和外部世界沟通：读输入、发输出。

---

I/O 用途一：数字输入 / 数字输出（Digital I/O pins）

> 数字 I/O 用于读高低电平信号（例如按钮、时钟、传感器输出），或输出高低电平控制外设。

---

I/O 用途二：模拟输入（Analog Input / ADC）

> 模拟输入 I/O（ADC）用于读取连续变化的物理量。

---

I/O 用途三：模拟输出（Analog Output / DAC 或 PWM）

> 输出 I/O 用于通过 DAC 或 PWM 生成执行器所需的信号。

---

I/O 用途四：通信 I/O

> 通信 I/O 用于和传感器模块、显示屏、存储器、其他控制器交换数据。

#### Timer – Purpose and Usage（定时器 - 目的和用法）

> “Pulse Width Modulation
> Used for imitation of analog signals with alternating ON-OFF cycles
> Parameters: Frequency [Hz], Duty cycle [%]”

---

产生周期性时间（Frequency generation）

PWM 的频率来自内部定时器

这意味着 Timer 的目的之一是：

> **提供精确、稳定的时间基准用于周期性事件。**

---

用于 PWM（控制电机/灯光）

> **“Usage of PWM signal instead of analog signal for motor control.”**

PWM 的本质是：

- Timer 负责按照设定频率开关输出引脚
- 根据占空比调节输出平均电压
- 用来驱动电机、灯光等执行器

所以 Timer 的第二个用途：

> **通过 PWM 控制执行器。**

---

提供系统内部时序与同步（Synchronization）

Timer 的第三个目的：

> **生成同步信号，让系统中的外设保持正确时序。**

---

为软件提供周期性触发（周期性任务）

- 每隔 1 ms 采样
- 每隔 100 ms 执行一次控制算法
- 产生定时中断

#### AD/DA Converters – Purpose and Usage（模数/数模转换器 - 目的和用法）

- 传感器输出一般是 **模拟信号（连续的电压）**
- 微处理器只能处理 **数字信号（离散的数值）**  
  → 必须使用 ADC 把模拟值转换成数字值。

- 微处理器的运算和输出是 **数字值**
- 很多执行器（如马达、音频、电压驱动装置）需要 **模拟电压或电流**  
  → 必须用 DAC 将数字数值转换成模拟信号。

- 没有 DAC 时，系统可以用 PWM“模拟”模拟电压

#### Comparators（比较器）

> “Comparison of the PWM controlling and analog controlling”  
> “Usage of PWM signal instead of analog signal for motor control.”

- 比较两个输入信号（通常是测量值 vs. 阈值）
- 若输入大于参考值 → 输出高电平
- 若输入小于参考值 → 输出低电平

---

阈值检测（Threshold detection）

当传感器信号超过某个阈值时触发事件。

---

作为 PWM 的比较核心

PWM 是由一个定时器的“锯齿波”与一个“参考电压”进行比较形成的。
PPT 中强调：

> **PWM is used instead of analog signal for motor control**

PWM 的生成离不开比较器：

- 当锯齿波 > 参考电压 → 输出低
- 当锯齿波 < 参考电压 → 输出高

---

过流/过压保护（安全控制）

作为模拟前端的一部分（Signal conditioning）

> **Signal conditioning：amplification, filtering, converting…**

比较器也是模拟信号调理中的常见模块，用于快速检测电平状态。

#### Communication Protocols（通信协议）

> “Most widely used protocols in embedded systems:
> UART, SPI, I2C, CAN bus, ModBus, FLEXRAY”

---

通信协议就是**微处理器与外部设备交换数据的方法**。
在嵌入式系统中，不同协议用于连接：

- 传感器
- 执行器
- 存储器
- 多个控制器
- 外部总线（如汽车 CAN）

控制器必须通过 I/O 与外部通信，因此通信协议是 CPU 的重要外设。

---

UART（Universal Asynchronous Receiver/Transmitter）

- 异步串行通信
- 只需要 TX、RX 两根线
- 简单、常用于电脑与微控制器通信

---

SPI（Serial Peripheral Interface）

- 高速
- 主从结构（Master–Slave）
- 常用于传感器、屏幕、存储器

---

I2C（Inter-Integrated Circuit）

- 只有两根线：SCL + SDA
- 可挂很多设备
- 速度比 SPI 慢，但接线最简单

---

CAN bus（Controller Area Network）

- 汽车行业最重要的通信协议
- 抗干扰强
- 多节点通信

---

ModBus

- 工业自动化最经典协议
- 常用于 PLC、工业传感器

---

FlexRay

- 比 CAN 更高速
- 用于自动驾驶、高安全需求系统

#### Real-timeness（实时性）

> “Real-time: The response of the system MUST follow deadlines.”

**实时系统的关键是：系统必须在截止时间（deadline）之前给出响应。**

> “The correctness of a real-time system depends not only on the logical results of the computations, but also on the time at which the results are produced.”

**实时系统不仅要求结果正确，还要求结果在正确的时间产生。**

实时系统不一定快，但必须准时。

- 1 秒内必须响应的系统，0.2 秒和 0.9 秒都算正确
- 但如果 1.1 秒才响应，即使非常快，也是不合格

> 汽车刹车系统必须在规定时间内作出反应，否则会造成危险。

实时系统的响应时间必须是可预测的，并且能被保证。

### Sensors（传感器）

> “In its broader definition, the purpose of a sensor is to detect a certain event, process or change in the environment and produce a corresponding output signal.”

传感器的目的就是检测环境中的事件或变化，并产生对应的输出信号。

Sensor 是 Transducer 的子类别

- Transducer（换能器）是更大的类别：任何能把一种物理量转换成另一种的人
- Sensor 是专门将物理量转换为 **信号（通常是电信号）** 的换能器

- 传感器是机器人/嵌入式系统与环境之间的信息入口
- 没有传感器，系统无法“看到”“听到”外部世界

---

Sensor 的 MUST 条件

> “Unambiguous and reproducible signal  
> Output only influenced by the input  
> Linear relationship (weak requirement)  
> Do not affect the measured system  
> Immunity to external disturbances  
> Output can be normalized.”

- 信号必须明确且可重复（Unambiguous & reproducible）  
  同样的输入应该产生同样的输出。

- 输出只能由输入决定  
  不能受到外界干扰。

- 线性关系（理想但弱要求）  
  输出随输入比例变化更易处理。

- 不应影响被测系统  
  例如温度传感器不能自己加热系统

- 抗干扰能力强

- 输出可归一化

---

Sensor 的分类

机械类传感器（Mechanical）

- 位置、速度、加速度
- 力、扭矩
- 压力

热类传感器（Thermal）

- 温度
- 热流

电类/磁类传感器（Electrical/Magnetic）

- 电压、电流、电荷
- 磁通、磁感应强度

光学传感器（Optical）

- 光强
- 波长

---

传感器需要 Signal Conditioning（信号调理）  
传感器输出通常很弱、不稳定，需要：

- 放大（amplification）
- 滤波（filtering）
- 隔离（isolation）
- 线性化（linearization）

#### Mostly Measured Physical Quantities（主要测量的物理量）

Mechanical Quantities（机械量）

- Position（位置）
- Velocity（速度）
- Acceleration（加速度）
- Angular position / velocity / acceleration（角位置、角速度、角加速度）
- Force（力）
- Torque（扭矩）
- Pressure（压力）

---

Thermal Quantities（热量）

- Temperature（温度）
- Heat flux（热通量）
- Radiation（辐射）

---

Electrical / Magnetic Quantities（电量 / 磁量）

- Charge（电荷）
- Voltage（电压）
- Current（电流）
- Magnetic induction（磁感应强度）
- Magnetic flux（磁通）

---

Optical Quantities（光学量）

- Light intensity（光强）
- Wavelength（波长）

#### Measurement in Mechanics（机械测量）

Position（位置）

- 包括线位移与角位移（angular position）
- 用于测量物体在哪里、转动到什么角度

典型传感器：

- 位移传感器
- 编码器（optical encoder）

Velocity（速度）

- 包括线速度与角速度（angular velocity）

Acceleration（加速度）

- 包括线加速度与角加速度
- 加速度计（在 IMU 中使用）

Force（力）

- 衡量推、拉、压等外力

Torque（扭矩）

- 旋转方向的力（转动力）

Pressure（压力）

- 面积上的垂直力（机械测量也涵盖压力）

#### Indirect Measurement Idea（间接测量思想）

重量是如何通过一系列中间物理量间接得到的

> Weight → Force → Mechanical stress → Deformation → Change in wire length → Change in wire resistance → Change in measured voltage

重量无法直接测量 → 通过电压变化间接得到。重量 → 力 → 应力 → 变形 → 电阻 → 电压

当我们不能直接测量一个物理量时，我们通过测量与它相关的其他物理量，并一步一步推导出最终要测的值，这就叫间接测量。

传感器很少直接测量我们想要的物理量，而是通过一系列中间物理量转换后得到信号。

#### Principle of the Optical Encoders（光学编码器的原理）

光学编码器是一种利用光源与光接收器，通过检测遮光盘的透光/遮光模式，来测量转动位置或速度的传感器。

光学编码器的工作原理：

1. 安装一个带孔的转盘（disk with holes）  
   这个转盘与被测设备（例如电机轴）连接。

2. 光源照射，接收器测量光线通过/被遮挡

   当转盘旋转时：

   - 孔对准光源 → 光通过
   - 没孔对准 → 光被挡住

   这就形成了一个 **光的“开/关”信号**（digital pulses）。

3. 通过“脉冲数量”测量运动  
   转盘每旋转一小段，就会产生一个光脉冲。  
   **脉冲数量 = 移动量（位置或角度）**。

---

如何测量方向？

- 使用 **两个错位的接收器（A 和 B 通道）**
- 当盘转动时，A、B 接收的光脉冲会有**相位差（phase shift）**

如果：

- A 先亮后 B → 向前
- B 先亮后 A → 向后

这就是 **Quadrature Encoding（正交编码）**。

---

光学编码器能测

- Position（位置）
  通过累计脉冲数。

- Velocity（速度）
  通过单位时间内脉冲数变化。

- Direction（方向）
  通过 A/B 两通道的相位差。

---

光学编码器精准

- 光的开关非常快
- 脉冲计数精确
- 转盘孔的数量决定分辨率（resolution）

### Actuators（执行器）

执行器的作用是根据计算单元的命令与环境交互。

执行器的“输出形式”

> – mechanical, electrical, thermal, optical.”

1. **机械作用**（力、运动）
2. **电作用**（电流、电压调节）
3. **热作用**（加热元件）
4. **光作用**（LED、激光器）

---

执行器的主要能量来源

> “Main energy sources: electrical, hydraulic, pneumatic.”

执行器的能源主要有三种：电能、液压、气压。

---

Power Machines vs. Actuators

- Power machine：提供能量（例如电源、电池、电网）
- Actuator：把能量转成有用的动作或力

> 电机不是能量源本身，它是执行器，把能量转换成运动。

---

功能总结

(1) 将能源 → 转换成 → 力 或 运动  
(2) 执行控制单元的命令（Core idea）

#### Main Energy Sources by Type Used（按类型使用的主要能源）

(1) Electrical（电能）

- 最常见的执行器能源
- 易于控制（电压、电流、PWM）
- 适合精确控制与高速响应

**典型执行器：**

- DC motor
- BLDC motor
- Stepper motor
- Servo motor

> 电能执行器控制简单、精度高，是嵌入式系统中最常用的类型。

---

(2) Hydraulic（液压）

- 使用不可压缩液体（通常是油）
- 能产生**非常大的力**
- 结构复杂、维护成本高

**典型应用：**

- 工业机械
- 重载机器人
- 工程设备（挖掘机、机械臂）

> 液压执行器用于需要大力输出的场景。

---

(3) Pneumatic（气压）

- 使用压缩空气
- 结构相对简单
- 速度快，但精度较低（因为气体可压缩）

**典型应用：**

- 工业自动化
- 快速开关、夹取动作

> 气压执行器响应快，但控制精度有限。

#### Power Machines vs Actuators（电源机器与执行器）

| 对比点               | Power Machine | Actuator      |
| -------------------- | ------------- | ------------- |
| 功能                 | 提供能量      | 转换能量      |
| 是否产生受控运动     | ❌            | ✅            |
| 是否直接执行控制命令 | ❌            | ✅            |
| 系统角色             | 能源来源      | 输出/动作单元 |

#### Positioning（定位）

Positioning 指的是：

执行器在控制命令作用下，把系统移动到一个期望的位置，并保持在那里。

---

(1) Open-loop Positioning（开环定位）

- **无反馈**
- 典型：**Stepper motor（步进电机）**
- 位置由“步数”决定

> 开环定位不使用传感器，位置由输入命令决定。

---

(2) Closed-loop Positioning（闭环定位）

- **有位置反馈**
- 典型：**Servo motor（伺服电机）**
- 使用编码器测量位置

> 闭环定位通过传感器反馈实现高精度位置控制。

---

(3) Indirect Positioning（间接定位）

- 不直接测位置
- 通过速度积分或脉冲计数得到位置
- 与前面学过的 **Indirect Measurement Idea** 呼应

#### DC Motor（直流电动机）

> **DC motor converts electrical energy into continuous rotational motion.**

- 输入：**电压 / 电流（Electrical energy）**
- 过程：**电磁作用产生转矩（torque）**
- 输出：**连续旋转运动（rotation）**

> 电压决定转速，电流决定转矩。（系统级理解即可）

(1) 连续旋转（Continuous rotation）

- 与步进电机不同
- 不自带“步”的概念

(2) 速度控制容易

- 通过 **PWM** 改变平均电压

---

DC motor 本身不适合直接定位（positioning）。

原因：

- 只能连续转
- 不知道当前位置

所以：

- **如果要定位 → 必须加传感器（如 optical encoder）**
- 通过闭环控制实现定位

---

优点

- 结构简单
- 成本低
- 控制容易

缺点

- 不能天然定位
- 精度依赖外部传感器
- 需要闭环才能精确控制位置

#### BLDC Motor（无刷直流电动机）

> **无刷直流电机 = 没有电刷（brushes），用电子方式换向的直流电机。**

- **没有机械电刷 → 没有火花与磨损**
- **效率更高**
- **寿命更长**
- **维护需求更低**

---

**控制结构**：

- 转子：**永磁体**
- 定子：**多相线圈**
- **电子换向（electronic commutation）**
  → 控制器按顺序给线圈通电
  → 产生旋转磁场
  → 转子跟随旋转

> BLDC motor uses electronic commutation instead of mechanical brushes.

---

BLDC Motor 电子换向 **必须知道转子位置**

- **Hall sensors**
- 或基于反电动势（sensorless）

控制方式

- **PWM → 控制转速/转矩**
- 控制器根据位置信息切换相位
- 本质是一个**闭环控制系统**

---

| 对比点     | DC Motor | BLDC Motor |
| ---------- | -------- | ---------- |
| 电刷       | 有       | 无         |
| 换向       | 机械     | 电子       |
| 效率       | 较低     | 较高       |
| 寿命       | 较短     | 较长       |
| 控制复杂度 | 低       | 高         |

---

- BLDC **可以用于定位**
- 但 **必须有位置反馈**
- 通常用于：

  - 机器人关节
  - 无人机
  - 高性能驱动系统

#### Stepper Motor（步进电动机）

> **步进电机不是连续转，而是“一步一步”转。**

- 电机的转动被**分割成固定角度的步（steps）**
- 每输入一个控制脉冲 → 转动一个固定角度
- 常见步距角（不要求数值）：如每步几度

> 每个脉冲对应一个固定角度的转动。

---

开环定位

- **不需要位置传感器**
- 位置由**步数累计**得到

因此：

> **Stepper motors are suitable for open-loop positioning.**  
> 步进电机可以在没有反馈的情况下实现定位。

---

控制方式

- 控制信号：**脉冲序列**
- **脉冲频率 → 转速**
- **脉冲数量 → 转角 / 位置**

---

优点

- 结构相对简单
- 定位直观、容易实现
- 不需要编码器即可定位
- 成本较低（系统层面）

缺点

- **可能丢步（missed steps）**
  - 负载过大或加速过快时
- 效率不高
- 高速性能差
- 振动与噪声相对较大

#### Linear Motor（线性电动机）

> **线性电机不是“转了再变直线”，而是直接产生直线运动。**

核心思想是：

- 旋转电机：
  电能 → **旋转运动** →（丝杆/齿轮）→ 直线运动
- **线性电机：**
  电能 → **直接直线运动**

> 线性电机省去了机械转换机构。

---

为什么要用 Linear Motor？

因为**去掉了机械传动部件**，线性电机具有以下特性：

- **高精度定位**
- **高动态响应**
- **无反向间隙（no backlash）**
- 机械结构简单（系统层面）

典型应用包括：

- 精密定位平台
- 自动化设备
- 高端工业机器人
- 半导体/光学系统

---

缺点

- **成本高**
- **控制复杂**
- 通常需要**精确反馈传感器**
- 散热与能耗要求高

线性电机通常用于闭环高精度定位。

- **Linear motors are mainly used for positioning tasks**
- 几乎总是 **闭环控制**
- 常配合：

  - 光学编码器
  - 线性编码器

---

| 项目       | Linear Motor | Rotational Motor + Transmission |
| ---------- | ------------ | ------------------------------- |
| 运动形式   | 直接直线     | 旋转 → 直线                     |
| 机械复杂度 | 低           | 高                              |
| 间隙/磨损  | 很小         | 存在                            |
| 成本       | 高           | 较低                            |

#### Special Actuators: Piezo Motor, Memory Alloy, MEMS（特殊执行器：压电电动机、记忆合金、MEMS）

这一类被单独拎出来，是因为它们：

- **不属于传统电机（DC / BLDC / Stepper）**
- **工作原理与宏观电机完全不同**
- 通常用于 **小尺寸 / 高精度 / 特殊场景**

---

Piezo Motor（压电执行器 / 压电电机）

- 基于 **压电效应（piezoelectric effect）**
- **施加电压 → 材料发生极小形变**
- 通过形变叠加 → 产生运动或力

- **非常小的位移**
- **非常高的精度**
- **响应极快**

> 压电执行器通过电压引起材料形变，实现极高精度的微小运动。

- 精密定位
- 光学系统
- 微调机构

---

Memory Alloy（记忆合金执行器，Shape Memory Alloy, SMA）

- 材料对 **温度变化** 有响应
- **加热 → 形状发生改变**
- 冷却后可恢复原状（或另一形状）

- **热 → 机械运动**
- 响应速度 **较慢**
- 控制 **不精确但结构简单**

> 记忆合金执行器利用温度变化引起材料形变，从而产生运动。

典型特点

- 结构非常简单
- 功率密度高
- 控制精度和速度有限

---

MEMS Actuators（微机电系统执行器）

MEMS = **Micro-Electro-Mechanical Systems**

- 尺寸在 **微米级**
- 通过微加工技术制造
- 常与 MEMS 传感器一起出现

- **极小尺寸**
- **集成度高**
- **输出力和位移都很小**

> MEMS 执行器是在微米尺度上工作的执行器，常用于微系统中。

典型应用

- 微镜
- 微阀
- 微机器人
- 传感器内部驱动结构

---

| 执行器类型   | 驱动原理    | 特点关键词       |
| ------------ | ----------- | ---------------- |
| Piezo        | 电压 → 形变 | 超高精度、微位移 |
| Memory Alloy | 温度 → 形变 | 结构简单、慢     |
| MEMS         | 微结构      | 超小尺寸、集成化 |

#### Principle of the Servo Motor（伺服电动机的原理）

伺服电机是一种通过**闭环控制**来实现**精确力矩、力、位置或速度输出**的执行器。

- precise（精确）
- torque / force / position / velocity
- closed-loop control（闭环控制）

普通 DC 电机

- 给电压 → 转
- **不知道转到哪**
- **没有反馈**

Servo Motor

- **有目标**
- **有反馈**
- **自动纠正误差**

---

6 个必备组成部分

1. **Motor**（电机）
2. **Gears**（齿轮箱）
3. **Position sensor**（通常是 potentiometer）（位置传感器，通常是电位器）
4. **Control electronics** （控制电子单元）
5. **Comparator electronics** （比较电子单元）
6. **Motor driver（H-bridge）** （电机驱动器，H 桥）

---

Motor（电机）

- 通常 **转速高**
- **力矩小**
- 不适合直接用来驱动负载

---

Gears（齿轮箱）

- Reduce RPM（降低转速）
- Increase torque **in the same ratio**（同等比例增加力矩）

例子：

- 1:200 减速比
  → 转速 ↓ 200 倍
  → 力矩 ↑ 200 倍

---

Position sensor（位置传感器）

- **Potentiometer**（电位器）
- Used as **voltage divider**（用作分压器）

作用只有一个：

> **Measure the actual position of the output shaft**
> 测量输出轴的实际位置

---

Control electronics

- 接收控制信号（目标位置）
- 处理反馈信号（实际位置）

---

Comparator electronics（比较器）

- 比较：

  - **Desired position**（目标位置）
  - **Measured position**（实际位置）

- 产生 **error（误差）**

---

Motor driver（H-bridge）

- 根据误差：

  - 决定转向
  - 决定转速

- 驱动电机正转 / 反转 / 停止

---

隐含流程可以用 **6 步**说清楚：

1. 给定 **目标位置**
2. 位置传感器测量 **实际位置**
3. 比较器计算 **误差**
4. 控制器决定 **驱动方向和大小**
5. 电机转动
6. **不断重复，直到误差接近 0**

## Ethorobotics（伦理机器人学）

引入 Ethorobotics 的核心背景是：

- 机器人 **不再只是工业机器**
- 机器人开始 **进入人类社会**
- 与人 **互动、交流、共存**

一旦机器人进入社会，就不只是“技术问题”，而是：

- 行为是否合适
- 是否安全
- 是否被人接受

---

Ethorobotics = **Ethology（动物行为学） + Robotics（机器人学）**

- 借鉴 **动物和人的行为模式**
- 研究 **机器人如何表现得“合适”**

Ethorobotics **不关心底层控制算法**，而关心：

- 行为（behavior）
- 互动（interaction）
- 感知方式（how humans perceive robots）
- 情感与社会影响

核心不是“机器人能不能动”，而是“动得对不对”

---

| 传统机器人 | Ethorobotics |
| ---------- | ------------ |
| 工业任务   | 社会互动     |
| 精度、速度 | 行为、接受度 |
| 功能正确   | 行为合适     |
| 不与人交流 | 与人交流     |

### Social Robots（社交机器人）

- 社交机器人**不是只干活**
- 它们的核心目标是：**与人互动**

- 能 **感知人**
- 能 **回应人**
- 行为 **符合社会规范**

包括但不限于：

- 语言交流
- 手势
- 表情
- 距离（不要靠太近）
- 轮流说话

---

社交机器人“必须具备”的三类能力

(1) Perception（感知）

- 识别人
- 感知声音、表情、动作

(2) Interaction（互动）

- 说话、回应
- 使用多种沟通方式（后面会讲 Communication Modalities）

(3) Behavior（行为）

- 动作要“像样”
- 不吓人
- 不冒犯

### Industrial Robots（工业机器人）

| 工业机器人 | 社交机器人 |
| ---------- | ---------- |
| 面向机器   | 面向人     |
| 目标：效率 | 目标：互动 |
| 不关心感受 | 必须被接受 |
| 隔离运行   | 与人共处   |

- 工业机器人是为**工业生产**而设计
- 目标是：**完成任务**

工业机器人**关心：**

- 精度（accuracy）
- 重复性（repeatability）
- 速度（speed）
- 可靠性（reliability）
- 效率（efficiency）

工业机器人**不关心：**

- 情感
- 社交
- 被“喜欢”
- 行为是否像人

---

工业机器人通常：

- 与人 **物理隔离**
- 在 **受控环境** 中运行
- 通过：

  - 安全围栏
  - 安全光幕
  - 紧急停止系统

---

典型应用

- 焊接（welding）
- 喷涂（painting）
- 装配（assembly）
- 搬运（pick and place）
- 加工（machining）

### Uncanny Valley（恐怖谷）

> **The uncanny valley describes a phenomenon where a robot that looks almost human, but not perfectly human, causes discomfort or eeriness in people.**

恐怖谷指的是：机器人越像人，但又不像到位时，人类反而会感到不适或恐惧。

一条**心理曲线**来解释：

- 横轴：**Human likeness（像人的程度）**
- 纵轴：**Affinity / Familiarity（亲近感）**

变化过程是：

1. 完全不像人 → 没问题
2. 有点像人 → 更亲近
3. **非常像但不完美 → 亲近感急剧下降（恐怖谷）**
4. 几乎完全像人 → 亲近感再次上升

中间那一段“掉下去”的区域，就是 **Uncanny Valley**。

---

- 外观很像人
- 但：

  - 动作不自然
  - 表情僵硬
  - 眼神不对
  - 反应不像人

大脑无法正确分类：是“人”还是“机器”？

Uncanny Valley 与 Social Robots 的关系

- 机器人如果**太像人但行为不自然**
  → 会 **降低信任**
  → 会 **引起排斥**

因此：

> **Designers must avoid the uncanny valley when creating social robots.**

### Main Fields of Application of Social Robotics（社交机器人的主要应用领域）

(1) **Healthcare / Caregiving（医疗与照护）**

**核心用途：**

- 陪伴老人
- 提醒吃药
- 简单交流、情感支持

**为什么适合社交机器人：**

- 需要互动
- 需要被接受
- 需要情感表达

> Social robots are used in healthcare for assistance, companionship and monitoring.

---

(2) **Education（教育）**

**核心用途：**

- 辅助教学
- 语言学习
- 儿童陪学

**为什么适合：**

- 互动可以提高学习动机
- 机器人可以反复、耐心教学

> Social robots are used in education to support learning through interaction.

---

(3) **Entertainment（娱乐）**

**核心用途：**

- 娱乐机器人
- 玩具
- 表演、互动展示

**为什么适合：**

- 娱乐本身就是社交行为
- 情感和互动是核心

> Social robots are used for entertainment and interactive experiences.

---

(4) **Customer Service / Public Spaces（服务与公共场所）**

**核心用途：**

- 接待
- 引导
- 信息提供（机场、商场、博物馆）

**为什么适合：**

- 需要与陌生人交流
- 需要友好、自然的行为

> Social robots can be used as service robots in public spaces to interact with people.

---

(5) **Therapy and Special Needs（治疗与特殊人群）**

**核心用途：**

- 自闭症儿童辅助
- 情绪训练
- 社会行为训练

**为什么适合：**

- 机器人行为可控
- 不带社会压力

> Social robots are used in therapy, especially for children with special needs.

### Communication Modalities in Interactions（交互中的通信模式）

> **A communication modality is a channel through which interaction between humans and robots takes place.**

通信模式就是人和机器人交流所使用的方式或通道。

- 人类交流是 **多模态（multimodal）**
- 只靠一种方式（例如只说话）是不自然的
- **社交机器人必须组合多种通信模式**

---

(1) **Verbal Communication（语言 / 语音）**

**内容：**

- 说话
- 听懂人说话

**作用：**

- 信息交换
- 指令
- 对话

> Verbal communication enables spoken interaction between humans and robots.

---

(2) **Non-verbal Communication（非语言）**

包括：

- 手势（gestures）
- 姿态（posture）
- 身体朝向（orientation）
- 距离（proxemics）

**作用：**

- 表达意图
- 增强自然感
- 辅助语言

> Non-verbal communication conveys intentions without spoken language.

---

(3) **Facial Expressions（面部表情）**

**内容：**

- 眼睛
- 眉毛
- 嘴部动作
- 表情变化

**作用：**

- 情绪表达
- 增加信任感
- 提高可接受度

> Facial expressions are important for emotional communication in social robots.

---

(4) **Gaze and Eye Contact（注视与眼神）**

**作用：**

- 表示注意力
- 表示轮到谁说话
- 增强“被关注”的感觉

> Eye gaze helps regulate interaction and attention.

---

(5) **Touch / Haptics（触觉）**

**内容：**

- 触摸
- 拥抱
- 物理反馈

**注意：**

- 强烈的伦理与安全问题
- 必须非常谨慎

> Touch can enhance interaction but raises ethical and safety concerns.

---

单模态 vs 多模态

| 单一通信模式 | 多模态通信   |
| ------------ | ------------ |
| 不自然       | 更自然       |
| 信息有限     | 信息丰富     |
| 易误解       | 更清晰       |
| 不像人       | 更像人类交流 |

> Multimodal communication leads to more natural human–robot interaction.

---

Communication Modalities 与 Uncanny Valley 的关系

- 外观像人
- 但通信模式单一或不自然
  → **更容易掉进恐怖谷**

> A mismatch between appearance and communication modalities can cause the uncanny valley effect.

### Attachment and the Ainsworth Strange Situation Test（依恋与艾因斯沃斯陌生情境测试）

> **Attachment is an emotional bond between an individual and a caregiver or social partner.**

依恋是个体与照料者或社会对象之间形成的情感联系。

- 社交机器人会：

  - 陪伴人
  - 长期互动
  - 表现出“社会行为”

- 人类**可能会对机器人产生情感反应**

因此必须研究：

> **Humans can form attachment-like relationships with robots.**

---

Ainsworth Strange Situation Test 是什么？

这是一个**心理学经典实验**，由 **Mary Ainsworth** 提出，用来研究**儿童依恋类型**。

> **The Strange Situation Test is a structured experiment designed to observe attachment behavior under stress.**

Strange Situation Test 的基本流程

- 把个体（通常是儿童）
- 放入 **陌生环境**
- 让 **照料者离开并返回**
- 观察个体的反应

**重点不是“发生了什么”，而是“如何反应”**。

---

测试中观察什么？

测试关注的是 **分离（separation）和重聚（reunion）时的行为**。

例如：

- 是否焦虑
- 是否探索环境
- 是否在重聚时寻求接触
- 是否容易被安抚

依恋类型

> **The test classifies different attachment styles based on behavior.**

依恋类型根据个体在测试中的行为反应进行分类。

---

Strange Situation Test 与 Social Robotics 的关系

在 Ethorobotics 中：

- 研究人员**借用该测试的思想**
- 来观察：

  - 人是否对机器人表现出依恋行为
  - 分离时是否不安
  - 重聚时是否寻求互动

> The Strange Situation Test is adapted to study attachment between humans and social robots.

---

为什么这涉及伦理（Ethics）？

因为一旦人对机器人产生依恋：

- 会影响情绪
- 会影响决策
- 会产生心理依赖

因此：

> **Attachment to robots raises ethical concerns.**

## Cognitive Robotics（认知机器人学）

- 传统机器人：
  → **按规则执行**
- 真实世界：
  → **不确定、变化、多样**

因此，认知机器人学研究机器人如何“理解世界并作出决策”。

> **Cognitive robotics is a field of robotics that studies robots capable of perception, reasoning, learning and decision-making.**

认知机器人学研究具有感知、推理、学习和决策能力的机器人。

- perception
- reasoning
- learning
- decision-making

| 传统机器人 | 认知机器人 |
| ---------- | ---------- |
| 固定规则   | 可适应     |
| 预定义行为 | 决策行为   |
| 环境简单   | 环境复杂   |
| 不学习     | 能学习     |

---

认知机器人要实现类似生物的能力：

- **Perception（感知）**
- **Memory（记忆）**
- **Attention（注意）**
- **Decision making（决策）**
- **Adaptivity（适应性）**

Cognitive Robotics ≠ Artificial Intelligence

- Cognitive robotics **使用 AI 方法**
- 但重点是：

  - **具身（embodied）**
  - **与物理世界交互**

---

为什么“认知”对机器人很重要？

因为现实环境中：

- 信息不完整
- 噪声存在
- 人类行为不可预测

因此机器人必须：

- 解释感知结果
- 在不确定性下决策
- 根据经验调整行为

### Cognitive Architectures（认知架构）

- 机器人需要 **感知、记忆、决策、行动**
- 如果没有统一结构 → 系统会变成**零散模块的拼凑**

因此需要：

> **A structured organization of cognitive functions.**

认知架构是用来组织机器人“如何思考”的整体结构。

> **A cognitive architecture is a framework that defines how perception, memory, reasoning, decision-making and action are organized and interact in a cognitive robot.**

认知架构规定了机器人中感知、记忆、推理、决策和行动如何协同工作。

- perception
- memory
- reasoning
- decision-making
- action

- 信息从哪里来？（感知）
- 信息存到哪里？（记忆）
- 如何使用信息？（推理）
- 什么时候行动？（决策）
- 如何执行？（行动）

Cognitive Architecture ≠ 单一算法

- ❌ 不是一个算法
- ❌ 不是一个神经网络
- ❌ 不是一个模块

而是：

> **An overall system-level organization.**

---

认知架构的典型组成

1. **Perception module** （感知模块）
2. **Memory**（短期 / 长期）
3. **Reasoning / cognition** （推理 / 认知）
4. **Decision-making** （决策）
5. **Action / motor control** （行动 / 运动控制）

为什么认知架构对 Cognitive Robotics 很重要？

因为：

- 认知机器人要 **长期运行**
- 要 **在复杂环境中适应**
- 要 **保持行为一致性**

- 认知不是抽象的
- 必须与身体和环境交互

因此：

> **Cognitive architectures must be embodied and connected to sensors and actuators.**

### Adaptivity（适应性）

- 真实世界 **不确定**
- 环境 **会变化**
- 人类行为 **不可预测**

如果机器人**不能改变自己的行为**，就只能在理想环境中工作。

适应性是机器人在变化环境中生存和工作的关键能力。

> **Adaptivity is the ability of a robot to change its behavior based on experience, feedback or environmental changes.**

适应性是机器人根据环境变化或经验调整自身行为的能力。

- change behavior
- experience / feedback
- environment

---

| 非适应型机器人  | 适应型机器人        |
| --------------- | ------------------- |
| 行为固定        | 行为可变            |
| 预定义规则      | 根据情况调整        |
| 环境变化 → 失败 | 环境变化 → 继续工作 |

在认知机器人中，适应性通常体现在：

- **Perception**：改变对环境的解释
- **Decision-making**：选择不同策略
- **Behavior**：调整动作方式

---

Adaptivity ≠ Learning

- **Learning（学习）**：
  → 获得新知识或模型
- **Adaptivity（适应性）**：
  → 使用已有或新知识调整行为

认知机器人要：

- 长时间运行
- 与人互动
- 面对未知情况

没有适应性就会：

- 行为僵化
- 无法应对新情况

> **Adaptivity does not necessarily require learning, but learning can enable adaptivity.**

在社交机器人中：

- 人类期望机器人：

  - 学会合适的行为
  - 不断调整互动方式

因此：

> **Adaptivity is also important for social interaction.**

### Braitenberg Vehicles（布雷滕伯格车辆）

> **Braitenberg Vehicles are simple artificial agents that demonstrate complex behaviors through simple sensor–motor connections.**

布雷滕伯格车辆是通过**非常简单的感知—运动连接**就能表现出复杂行为的简单机器人。

- simple
- sensor–motor connections
- complex behavior

> **Complex behavior does not require complex cognition.**

也就是说：

- 不一定需要记忆
- 不一定需要规划
- 不一定需要推理

简单结构 + 正确连接 = 看起来“聪明”的行为

---

每一个 Braitenberg Vehicle 只有三样东西：

1. **Sensors（传感器）**

   - 通常是光传感器

2. **Motors（电机）**

   - 左轮 / 右轮

3. **Connections（连接）**

   - 传感器 → 电机（直接连）

**行为不是“算出来的”，而是“连出来的”**。

- 传感器感到刺激
- 马上影响电机速度
- 运动发生
- 行为出现

**没有中央控制器**。

---

连接方式决定行为

(1) 同侧连接 vs 交叉连接

- 左传感器 → 左电机（同侧）
- 左传感器 → 右电机（交叉）

(2) 兴奋型 vs 抑制型连接

- 强刺激 → 电机更快
- 强刺激 → 电机更慢

不同组合会产生**完全不同的行为**。

---

看起来像“情绪”的行为（Ethorobotics 连接点）

- 喜欢光（love）
- 害怕光（fear）
- 攻击（aggression）
- 探索（exploration）

**但这只是观察者的解释，不是真正的情感。**

> Braitenberg vehicles appear emotional, but have no cognition or emotions.

---

Braitenberg Vehicles 在 Cognitive Robotics 中的意义

> **They show that perception–action coupling can produce adaptive-looking behavior without internal representations.**

仅靠感知—动作耦合，就能产生看似智能和适应性的行为。

---

和 Adaptivity 的关系

- Braitenberg Vehicles：

  - 没有学习
  - 没有记忆

- 但行为会随环境变化而变化

> **They show a basic form of adaptivity without learning.**

### Cognitive Model of iPhonoid（iPhonoid 的认知模型）

> **iPhonoid is a social robot used as a platform to study cognitive and social interaction.**

iPhonoid 是一个用于研究认知与社交行为的机器人平台。

- 认知不是抽象软件
- 必须 **具身（embodied）**
- 必须 **连接传感器与执行器**
- 必须 **实时与人互动**

iPhonoid 的认知模型不是“高智能规划”，而是：

> **Perception → Internal state → Action**

也就是一个**闭环的认知—行为系统**。

---

iPhonoid 认知模型的主要组成

(1) **Perception（感知）**

- 听觉（声音）
- 视觉（人、环境）
- 传感器输入

用来获取外界信息。

---

(2) **Internal States（内部状态）**

- 情绪状态
- 动机状态
- 压力 / 激活水平（后面会专门讲）

决定机器人“当前处于什么状态”。

---

(3) **Decision / Mapping（决策映射）**

- 根据感知 + 内部状态
- 选择行为

不是复杂规划，而是**状态驱动行为选择**。

---

(4) **Action（行为）**

- 发声
- 动作
- 表情或姿态变化

行为会反过来影响人 → 再被感知（闭环）。

---

Phonoid 的行为会根据内部状态发生变化，而不只是简单反射。

| Braitenberg Vehicle | iPhonoid           |
| ------------------- | ------------------ |
| 无内部状态          | 有内部状态         |
| 直接感知 → 行动     | 感知 → 状态 → 行动 |
| 极简                | 更接近认知模型     |

因为有内部状态：

- 同样的刺激
- 在不同状态下
- 会产生不同反应

因此：

> **iPhonoid exhibits adaptive behavior based on its cognitive state.**

### Stress-inspired Working Memory（压力启发的工作记忆）

- 人类和动物的行为 **会受到压力影响**
- 压力会：

  - 改变注意力
  - 改变记忆容量
  - 改变决策方式

因此问题是：

> **Can we model similar effects in robots?**

压力会影响认知，所以认知机器人需要一个“受压力调节的记忆模型”。

---

什么是 Working Memory

工作记忆是用于临时存储和处理信息的短期记忆。

- 记忆不是固定大小
- **压力水平会改变：**

  - 能记住多少
  - 记住什么
  - 忘记什么

---

这里的压力 **不是心理学细节**，而是一个**内部状态变量**。

- Stress ≠ 情绪
- Stress = **系统的激活/负载水平**

例如：

- 刺激太多
- 互动太频繁
- 环境太复杂

**类人生物行为**：

低压力

- 工作记忆容量较大
- 可以处理更多信息
- 行为更平稳

高压力

- 工作记忆容量下降
- 只保留最重要的信息
- 行为更简单、更反射化

---

在 iPhonoid 认知模型中：

- 感知 → 增加或减少压力
- 压力 → 调节工作记忆
- 工作记忆 → 影响行为选择

这是一个闭环过程

为什么这个模型重要？

因为它说明：

- 机器人行为 **不是固定映射**
- 内部状态会改变认知资源
- 行为因此更像生物

> Stress-inspired working memory enables more realistic and adaptive robot behavior.

---

- **Adaptivity**：
  行为随内部状态变化
- **Cognitive architecture**：
  工作记忆是架构的一部分
- **Ethorobotics**：
  行为看起来更“自然”

### Robot Pianist（机器人钢琴家）

机器人钢琴家是一个能够感知音乐并在钢琴上演奏的认知机器人。

> **Playing music is not only a motor task, but a cognitive task.**

原因是演奏需要同时处理：

- 时间（节奏）
- 顺序（音符先后）
- 力度（强弱）
- 错误修正
- 感知反馈

这是一个完整的认知—行动闭环示例。

---

(1) Perception（感知）

- 读取乐谱 / 输入信息
- 听到自己弹出的声音（听觉反馈）

(2) Memory（记忆）

- 记住音符序列
- 记住节奏模式
- 使用工作记忆处理当前音符

(3) Timing（时间控制）

- 演奏**必须严格按时间**
- 与 **real-time** 强相关

> Musical performance requires precise timing.

(4) Decision-making（决策）

- 何时弹哪个键
- 力度如何
- 是否需要纠错

(5) Action（行动）

- 精确控制手指或击键机构
- 力与位置控制

---

- 机器人钢琴家不是“死弹”
- 可以根据：

  - 节奏变化
  - 错误
  - 外界干扰
    来调整演奏

与 Stress-inspired Working Memory 的联系

- 演奏复杂段落 → 压力高
- 工作记忆负载增加
- 行为可能变简单或更保守

> **The robot pianist demonstrates how perception, memory, timing, decision-making and motor control are integrated in a cognitive robotic system.**  
> 机器人钢琴家展示了感知、记忆、时间控制、决策和运动控制如何在认知机器人系统中集成。

## Evolutionary Robotics（进化机器人学）

- 机器人设计 **非常复杂**
- 手工设计控制器 / 结构 **成本高、效果有限**
- 很多行为 **难以直接建模**

> **Why not let robots evolve their behavior automatically?**

进化机器人学通过“进化”而不是“人工设计”来获得机器人行为。

> **Evolutionary robotics is a field of robotics where evolutionary algorithms are used to automatically design robot controllers, behaviors or even morphologies.**

进化机器人学使用进化算法自动生成机器人的控制和行为。

- evolutionary algorithms
- automatic design
- behavior / controller

这里的进化是**达尔文式进化思想**，不是生物学本身。

核心要素只有三点：

1. **Population（种群）**
2. **Variation（变异）**
3. **Selection（选择）**

> Better-performing robots are selected and modified over generations.

| 传统机器人设计 | 进化机器人学 |
| -------------- | ------------ |
| 人工设计规则   | 自动进化     |
| 人定义行为     | 行为涌现     |
| 可解释         | 常不可解释   |
| 受限于设计者   | 可发现新策略 |

---

可以进化的对象包括：

- **Robot controllers（控制器）**
- **Parameters（参数）**
- **Behaviors（行为）**
- 有时甚至是：

  - **Robot morphology（结构）**

---

核心优势

- 不需要精确模型
- 适合复杂、未知环境
- 能产生意想不到但有效的策略

局限

- 计算成本高
- 进化结果不一定可解释
- 现实机器人上直接进化有风险

### Robot Path Planning（机器人路径规划）

> **Robot path planning is the problem of finding a feasible path from a start position to a goal position while avoiding obstacles.**

机器人路径规划是让机器人从起点到终点，同时避开障碍物的问题。

路径规划一定包含这四点：

1. **Start position（起点）**
2. **Goal position（终点）**
3. **Environment（环境）**
4. **Obstacles（障碍物）**

为什么路径规划是“难问题”？

- 环境复杂
- 障碍物多
- 状态空间大
- 手工设计路径或规则困难

---

Path Planning vs Evolutionary Path Planning

传统方法

- 基于规则
- 基于模型
- 人工设计

进化方法

- 不直接设计路径
- **进化控制策略或行为**
- 路径是行为的结果

---

进化机器人中“规划”的真正含义

- 没有明确的“路线图”
- 只有：

  - 传感器输入
  - 行为输出

- 好的行为自然走到目标

---

Fitness（适应度）在路径规划中的作用

- 路径是否到达目标
- 是否避开障碍
- 是否高效（距离、时间）

这些都会体现在：Fitness function

---

Robot Path Planning 在 Evolutionary Robotics 中的意义

- 是一个经典问题
- 非常适合展示进化方法的优势
- 能产生非直观但有效的路径

### Workspace Optimization（工作空间优化）

> **The workspace is the set of all positions and orientations that a robot can reach.**

工作空间是机器人能够到达的所有位置（和姿态）的集合。

什么是 Workspace Optimization

让机器人

- **覆盖更多区域**
- **更容易到达目标**
- **更高效地完成任务**

> 工作空间优化就是让机器人“更好地利用它能到达的空间”。

---

为什么 Workspace Optimization 很重要？

- 机器人结构和参数一旦固定
- 工作空间就会受到限制
- 如果设计不好：

  - 有些位置到不了
  - 有些动作效率很低

因此：

> **Optimizing the workspace improves task performance.**

---

在进化机器人学中，**不手工计算最优结构**，而是：

- 进化：

  - 控制参数
  - 关节配置
  - 有时甚至是机械结构

- 通过适应度函数评估：

  - 覆盖范围
  - 可达性
  - 操作效率

> Workspace optimization is achieved by evolving robot parameters and evaluating their performance.

---

可以优化哪些方面？

- **Robot morphology（结构）**
- **Joint limits（关节范围）**
- **Control strategies（控制策略）**

Workspace Optimization 与任务的关系

- 不同任务 → 不同最优工作空间
- 优化是 **任务相关的（task-dependent）**

为什么进化方法适合 Workspace Optimization？

- 搜索空间大
- 人工设计困难
- 进化可以发现非直观解

### Estimation of Kinematic Chain（运动链估计）

> **A kinematic chain is a sequence of links and joints that describes how motion is transmitted from the base to the end-effector.**

运动链是由连杆和关节组成的结构，描述运动如何从底座传到末端。

什么是 Estimation of Kinematic Chain

- 不事先完全知道：

  - 关节参数
  - 连杆长度
  - 关节关系

- **通过运动和感知来估计**

> 运动链估计就是通过观测来推断机器人的运动学模型。

---

为什么需要“估计”？

- 机器人可能：

  - 自我重构
  - 被进化改变结构
  - 参数随时间变化

- 人工标定不现实

因此：

> **The robot must estimate its own kinematic structure.**

---

在 Evolutionary Robotics 中如何用到运动链估计？

- 进化可能改变：

  - 控制策略
  - 结构参数

- 机器人需要：

  - **重新理解“我怎么动”**

所以：

> **Kinematic chain estimation supports adaptive and evolutionary systems.**

---

估计是基于什么信息？

- 传感器数据
- 关节运动
- 末端执行器位置变化

> Estimation is based on observed motion and sensor feedback.

---

运动链估计解决什么问题？

- 正确预测运动结果
- 改善控制精度
- 在结构变化后继续工作

> Estimating the kinematic chain allows the robot to control its motion correctly.

---

与 Workspace Optimization 的关系

- 工作空间依赖于运动链
- 如果运动链变化 → 工作空间也变化
- 因此需要估计 → 再优化

> Kinematic chain estimation is necessary for workspace optimization.

### Welding Robot（焊接机器人）

焊接机器人是用于自动完成焊接任务的工业机器人。

焊接任务为什么“难”？是因为它同时具有：

- **复杂几何路径**
- **严格的时间与速度要求**
- **高精度位置控制**
- **对环境变化敏感**

---

核心问：

(1) **Path Planning（路径）**

- 焊枪必须沿焊缝移动
- 路径必须连续、平滑

(2) **Timing & Speed（时间与速度）**

- 速度过快或过慢都会影响焊接质量

(3) **Positioning Accuracy（定位精度）**

- 焊枪位置误差会导致焊接失败

(4) **Adaptation（适应性）**

- 工件可能存在偏差
- 焊缝不完全一致

---

因此可以使用进化方法来：

- 自动优化：

  - 运动参数
  - 路径跟随行为
  - 控制策略

在焊接场景中，进化的目标通常是：

- 焊缝质量
- 稳定性
- 效率
- 错误容忍度

这些都会体现在 **fitness evaluation** 中。

## Biologically-inspired Robot Locomotion（生物启发的机器人运动）

- 传统机器人运动方式：

  - 轮式
  - 履带

- **在复杂环境中表现很差**

  - 不平整地形
  - 障碍物
  - 柔性接触

而自然界中：

- 动物已经在这些环境中 **进化了几百万年**
- 生物运动：

  - 稳定
  - 高效
  - 自适应

---

“Inspired”是什么意思

- ❌ 不是完全复制动物
- ❌ 不是做“动物模型”
- ✅ 是**借鉴原理**

例如：

- 步态
- 协调方式
- 神经控制机制

---

生物启发运动关注哪些方面？

- **Gaits（步态）**
- **Coordination（协调）**
- **Stability（稳定性）**
- **Energy efficiency（能效）**
- **Adaptation（适应性）**

---

与 Evolutionary Robotics 的关系

- 生物启发运动：

  - 提供结构与控制思路

- 进化机器人学：

  - 自动优化这些运动模式

> Biologically-inspired locomotion is often combined with evolutionary methods.

---

生物启发运动 vs 传统运动

| 传统机器人运动 | 生物启发运动    |
| -------------- | --------------- |
| 规则控制       | 协调控制        |
| 结构刚性       | 柔性 / 多自由度 |
| 环境受限       | 环境适应性强    |

> Biologically-inspired locomotion provides better adaptability to complex environments.

### Evolutionary-based Locomotion（基于进化的运动）

基于进化的运动是通过进化算法自动生成和优化机器人的运动方式。

为什么不用“手工设计步态”？

- 多足机器人、柔性机器人
- 自由度高
- 动力学复杂
- 人工设计步态 **困难且不鲁棒**

因此：

> **Locomotion is a suitable target for evolutionary methods.**

> 当运动系统复杂时，进化方法比人工设计更合适。

---

Evolutionary-based Locomotion 的基本思想

在这种方法中：

- **不预定义步态**
- 进化的是：

  - 控制参数
  - 传感器–执行器映射

- 运动模式 **从行为中涌现**

> Gaits emerge through evolution rather than being explicitly programmed.

---

“进化”是如何作用在运动上的？

1. 生成多种运动控制方案（种群）
2. 在环境中测试运动
3. 评估运动表现（fitness）
4. 选择更好的方案
5. 迭代进化

> Locomotion patterns are selected based on performance in the environment.

---

Fitness 在运动进化中的含义

Fitness 通常反映：

- 移动距离
- 稳定性
- 能耗
- 是否跌倒

> Fitness evaluates how well the robot moves.

---

Evolutionary-based Locomotion 的优势

- 能发现非直观步态
- 适应特定机器人结构
- 适应特定环境

> Evolutionary locomotion can discover efficient and unexpected movement strategies.

---

与 Biologically-inspired Locomotion 的关系

- 生物启发 → 提供灵感
- 进化方法 → 自动优化

因此：

> **Evolutionary-based locomotion often uses biologically inspired control principles.**

局限性

- 计算成本高
- 仿真到现实存在差距

### Neurooscillator-based Locomotion Generation（基于神经振荡器的运动生成）

为什么要用 Neurooscillators？

- 动物的行走、游泳、爬行
- 并不是每一步都“计算出来”
- 而是由 **神经振荡器（Central Pattern Generators, CPGs）** 产生

> 生物运动来源于神经振荡，而不是逐步计算。

什么是 Neurooscillator

神经振荡器是一种无需周期输入就能产生周期信号的系统。

Locomotion Generation

基于神经振荡器的运动生成利用振荡信号来驱动机器人运动。

---

神经振荡器如何产生运动？

1. 振荡器产生周期信号
2. 信号驱动关节或电机
3. 多个振荡器相互耦合
4. 形成协调的步态

不需要显式规划步态

> Coordinated locomotion emerges from coupled oscillators.

为什么这种方法适合机器人运动？

- **平滑运动**
- **自然节律**
- **对扰动鲁棒**
- **易于适应不同速度**

> Neurooscillator-based locomotion is robust and produces smooth, natural motion.

---

与 Biologically-inspired Locomotion 的关系

> **This approach is directly inspired by biological central pattern generators.**

也就是说：

- 不是算法巧合
- 是明确的生物启发

与 Evolutionary-based Locomotion 的关系

- 振荡器结构是生物启发的
- **参数可以通过进化优化**

> Neurooscillator parameters are often optimized using evolutionary algorithms.

解决了什么问题？

- 不需要复杂规划
- 不需要精确模型
- 行为自然、稳定

> Neurooscillator-based locomotion simplifies control of complex robots.

### Evolving a Sensory-Motor Interconnection Structure（进化感觉-运动互连结构）

感觉-运动互连结构就是“传感器如何影响执行器”。

例如：

- 哪个传感器连到哪个电机
- 信号是增强还是抑制
- 是否经过中间节点（如振荡器）

什么是“Evolving” Sensory-Motor Structure？

> 进化感觉-运动互连结构，就是用进化算法自动生成传感器到执行器的连接方式。

---

为什么要进化“结构”，而不是只进化参数？

- 手工设计连接结构：

  - 依赖经验
  - 容易限制行为

- 很多有效行为：

  - **不是人类直觉能想到的**

因此：

> **The structure itself should be subject to evolution.**

> 不只参数，连接方式本身也应该被进化。

---

进化互连结构 vs 固定互连结构

| 固定结构 | 进化结构     |
| -------- | ------------ |
| 人工设计 | 自动发现     |
| 行为受限 | 行为涌现     |
| 可解释   | 可能不可解释 |
| 适应性低 | 适应性高     |

> Evolving interconnections allows more flexible and adaptive behavior.

---

进化的“结构”可能包括什么？

- 哪些传感器连接到哪些电机
- 连接强度的正负（兴奋/抑制）
- 是否存在中间处理单元
- 连接的拓扑结构

---

与 Braitenberg Vehicles 的直接联系

- Braitenberg Vehicles：

  - **手工设计**感觉-运动连接

- 这里：

  - **自动进化**感觉-运动连接

> Evolving sensory-motor interconnections generalizes the idea of Braitenberg Vehicles.

与 Neurooscillator-based Locomotion 的关系

在生物启发运动中：

- 传感器
- 神经振荡器
- 电机

它们之间的连接方式可以：

> **be evolved to produce stable and adaptive locomotion.**

---

为什么这种方法“很像生物”？

- 生物的神经系统：

  - 不是人工设计的
  - 是进化结果

- 机器人也可以：

  - 通过进化形成有效连接结构

> This approach is biologically inspired at the structural level.

## Exam

### Write a short essay [max 10-15 sentence] about the Braitenberg vehicles. Sketch at least 2 different vehicles and analyze their behavior. Make a summary conclusion about the topic

写一篇关于布拉伊滕贝格小车的短文 [最多 10-15 句话]。请绘制至少 2 种不同的车辆草图并分析它们的行为。对该主题做一个总结性结论。

Braitenberg vehicles are minimalistic thought-experiment robots introduced by Valentino Braitenberg.  
They consist only of sensors, motors, and direct connections between them.  
There is no internal model, memory, planning, or cognition.  
Despite this simplicity, they exhibit complex, lifelike behaviors.

布拉伊滕贝格小车是由 Valentino Braitenberg 提出的极简机器人思想实验。  
它们只包含 传感器、电机，以及两者之间的直接连接。  
没有记忆、规划、推理或智能模块。  
但却能表现出看似“智能”的复杂行为。

The key idea is that behavior emerges from sensor–motor coupling.  
Small changes in wiring structure can lead to dramatically different behaviors.  
Observers often over-interpret these behaviors as intentional or emotional.

核心思想是：行为来自传感器与电机之间的耦合关系。  
微小的连接变化，就会产生完全不同的行为。  
人类观察者往往会错误地赋予机器人情感或意图。

---

基本组成模块

Sensors（传感器）

- Light sensor
- Sound sensor
- Distance sensor

Motors（电机）

- Left motor
- Right motor

Connections（连接方式）

- **Excitatory（兴奋）**：刺激 ↑ → 电机速度 ↑
- **Inhibitory（抑制）**：刺激 ↑ → 电机速度 ↓
- **Ipsilateral（同侧）**
- **Contralateral（交叉）**

**所有行为只来自这四点**

---

Braitenberg 按 **复杂度递增** 提出了多种车辆，常见分类如下：

Vehicle 0 – No Sensors

0 型：无传感器

Vehicle 0 has no sensors and moves at constant speed.  
It shows no reaction to the environment.

0 型小车没有传感器，只是匀速运动。  
对环境没有任何反应。

**意义**：作为对照组

---

Vehicle 1 – One Sensor

1 型：单传感器

Vehicle 1 has one sensor connected to both motors.  
It moves faster when the stimulus is stronger.

1 型只有一个传感器，控制两个电机。  
刺激越强，运动越快。

**行为**：简单反射

---

Vehicle 2 – Two Sensors, Direct Connections

2 型：双传感器 + 同侧连接

Vehicle 2a – Fear（恐惧）

**Connection**

- Sensor → **Excitatory** （兴奋） → same-side motor

**Behavior**

- Turns away from stimulus

The vehicle speeds up the motor on the stimulated side and turns away from the source.

受刺激一侧加速，车辆转向远离刺激源，看起来像“害怕”。

---

Vehicle 2b – Aggression（攻击）

**Connection**

- Sensor → **Inhibitory** （抑制） → same-side motor

**Behavior**

- Moves toward stimulus rapidly

刺激越强，靠近越快，看起来像“攻击”。

---

Vehicle 3 – Two Sensors, Crossed Connections

3 型：双传感器 + 交叉连接（最重要）

Vehicle 3a – Love（爱）

**Connection**

- Sensor → **Inhibitory** → opposite motor

**Behavior**

- Approaches stimulus and stops near it

The vehicle slows down as it approaches the stimulus and finally stops close to it.

靠近刺激源时逐渐减速，最后停在附近，看起来像“爱”。

---

Vehicle 3b – Explorer / Curiosity（探索）

**Connection**

- Sensor → **Excitatory** → opposite motor

**Behavior**

- Actively seeks stimulus, may circle around it

车辆不断主动接近并绕着刺激源运动，看起来像“好奇”。

---

Vehicle 4 – Nonlinear Connections

4 型：非线性连接

Vehicle 4 introduces nonlinear transfer functions.
Small stimuli cause weak reactions, strong stimuli cause strong reactions.

4 型引入非线性映射，刺激与行为不再线性对应。

**意义**：更接近真实生物反应

---

Vehicle 5+ – Memory and Internal States

高级型（5 及以上）

Later vehicles introduce internal states and simple memory.
Behavior depends on past stimulation.

更高级的小车具有内部状态或记忆。
行为不仅取决于当前刺激，还取决于过去。

**已接近真正控制系统**

---

| Vehicle | Sensors | Connection            | Behavior        | Interpretation |
| ------- | ------- | --------------------- | --------------- | -------------- |
| 0       | 0       | –                     | Constant motion | 无反应         |
| 1       | 1       | Direct                | Speed change    | 反射           |
| 2a      | 2       | Excitatory, same side | Avoidance       | 恐惧           |
| 2b      | 2       | Inhibitory, same side | Attack          | 攻击           |
| 3a      | 2       | Inhibitory, crossed   | Stop near       | 爱             |
| 3b      | 2       | Excitatory, crossed   | Active seeking  | 好奇           |
| 4       | 2       | Nonlinear             | Complex         | 生物化         |
| 5+      | ≥2      | Internal states       | Adaptive        | 学习           |

### Choose one vehicle from Task1. Your task is to make a project proposal to the realization of the hardware

从任务 1 中选择一种车辆。你的任务是为硬件实现制定一份项目提案。

#### Choose an actuator type option from the learnt ones and argue Your choice. [Compare the benefits and drawback with the other types.]

从学过的执行器类型中选择一种，并论证你的选择。[与其他类型比较优缺点。]

I choose DC motors as actuators.  
DC motors are simple, cheap, and easy to control using voltage or PWM signals.  
They are sufficient for demonstrating Braitenberg vehicle behavior.

Compared to stepper motors, DC motors require less control complexity and fewer resources.  
Compared to servo motors, DC motors are cheaper and more flexible for continuous motion.  
Their main drawback is lower position accuracy, but position control is not required here.

我选择 直流电机（DC motor）。  
优点：结构简单、成本低、PWM 易控制。  
相比步进电机：控制更简单。  
相比舵机：更便宜，适合连续运动。  
缺点是定位精度低，但本项目不需要精确位置控制。

#### Make a simplified structural plan for the peripherals needed for the project [similar graph that we saw on lectures] and explain how You would use them in the project

为项目所需的外设制定一个简化的结构规划图 [类似于我们在讲座中看到的图表]，并解释你将如何在项目使用它们。

```txt
[Light Sensors]
        ↓
[Signal Conditioning]
        ↓
[Microcontroller]
        ↓
[Motor Driver]
        ↓
[DC Motors]
```

Light sensors measure the stimulus intensity.  
Signal conditioning converts raw signals to usable voltage levels.  
The microcontroller processes sensor signals and applies inhibitory control logic.  
The motor driver amplifies control signals.  
DC motors generate movement.

传感器采集光强 → 信号调理 → 控制器计算 → 电机驱动 → 小车运动。

### What are the main signal types?

主要的信号类型有哪些？

Analog signals（模拟信号）  
Continuous values, e.g. light intensity

Digital signals（数字信号）  
Discrete values, 0 or 1

PWM signals（脉宽调制信号）  
Digital signal used to control motor speed

Communication signals（通信信号）  
I²C, SPI, UART

### Draw a block diagram about the generalized control loop. What are the main components of it?

画出通用控制回路的框图。它的主要组成部分是什么？

A generalized control loop is a closed-loop system that continuously regulates a process by comparing the desired reference with the measured output and applying corrective actions through feedback.

通用控制回路是一种**闭环系统**，通过不断比较**期望值（参考输入）**与**实际输出**，并利用**反馈**进行修正，从而稳定和控制系统行为。

基本框图

```txt
Reference r(t)
     ↓
  [ Comparator ]
     ↓  error e(t)
  [ Controller ]
     ↓  control u(t)
  [ Actuator ]
     ↓
  [ Plant / System ]
     ↓  output y(t)
  [ Sensor ]
     └──────── Feedback ────────┘
```

---

主要组成部分

1️⃣ Reference / Setpoint

**参考输入 / 目标值**

- Desired value the system should reach
- 系统希望达到的目标
- 例子：目标速度、目标位置、目标温度

---

2️⃣ Comparator

**比较器（误差计算）**

- Computes the error
  $e(t) = r(t) - y(t)$
- 计算误差 = 目标 − 实际输出

**误差是控制的核心驱动力**

---

3️⃣ Controller

**控制器**

- Generates control signal based on the error
- 根据误差计算控制量

常见控制器：

- **P** (Proportional)
- **PI** (Proportional + Integral)
- **PID** （Proportional + Integral + Derivative）

| 控制器 | 用了什么信息           | 能消除稳态误差 | 稳定性 |
| ------ | ---------------------- | -------------- | ------ |
| P      | 当前误差               | ❌ 否          | 中     |
| PI     | 当前 + 过去            | ✅ 是          | 中     |
| PID    | 当前 + 过去 + 变化趋势 | ✅ 是          | 高     |

---

4️⃣ Actuator

**执行器**

- Converts control signal into physical action
- 把控制信号变成物理运动或能量

例子：

- DC motor
- Servo motor
- Hydraulic actuator

---

5️⃣ Plant / System

**被控对象**

- The physical system to be controlled
- 真正要被控制的系统

例子：

- Robot
- Motor system
- Vehicle

---

6️⃣ Sensor

**传感器**

- Measures system output
- 测量系统状态

例子：

- Encoder（位置/速度）
- Camera
- Temperature sensor

---

7️⃣ Feedback

**反馈（闭环关键）**

- Sends measured output back to the controller
- 把输出返回用于修正误差

**没有反馈 = 开环**

---

Signal Flow

信号流向

Reference → Error → Control signal → Physical action → Measured output → Feedback

目标 → 误差 → 控制信号 → 物理作用 → 测量输出 → 反馈

| Type        | Feedback | Accuracy | Robustness |
| ----------- | -------- | -------- | ---------- |
| Open-loop   | ❌ No    | Low      | Poor       |
| Closed-loop | ✅ Yes   | High     | Strong     |

---

A control loop is stable if its output converges to the reference without oscillation or divergence.

如果系统输出能稳定接近目标值，而不震荡或发散，则系统是稳定的。

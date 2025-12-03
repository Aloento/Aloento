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

#### Mostly Measured Physical Quantities（主要测量的物理量）

#### Measurement in Mechanics（机械测量）

#### Indirect Measurement Idea（间接测量思想）

#### Principle of the Optical Encoders（光学编码器的原理）

### Actuators（执行器）

#### Main Energy Sources by Type Used（按类型使用的主要能源）

#### Power Machines vs Actuators（电源机器与执行器）

#### Positioning（定位）

#### DC Motor（直流电动机）

#### BLDC Motor（无刷直流电动机）

#### Stepper Motor（步进电动机）

#### Linear Motor（线性电动机）

#### Special Actuators: Piezo Motor, Memory Alloy, MEMS（特殊执行器：压电电动机、记忆合金、MEMS）

#### Principle of the Servo Motor（伺服电动机的原理）

## Ethorobotics（伦理机器人学）

### Social Robots（社交机器人）

### Industrial Robots（工业机器人）

### Uncanny Valley（恐怖谷）

### Main Fields of Application of Social Robotics（社交机器人的主要应用领域）

### Communication Modalities in Interactions（交互中的通信模式）

### Attachment and the Ainsworth Strange Situation Test（依恋与艾因斯沃斯陌生情境测试）

## Cognitive Robotics（认知机器人学）

### Cognitive Architectures（认知架构）

### Adaptivity（适应性）

### Braitenberg Vehicles（布雷滕伯格车辆）

### Cognitive Model of iPhonoid（iPhonoid 的认知模型）

### Stress-inspired Working Memory（压力启发的工作记忆）

### Robot Pianist（机器人钢琴家）

## Evolutionary Robotics（进化机器人学）

### Robot Path Planning（机器人路径规划）

### Workspace Optimization（工作空间优化）

### Estimation of Kinematic Chain（运动链估计）

### Welding Robot（焊接机器人）

## Biologically-inspired Robot Locomotion（生物启发的机器人运动）

### Evolutionary-based Locomotion（基于进化的运动）

### Neurooscillator-based Locomotion Generation（基于神经振荡器的运动生成）

### Evolving a Sensory-Motor Interconnection Structure（进化感觉-运动互连结构）

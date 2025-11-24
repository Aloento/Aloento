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

#### Types of Signals Based on the Time/Value Quantization（基于时间/数值量化的信号类型）

#### Signal Preprocessing Methods（信号预处理方法）

#### Filter Types（滤波器类型）

### Microprocessor as the Computational Unit of the Embedded Systems（微处理器作为嵌入式系统的计算单元）

#### Most Used Peripherals（最常用的外围设备）

#### I/O – Purpose and Usage（输入/输出 - 目的和用法）

#### Timer – Purpose and Usage（定时器 - 目的和用法）

#### AD/DA Converters – Purpose and Usage（模数/数模转换器 - 目的和用法）

#### Comparators（比较器）

#### Communication Protocols（通信协议）

#### Real-timeness（实时性）

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

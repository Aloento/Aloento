---
title: OpenStack 学习日记 第二天
date: 2022-06-15 17:05:43
toc: true
categories:
  - [Cloud, OpenStack]
  - [Diary]
tags: [云, OpenStack, 日记]
---

## Cinder

操作系统挂载储存空间的方法有：

<!-- more -->

1. Block Storage 块储存：通过本地协议（SCSI、SAS）等挂载裸磁盘，每个磁盘叫做 Volume 卷
2. 文件系统储存：通过网络协议（NFS、CIFS）等挂载远程文件系统，分布式就是这种

Block Storage Service 提供对 volume 从创建到删除整个生命周期的管理  
从 instance 的角度看，挂载的每一个 Volume 都是一块硬盘

Cinder：

1. 提供 REST API 使用户能够查询和管理 volume、volume snapshot 以及 volume type
2. 提供 scheduler 调度 volume 创建请求，合理优化存储资源的分配
3. 通过 driver 架构支持多种 back-end（后端）存储方式，包括 LVM，NFS，Ceph 和其他诸如 EMC、IBM 等商业存储产品和方案

### 组件

1. cinder-api
   接收 API 请求，调用 cinder-volume 执行操作

2. cinder-volume
   管理 volume 的服务，与 volume provider 协调工作，管理 volume 的生命周期  
   运行 cinder-volume 服务的节点被称作为存储节点，LVM 是默认的 provider

3. cinder-scheduler
   scheduler 通过调度算法选择最合适的存储节点创建 volume

4. volume provider
   数据的存储设备，为 volume 提供物理存储空间  
   支持多种 volume provider，每种 provider 通过自己的 driver 与 cinder-volume 协调工作

5. Message Queue
   Cinder 各个子服务通过消息队列实现进程间通信和相互协作  
   因为有了消息队列，子服务之间实现了解耦，这种松散的结构也是分布式系统的重要特征

6. Database
   数据库是安装在控制节点上的

### 其他

> 理解 Cinder 架构 – 每天 5 分钟玩转 OpenStack（45）

主要还是在讲传统分布式设计

> 掌握 Cinder 的设计思想 – 每天 5 分钟玩转 OpenStack（46）

cinder-api 是整个 Cinder 组件的门户，所有 cinder 的请求都首先由 nova-api 处理

cinder-volume 在存储节点上运行，OpenStack 对 Volume 的操作，最后都是交给 cinder-volume 来完成的  
cinder-volume 自身并不管理真正的存储设备，存储设备是由 volume provider 管理的。cinder-volume 与 volume provider 一起实现 volume 生命周期的管理

> Cinder 组件详解 – 每天 5 分钟玩转 OpenStack（47）

### 调度器

Filter scheduler 是 cinder-scheduler 默认的调度器

1. AvailabilityZoneFilter
   为提高容灾性和提供隔离服务，可以将存储节点和计算节点划分到不同的 Availability Zone 中

2. CapacityFilter
   将存储空间不能满足 Volume 创建需求的存储节点过滤掉

3. CapabilitiesFilter
   不同的 Volume Provider 有自己的特性（Capabilities），比如是否支持 thin provision 等  
   Cinder 允许用户创建 Volume 时通过 Volume Type 指定需要的 Capabilities

4. Weighter
   通过 scheduler_default_weighers 指定计算权重的 weigher，默认为 CapacityWeigher  
   CapacityWeigher 基于存储节点的空闲容量计算权重值，空闲容量最大的胜出

> 掌握 cinder-scheduler 调度逻辑 – 每天 5 分钟玩转 OpenStack（48）

### 操作

> 准备 LVM Volume Provider – 每天 5 分钟玩转 OpenStack（49）

> Create Volume 操作（Part I） – 每天 5 分钟玩转 OpenStack（50）

> Create Volume 操作（Part II） – 每天 5 分钟玩转 OpenStack（51）

> Create Volume 操作（Part III） – 每天 5 分钟玩转 OpenStack（52）

> Attach Volume 操作（Part I） – 每天 5 分钟玩转 OpenStack（53）

> Attach Volume 操作（Part II） – 每天 5 分钟玩转 OpenStack（54）

> Detach Volume 操作 – 每天 5 分钟玩转 OpenStack（55）

> Extend Volume 操作 – 每天 5 分钟玩转 OpenStack（56）

> Delete Volume 操作 – 每天 5 分钟玩转 OpenStack（57）

> Snapshot Volume 操作 – 每天 5 分钟玩转 OpenStack（58）

> Backup Volume 操作 – 每天 5 分钟玩转 OpenStack（59）

> Restore Volume 操作 – 每天 5 分钟玩转 OpenStack（60）

> Boot From Volume – 每天 5 分钟玩转 OpenStack（61）

### NFS

> NFS Volume Provider（Part I） – 每天 5 分钟玩转 OpenStack（62）

> NFS Volume Provider（Part II） – 每天 5 分钟玩转 OpenStack（63）

> NFS Volume Provider（Part III） – 每天 5 分钟玩转 OpenStack（64）

---

## Neutron

“软件定义网络（software-defined networking, SDN）”所具有的灵活性和自动化优势

Neutron 的设计目标是实现“网络即服务（Networking as a Service）”  
在设计上遵循了基于 SDN 实现网络虚拟化的原则，在实现上充分利用了 Linux 系统上的各种网络相关的技术

Neutron 为整个 OpenStack 环境提供网络支持，包括二层交换，三层路由，负载均衡，防火墙和 VPN 等

1. 二层交换 Switching
   Nova 的 Instance 是通过虚拟交换机连接到虚拟二层网络的  
   Neutron 支持多种虚拟交换机，包括 Linux 原生的 Linux Bridge 和 Open vSwitch  
   Neutron 除了可以创建传统的 VLAN 网络，还可以创建基于隧道技术的 Overlay 网络，比如 VxLAN 和 GRE

2. 三层路由 Routing
   Neutron 支持多种路由，包括 Linux 原生的 Linux Bridge 和 Open vSwitch  
   Instance 可以配置不同网段的 IP，Neutron 的 router（虚拟路由器）实现 instance 跨网段通信  
   router 通过 IP forwarding，iptables 等技术来实现路由和 NAT

3. 负载均衡 Load Balancing
   Load-Balancing-as-a-Service（LBaaS）  
   支持多种负载均衡产品和方案，不同的实现以 Plugin 的形式集成到 Neutron，目前默认的 Plugin 是 HAProxy。

4. 防火墙 Firewalling
   Security Group：通过 iptables 限制进出 instance 的网络包  
   FWaaS：限制进出虚拟路由器的网络包，也是通过 iptables 实现

> Neutron 功能概述 – 每天 5 分钟玩转 OpenStack（65）

### 概念

Neutron 支持多种类型的 network，包括 local, flat, VLAN, VxLAN 和 GRE。

1. local
   local 网络与其他网络和节点隔离。local 网络中的 instance 只能与位于同一节点上同一网络的 instance 通信，local 网络主要用于单机测试

2. flat
   flat 网络是无 vlan tagging 的网络。flat 网络中的 instance 能与位于同一网络的 instance 通信，并且可以跨多个节点。

3. vlan
   vlan 网络是具有 802.1q tagging 的网络。vlan 是一个二层的广播域，同一 vlan 中的 instance 可以通信，不同 vlan 只能通过 router 通信。vlan 网络可以跨节点，是应用最广泛的网络类型

4. vxlan
   vxlan 是基于隧道技术的 overlay 网络。vxlan 网络通过唯一的 segmentation ID（也叫 VNI）与其他 vxlan 网络区分  
   vxlan 中数据包会通过 VNI 封装成 UDP 包进行传输  
   因为二层的包通过封装在三层传输，能够克服 vlan 和物理网络基础设施的限制

5. gre
   gre 是与 vxlan 类似的一种 overlay 网络。主要区别在于使用 IP 包而非 UDP 进行封装

> Neutron 网络基本概念 – 每天 5 分钟玩转 OpenStack（66）

### 组件

1. Neutron Server
   对外提供 OpenStack 网络 API，接收请求，并调用 Plugin 处理请求。

2. Plugin
   处理 Neutron Server 发来的请求，维护 OpenStack 逻辑网络的状态， 并调用 Agent 处理请求。

3. Agent
   处理 Plugin 的请求，负责在 network provider 上真正实现各种网络功能。

4. network provider
   提供网络服务的虚拟或物理网络设备，例如 Linux Bridge，Open vSwitch 或者其他支持 Neutron 的物理交换机。

5. Queue
   Neutron Server，Plugin 和 Agent 之间通过 Messaging Queue 通信和调用。

6. Database
   存放 OpenStack 的网络状态信息，包括 Network, Subnet, Port, Router 等。

> Neutron 架构 – 每天 5 分钟玩转 OpenStack（67）

### 部署

1. 方案 1：控制节点 + 计算节点
   控制节点：部署的服务包括：neutron server, core plugin 的 agent 和 service plugin 的 agent  
   计算节点：部署 core plugin 的 agent，负责提供二层网络功能。

2. 方案 2：控制节点 + 网络节点 + 计算节点
   控制节点：部署 neutron server 服务  
   网络节点：部署的服务包括：core plugin 的 agent 和 service plugin 的 agent  
   计算节点：部署 core plugin 的 agent，负责提供二层网络功能。

> Neutron 物理部署方案 – 每天 5 分钟玩转 OpenStack（68）

### 结构

1. Core API
   对外提供管理 network, subnet 和 port 的 RESTful API。

2. Extension API
   对外提供管理 router, load balance, firewall 等资源 的 RESTful API。

3. Commnon Service
   认证和校验 API 请求。

4. Neutron Core
   Neutron server 的核心处理程序，通过调用相应的 Plugin 处理请求。

5. Core Plugin API
   定义了 Core Plgin 的抽象功能集合，Neutron Core 通过该 API 调用相应的 Core Plgin。

6. Extension Plugin API
   定义了 Service Plgin 的抽象功能集合，Neutron Core 通过该 API 调用相应的 Service Plgin。

7. Core Plugin
   实现了 Core Plugin API，在数据库中维护 network, subnet 和 port 的状态，并负责调用相应的 agent 在 network provider 上执行相关操作，比如创建 network。

8. Service Plugin
   实现了 Extension Plugin API，在数据库中维护 router, load balance, security group 等资源的状态，并负责调用相应的 agent 在 network provider 上执行相关操作，比如创建 router。

> 理解 Neutron Server 分层模型 – 每天 5 分钟玩转 OpenStack（69）

> Neutron 如何支持多种 network provider – 每天 5 分钟玩转 OpenStack（70）

### ML2

Moduler Layer 2（ML2）是 Neutron 在 Havana 版本实现的一个新的 core plugin，用于替代原有的 linux bridge plugin 和 open vswitch plugin

传统 core plugin 存在两个突出的问题:

1. 无法同时使用多种 network provider

2. 开发新的 core plugin 工作量大

> 详解 ML2 Core Plugin（I） – 每天 5 分钟玩转 OpenStack（71）

ML2 对二层网络进行抽象和建模，引入了 type driver 和 mechanism driver  
这两类 driver 解耦了 Neutron 所支持的网络类型（type）与访问这些网络类型的机制（mechanism）  
其结果就是使得 ML2 具有非常好的弹性，易于扩展，能够灵活支持多种 type 和 mechanism。

#### Type Driver

Neutron 支持的每一种网络类型都有一个对应的 ML2 type driver。type driver 负责维护网络类型的状态，执行验证，创建网络等。ML2 支持的网络类型包括 local, flat, vlan, vxlan 和 gre

#### Mechanism Driver

Neutron 支持的每一种网络机制都有一个对应的 ML2 mechanism driver

mechanism driver 负责获取由 type driver 维护的网络状态，并确保在相应的网络设备（物理或虚拟）上正确实现这些状态

mechanism driver 有三种类型

1. Agent-based
   包括 linux bridge, open vswitch 等

2. Controller-based
   包括 OpenDaylight, VMWare NSX 等

3. 基于物理交换机
   包括 Cisco Nexus, Arista, Mellanox 等

> 详解 ML2 Core Plugin（II） – 每天 5 分钟玩转 OpenStack（72）

#### Service Plugin

Core Plugin/Agent 负责管理核心实体：net, subnet 和 port  
而对于更高级的网络服务，则由 Service Plugin/Agent 管理  
Service Plugin 及其 Agent 提供更丰富的扩展功能，包括路由，load balance，firewall 等

1. DHCP
   dhcp agent 通过 dnsmasq 为 instance 提供 dhcp 服务

2. Routing
   l3 agent 可以为 project（租户）创建 router，提供 Neutron subnet 之间的路由服务  
   路由功能默认通过 IPtables 实现

3. Firewall
   l3 agent 可以在 router 上配置防火墙策略，提供网络安全防护  
   另一个与安全相关的功能是 Security Group，也是通过 IPtables 实现  
   Firewall 安全策略位于 router，保护的是某个 project 的所有 network  
   Security Group 安全策略位于 instance，保护的是单个 instance

4. Load Balance
   Neutron 默认通过 HAProxy 为 project 中的多个 instance 提供 load balance 服务

> Service Plugin / Agent – 每天 5 分钟玩转 OpenStack（73）

> 两张图总结 Neutron 架构 – 每天 5 分钟玩转 OpenStack（74）

> 为 Neutron 准备物理基础设施（I） – 每天 5 分钟玩转 OpenStack（75）

> 为 Neutron 准备物理基础设施（II） – 每天 5 分钟玩转 OpenStack（76）

---
title: OpenStack 学习日记 | 第一天
date: 2022-06-09 13:08:56
toc: true
categories:
  - [Cloud, OpenStack]
  - [Diary]
tags: [云, OpenStack, 日记]
---

由于本人最近需要从事 OpenStack 相关工作，所以急需对 OpenStack 进行学习  
本系列日记仅作为本人的学习记录  
学习材料为 《每天 5 分钟玩转 OpenStack》

## 学习前需要知道的

### OpenStack 涉及的范围广

计算，储存，网络，虚拟化，可用性，安全性，灾备  
等一些列关于 IT 基础设施的范围 OpenStack 都有涵盖

### OpenStack 是一个平台

它的各个组件都采用了 Driver 架构，支持各种的具体实现。  
比如 OpenStack 储存服务 Cinder 只定义抽象 API，而具体实现交给具体的 Driver  
比如基于 LVM 的 iSCSI， EMC，或者开源的 Ceph，GlusterFS 等等

这里我们可以类比到 Entity Framework，它只定义了上层的 API  
而具体的数据库操作交给了你指定的 Driver，如 Npgsql

### OpenStack 是一个分布式系统

这也是学习它的比较大的阻碍，因为它原生就是分布式的，各个组件拆的很散  
不过我们学习的时候都使用 All-in-one 部署模式

## 我们要学习的内容

- 预备知识

  - 虚拟化
  - 云计算

- 核心组件
  - 架构
  - 认证 Keystone
  - 镜像 Glance
  - 计算 Nova
  - 储存 Cinder
  - 网络 Neutron

> 写在最前面 – 每天 5 分钟玩转 OpenStack（1）

---

## 虚拟化

虚拟化是云计算的基础  
虚拟机(Guest)共享物理机(Host)的资源，比如 CPU，内存，硬盘，网络，磁盘等

这主要通过 Hypervisor 来实现，比如 KVM，Xen，VMWare 等等

#### 1 类虚拟化

Hypervisor 是一个操作系统，直接安装在物理机上  
最典型的就是 Windows 上的 Hyper-V  
其他的还有 Xen 和 ESXi

#### 2 类虚拟化

Hypervisor 作为操作系统中的一个程序或者模块运行  
最典型的有 KVM 和 VMware Workstation

#### 对比

理论上讲，1 类虚拟化性能比 2 类的要好  
而 2 类虚拟化会更灵活，比如支持嵌套虚拟化

### KVM

对我来说 KVM 已经是一个听过无数次的词了  
OpenStack 对 KVM 的支持最好，全称叫 Kernel-based Virtual Machine  
也就是说它基于 Linux 的内核实现，它有一个模块叫 kvm.ko，只用于管理虚拟 CPU 和内存

那我们就要问了，那 IO 虚拟化呢，这个交给 Linux 内核与 QEMU 实现

#### Libvirt

这是 KVM 的管理工具，包含三个模块  
后台 daemon，api 库，和 命令行工具 virsh
virsh 和 virt-manager 是一定要会用的

> 虚拟化 – 每天 5 分钟玩转 OpenStack（2）

#### 安装

我们使用 Ubuntu，安装 KVM 需要的包

```shell
sudo apt install qemu-kvm qemu-system libvirt-bin virt-manager bridge-util
```

1. qemu-kvm 和 qemu-system 是 KVM 和 QEMU 的核心包，提供 CPU、内存和 IO 虚拟化功能
2. libvirt-bin 就是 libvirt，用于管理 KVM 等 Hypervisor
3. virt-manager 是 KVM 图形化管理工具
4. bridge-utils 和 vlan，主要是网络虚拟化需要，KVM 网络虚拟化的实现是基于 linux-bridge 和 VLAN

> 准备 KVM 实验环境 – 每天 5 分钟玩转 OpenStack（3）

对于我自己来说，使用 KVM 等本来就是轻车熟路了，所以我跳过这一部分

> 启动第一个 KVM 虚机 – 每天 5 分钟玩转 OpenStack（4）

> 远程管理 KVM 虚机 – 每天 5 分钟玩转 OpenStack（5）

#### CPU 虚拟化

KVM 虚拟机 在宿主机中其实是一个 QEMU-KVM 进程，与其他进程一同被调度  
虚拟中的每一个 vCPU 就对应 QEMU-KVM 进程中的一个 线程

这就表明 vCPU 的总数可以超过物理机的 CPU 总数，这叫 CPU OverCommit 超配  
这个特性让虚拟机能充分利用宿主机的 CPU 资源，但是这也导致了 VPS 中令人诟病的超售行为

#### 内存虚拟化

这一段算是我看的比较迷糊的一段  
不过说到底也不需要了解多少，只需要知道它并不是像一个普通程序那样分配内存即可  
中间存在大量的内存地址转换，各个厂家也为了转换效率做了很多特殊的优化  
Guest Virtual Address -> Guest Physical Address ->
Host Virtual Address -> Host Physical Address

内存也是可以超配的，所以超售机一大堆

> CPU 和内存虚拟化原理 – 每天 5 分钟玩转 OpenStack（6）

#### 储存虚拟化

##### 目录类型

文件目录类型是最常用的  
KVM 将宿主机目录 /var/lib/libvirt/images/ 作为默认的 Storage Pool

这个目录下面的每一个文件就是一个 Volume  
说白了就是用文件来当磁盘，我们最常用的方式
存储方便、移植性好、可复制、可远程访问  
KVM 支持 raw, qcow2, qed, vmdk, vdl 格式的磁盘文件

> KVM 存储虚拟化 – 每天 5 分钟玩转 OpenStack（7）

##### LVM 类型

这个用的不多，也就是把实际的磁盘划出来给虚拟机用，跳过

> LVM 类型的 Storage Pool – 每天 5 分钟玩转 OpenStack（8）

#### 网络虚拟化

这章是虚拟化中最复杂，最重要的部分

##### Linux Bridge

其实就是网桥，用来做 TCP/IP 二层协议交换的模块  
对于我来说这玩意接触的也比较多

> KVM 网络虚拟化基础 – 每天 5 分钟玩转 OpenStack（9）

这里记录几个重点

- 修改 /etc/network/interfaces 以配置网桥
- 使用 ifconfig 查看 IP 配置
- brctl show 查看当前 Linux Bridge 的配置

> 动手实践虚拟网络 – 每天 5 分钟玩转 OpenStack（10）

##### virbr0

virbr0 是 KVM 默认创建的一个 Bridge，其作用是为连接其上的虚机网卡提供 NAT 访问外网的功能。  
virbr0 默认分配了一个 IP 192.168.122.1，并为连接其上的其他虚拟网卡提供 DHCP 服务。  
这没啥好难的就是一个 NAT 网关而已

> 理解 Virbr0 – 每天 5 分钟玩转 OpenStack（11）

##### VLAN

也就是虚拟局域网，隔离用，二层交换机，不需要想的太复杂  
在一张网卡下面划分多个空间而已

> Linux 如何实现 VLAN – 每天 5 分钟玩转 OpenStack（12）

具体如何配置就等到要用的时候现查  
不过还是修改 /etc/network/interfaces

> 动手实践 Linux VLAN – 每天 5 分钟玩转 OpenStack（13）

### 云计算

- IaaS（Infrastructure as a Service）提供的服务是虚拟机
  典型的有 AWS，OpenStack 等

- PaaS（Platform as a Service）提供的服务是应用的运行环境
  比如 Github Pages

- SaaS（Software as a Service）提供的是应用服务
  对象通常是最终用户，就像 Gmail

> OpenStack is a cloud operating system that controls large pools of compute, storage,and networking resources throughout a datacenter, all managed through a dashboard that gives administrators control while empowering their users to provision resources through a web interface.

OpenStack 对数据中心的计算、存储和网络资源进行统一管理

> 云计算与 OpenStack – 每天 5 分钟玩转 OpenStack（14）

---

## OpenStack

写日记的时候最新版本是 Yoga，下一个版本是 Zed

首先列出模块列表

| 名称       | 用途                                                          | 中文                                                                              |
| ---------- | ------------------------------------------------------------- | --------------------------------------------------------------------------------- |
| cyborg     | Accelerator Life Cycle Management                             | 用于管理硬件和软件加速资源（如 GPU）的框架                                        |
| freezer    | Backup, Restore, and Disaster Recovery service                | 备份、恢复和灾难恢复服务                                                          |
| ironic     | Bare Metal service                                            | 裸机服务                                                                          |
| cinder     | Block Storage service                                         | 存储服务                                                                          |
| ceilometer | Data collection service                                       | 数据收集服务                                                                      |
| kuryr      | Bridge between container framework and OpenStack abstractions | 容器框架和 OpenStack 抽象之间的桥梁                                               |
| keystone   | Identity Service                                              | 管理身份验证、服务规则和服务令牌功能                                              |
| senlin     | Clustering service                                            | 集群服务                                                                          |
| storlets   | Compute inside Object Storage service                         | 对象存储服务中的计算                                                              |
| nova       | Compute service                                               | 计算服务，管理 VM 的生命周期                                                      |
| neutron    | network connectivity as a service                             | 网络连接服务，负责创建和管理 L2、L3 网络， 为 VM 提供虚拟网络和物理网络连接       |
| zun        | Containers service                                            | 容器服务                                                                          |
| horizon    | Dashboard                                                     | 仪表盘                                                                            |
| designate  | DNS service                                                   | DNS 服务                                                                          |
| ec2-api    | EC2 API compatibility layer                                   | EC2 API 兼容层                                                                    |
| glance     | Image service                                                 | 启动镜像服务                                                                      |
| watcher    | Infrastructure Optimization service                           | 基础设施优化服务                                                                  |
| masakari   | Instances High Availability Service                           | 实例高可用性服务                                                                  |
| barbican   | Key Manager service                                           | 密钥管理器服务                                                                    |
| octavia    | Load-balancer service                                         | 负载均衡器服务                                                                    |
| neutron    | Networking service                                            | 网络服务                                                                          |
| tacker     | NFV Orchestration service                                     | NFV 管理器，用于监视、配置 NFV 和管理 NFV 全生命周期                              |
| swift      | Object Storage service                                        | 对象存储服务                                                                      |
| heat       | Orchestration service                                         | REST 服务，能够基于一个声明式的模板，通过装配引擎装配组合若干个云应用             |
| placement  | Placement service                                             | REST API 堆栈和数据模型，用于跟踪资源提供程序的清单和使用情况，以及不同的资源类别 |
| cloudkitty | Rating service                                                | 计费服务                                                                          |
| vitrage    | RCA (Root Cause Analysis) service                             | 用于组织、分析和扩展 OpenStack 的告警和事件                                       |
| blazar     | Resource reservation service                                  | 资源保留服务                                                                      |
| manila     | Shared File Systems service                                   | 共享文件系统服务                                                                  |
| aodh       | Telemetry Alarming services                                   | 遥测报警服务                                                                      |
| ceilometer | Telemetry Data Collection service                             | 遥测数据采集服务                                                                  |

https://www.openstack.org/software/project-navigator/  
这么一大堆模块一时半会肯定是学不完的，我们挑重点学习  
搞清楚 OpenStack 是图和对计算，网络，储存资源进行管理的

### 核心组件

1. Nova 管理计算资源，是核心服务。
2. Neutron 管理网络资源，是核心服务。
3. Glance 为 VM 提供 OS 镜像，属于存储范畴，是核心服务。
4. Cinder 提供块存储，VM 怎么也得需要数据盘吧，是核心服务。
5. Swift 提供对象存储，不是必须的，是可选服务。
6. Keystone 认证服务，没它 OpenStack 转不起来，是核心服务。
7. Ceilometer 监控服务，不是必须的，可选服务。
8. Horizon 大家都需要一个操作界面吧。

OpenStack 本身是一个分布式系统，不但各个服务可以分布部署，服务中的组件也可以分布部署  
这也使得 OpenStack 比一般系统复杂，学习难度也更大

> OpenStack 架构 – 每天 5 分钟玩转 OpenStack（15）

搭建 Dev 环境我一般使用 MicroStack 一键解决

> 搭建 OpenStack 实验环境 – 每天 5 分钟玩转 OpenStack（16）

> 部署 DevStack – 每天 5 分钟玩转 OpenStack（17）

### Keystone

对于天天跟 OAuth 打交道的我这部分其实可以跳过

- Authentication 解决的是“你是谁？”的问题
- Authorization 解决的是“你能干什么？”的问题
- Keystone 负责管理和维护每个 Service 的 Endpoint
- Service 通过 Endpoint 暴露自己的 API

> 理解 Keystone 核心概念 – 每天 5 分钟玩转 OpenStack（18）

> 通过例子学习 Keystone – 每天 5 分钟玩转 OpenStack（19）

### Glance

这玩意还储存快照

Glance 支持多种 backend，包括

- A directory on a local file system（这是默认配置）
- GridFS
- Ceph RBD
- Amazon S3
- Sheepdog
- OpenStack Block Storage (Cinder)
- OpenStack Object Storage (Swift)
- VMware ESX

没啥好讲的，需要用到时候现查，而且大部分操作都可以通过 GUI 完成

> 理解 Glance – 每天 5 分钟玩转 OpenStack（20）

> 创建 Image – 每天 5 分钟玩转 OpenStack（21）

> 如何使用 OpenStack CLI – 每天 5 分钟玩转 OpenStack（22）

### Nova

Compute Service Nova 是 OpenStack 最核心的服务，负责维护和管理云环境的计算资源。  
OpenStack 作为 IaaS 的云操作系统，虚拟机生命周期管理也就是通过 Nova 来实现的。

- nova-api
  接收和响应客户的 API 调用， 还支持 Amazon EC2 API

- nova-scheduler
  虚机调度服务，负责决定在哪个计算节点上运行虚机

- nova-compute
  管理虚机的核心服务，通过调用 Hypervisor API 实现虚机生命周期管理

- nova-conductor
  nova-compute 经常需要更新数据库，比如更新虚机的状态  
  出于安全性和伸缩性的考虑，nova-compute 并不会直接访问数据库

- nova-console
  用户可以通过多种方式访问虚机的控制台：  
  nova-novncproxy，基于 Web 浏览器的 VNC 访问  
  nova-spicehtml5proxy，基于 HTML5 浏览器的 SPICE 访问  
  nova-xvpnvncproxy，基于 Java 客户端的 VNC 访问

- nova-consoleauth
  负责对访问虚机控制台请求提供 Token 认证

- nova-cert
  提供 x509 证书支持

总之我越看越觉得 OpenStack 就是在 Hypervisor 上套了一层又一层  
而且我个人对 Python 写的大型项目是完全没有好感

> 理解 Nova 架构 – 每天 5 分钟玩转 OpenStack（23）

#### 部署方案

哪里有那么复杂，专门负责装 VPS 的 Hypervisor 就装 nova-compute  
然后其他服务放别处就行了

OpenStack 默认是用 RabbitMQ 作为 Message Queue，好评

> Nova 组件如何协同工作 – 每天 5 分钟玩转 OpenStack（24）

#### 设计思路

说那么多到底还是解耦，疯狂解耦  
然后各种抽象 API，疯狂增加项目体积  
再加入各种调度，最离谱的是居然默认用 MySQL  
当然对大型集群这都不算什么

> OpenStack 通用设计思路 – 每天 5 分钟玩转 OpenStack（25）

#### 组件

> Nova 组件详解 – 每天 5 分钟玩转 OpenStack（26）

flavor 就是 plan，选 VPS 配置

- Filter scheduler 是 nova-scheduler 默认的调度器

  1. 通过过滤器（filter）选择满足条件的计算节点
  2. 通过权重计算（weighting）选择在最优（权重值最大）的计算节点上创建 Instance

- RetryFilter 的作用是刷掉之前已经调度过的节点

- 为提高容灾性和提供隔离服务，可以将计算节点划分到不同的 Availability Zone 中

- RamFilter 将不能满足 flavor 内存需求的计算节点过滤掉

- DiskFilter 将不能满足 flavor 磁盘需求的计算节点过滤掉

- CoreFilter 将不能满足 flavor vCPU 需求的计算节点过滤掉

- ComputeFilter 保证只有 nova-compute 服务正常工作的计算节点才能够被 nova-scheduler 调度

- ComputeCapabilitiesFilter 根据计算节点的特性来筛选
  可以从 Metadata 中筛选架构之类的

- ImagePropertiesFilter 根据所选 image 的属性来筛选匹配的计算节点
  镜像也带 Metadata，可以限定比如只能运行在 kvm 上之类的

- ServerGroupAntiAffinityFilter 可以尽量将 Instance 分散部署到不同的节点上

- ServerGroupAffinityFilter 会尽量将 instance 部署到同一个计算节点上

nova-scheduler 的默认实现是根据计算节点空闲的内存量计算权重值：  
空闲内存越多，权重越大，instance 将被部署到当前空闲内存最多的计算节点上

> 看 Nova-Scheduler 如何选择计算节点 – 每天 5 分钟玩转 OpenStack（27）

每隔一段时间，nova-compute 就会报告当前计算节点的资源使用情况和自己的状态

这不就是微服务么，eureka 既视感

instance 的 launch、shutdown、reboot、suspend、resume、terminate、resize、migration、snapshot

> Nova-Compute 部署 Instance 详解 – 每天 5 分钟玩转 OpenStack（28）

#### 生命周期

OpenStack 的日志格式都是统一的，如下
`<时间戳><日志等级><代码模块><Request ID><日志内容><源代码位置>`

> 教你看懂 OpenStack 日志 – 每天 5 分钟玩转 OpenStack（29）  
> Launch 和 Shut Off 操作详解 – 每天 5 分钟玩转 OpenStack（30）  
> Start Instance 操作详解 – 每天 5 分钟玩转 OpenStack（31）  
> Nova reboot 和 lock 操作 – 每天 5 分钟玩转 OpenStack（32）  
> Terminate Instance 操作详解 – 每天 5 分钟玩转 OpenStack（33）  
> Pause/Resume Instance 操作详解 – 每天 5 分钟玩转 OpenStack（34）  
> Nova Suspend/Rescue 操作详解 – 每天 5 分钟玩转 OpenStack（35）  
> Snapshot Instance 操作详解 – 每天 5 分钟玩转 OpenStack（36）  
> Rebuild Instance 操作详解 – 每天 5 分钟玩转 OpenStack（37）  
> Shelve Instance 操作详解 – 每天 5 分钟玩转 OpenStack（38）  
> Unshelve Instance 操作详解 – 每天 5 分钟玩转 OpenStack（39）  
> Migrate Instance 操作详解 – 每天 5 分钟玩转 OpenStack（40）  
> Resize Instance 操作详解 – 每天 5 分钟玩转 OpenStack（41）  
> Live Migrate 操作 – 每天 5 分钟玩转 OpenStack（42）  
> 计算节点宕机了怎么办？Evacuate - 每天 5 分钟玩转 OpenStack（43）  
> 1 张图秒懂 Nova 16 种操作 – 每天 5 分钟玩转 OpenStack（44）

上面这一大堆操作都是属于遇到了现查来得更快，而且很多都浅显易懂，盲猜也能用个大概

---

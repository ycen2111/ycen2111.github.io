---
title: AHB
date: 2023-04-05 10:29:38
tags: 
- Hardware
- Logic gate
categories: 
- Hardware
---

ARB AHB (Advanced High-performance Bus) 总线协议，结构和控制信号分析。

<!-- more -->

# 总体结构
![001.png](001.png)
AHB主要由Master，Slave，Arbiter，Decoder四部分组成。特点为可以发送连续突发信号，加快传输效率（重点）。
AHB为主要的连接各个高性能外设的bus协议。

Master：主机，可以支持多主机，但只能有一个主机控制总线
Slave：从机，通过地址查询，返回成功，失败，和data数据
Arbiter：仲裁器，决定那个master可以控制总线。只有单个master可以没有arbiter
Decoder：翻译地址信号，选择给对应slave。

![002.png](002.png)
上图缺少一个从slave回master的由Decoder控制的MUX。

AHB to APB Bridge可以被看做AHB master向一个slave传输的过程，APB通常会处理一些低速任务，像IIC，interrupt，GPIO等

![003.png](003.png)

# Master主要信号
![004.png](004.png)

|信号|源信号|长度|介绍|
|:----|:----|:----|:----|
|HCLK|CLK|1|时钟信号|
|HRESETn|RESET|1|复位信号|
|HADDR[31:0]|output|32|输出地址信号|
|HWRITE|output|1|1表示master写入了data，0表示没写data|
|HTRANS[1:0]|output|2|传输的类型，00为IDLE，无信号传输需求，01为BUSY，表示在突发传输时空闲下一个周期（00和01必须要slaver马上返回一个okay信号），10为NONSEQ，表示开始突发或非突发传输，11为SEQ，为剩余的突发传输|
|HSIZE|output|3|每次传输的数据量|
|HBURST[2:0]|output|3|控制传输类型，如单一传输，回环突发，增量突发，多少长度等|
|HPROT[3:0]|output|4|保护slave信号，一般不使用（非cache时），可设置为0011挂空|
|HWDATA[31:0]|output|32|写数据|
|HRDATA[31:0]|slave|32|读数据|
|HSEL|decoder|x|选择目标slave信号（MUX）|
|HREADY|slave|1|为1时表示完成传输，如果为0则将此信号多打一拍|
|HRESP|slave|2|slave状态，如error，okay，retry（将重启传输，HREADY必须低电平），split等|

# Arbiter信号
![005.png](005.png)

|信号|源信号|长度|介绍|
|:----|:----|:----|:----|
|HGRANTx|output|1|为0时master不允许访问总线|
|HBUSREQx|master|1|传给arbiter，传递是哪个master|
|HLOCkx|master|1|霸占bus使用权|
|HMASTERx|output|n|指出哪个master占用bus|
|HMASTLOCK|output|1|指示正在被占位传输|

# 示例
![006.png](006.png)
T3之前为一次传输，T3之后为一次传输，之前为half-word 2byte，之后为full-word 4 byte，增量突发。
T4-T5 HREADY为低，所以delay了一拍
![007.png](007.png)
当RETRY信号发出后，如果HEADY为低，将会重复当前传输
![008.png](008.png)
ARBITER判决示例
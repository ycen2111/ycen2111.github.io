---
title: FPGA程序复现
date: 2023-05-08 22:01:46
tags: 
- 编程
- FPGA
- Conway生命游戏
categories: 
- 生命游戏
---

使用Verilog实现Conway生命游戏逻辑并使用VGA和鼠标显示并控制
基于BASYS3板，Vivado 2015.2版本开发
logbook过程记录

<!-- more -->

# 2023/05/06 (过时)
1. 设计了核心逻辑Core_logic.v并配套testbench文件，可测试reset，enter，output，和正常运行功能。
2. 已通过behavior simulation

Core_logic.v：
BIT_NUM: 长宽值的比特数，如长宽均为4，比特数为2

|port name|type|bits|comment|
|:----|:----|:----|:----|
|clk|input|1|clock cycle|
|reset|input|1|rset signal|
|enter|input|1|input new board figure|
|board_in|input|2**BIT_NUM**2|new board figure|
|board_out|output|2**BIT_NUM**2|simulated board output|

## 内部变量：
SIZE_SQUARE = |2**BIT_NUM**2
board[SIZE_SQUARE - 1:0] 为当前需要处理的图像，输出为board_out
next_board[SIZE_SQUARE - 1:0] 为board处理的下一次需要处理图像
past_board[SIZE_SQUARE - 1:0] 为保存的上一次图像，主要为neighbors判断下一次状态做准备
[3:0] neighbors [SIZE_SQUARE - 1:0] 为判断好的每个格子周围活着的cell数量，会在下一个cycle判断并存在next_board

## 主逻辑：
for循环遍历所有元素，判断是否为最上下左右，和四个角的位置，分9种不同的状态分析，存储在neighbors中
在下个个cycle根据neighbors中的值和past_board判断next_board
每个cycle都会将next_board赋值给board
如果为reset或enter，将其他值赋给board

![0506_01.png](0506_01.png)
![0506_02.png](0506_02.png)
注：I/O过高是因为所有board_in，board_out直接输入导致

# 2023/05/08 (过时)
1. 新增分频模块
2. 为core_logic增加pipeline分析 (core_logic_v1.v)

## 新增模块
最普通偶分频程序，输入系统clk输出分频lk

## 新发现问题
虽然可以综合16X16网格逻辑，但无法综合更大的逻辑（LUT占有率超100%）

### 改进方法
增加pipeline分析，每个posedge只会计算一行网格，在所有网格计算完成后输出finish信号并将next_board赋予board输出

### 改进结果
允许最多256X256网格分析（port最多允许10000000 bits array）并顺利综合
同时注意for循环不能将结束循环的值设置太大，即使像for(i=500; i=500+10; i=i+1)也会报错因为程序会认为循环数太多

![0508_01.png](0508_01.png)
![0508_02.png](0508_02.png)

# 2023/05/17
考试结束继续开发
复盘了之前的逻辑，发现大量的LUT浪费在判断neighbor数量的重复逻辑上，我们不需要如此快的运算效率
因此打算重写主逻辑，使用pipline来降低效率，同时增加可处理的数据数量

1. 覆写游戏核心逻辑，以支持pipline结构
2. 配置对应TB，确保综合结果有效
3. 整个module都使用parameter管理常量，方便之后变动

## 逻辑解释
module名：Find_neighbors
假设同时处理N*N个数据，
input：cell_in (N+2)*(N+2) //1-D 数组，左上角数据为最低位
output：cell_out N*N

程序会接收需要处理的N*N marix和额外围绕在这个matrix外一圈的数据，统一得到核心N*N元素的neighbor数量
如果一个核心N*N元素已经是角落和边上的数据，在它之外的数据会直接当0输入 (归一化)

## 数据轨迹
input -> cell_in -> neighbors -> new_cell -> output

从cell_in -> neighbors和neighbors -> new_cell都为时序逻辑，所以需要2 cycles来得到对应的数据

## 结果
输入：cell_in = 25'b0000001110011100111000000;
![0517_01.png](0517_01.png)
![0517_02.png](0517_02.png)

# 2023/05/18

1. 继续编写Find_neighbors配套上层调用逻辑
2. 使用FSM控制整体逻辑
3. 编写配套TB，确认综合可用

## 核心逻辑
module名：Logic_manager
input：enter信号，当前matrix需要的ROW，COLUMN，新输入的点的row_in，column_in值
output：未定，暂时输出cell_out

curr_cell,next_cell[][]：主要存储各cell状态的2-D数组

### FSM状态：
1. IDLE：初始化状态，如果收到RESET就会回归此处。初始化next_cell。如enter为1则转ENTER，否则转OVERWRITE
2. ENTER：更新个别cell状态。如果enter为1则将next_cell[row_in][column_in]赋值为1，否则转OVERWRITE
3. OVERWRITE：将next_cell的值赋给curr_cell。由于是2-D matrix所以要很久。之后可以根据空闲资源加快此效率。完成后转RUNNIGN_1
4. RUNNING_1：管理Find_neighbors pipline的前两个状态。对Find_neighbors的控制分三步进行：
    第一步，只有input没用output，此步有2 cycles
    第二部，同时有input和output，此步持续到所有data全部输入
    第三步，只有output没用input，此步有2 cycles

    RUNNING_1管理所有输入并标记可以输出的时间点。举个3*3核心数据（5*5总数据）例子：

    |0|1|2|3|4|
    |:----|:----|:----|:----|:----|
    |5|6|7|8|9|
    |10|11|12|13|14|
    |15|16|17|18|19|
    |20|21|22|23|24|

    如果每次输入Find_neighbors数据是4*4数据，第一次会输入0到18这个正方形内数据，下一个cycle输入1-19正方形数据（因为这是最少的完全包含核心数据的方法），之后类推是5-23，6-24数据。
5. RUNNING_2: 管理Find_neighbors pipline的最后一个状态，接收所有数据后转回OVERWRITE

## 未完成目标
1. 暂停功能，即把程序在完成一次运算后暂停的能力
2. 在开始运算后还能不经过RESET enter新数据的能力
3. LUT占用超出预期，需要调整

## 结果
此处的X为未使用的占位内存，可以在大小需求不大时节省运算资源
![0518_01.png](0518_01.png)
过高的LUT，问题出在generate block赋值不严谨，需再次调整
![0518_02.png](0518_02.png)

# 2023/05/19
1. 理解VGA端口工作原理与设置
2. 规划VGA数据传输方式

## VGA原理
VGA主要还是sweep的方式逐行逐帧更新屏幕

|端口|作用|
|:----|:----|
|CLK|时序信号|
|HS|水平信号，可以粗粗理解为列的enable|
|VS|垂直信号，可以粗粗理解为行的enable|
|R[7:0]|红色，VGA端口为相应的模拟信号，下面同理|
|G[7:0]|绿色|
|B[7:0]|蓝色|

总体来说，当HS和VS给出信号后，VGA会自己读取相应时间下对应的颜色，并输出到屏幕上。
VGA会逐行读取，直到完成一帧
![0519_01.png](0519_01.png)
已上图来说，HS在96 cycles后会变高电平，VS在2 cycles后变为高电平，
但只有在HS和VS都在有效显示范围内，才会读取当时的颜色并输出
如，HS=96+48， VS=2+33时才会按当时输出的RGB颜色输出第一个点

## 传输规划
1. 由于在真正VGA输出前有一段空闲时间，可以利用这段时间更新显示内容
2. 所以可以初步计划在VGA显示的时候计算下一步的cell，并在上一帧更新完之后再将新的图像信息输入VGA
3. 这个项目不会用到太多颜色，应该双色就可以解决。所以显存或许可以定为480X640数组，如果需要多种颜色就之后再说
4. 并且由于显示器最大也只有480X640像素，总画布（cell数）不可能太大，导致1-D数组也可以完美记录所有数据，所以计划还是Logic_manager内cell变换为1-D数组，这又会加快运行效率（不必考虑2-D数组复杂的赋值）

总之，昨天有一部分又白写了，早知道先看这一块了 :(
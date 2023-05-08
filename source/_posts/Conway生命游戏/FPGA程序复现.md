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

# 2023/05/06
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

# 2023/05/08
1. 新增分频模块
2. 为core_logic增加pipeline分析 (core_logic_v1.v)

## 新增模块
最普通偶分频程序，输入系统clk输出分频lk

## 主要问题
虽然可以综合16X16网格逻辑，但无法综合更大的逻辑（LUT占有率超100%）

## 改进方法
增加pipeline分析，每个posedge只会计算一行网格，在所有网格计算完成后输出finish信号并将next_board赋予board输出

## 改进结果
允许最多256X256网格分析（port最多允许10000000 bits array）并顺利综合
同时注意for循环不能将结束循环的值设置太大，即使像for(i=500; i=500+10; i=i+1)也会报错因为程序会认为循环数太多

![0508_01.png](0508_01.png)
![0508_02.png](0508_02.png)
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

# 2023/05/22
又出问题了，昨天新写的代母估计又要修改
先说问题，大概率cell的数据需要存到memory内，否则LUT占比巨大（仅 32X32 cell 就占了57% LUT）

1. 改进了原逻辑下的FSM流程
2. 综合后分析波形并订正冲突
3. 分析LUT占比过高原因
4. 测试了memory和LUT记录数据后综合的结果

## 原逻辑改进
主要是更改了RUNNING_1的三步状态，删除了原记录pipline步数的变量，改为左移一个array
如：最开始为一个2bits array：[1:0] mark, 初始化为2'b00。如果有输入find_beighbors就赋值mark[0] = 1，并在下cycle一开始左移一位
如果mark内有位数为1则说明find_neighbors还在运算，否则说明运算完成

这个方法可以稍微节省一点点资源（但可读性大大下降 （尴尬））

## 综合冲突
将RTL综合后发现输出cell为X，反推逻辑发现是赋值造成的问题。curr_cell在default内是非阻塞赋值，FSM内是阻塞赋值导致冲突。前后统一后问题解决
此问题原因是更改逻辑时未完全更改所有变量。之后应该尝试使用search，可以此类错误出现概率会小些

同时发现LUT占比更加夸张，如果还保持16X16 find_neighbors会达到256% LUT占用。
查看schemetic发现基本LUT消耗在curr_cell上，此问题涉及数据存储的原理

## 数据设置与类型
verilog中可以用两种方法设置array：
1. [5 : 0] array
2. [0 : 0] array [5 : 0]

以上两种存储数据大小相同，区别在1.是直接存在LUT内，2.存在memory（BRAM）内。
1可以很方便的对所有数据统一处理，但问题在如果array巨大（如 4000+），那么会消耗海量资源（密密麻麻全是赋值比对的）。
2可以共用一套逻辑，但问题在覆写数据麻烦，需要一个个赋值

下面是分别用两种方法读取或写入数据的综合对比

### [5 : 0] array
``` bash
module Cell_mem#(
    parameter MAX_ROW_BITS = 5, //512
    parameter MAX_COLUMN_BITS = 5, //512
    parameter MAX_ROW = 2 ** MAX_ROW_BITS,
    parameter MAX_COLUMN = 2 ** MAX_COLUMN_BITS
    )(
    input CLK,
    input RESET,
    input W_enable,
    input [MAX_ROW_BITS + MAX_COLUMN_BITS - 1 : 0] address_in,
    input data_in,
    input [MAX_ROW_BITS + MAX_COLUMN_BITS - 1 : 0] address_out,
    output reg data_out
    );
    
    reg [MAX_ROW * MAX_COLUMN - 1 : 0] Mem_1;
    
    always @(posedge CLK) begin
        if (W_enable)
            Mem_1[address_in] <= data_in;
    end
    
    always @(posedge CLK) begin
        data_out <= Mem_1[address_out];
    end
    
endmodule
```
![0522_03.png](0522_03.png)
![0522_04.png](0522_04.png)

### [0 : 0] array [5 : 0]
``` bash
odule Cell_mem#(
    parameter MAX_ROW_BITS = 5, //512
    parameter MAX_COLUMN_BITS = 5, //512
    parameter MAX_ROW = 2 ** MAX_ROW_BITS,
    parameter MAX_COLUMN = 2 ** MAX_COLUMN_BITS
    )(
    input CLK,
    input RESET,
    input W_enable,
    input [MAX_ROW_BITS + MAX_COLUMN_BITS - 1 : 0] address_in,
    input data_in,
    input [MAX_ROW_BITS + MAX_COLUMN_BITS - 1 : 0] address_out,
    output reg data_out
    );
    
    reg [0:0] Mem [MAX_ROW * MAX_COLUMN - 1 : 0];
    
    always @(posedge CLK) begin
        if (W_enable)
            Mem[address_in] <= data_in;
    end
    
    always @(posedge CLK) begin
        data_out <= Mem[address_out];
    end
    
endmodule
```
![0522_01.png](0522_01.png)
![0522_02.png](0522_02.png)

### 总结
后一种占用资源明显减少，结构也更简单
所以还是要更改find_neighbors驱动

现在暂时有两个修改方案，1.是memory每一行有8个数据（2-D数组），分别是一个cell周围一圈的neighbor，方便直接计算neighbor数量，但保存的数据会巨大
2.是保持原样每行1个数据（就是1-D数组），直接读取所有需要的cell。逻辑会更复杂，但应该更省心

# 2023/05/23
先说结构，最后打算采用16bits为一组的16列sweep读取计算方式
如详细编码方式之后编写数据传输时会解释，这里主要记录memory控制方法

需要注意的是所有memory都会有一个备用存储空间，用来暂时记录下一步matrix会显示的数据

1. 编写memory读写逻辑
2. 编写memory driver控制逻辑
3. 通过testbench并成功综合

## memory读写逻辑

存储memory：
reg [15:0] Mem [2 ** (MAX_ROW_BITS + MAX_COLUMN_BITS - 4) - 1 : 0];
每条数据存储16位，因为16bits为memory单block可支持最大bits
一共有MAX_ROW*MAX_COLUMN/16条数据

|type|bits|name|description|
|:----|:----|:----|:----|
|input|1|CLK|时钟|
|input|1|RESET|复位|
|input|1|W_enable|允许写入|
|input|[2 ** (MAX_ROW_BITS + MAX_COLUMN_BITS - 4) - 1 : 0]|data_in_add|写入地址|
|input|[15 : 0]|data_in|写入数据|
|input|[2 ** (MAX_ROW_BITS + MAX_COLUMN_BITS - 4) - 1 : 0]|data_out_add|读出地址|
|output|reg [15 : 0]|data_out|读出数据|

如果RESET， Mem会将自己覆写为"Mem.txt"内数据
如果W_enable，Mem[data_in_add] 会覆写为 data_in
无论何时data_out 都为输出 Mem[data_out_add]

## memory driver逻辑
主要处理两件事，将输入的横纵坐标转化为mem的id，和控制两个memory各自读写权限

|type|bits|name|description|
|:----|:----|:----|:----|
|input|1|CLK|时钟|
|input|1|RESET|复位|
|input|1|W_enable|允许写入|
|input|1|finish|一帧matrix计算完成|
|input|[MAX_ROW_BITS - 1 : 0]|row_in|写入数据的行坐标|
|input|[MAX_COLUMN_BITS - 1 : 0]|column_in|写入数据的纵坐标|
|input|[15 : 0]|data_in|写入数据|
|input|[MAX_ROW_BITS - 1 : 0]|row_out|输出数据的行坐标|
|input|[MAX_COLUMN_BITS - 1 : 0]|column_out|输出数据的纵坐标|
|output|[15 : 0]|data_out|读出数据|

### 坐标转化
row_in和column_in会转换为data_in_add传给memory，
data_in_add = {column_in[4 +: MAX_ROW_BITS - 4], row_in} //(column/16)*MAX_ROW+row

![0523_01.png](0523_01.png)
memory id的摆列如图所示，如row=0，column=1，data_in_add就是1
如row=17，column=1，data_in_add就是7

### 读写权限sweep
考虑到每次计算完一帧matrix后需要把整个matrix从temp覆写到real matrix上，对memory来说过于复杂，
因此计划实例化两个memory_cell分别交替进行读写操作
此步骤由变量switch负责，

|switch|mem_1|mem_2|
|:----|:----|:----|
|1|write|read|
|0|read|write|

switch会在检测到finish信号上升沿后变化

## 结果
![0523_02.png](0523_02.png)

在512X512数据下已经占用32%BRAM，考虑到需要给VGA显存保留空间，在不改变逻辑前提下最大的matrix size可能只能达到512*1024

# 2023/05/26
1. 编写了VGA显存逻辑和支持
2. 配套鼠标和7-segments显示
3. 上板子测试通过

## VGA显存逻辑
VGA显存设计为1024X512大小RAM存储，每次只能保存或读取一bit数据
直接通过VGA address存读数据

## VGA reader逻辑
根据05.19内的VGA显示逻辑，控制FPGA在当前时序内读取显存内存储的数据，并输出对应颜色。
注意必须在25MHz下设置VGA逻辑，否则会无法显示
![0526_01.png](0526_01.png)
已通过在现存内设置初始值来测试单个点显示功能

## 配套鼠标和7-segments
利用之前microprocessor内轮子，直接嵌套模块
将鼠标原本8bits数据输出转换为12bits输出，方便显示480X640像素坐标
将原本7-segments的左右各输出x，y坐标，改为只显示x或y坐标，并通过外部控制切换，方便完全显示数据

暂时设置为鼠标按下时显示鼠标路径，测试模拟VGA数据改变。测试成功

## 结果
图片忘拍了，之后补上

# 2023/05/29
几天的内容一起补上，实现了VGA显示cell图像，加鼠标控制的逻辑

1. 实现了VGA显示保存的matrix图像
2. 可以用上下键控制单个cell大小
3. 可以用鼠标中键移动画布
4. 可以用鼠标左键点亮新的cell
5. 可以用鼠标右键按灭cell

## VGA写入
因为在每次开始VGA显示前总有一段时间是没用显示的，可以乘此机会写入buffer下一帧VGA的数据
但这个间隔时间又不够完全写入（大概只能写入一半的数据），但因为VGA的读取速度远小于写入速度（VGA clk为25Mhz，写入频率为100Mhz）
所以可以在上一帧完成显示后开始写入下一帧，直到写入完成
在此过程中会出现buffer前面在读取，后面在写入的情况，不过不需要担心
![0529_01.png](0529_01.png)
倒数第二行是写入数据，最后一行是读取数据

## VGA像素生成
这一块用了pipline方法，每一个clk查询写入一个像素
因为查询cell的状态需要一个cycle，所以记得注意相关时序问题

而从VGA像素转换到cell坐标需要以下数据：
1. 单个cell长度 cell_length
2. 最左上角那个点相比（0，0）的偏移像素值 start_row/column_pixcle
3. 当前扫到的VGA绝对位置 curr_screen_row/column

当前VGA像素所代表的cell坐标可以计算为：
cell_coordinate = (curr_screen_row/column + start_row/column_pixcle) / cell_length

注：当前鼠标所在像素所代表的cell坐标也可以这么转换

## 调整单个cell大小
FPGA板子上的上下键可以将cell_length左移/右移一位，来更改cell大小

cell最大为64像素，最小为1像素

## 平移画布
当按下鼠标中键时可以拖动画布
这是通过改变start_row/column_pixcle的值实现的

当鼠标中键按下时，可以以像素级的精度平移画布
![0529_02.png](0529_02.png)

## 增加/消除cell
按下鼠标左键/右键可以分辨添加/消除cell的颜色

注意，需要将enter开关关掉才能输入（只有在停止matrix迭代时才能手动变化cell）

## 总结
至此VGA方面的逻辑已基本完成，VGA和cell memory之间的连接也已实现
BRAM的利用率已经尽可能调到最大，现在最大可支持1024X512的matrix
之后只要把主逻辑的功能进行完善进行
![0529_03.png](0529_03.png)
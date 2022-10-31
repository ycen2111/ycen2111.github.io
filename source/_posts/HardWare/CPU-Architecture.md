---
title: CPU Architecture
date: 2022-09-01 16:40:41
tags: 
- Hardware
- Logic gate
categories: 
- Hardware
---

从NAND开始构建所有基础logic gate并且最终完成一个turing complete的基础的，可编程的计算机结构。基于游戏turing complete。

<!-- more -->
# Basic Logic
![Basic_Logic](basic_logic.png)
## Crude Awakening
![1.1](1.1.png)

|Input|Output|
|:----|:----|
|1|1|
|0|0|

Input=Output

基础连接教程
## NAND Gate
![1.2](1.2.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|1|
|0|1|1|
|1|0|1|
|1|1|0|

(Input1*Input2)=Output

## NOT Gate
![1.3](1.3.png)

|Input|Output|
|:----|:----|
|1|0|
|0|1|

Input'=Output

## AND Gate
![1.4](1.4.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|0|
|0|1|0|
|1|0|0|
|1|1|1|

Input1*Input2=Output

## NOR Gate
![1.5](1.5.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|1|
|0|1|0|
|1|0|0|
|1|1|0|

(Input1+Input2)'=Output

## OR Gate
![1.6](1.6.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|1|

Input1+Input2=Output

## Always On
![1.7](1.7.png)

|Input|Output|
|:----|:----|
|1|1|
|0|1|

1=Output

## Second Tick
![1.8](1.8.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|0|
|0|1|0|
|1|0|1|
|1|1|0|

Input1*Input2'=Output

## XOR Gate
![1.9](1.9.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|0|
|0|1|1|
|1|0|1|
|1|1|0|

Input1*Input2'+Input1'*Input2=Output

## Bigger OR Gate
![1.10](1.10.png)

Input1+Input2+Input3=Output

## Bigger AND Gate
![1.11](1.11.png)

Input1*Input2*Input3=Output

## XNOR Gate
![1.12](1.12.png)

|Input1|Input2|Output|
|:----|:----|:----|
|0|0|1|
|0|1|0|
|1|0|0|
|1|1|1|

(Input1*Input2'+Input1'*Input2)'=Output

# Arthmetic
![Arthmetic_Memory.png](Arthmetic_Memory.png)

## Binary Racer
None

## Double Trouble
![2.2](2.2.png)

输出1如果大于或等于2个inputs为1

## ODD Number of Signals
![2.3](2.3.png)

输出1如果1个或3个inputs为1

## Counting Signals
![2.4](2.4.png)

输出inputs为1的terminal的数量。output是3 bits输出，可为000， 001， 010， 011， 100
1.首先由ODD Number of Signals决定最后一位
2.再由Double Trouble找出大于等于2的情况，并和(3.)连接一个XOR去除找出全为1的情况
3.将4个terminals用and连接找出全为1的情况

## Half Adder
![2.5](2.5.png)

|Input1|Input2|Sum|Carry|
|:----|:----|:----|:----|
|0|0|0|0|
|0|1|1|0|
|1|0|1|0|
|1|1|0|1|

统计Input True数量，只有两个Inputs的Counting Signals
Sum: 个位
Carry: 十位

## Double the Number
![2.6](2.6.png)

Bits Shift Left

## Full Adder
![2.7](2.7.png)

|Input1|Input2|Input3|Sum|Carry|
|:----|:----|:----|:----|:----|
|0|0|0|0|0|
|0|0|1|1|0|
|0|1|0|1|0|
|0|1|1|0|1|
|1|0|0|1|0|
|1|0|1|0|1|
|1|1|0|0|1|
|1|1|1|1|1|

统计Input True数量，只有三个Inputs的Counting Signals
Sum: 个位
Carry: 十位

## Byte OR
![2.8](2.8.png)

暴力堆叠

## Byte NOT
![2.9](2.9.png)

## Adding Byte
![2.10](2.10.png)

## Negative Numbers
None

## Signed Negator
![2.12](2.12.png)

转负数

## 1 bit decoder
![2.13](2.13.png)

1 bit解码器，将两种情况分别用两个output terminals输出

## 3 bit decoder
![2.14](2.14.png)
3 bit解码器，计算机设计最常用的器件之一，可以很方便的解码program coding，特别是分析opcode的指令

## Logic Engine
![2.15](2.15.png)

3 bits解码器简单应用，用decoder控制输出的数据是or nor and nand这四种里的一种情况

# Memory

![Arthmetic_Memory.png](Arthmetic_Memory.png)

## Circular Dependency

None

## Delayed Lines
![3.2](3.2.png)

过一个tick输出上一个tick内容

## Odd Ticks
![3.3](3.3.png)

在奇数tick才会输出1

## Bit Switch
![3.4](3.4.png)

使用一个可选择开关的component

## Bit Inverter
![3.5](3.5.png)

只有两个inputs不一样才会输出1

## Input Selector
![3.6](3.6.png)

根据上边input bit来选择输出下边那个数据

## Bus
![3.7](3.7.png)

设计一种总线来统一转递数据和控制数据传递

## Saving Gracefully
![3.8](3.8.png)

上边是save，下边是value，当save为1时更新output为value的值，1 bit memory, register的基础

## Saving Bytes
![3.9](3.9.png)

用1 bit memory来保存1 byte的数据

## Little Box
![3.10](3.10.png)

最上边两个为loading and saving，然后是选择A/B和0/1，并最终定位到四个register中的一个，来操作saving或loading操作

## Counter
![3.11](3.11.png)

平时每过一个tick就加1，如果overwrite为1就直接写入input的数值，之后program时用来读取程序的component

# CPU Architecture
![CPU_Architecture](CPU_Architecture.png)

## Arithmetic Engine
![4.1](4.1.png)

最上边的是1 byte输入，通过不同的输入分别输出不同的运算结果

|Input|Operation|
|:----|:----|
|0|OR|
|1|NAND|
|2|NOR|
|3|AND|
|4|ADD|
|5|SUB|

## Register
![4.2](4.2.png)

3输入分别为loading，saving和saved value。输出的话上边的output只有在loading为1时才输出，下边在任何时候都会输出

## Decoder
![4.3](4.3.png)

3 bits decoder的简单应用

## Calculations
![4.4](4.4.png)

Arithmetic Engine的扩展运用，基本一致

|Input|Operation|
|:----|:----|
|0|OR|
|1|NAND|
|2|NOR|
|3|AND|
|4|ADD|
|5|SUB|
|6|XOR|

## Conditions
![4.5](4.5.png)

根据上边的输入选择不同的判断条件，如果输入符合就输出1，不符合输出0。类似if的判断逻辑

|Input|Condition|
|:----|:----|
|0|NEVER(Always off)|
|1|=0|
|2|<0|
|3|<=0|
|4|ALWAYS(Always on)|
|5|!=0|
|6|>=0|

## Turing Complete
![4.6](4.6.png)

一个可以编程的可运算图灵完备的结构，配备program ram，counter，6 registers，compute，condition。
任何将saving，loading，或calculation的值都会先输入到一个bus内统一调取。
每个program里的数据为1 byte，最后两位控制这个数据的类型并由DEC解码和控制：

|bits(7 and 8 bit)|type|
|:----|:----|
|00|IMMEDIATE|
|01|COMPUTE|
|10|COPY|
|11|CONDITION|

### 10
两个3 bits decoders分别控制6个registers，input and output的loading和saving操作
如指令 10 110 001 意思是将input and output 里的数据复制到reg1里

|VALUE(1-3bits for saving, 4-6bits for loading)|component|
|:----|:----|
|0|reg0|
|1|reg1|
|2|reg2|
|3|reg3|
|4|reg4|
|5|reg5|
|6|input and output|

### 00
如果为00，将直接将前6位bits写入reg0，直接disable 2个3 bits decorders，并将value直接saving进reg0内
如 00 000 010 将直接在reg0内写入数值2
注意这个方法只能最大写入2^6=64到reg0内

### 01
如果为01，ALU将被enabled并根据1-3 bits判断计算方式，如之前的Calculations：

|Input|Operation|
|:----|:----|
|0|OR|
|1|NAND|
|2|NOR|
|3|AND|
|4|ADD|
|5|SUB|
|6|XOR|

reg1和reg2内的数值将分别当作input1和input2，并将result自动存入reg3内
如 01 000 100 将自动把reg1和reg2内的值相加，并存储到reg3内

### 11
如果为11，机器将根据COND里的逻辑分析1-3 bits：

|Input|Condition|
|:----|:----|
|0|NEVER(Always off)|
|1|=0|
|2|<0|
|3|<=0|
|4|ALWAYS(Always on)|
|5|!=0|
|6|>=0|

机器将自动读取reg3内的值输入，如果条件成立，会自动loading reg0内的值并赋值给counter来达到跳转的效果，类似if语句内达到条件就运行新语句的效果
如 11 000 100 就会一直将reg0内的值赋予counter，做到汇编内JMP的效果

### program example

|Name|code|
|:----|:----|
|MOV|10 000 000|
|from_REG1|00 001 000|
|to_REG1|00 000 001|
|AND|01 000 011|
|JMP|11 000 100|

``` Bash
//计算一个数除以4后的余数，可以将这个数和3进行AND操作来计算
//如 7%4=0000 0111 & 0000 0011=0000 0011=3
label loop //标记一个标签点

3 //将3写入reg0
MOV+REG0+to_REG1 //将reg0的值复制到reg1
MOV+INPUT+to_REG2 //将输入的值复制到reg2
AND //将reg1和reg2内的值进行byte AND操作，输入reg3
MOV+from_REG3+OUTPUT //将reg3的值输出到output

loop //将loop标记点的地址写入reg0
JMP //always condition，每次都会将reg0内的值写入counter进行转跳
```

一行代码可以选择将不同的命令相加来达到灵活编程的目的，如MOV+REG0+to_REG1=10 000 000+00 000 000+00 000 001=10 000 001=将reg0内的值复制到reg1
---
title: Digital System Design
date: 2023-02-13 11:35:19
tags:
 - 2022-2023
categories: 
 - academic material
---

<!-- more -->

# Clock time calculation
![001.png](001.png)
• Clock period (clock cycle time)
• Clock frequency (clock rate) = 1/Clock period
• Clock Cycle Time = 1/Clock rate
• CPU Time = CPU Clock Cycles * Clock Cycle Time
• Clock Cycles = Instruction Count * Cycles per Instruction (CPI)
note: if there have multiple IC and CPI, final clock cycles is their summ result

# Risc V code
Risc V Green Code: https://pipirima.top/2022-2023/RISC-V-green-card-d1b1771d8486/
![002.png](002.png)

opcode: operation code
rd: destination register number
funct3: 3-bit function code (additional opcode)
rs1: the first source register number
rs2: the second source register number
funct7: 7-bit function code (additional opcode)

## R type
add x9,x20,x21

|funct7|rs2|rs1|funct3|rd|opcode|
|:----|:----|:----|:----|:----|:----|
|0|21|20|0|9|51|
|7 bit|5 bit|5 bit|3 bit|5 bit|7 bit|
|000 0000|1 0101|1 0100|000|0 1001|011 0011|

## I type
lw x9,32(x22) -> load X9 by the data from x22[8] //32/4=8

|immediate|rs1|funct3|rd|opcode|
|:----|:----|:----|:----|:----|
|32|22|2|9|3|
|12 bit|5 bit|3 bit|5 bit|7 bit|
|0000 0010 0000|1 0110|010|0 1001|000 0011|

## S type
sw x9,32(x22) -> save x9's data into x22[8]

|imm[11:5]|rs2|rs1|funct3|imm[4:0]|opcode|
|:----|:----|:----|:----|:----|:----|
|1|9|22|2|0|23|
|7 bit|5 bit|5 bit|3 bit|5 bit|7 bit|
|000 0001|0 1001|1 0110|010|0 0000|001 0111|

imm=32=0000 0010 0000

## U type
lui x19, 976 

|Immediate [31:12]|rd|opcode|
|:----|:----|:----|
|976|19|55|
|20 bit|5 bit|7 bit|
|0000 0000 0011 1101 0000|1 0011|011 0111|

note: U type can read upeer 20 bits from register, if some data is in total 32 bits

## SB type
bne x10, x11, 2000

|Imm [12]|Imm [10:5]|rs2|rs1|funct3|Imm [4:1]|Imm [11]|opcode|
|:----|:----|:----|:----|:----|:----|:----|:----|
|0|62|11|10|1|8|0|51|
|1 bit|6 bit|5 bit|5 bit|3 bit|4 bit|1 bit|7 bit|
|0|11 1110|0 1011|0 1010|001|1000|0|110 0011|

imm=2000=0111 1101 0000

Target address = PC + immediate
eg. if this code is in address X20, new jumped add=20+2000=x2020

## UJ type
jal x1, 2000

|Imm [20]|Imm [10:1]|Imm [11]|Imm [19:12]|rd|opcode|
|:----|:----|:----|:----|:----|:----|
|0|62|0|0|1|111|
|1 bit|10 bit|1 bit|8 bit|4 bit|7 bit|
|0|11 1110 1000|0|0000 0000|0 0001|110 1111|

imm=2000=0111 1101 0000

## basic srchitecture structure
![003.png](003.png)
each operation will only part of these terminals

![004.png](004.png)
![005.png](005.png)
![006.png](006.png)
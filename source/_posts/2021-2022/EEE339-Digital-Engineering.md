---
title: EEE339 Digital Engineering
date: 2021-09-27 14:09:24
tags:
 - 2021-2022
categories: 
 - academic material

password: frank
---
# week1

## Application Specific Integrated Circuits(ASICS)

ASICs are silicon chips that have been designed for a specific purpose

### Full Custom Design
- the highest performance
- the most expensive and time consuming to produce

### Semi-Custom Design
for Gate Array:
- predefined on silicon wafer
- need to define the interconnections for final device

for Standard Cell:
- predefined functional blocks improve layout density and performance.

### Field Programmable Gate Array (FPGA)
- contain configurable logic resources and memory
- are most useful for prototyping and can be cost effective for low volume production runs.

![101.PNG](101.PNG)

Software tools enable users to enter designs, simulate them to ensure correct functionality and then synthesize a solution for a chosen target device.

## Verilog

### Basic structure

The module body describes the functionality of the model and the relationship between the input and output ports. 
![102.PNG](102.PNG)

The keyword wire is used to declare internal signals. For example:
![103.PNG](103.PNG)
``` Bash
module Add_full(output c_out, sum, input a, b, c_in);
	wire w1, w2, w3;
	Add_half M1(w2, w1, a, b);
	Add_half M2(w3, sum, c_in, w1);
	or (c_out, w3, w2);
endmodule
```

### User Defined Primitives (UDP)

The module descripted by truth table

![104.PNG](104.PNG)
``` Bash
primitive mux_21_udp(output f, input s, a, b);
	table
		// s a b : f 
		0 0 ? : 0 ; //(? means not care)
		0 1 ? : 1 ; 
		1 ? 0 : 0 ;
		1 ? 1 : 1 ;
	endtable
endprimitive
```

### Port mapping

Another writing format can not stricly follow the variables' order.

When the number of ports grows larger, it is easier to associate ports by their names.

``` Bash
Add_half M1 (.b(b), .c_out(w2), .a(a), .sum(w1));
```

# Week2

## delay module

Propagation delay: time from the input changing to the output responding.

Inertial delay model(for components): changes to the output of ogic gates can not happen instantly due to the charging and discharging of capacitances.(6ps)
If the width of an input pulse is shorter than the inertial delay, the input pulse is supressed and the output will not change in response to it.

Transport delay model(for wire): Time taken for a signal to propagate alonga wire.(1ps)

![201.PNG](201.PNG)

``` Bash
Example:
`timescale 10ps / 1ps //<time_unit>/<time_precision>
module timedelay (f, a ,b);
input a, b;
output f;
nand #2.58 (f, a, b);
endmodule
```
#2.58=2.58*10ps=25.8ps rounded to 26ps

## four-value logic system

1 – assertion (True)
0 – de-assertion (False)
x – unknown (ambiguous)
z – high impedance (disconnected from driver)

nets: build connections but not store values, like wire.
registers: store value and informations

# Week3

## Register file
The registers in a CPU can be grouped into a register file. Two outputs are supplied in order to feed the ALU.
![301.PNG](301.PNG)

## shifter

standard bidirectional shift register: A multiplexer on each input gives a choice of left shift, right shift, parallel load and no-shift, by selecting the source of the D input appropriately.
![302.PNG](302.PNG)

Combinational Shifter: shift data using multiplexers. B1,2,3 is input and H1,2,3 is output.
![303.PNG](303.PNG)

Barrel Shifter: The circuit rotates its contents left from 0 to 3 positions depending on S
![304.PNG](304.PNG)
---
title: Vivado tutorial
date: 2022-12-19 12:40:59
tags: 
- APP
- FPGA
categories: 
- FPGA
---

# 介绍

关于如何使用Vivado编写Verilog, 仿真，综合，上板子教程

<!-- more -->

# start
1. Create new programe -> Next -> set project name and address
2. select Project types: RTL Project: the most common project type, design Verilog or VHDL programe. have IP integrator, generate IP, RTL analysis, synthesis, implementation, design planning
3. Create new source, can be ignored
4. default
5. Define module, click "bus" if have multi-bits data stream

# add files
1. File -> add sources -> add or create design source -> "+" -> add file -> enter file name and press OK -> finish
![001.png](001.png)
2. set port names. click "Bus" is this port has multi-bits -> OK
3. new file will be generated
![002.png](002.png)

``` Bash
`timescale 1ns / 1ps

module test(
    input rst,
    input clk,
    output [3:0] cmd
    );
    
reg [3:0] value=0;
    
assign cmd=value;
    
always@ (posedge clk or negedge rst) begin
    if (!rst) begin
        value<=0;
    end
    value<=value+1;
end
    
endmodule

```

# add testbench and simulation
1. File -> add sources -> add or create simularion source -> "+" -> add file -> enter file name and press OK -> finish
2. set reg and wire
3. set initial
4. import source and set all variables
5. the imported source file will be folded under testbench.
![003.png](003.png)
6. to set top simulation file: 
![004.png](004.png)
7. left bar, Simulation -> run simulation

``` Bash
`timescale 1ns / 1ps

module test_bench();

reg clk;
reg rst;
wire [3:0] cmd;

always #10 clk=!clk;

test UUT (
    .rst(rst),
    .clk(clk),
    .cmd(cmd)
    );
    
initial begin
    rst=0; clk=0;
    #40 rst=1;
end

endmodule

```
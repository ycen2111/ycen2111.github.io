---
title: FSM 状态机
date: 2022-12-19 12:32:48
tags: 
- 编程
- FPGA
- HDL
categories: 
- FPGA
---

# 介绍

Mealy, Moore状态机；一，二，三段式状态机代码

<!-- more -->

# Mealy and Moore
Mealy状态机：时序逻辑的输出不仅取决于当前状态，还与输入有关；
Moore状态机：时序逻辑的输出只与当前状态有关。

# test bench
``` Bash
`timescale 1ns / 1ps

module FSM_test();

reg clk=1'd0, rst=1'd0, in=1'd0;

wire [2:0] out;

always #10 clk=!clk;

One_part UUT (
    .clk(clk),
    .rst(rst),
    .in(in),
    .out(out)
    );

initial begin
    #40 rst=1'd1;
    #40 in=1'd1;
    #80 in=1'd0;
    #40 in=1'd1;
    #40 in=1'd0;
end

endmodule

```

# 一段式
只有一个always block，把所有的逻辑（输入、输出、状态）都在一个always block的时序逻辑中实现
但是不利于维护
![001.png](001.png)
``` Bash
`timescale 1ns / 1ps

module One_part(
    input clk, rst,
    input in,
    output [2:0] out
    );
    
reg [1:0] state=2'd0;
reg [2:0] out_d=3'd0;

assign out=out_d;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        state <= 2'd0;
    end
    
    else begin
        case (state)
            2'd0: begin
                if (in) begin //输入
                    state <= 2'd1; //判断
                    out_d <= 3'd2; //输出
                end
                else begin
                    state <= 2'd1;
                    out_d <= 3'd0;
                end
            end
            
            2'd1: begin
                if (in) begin
                    state <= 2'd2;
                    out_d <= 3'd3;
                end
                else begin
                    state <= 2'd0;
                    out_d <= 3'd8;
                end
            end
            
            2'd2: begin
                if (in) begin
                    state <= 2'd3;
                    out_d <= 3'd4;
                end
                else begin
                    state <= 2'd2;
                    out_d <= 3'd7;
                end
            end
            
            2'd3: begin
                if (in) begin
                    state <= 2'd1;
                    out_d <= 3'd5;
                end
                else begin
                    state <= 2'd2;
                    out_d <= 3'd6;
                end
            end
            
            default: state <= 2'd0;
        endcase
    end
end

endmodule
```

# 二段式
有两个always block，把时序逻辑和组合逻辑分隔开来。时序逻辑里进行当前状态和下一状态的切换，组合逻辑实现各个输入、输出以及状态判断。
可能存在竞争和冒险，产生毛刺
把第二和第三段合在一起
![002.png](002.png)

``` Bash
`timescale 1ns / 1ps

module two_parts(
    input clk, rst,
    input in,
    output [2:0] out
    );
    
reg [1:0] current_state=2'd0, next_state=2'd0;
reg [2:0] out_d=3'd0;
    
assign out=out_d;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        current_state <= 1'd0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        2'd0: begin
            out_d <= 3'd0;
            if (in) begin
                next_state <= 2'd1;
            end
            else begin
                next_state <= 2'd0;
            end
        end
        
        2'd1: begin
            out_d <= 3'd1;
            if (in) begin
                next_state <= 2'd2;
            end
            else begin
                next_state <= 2'd0;
            end
        end
            
        2'd2: begin
            out_d <= 3'd2;
            if (in) begin
                next_state <= 2'd3;
            end
            else begin
                next_state <= 2'd2;
            end
        end
        
        2'd3: begin
            out_d <= 3'd3;
            if (in) begin
                next_state <= 2'd1;
            end
            else begin
                next_state <= 2'd2;
            end
        end
        
    endcase
end
    
endmodule
```

# 三段式
一个时序逻辑采用同步时序的方式描述状态转移，一个采用组合逻辑的方式判断状态转移条件、描述状态转移规律，第三个模块使用同步时序的方式描述每个状态的输出。
解决了两段式组合逻辑的毛刺问题，但是从资源消耗的角度上看，三段式的资源消耗多一些.
``` Bash
`timescale 1ns / 1ps

module three_parts(
    input clk, rst,
    input in,
    output [2:0] out
    );
    
reg [1:0] current_state=2'd0, next_state=2'd0;
reg [2:0] out_d=3'd0;
    
assign out=out_d;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        current_state <= 1'd0;
    end
    else begin
        current_state <= next_state;
    end
end

always @(*) begin
    case (current_state)
        2'd0: begin
            if (in) begin
                next_state <= 2'd1;
            end
            else begin
                next_state <= 2'd0;
            end
        end
        
        2'd1: begin
            if (in) begin
                next_state <= 2'd2;
            end
            else begin
                next_state <= 2'd0;
            end
        end
            
        2'd2: begin
            if (in) begin
                next_state <= 2'd3;
            end
            else begin
                next_state <= 2'd2;
            end
        end
        
        2'd3: begin
            if (in) begin
                next_state <= 2'd1;
            end
            else begin
                next_state <= 2'd2;
            end
        end
        
    endcase
end

always @(posedge clk) begin
    case (current_state)
        2'd0: begin
            out_d <= 3'd0;
        end
        
        2'd1: begin
            out_d <= 3'd1;
        end
            
        2'd2: begin
            out_d <= 3'd2;
        end
        
        2'd3: begin
            out_d <= 3'd3;
        end
    
    endcase
end

endmodule
```
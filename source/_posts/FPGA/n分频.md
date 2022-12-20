---
title: n分频
date: 2022-12-20 12:59:27
tags: 
- 编程
- FPGA
- HDL
categories: 
- FPGA
---

# 介绍
使用计数器或触发器进行分频

<!-- more -->

# 偶数分频
如果是2分频就一个D-FF就行

其他偶数分频：
``` Bash
`timescale 1ns / 1ps

module even_divider(
    input [3:0] divider,
    input clk,
    input rst,
    output reg out_clk
    );
    
reg [2:0] count=3'd0;

always @ (posedge clk or negedge rst) begin
    if (!rst) begin
        count <= 3'd0;
        out_clk <= 1'd0;
    end
end

// N/2-1
always @(posedge clk) begin
        if (count==(divider/2)-1) begin
            count <= 3'd0;
            out_clk <= !out_clk;
        end
        else begin
            count <= count+1;
        end
end
    
endmodule
```

# 奇数分频
out_clk=p_clk | n_clk
p_clk: switch in posedge clk when count==N-1 or count==(N-1)/2
n_clk: same, but check in negedge
``` Bash
`timescale 1ns / 1ps

module odd_divider(
    input [3:0] divider,
    input clk,
    input rst,
    output out_clk
    );
    
reg p_clk=1'd0, n_clk=1'd0;
reg [3:0] count;

assign out_clk=p_clk|n_clk;
    
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        count <= 4'd0;
    end
    else if (count == divider-1) begin
        count <= 4'd0;
    end
    else begin
        count <= count+1'd1;
    end
end

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        p_clk <= 1'd0;
    end
    else if (count==divider-1'd1 || count==(divider-1'd1)/2) begin
        p_clk <= !p_clk;
    end
    else begin
        p_clk <= p_clk;
    end
end

always @(negedge clk or negedge rst) begin
    if (!rst) begin
        n_clk <= 1'd0;
    end
    else if (count==divider-1'd1 || count==(divider-1'd1)/2) begin
        n_clk <= !n_clk;
    end
    else begin
        n_clk <= n_clk;
    end
end
    
endmodule
```

# testbench
``` Bash
`timescale 1ns / 1ps

module test_bench();

parameter [3:0] divider=3;

reg clk,rst;
wire out_clk;

always #10 clk = !clk;

odd_divider UUT(
    .divider(divider),
    .clk(clk),
    .rst(rst),
    .out_clk(out_clk)
    );
    
initial begin
    clk=0; rst=0;
    #40 rst=1;
end

endmodule

```
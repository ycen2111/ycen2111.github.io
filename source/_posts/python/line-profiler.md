---
title: line profiler
date: 2022-06-23 13:15:01
tags:
- 编程
- python
- plugin
categories: 
- python
---

## 介绍

测量每一行代码运行次数，时间，百分比等。通过console调用，不想记python代码效率关系就用它。

<!-- more -->

## 安装
``` Bash
pip install line_profiler
```

## 调用
github:(https://github.com/pyutils/line_profiler#:~:text=LineProfiler%20can%20be%20given%20functions%20to%20profile%2C%20and,every%20single%20line%20of%20code%20would%20be%20overwhelming.)

``` Bash
#在需要测量的def上一行标记一下
@profile

#在console内输入
kernprof -l -v ./main.py

#输出
Line #      #row number
Hits         #executed times
Time        #total amount of time spent executing the line in the timer's units
Per Hit     #average amount of time spent executing the line
% Time      #percentage of time spent on that line
Line Contents #code content
```

## 注意事项
使用@profile标记可能会报warning，不用管它直接console里运行就行。

计算出的time单位为1e-6s
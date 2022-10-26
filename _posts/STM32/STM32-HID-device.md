---
title: STM32 HID device
date: 2021-10-30 14:58:48
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

可用STM32模拟鼠标数据控制。

<!-- more -->

发送给上位机数据为4 bytes

|byte|bit|implement|
|:----|:----|:----|
|1|7|1 means Y changes larger than the range -256~255|
|1|6|1 means X changes larger than the range -256~255|
|1|5|1 means Y changes to negative part|
|1|4|1 means X changes to negative part|
|1|3|constant 1|
|1|2|middle key pressed|
|1|1|right key pressed|
|1|0|left key pressed|
|2|0-7|X coordinate's chaning|
|3|0-7|Y coordinate's chaning|
|4|0-7|rolling value|

## 初始化

CubeMX里 connectivity-USB enable "Device", 然后Middleware 选择 HID，保持默认即可

在main.c中添加

``` Bash
#include “usbd_hid.h”

uint8_t MouseData01[4] = {0,0,0,0};
extern USBD_HandleTypeDef hUsbDeviceFS;
```
while里

``` Bash
USBD_HID_SendReport(&hUsbDeviceFS,(uint8_t*)&MouseData01,sizeof(MouseData01));
```

即可控制
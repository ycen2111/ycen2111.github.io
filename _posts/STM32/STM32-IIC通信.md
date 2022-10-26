---
title: STM32 IIC通信
date: 2021-09-24 14:05:37
ags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

IIC协议是一种通用connection method，通过SCL和SDA双线通讯，可以通过设置地址来实现多主机/从机共用双线通讯，节省端口。但效率不高，遇上大数据量通讯弊端明显。

<!-- more -->

## IIC协议

IIC时序有如下规律：

SCL | SDA | Result
  H  |    ↓    | Start Signal
  H  |    ↑    | Stop Signal
  H  |   →   | Read Signal
  L   |    X   | Change Signal

![20190409113350288.png](20190409113350288.png)

寻址方面，一般寻址会发送8位数据，前7位为地址，第8位为读/写（1/0）标记。
例如主机从从机读数据，可以是1010 0001。

每次发送一个字节数据后，主机会拉高SDA并等待从机应答。如检测到下拉信号后继续传输。一般一次传输完成后需delay至少5ms再继续传输。

## 初始化

cubemx connectivity中可选择I2C1或是2。选择standard mode就行，这样内部时钟就是100khz。

注意：如使用mini板会发现它将EEPROM，24C02芯片连接在PC11和PC12上，而非定义的IIC接口，需要外部自行连接。

另：在查资料时发现有说法将以下自动生成的代码放置在GPIO enable之前：
``` Bash
__HAL_RCC_I2C2_CLK_ENABLE();
```
但尝试后发现并无区别，先在此记录。

## 使用

### polling

单纯的读写可使用如下函数：

HAL_StatusTypeDef HAL_I2C_Master_Transmit(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
HAL_StatusTypeDef HAL_I2C_Master_Receive(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint8_t *pData, uint16_t Size, uint32_t Timeout)
example：HAL_I2C_Master_Transmit(&hi2c2, 0xA0, Buffer, 8, 1000);

或：
HAL_StatusTypeDef HAL_I2C_Mem_Write(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size, uint32_t Timeout)
HAL_StatusTypeDef HAL_I2C_Mem_Read(I2C_HandleTypeDef *hi2c, uint16_t DevAddress, uint16_t MemAddress, uint16_t MemAddSize, uint8_t *pData, uint16_t Size, uint32_t Timeout)
example：HAL_I2C_Mem_Write(&hi2c2, 0xA0,8*i,I2C_MEMADD_SIZE_8BIT,Buffer+8*i,8, 1000);

基本上最好选择mem记录和读取，因为可以选择开始储存的地址，灵活。
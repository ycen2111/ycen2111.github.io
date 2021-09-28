---
title: STM32 串口通信
date: 2021-09-14 22:16:44
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

通过USART和上位或下位机通信。通过schematic diagram可以发现USB转串口接口PA9，PA10正是由USART1控制。这里选择USART1，和上位机电脑进行通信。

<!-- more -->

## 非中断通信

在CUBE MX里选择USART1
Mode: Asynchronous
Baud Rate: 115200 (只要与接受口一样就行)
Word Length: 8 Bits

生成后只要调用两函数就行
``` Bash
uint8_t aRxBuffer[10];

HAL_UART_Receive(&huart1, (uint8_t *)aRxBuffer, 10, 0xffff);
HAL_UART_Transmit(&huart1, (uint8_t *)aRxBuffer, sizeof(aRxBuffer), 0xffff);
```

就可以接收上位机信息并发回去。但因为会中断其他所有进程，不灵活，所有基本不用。

## printf 重定向

可以利用usb转串口将printf里的内容重定向到串口上，显示在上位机里。

printf函数内部会调用fputc()函数，如果重定义此函数并加入HAL_UART_Transmit函数即可在串口打印。

在usart.h内添加
``` Bash
#include "stdio.h"
```

在usart.c内添加从定向函数
``` Bash
#ifdef __GNUC__
  /* With GCC/RAISONANCE, small printf (option LD Linker->Libraries->Small printf
     set to 'Yes') calls __io_putchar() */
  #define PUTCHAR_PROTOTYPE int __io_putchar(int ch)
#else
  #define PUTCHAR_PROTOTYPE int fputc(int ch, FILE *f)
#endif /* __GNUC__ */
/**
  * @brief  Retargets the C library printf function to the USART.
  * @param  None
  * @retval None
  */
PUTCHAR_PROTOTYPE
{
  /* Place your implementation of fputc here */
  /* e.g. write a character to the EVAL_COM1 and Loop until the end of transmission */
  HAL_UART_Transmit(&huart1, (uint8_t *)&ch, 1, 0xFFFF);
  
  return ch;
}
```

注意：如果没选择semiLib库需要在usart.c内额外添加
``` Bash
void _sys_exit(int x)
{
    x = x;
}
 
void _ttywrch(int x)
{
    x = x;
}
 
struct __FILE
{
    int handle;
};
 
FILE __stdout;    
```

否则程序会在printf函数处卡死。

现在在主函数输入 printf("test\r\n"); 即可通讯。

## 中断通信

生成代码时在NVIC enable通道设置优先级。由于暂不清楚项目中通信的流程顾先放过，之后熟悉了再来完善。
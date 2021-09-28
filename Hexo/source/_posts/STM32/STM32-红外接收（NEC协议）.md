---
title: STM32 红外接收（NEC协议）
date: 2021-09-21 19:38:54
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

本文将使用[TSAL6200](https://pdf1.alldatasheet.com/datasheet-pdf/view/26526/VISHAY/TSAL6200.html)发射头和[HS0038](https://pdf1.alldatasheet.com/datasheet-pdf/view/103034/VISHAY/HS0038B.html)接收头传递信号。HS0038会输出解码完成的信号并以高低电频方式输出。

<!-- more -->

## 输入捕获

通过tim IC功能实现输入中断，来测量两trigger间时间差。

由于接红外接收头连接于PA1，这里选用TIM5 channel 2实现中断。

cubeMX选中TIM5 channel 2 Input Capture direct mode, 勾选Internal Clock。

Prescaler= 72-1
Counter Period= 65535(0XFFFF) //越大越好，尽量减少溢出次数
auto-reload= enable

记得设置NVIC优先级。

### tim.c

需要在init之后加入
``` Bash
HAL_TIM_Base_Start_IT(&htim5); //开启计时中断
HAL_TIM_IC_Start_IT(&htim5,TIM_CHANNEL_2); //开启输入中断
```

计数器溢出回调函数。计数溢出次数，并标记一些重要内容。
RmtSta[(0<=接收标记)00(0<=high trigger标记) (0000<=4bits counter)]
``` Bash
void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
	if(htim==(&htim5))
	{
 		if(RmtSta&0x80)//1000 0000 start receiving
		{	
			RmtSta&=~0X10; //cancle the rising mark
			if((RmtSta&0X0F)==0X00)RmtSta|=1<<6;//0100 0000 finishing a receive
			if((RmtSta&0X0F)<14)RmtSta++;
			else //(RmtSta&0X0F)=15
			{
				RmtSta&=~(1<<7);
				RmtSta&=0XF0;
			}		
		}	
	}
}
```

输入中断回调函数。计算一个周期内的时间差，交替设置high/down trigger中断来实现高/低电频时间测量。
``` Bash
void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
{
	if(htim==(&htim5))
	{
		if (HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_1))
		{
			TIM_RESET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2); //reset configuration (important)
			TIM_SET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2,TIM_ICPOLARITY_FALLING); //interrept in falling edge
			__HAL_TIM_SET_COUNTER(&htim5,0);	  //reset timer
		  RmtSta|=0X10; //0001 0000
		}
		else
		{
			Dval=HAL_TIM_ReadCapturedValue(&htim5,TIM_CHANNEL_2); //get time difference
			TIM_RESET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2);
			TIM_SET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2,TIM_ICPOLARITY_RISING); //interrept in rising edge
		  RmtSta&=~(1<<4); //000(1<-0) 0000
		}
	}
```

之后将Dval加上溢出的时间就得到完整的高/低电频时间了。

## NEC协议

NEC协议遵从以下规则：

![12215924-779a256456e84999b95e2b9133125781.png](12215924-779a256456e84999b95e2b9133125781.png)

每条命令会由一个起始信号，8位地址，8位反位地址，8位cmd,8位反位cmd和若干repeat信号组成。

![20190615153604389.png](20190615153604389.png)

起始信号会产生9ms高信号和4.5ms低信号，

发射逻辑“1”会产生560μs高信号和1690μs低信号，

发射逻辑“0”会产生560μs高信号和560μs低信号，

repeat会产生9ms高信号和2.25ms低信号。

![20190615155851364.png](20190615155851364.png)

但是接收头却会反调接收的高信号和低信号，如接收逻辑“1”会产生560μs低信号和1690μs高信号。

由于接收的高信号足以区分不同codes，因此可以只检测高信号长度来解码。

### 按钮信号

通过测试正点原子配套的遥控器，得如下结果：

按7X3位置排序cmd码
 162 | 098 | 226
 034 | 002 | 194
 224 | 168 | 144
 104 | 152 | 176
 048 | 024 | 122
 016 | 056 | 090
 066 | ( n ) | 082

### tim.c

``` Bash
#include "tim.h"

#include "stdio.h"
# include "LED\BSP_LED.h"
#include "OLED\oled.h"

TIM_HandleTypeDef htim2;
TIM_HandleTypeDef htim5;

/* TIM2 init function */
void MX_TIM2_Init(void)
{

  TIM_ClockConfigTypeDef sClockSourceConfig = {0};
  TIM_MasterConfigTypeDef sMasterConfig = {0};

  htim2.Instance = TIM2;
  htim2.Init.Prescaler = 7200-1;
  htim2.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim2.Init.Period = 5000-1;
  htim2.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim2.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;
  if (HAL_TIM_Base_Init(&htim2) != HAL_OK)
  {
    Error_Handler();
  }
  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim2, &sClockSourceConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim2, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
HAL_TIM_Base_Start_IT(&htim2);

}
/* TIM5 init function */
void MX_TIM5_Init(void)
{
  TIM_ClockConfigTypeDef sClockSourceConfig = {0};
  TIM_MasterConfigTypeDef sMasterConfig = {0};
  TIM_IC_InitTypeDef sConfigIC = {0};

  htim5.Instance = TIM5;
  htim5.Init.Prescaler = 72-1;
  htim5.Init.CounterMode = TIM_COUNTERMODE_UP;
  htim5.Init.Period = 65535;
  htim5.Init.ClockDivision = TIM_CLOCKDIVISION_DIV1;
  htim5.Init.AutoReloadPreload = TIM_AUTORELOAD_PRELOAD_ENABLE;
  if (HAL_TIM_Base_Init(&htim5) != HAL_OK)
  {
    Error_Handler();
  }
  sClockSourceConfig.ClockSource = TIM_CLOCKSOURCE_INTERNAL;
  if (HAL_TIM_ConfigClockSource(&htim5, &sClockSourceConfig) != HAL_OK)
  {
    Error_Handler();
  }
  if (HAL_TIM_IC_Init(&htim5) != HAL_OK)
  {
    Error_Handler();
  }
  sMasterConfig.MasterOutputTrigger = TIM_TRGO_RESET;
  sMasterConfig.MasterSlaveMode = TIM_MASTERSLAVEMODE_DISABLE;
  if (HAL_TIMEx_MasterConfigSynchronization(&htim5, &sMasterConfig) != HAL_OK)
  {
    Error_Handler();
  }
  sConfigIC.ICPolarity = TIM_INPUTCHANNELPOLARITY_RISING;
  sConfigIC.ICSelection = TIM_ICSELECTION_DIRECTTI;
  sConfigIC.ICPrescaler = TIM_ICPSC_DIV1;
  sConfigIC.ICFilter = 0;
  if (HAL_TIM_IC_ConfigChannel(&htim5, &sConfigIC, TIM_CHANNEL_2) != HAL_OK)
  {
    Error_Handler();
  }
	HAL_TIM_Base_Start_IT(&htim5);
	HAL_TIM_IC_Start_IT(&htim5,TIM_CHANNEL_2);

}

void HAL_TIM_Base_MspInit(TIM_HandleTypeDef* tim_baseHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(tim_baseHandle->Instance==TIM2)
  {
    /* TIM2 clock enable */
    __HAL_RCC_TIM2_CLK_ENABLE();

    /* TIM2 interrupt Init */
    HAL_NVIC_SetPriority(TIM2_IRQn, 10, 0);
    HAL_NVIC_EnableIRQ(TIM2_IRQn);
  }
  else if(tim_baseHandle->Instance==TIM5)
  {
    /* TIM5 clock enable */
    __HAL_RCC_TIM5_CLK_ENABLE();

    __HAL_RCC_GPIOA_CLK_ENABLE();
    /**TIM5 GPIO Configuration
    PA1     ------> TIM5_CH2
    */
    GPIO_InitStruct.Pin = GPIO_PIN_1;
    GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
    GPIO_InitStruct.Pull = GPIO_NOPULL;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

    /* TIM5 interrupt Init */
    HAL_NVIC_SetPriority(TIM5_IRQn, 2, 0);
    HAL_NVIC_EnableIRQ(TIM5_IRQn);
  }
}

void HAL_TIM_Base_MspDeInit(TIM_HandleTypeDef* tim_baseHandle)
{

  if(tim_baseHandle->Instance==TIM2)
  {
    /* Peripheral clock disable */
    __HAL_RCC_TIM2_CLK_DISABLE();

    /* TIM2 interrupt Deinit */
    HAL_NVIC_DisableIRQ(TIM2_IRQn);
  }
  else if(tim_baseHandle->Instance==TIM5)
  {
    /* Peripheral clock disable */
    __HAL_RCC_TIM5_CLK_DISABLE();

    /**TIM5 GPIO Configuration
    PA1     ------> TIM5_CH2
    */
    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_1);

    /* TIM5 interrupt Deinit */
    HAL_NVIC_DisableIRQ(TIM5_IRQn);
  }
}

static uint8_t 	RmtSta=0,RmtCnt=0;	  
uint8_t count=0;
uint16_t Dval;
static uint32_t RmtRec;

void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
	if(htim==(&htim2))
    {		
    LED_switch(LED0);
    }
	if(htim==(&htim5))
	{
 		if(RmtSta&0x80)//1000 0000 start receiving
		{	
			RmtSta&=~0X10; //cancle the rising mark
			if((RmtSta&0X0F)==0X00)RmtSta|=1<<6;//0100 0000 finishing a receive
			if((RmtSta&0X0F)<14)RmtSta++;
			else //(RmtSta&0X0F)=15
			{
				RmtSta&=~(1<<7);
				RmtSta&=0XF0;	
			}		
		}	
	}
}

void HAL_TIM_IC_CaptureCallback(TIM_HandleTypeDef *htim)
{
	if(htim==(&htim5))
	{
		if (HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_1))
		{
			TIM_RESET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2);
			TIM_SET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2,TIM_ICPOLARITY_FALLING);
			__HAL_TIM_SET_COUNTER(&htim5,0);	  
		  RmtSta|=0X10; //0001 0000
		}
		else
		{
			Dval=HAL_TIM_ReadCapturedValue(&htim5,TIM_CHANNEL_2);
			TIM_RESET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2);
			TIM_SET_CAPTUREPOLARITY(&htim5,TIM_CHANNEL_2,TIM_ICPOLARITY_RISING);
			
			if (RmtSta&0X80)//1000 0000
			{
				if(Dval>300&&Dval<800) //560us logic 0
					{
						RmtRec<<=1;
						RmtRec|=0;  
						count++;
					}else if(Dval>1400&&Dval<1800) //1680us logic 1
					{
						RmtRec<<=1;
						RmtRec|=1;
						count++;
					}else if(Dval>2200&&Dval<2600) //2.25us
					{
						RmtCnt++;
						RmtSta&=0XF0;		
					}
					
				if (count==32)
				{
					printf(" [%d %d %d %d]\r\n",(RmtRec&0XFF000000)>>24,(RmtRec&0X00FF0000)>>16,(RmtRec&0X0000FF00)>>8,RmtRec&0X000000FF);
					count=0;
				}
			}
			else if(Dval>4200&&Dval<4700)		//4.5ms
				{
					RmtSta|=1<<7;	//1000 0000
					RmtCnt=0;
				}
			
		  RmtSta&=~(1<<4); //000(1<-0) 0000
		}
	}
}

uint8_t get_radio(void)
{
	uint8_t check=0,add=0;
	
	if (RmtSta&0x40)//0100 0000
	{
		printf("start getting\r\n");
		if (((RmtRec&0XFF000000)>>24==(~RmtRec&0X00FF0000)>>16)&&((RmtRec&0X0000FF00)>>8==(~RmtRec&0X000000FF))) check=1;
		if (check) {add=((RmtRec&0X0000FF00)>>8); printf("add=%d\r\n",add);}
		if (check==0||(RmtSta&0x80)==0)
		{
			RmtCnt=0;
			RmtSta&=~(0x40);//0(1<=0)00 0000
			printf("stop checking");
		}
		
	}
	
	return add;
}

```

### tim.h

``` Bash
#ifndef __TIM_H__
#define __TIM_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

extern TIM_HandleTypeDef htim2;
extern TIM_HandleTypeDef htim5;

void MX_TIM2_Init(void);
void MX_TIM5_Init(void);

uint8_t get_radio(void);

#ifdef __cplusplus
}
#endif

#endif /* __TIM_H__ */

```

### 实例

LED0做指示灯会循环开关。oled会显示按下的按钮cmd编号。

``` Bash
#include "main.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"

#include "LED\BSP_LED.h"
#include "OLED\oled.h"

/* USER CODE BEGIN PV */
uint8_t startMessage[]="start communication \r\n";
uint8_t aRxBuffer[10];

void SystemClock_Config(void);

int main(void)
{

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

	LED_Init();
	OLED_Init();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_TIM2_Init();
  MX_USART1_UART_Init();
  MX_TIM5_Init();
	OLED_ShowString(0,0,"Ray test",24);
	OLED_ShowString(0,32,"address=000",16);
	
	OLED_Refresh_Gram();

  /* Infinite loop */
	uint8_t radio_num=0;
	
  while (1)
  {
		radio_num=get_radio();
		
		if (radio_num)
		{
			OLED_ShowNum(64,32,radio_num,3,16);
			OLED_Refresh_Gram();
		}
		
		HAL_Delay(10);
		radio_num=0;
	}	
}

```
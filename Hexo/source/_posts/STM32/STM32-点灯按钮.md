---
title: STM32 点灯/按钮
date: 2021-09-13 17:39:26
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 软件

此系列用于介绍常见STM32外设及使用方法，基于[STM32CubeMX](https://www.st.com/en/development-tools/stm32cubemx.html)初始化。

<!-- more -->

## 点灯

直接在GPIO端设置即可，设置推挽输出。

### LED.c
``` Bash
#include "LED\BSP_LED.h"

//LED0 LED1 initialize
void LED_Init(void)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_SET);

  /*Configure GPIO pin Output Level */
  HAL_GPIO_WritePin(GPIOD, GPIO_PIN_2, GPIO_PIN_SET);

  /*Configure GPIO pin : PA8 */
  GPIO_InitStruct.Pin = GPIO_PIN_8;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /*Configure GPIO pin : PD2 */
  GPIO_InitStruct.Pin = GPIO_PIN_2;
  GPIO_InitStruct.Mode = GPIO_MODE_OUTPUT_PP;
  GPIO_InitStruct.Pull = GPIO_NOPULL;
  GPIO_InitStruct.Speed = GPIO_SPEED_FREQ_LOW;
  HAL_GPIO_Init(GPIOD, &GPIO_InitStruct);

}

//switching on/off LED
void LED_switch (uint8_t LEDx)
{
	
	uint8_t state;
	
	switch (LEDx)
	{
		case LED0:
			state=HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_8);
			if (state) HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_RESET);
			else HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_SET);
			break;
		
		case LED1:
			state=HAL_GPIO_ReadPin(GPIOD,GPIO_PIN_2);
			if (state) HAL_GPIO_WritePin(GPIOD, GPIO_PIN_2, GPIO_PIN_RESET);
			else HAL_GPIO_WritePin(GPIOD, GPIO_PIN_2, GPIO_PIN_SET);
			break;
	}
			
	return;
}

```

### LED.h

``` Bash
#ifndef __BSP_LED_H__
#define __BSP_LED_H__

#include "main.h"

#define LED0 0
#define LED1 1

void LED_Init(void);
void LED_switch (uint8_t LEDx);

#endif

```

### 实例

LED0，LED1 流水灯，交替亮
``` Bash

#include "main.h"
#include "LED/BSP_LED.h"

void SystemClock_Config(void);

int main(void)
{
  HAL_Init();
  LED_Init();

  SystemClock_Config();

  HAL_GPIO_WritePin(GPIOA, GPIO_PIN_8, GPIO_PIN_SET); //turn off
  HAL_GPIO_WritePin(GPIOD, GPIO_PIN_2, GPIO_PIN_RESET); //turn on

  while (1)
  {
	HAL_Delay(500);
	LED_switch (LED0); //switching the state
	LED_switch (LED1);
		
  }
}

```

## 按键

三个按键中PA0需设置下拉输出，其他两个PC5,PA15上拉输出

### KEY.c
``` Bash
#include "KEY\BSP_KEY.h"

void KEY_Init(void)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOC_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();

/*Configure GPIO pin : PA0 */
GPIO_InitStruct.Pin=GPIO_PIN_0; 
  GPIO_InitStruct.Mode=GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull=GPIO_PULLDOWN; 
  GPIO_InitStruct.Speed=GPIO_SPEED_FREQ_HIGH;
  HAL_GPIO_Init(GPIOA,&GPIO_InitStruct);
	
  /*Configure GPIO pin : PC5 */
  GPIO_InitStruct.Pin = GPIO_PIN_5;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  HAL_GPIO_Init(GPIOC, &GPIO_InitStruct);

  /*Configure GPIO pin : PA15 */
  GPIO_InitStruct.Pin = GPIO_PIN_15;
  GPIO_InitStruct.Mode = GPIO_MODE_INPUT;
  GPIO_InitStruct.Pull = GPIO_PULLUP;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

}

uint8_t KEY_Scan(uint8_t mode)
{
    static uint8_t key_up=1;
    if(mode==1)key_up=1; 
    if(key_up&&(KEY0==0||KEY1==0||WK_UP==1))
    {
        HAL_Delay(10);
        key_up=0;
        if(KEY0==0)       return KEY0_PRES;
        else if(KEY1==0)  return KEY1_PRES;
        else if(WK_UP==1) return WKUP_PRES;          
    }else if(KEY0==1&&KEY1==1&&WK_UP==0)key_up=1;
    return;
}

```

### KEY.h
``` Bash
#ifndef __BSP_KEY_H__
#define __BSP_KEY_H__

#include "main.h"

#define KEY0        HAL_GPIO_ReadPin(GPIOC,GPIO_PIN_5)  //KEY0
#define KEY1        HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_15) //KEY1°
#define WK_UP       HAL_GPIO_ReadPin(GPIOA,GPIO_PIN_0)  //WKUP

#define KEY0_PRES 	1
#define KEY1_PRES		2
#define WKUP_PRES   	3

void KEY_Init(void);
uint8_t KEY_Scan(uint8_t mode);

#endif

```

### 实例

按key0 LED0变化，key1 LED1变化
按WKUP两个都变化
``` Bash
#include "main.h"
#include "gpio.h"

#include "LED\BSP_LED.h"
#include "KEY\BSP_KEY.h"

void SystemClock_Config(void);

int main(void)
{
  HAL_Init();

  LED_Init();
  KEY_Init();
  
  SystemClock_Config();

  while (1)
  {
		
	switch(KEY_Scan(0))
	{
		case KEY0_PRES:
			LED_switch(LED0);
			break;
		case KEY1_PRES:
			LED_switch(LED1);
			break;
		case WKUP_PRES:
			LED_switch(LED0);
			LED_switch(LED1);
			break;
	}		
  }
}

```
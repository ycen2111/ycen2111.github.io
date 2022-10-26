---
title: STM32 中断
date: 2021-09-14 12:23:18
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

此文会记录stm32中外部中断和定时器中断的使用方法及注意事项。中断可以一定程度上模拟计算机中的多线程进程，但需要特别注意优先级问题（特别是HAL_DELAY函数优先级冲突导致的卡死问题）。

<!-- more -->

## 外部中断

可通过外部按钮，IO口等外部控制中断。

### EXTI.c

选择IO口后选择"GPIO_EXTIx",根据端点情况GPIP mode选rising edge或falling edge。进入NVIC enable对应通道，设置优先级后生成代码。

完成后加入"void EXTIx_IRQHandler(void)"函数（注意EXTI0会在system文件中重复定义，注销掉即可），"void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)"函数，这两个函数名是确定的，不能改变。注意不要使用HAL_DELAY函数，解决方法之后有机会去研究下。
``` Bash
#include "EXIT\BSP_EXTI.h"

#include "KEY\BSP_KEY.h"
#include "LED\BSP_LED.h"

/** Configure pins as
        * Analog
        * Input
        * Output
        * EVENT_OUT
        * EXTI
*/
void EXTI_Init(void)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};

  /* GPIO Ports Clock Enable */
  __HAL_RCC_GPIOD_CLK_ENABLE();
  __HAL_RCC_GPIOA_CLK_ENABLE();

  /*Configure GPIO pin : PA0 */
  GPIO_InitStruct.Pin = GPIO_PIN_0;
  GPIO_InitStruct.Mode = GPIO_MODE_IT_RISING;
  GPIO_InitStruct.Pull = GPIO_PULLDOWN;
  HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);

  /* EXTI interrupt init*/
  HAL_NVIC_SetPriority(EXTI0_IRQn, 2, 0);
  HAL_NVIC_EnableIRQ(EXTI0_IRQn);

}

void EXTI0_IRQHandler(void)
{
	HAL_GPIO_EXTI_IRQHandler(GPIO_PIN_0);
}

void HAL_GPIO_EXTI_Callback(uint16_t GPIO_Pin)
{
    //HAL_Delay(100); //!!! dont use it !!!
    switch(GPIO_Pin)
    {
        case GPIO_PIN_0:
	if(WK_UP==1){
		LED_switch(LED0);
	}
	break;
    }
}

```

### EXTI.h

``` Bash
#ifndef __BSP_EXTI_H__
#define __BSP_EXTI_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

void EXTI_Init(void);

#ifdef __cplusplus
}
#endif
#endif /*__BSP_EXTI_H__ */

```

### 实例

按下WK_UP按钮会变换LED0状态。

``` Bash
#include "main.h"

#include "KEY\BSP_KEY.h"
#include "LED\BSP_LED.h"
#include "EXTI\BSP_EXTI.h"

void SystemClock_Config(void);

int main(void)
{
   HAL_Init();

  SystemClock_Config();

  EXTI_Init();
  LED_Init();
  KEY_Init();

  while (1)
  {
	HAL_Delay(500);
	LED_switch(LED1);
  }
}

```

## 定时器中断

通过内部计时定时中断。

在Cube MX选择定时器（TIM2为例）,
Clock Source: Internal Clock
Prescaler: 7200-1
Counter Period: 5000-1
auto-reload preload: Enable (important)
(Tout=((arr+1)*(psc+1))*Tclk)=(5000*7200)*(1/72Mhz)=0.5s,会每隔500ms中断下循环。但现实却有细微误差，和HAL_DELAY(500)同时运行会发现频率有细微差别，初步估计是内部语句运行误差。

别忘记在NVIC中enable interrupt并设定优先级。

### tim.c

需自行加上（void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)）回调函数，同时在initialization函数末尾加上（HAL_TIM_Base_Start_IT(&htim2);）开启计时器。
``` Bash
#include "tim.h"

#include "LED\BSP_LED.h"

TIM_HandleTypeDef htim2;

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

void HAL_TIM_Base_MspInit(TIM_HandleTypeDef* tim_baseHandle)
{

  if(tim_baseHandle->Instance==TIM2)
  {
    /* TIM2 clock enable */
    __HAL_RCC_TIM2_CLK_ENABLE();

    /* TIM2 interrupt Init */
    HAL_NVIC_SetPriority(TIM2_IRQn, 2, 0);
    HAL_NVIC_EnableIRQ(TIM2_IRQn);
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
}

void HAL_TIM_PeriodElapsedCallback(TIM_HandleTypeDef *htim)
{
    if(htim==(&htim2))
    {
        LED_switch(LED0);
    }
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

void MX_TIM2_Init(void);

#ifdef __cplusplus
}
#endif

#endif /* __TIM_H__ */
```

### 实例

LED0和LED1会同时闪烁，LED0为定时器中断控制。
``` Bash
#include "main.h"
#include "tim.h"
#include "gpio.h"

/* Private includes ----------------------------------------------------------*/
#include "LED\BSP_LED.h"

/* Private typedef -----------------------------------------------------------*/
void SystemClock_Config(void);

int main(void)
{

  /* MCU Configuration--------------------------------------------------------*/

  /* Reset of all peripherals, Initializes the Flash interface and the Systick. */
  HAL_Init();

  /* Configure the system clock */
  SystemClock_Config();

  /* Initialize all configured peripherals */
  MX_GPIO_Init();
  MX_TIM2_Init();
	LED_Init();

  /* Infinite loop */
  while (1)
  {
		HAL_Delay(500);
		LED_switch(LED1);
	}
}

```
---
title: STM32 ADC
date: 2021-09-16 21:32:12
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

将模电数据转换为数字信号后传输，一般返回12位数据，可用unit16_t接收数据。返回值最大4096，可通过（Voltage=value*3.3/4096）得到最大3.3v的结果。尽量不要测量大于3.3v的电压以防止烧坏ADC。

<!-- more -->

## ADC

选择ADC1，IN1，选中PA1端口。

Mode：indepandent mode 每个端口只会有一个测量通道

Data Alignment: 向左对其或向右对其，只要对应即可

注意：如果用中断实现的话adc初始化必须在tim初始化之前，不然会在中断里卡死。

### adc.c

不需要改任何东西，生成就能用

``` Bash
#include "adc.h"

ADC_HandleTypeDef hadc1;

void MX_ADC1_Init(void)
{
  ADC_ChannelConfTypeDef sConfig = {0};
  hadc1.Instance = ADC1;
  hadc1.Init.ScanConvMode = ADC_SCAN_DISABLE;
  hadc1.Init.ContinuousConvMode = DISABLE;
  hadc1.Init.DiscontinuousConvMode = DISABLE;
  hadc1.Init.ExternalTrigConv = ADC_SOFTWARE_START;
  hadc1.Init.DataAlign = ADC_DATAALIGN_RIGHT;
  hadc1.Init.NbrOfConversion = 1;
  if (HAL_ADC_Init(&hadc1) != HAL_OK)
  {
    Error_Handler();
  }
  sConfig.Channel = ADC_CHANNEL_1;
  sConfig.Rank = ADC_REGULAR_RANK_1;
  sConfig.SamplingTime = ADC_SAMPLETIME_1CYCLE_5;
  if (HAL_ADC_ConfigChannel(&hadc1, &sConfig) != HAL_OK)
  {
    Error_Handler();
  }
}

void HAL_ADC_MspInit(ADC_HandleTypeDef* adcHandle)
{

  GPIO_InitTypeDef GPIO_InitStruct = {0};
  if(adcHandle->Instance==ADC1)
  {
    __HAL_RCC_ADC1_CLK_ENABLE();

    __HAL_RCC_GPIOA_CLK_ENABLE();

    GPIO_InitStruct.Pin = GPIO_PIN_1;
    GPIO_InitStruct.Mode = GPIO_MODE_ANALOG;
    HAL_GPIO_Init(GPIOA, &GPIO_InitStruct);
  }
}

void HAL_ADC_MspDeInit(ADC_HandleTypeDef* adcHandle)
{

  if(adcHandle->Instance==ADC1)
  {
    __HAL_RCC_ADC1_CLK_DISABLE();

    HAL_GPIO_DeInit(GPIOA, GPIO_PIN_1);
  }
}

```

### adc.h

``` Bash
#ifndef __ADC_H__
#define __ADC_H__

#ifdef __cplusplus
extern "C" {
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

extern ADC_HandleTypeDef hadc1;

void MX_ADC1_Init(void);

#ifdef __cplusplus
}
#endif

#endif /* __ADC_H__ */

```

### 实例

加入oled.h来实时显示数值。会实时显示PA1处电压。

HAL_ADC_Start(&hadc1)； 打开adc

HAL_ADC_PollForConversion(&hadc1, 0xFF); 等待读取完成

adc_value=HAL_ADC_GetValue(&hadc1); 读数据

HAL_ADC_Stop(&hadc1); 关闭

需注意有时候显示上一个时段数据却误以为是最新数据，需仔细分析时序逻辑。

``` Bash
#include "main.h"
#include "adc.h"
#include "gpio.h"

#include "LED\BSP_LED.h"
#include "OLED\oled.h"

uint8_t startMessage[]="start communication \r\n";
uint8_t aRxBuffer[10];

void SystemClock_Config(void);

int main(void)
{
	uint16_t adc_value=0;
	float adc_cal=0.0;

   HAL_Init();

  SystemClock_Config();

	LED_Init();
	OLED_Init();

  MX_GPIO_Init();
  MX_ADC1_Init();
	
	OLED_ShowString(0,0,"ADC test",24);
	OLED_ShowString(0,32,"adc=0000",16);
	OLED_ShowString(0,48,"adc/3.3V=0.000",16);
	OLED_Refresh_Gram();	
	
  while (1)
  {
		LED_switch(LED0);
		HAL_Delay(500);
		
		HAL_ADC_Start(&hadc1);
		HAL_ADC_PollForConversion(&hadc1, 0xFF);
		adc_value=HAL_ADC_GetValue(&hadc1);
		adc_cal=(float)adc_value*3.3/4096;
		OLED_ShowNum(32,32,adc_value,4,16);
		OLED_ShowNum(72,48,(uint16_t)adc_cal,1,16);
		OLED_ShowNum(88,48,(uint16_t)((adc_cal-(uint16_t)adc_cal)*1000),3,16);
		HAL_ADC_Stop(&hadc1);
		
		
		OLED_Refresh_Gram();
	}	
}

```

## 内置温度测量器

STM32F10系列有内部温度计可以通过内部通道测量。在adc中选择Temperature（或者应该是IN16）开启。

公式：T=(V25-Vout)/Avg_Slop(V)+25

数据可在datasheet 113页看到。通常V25=1.43V，Avg_Slop=0.0043V/°C

刚开板子会出现小于10°的情况，放太阳下照照就上来了。
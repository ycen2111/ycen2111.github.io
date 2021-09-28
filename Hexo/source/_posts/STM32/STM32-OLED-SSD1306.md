---
title: STM32 OLED(SSD1306)
date: 2021-09-15 10:33:23
tags:
 - 编程
 - stm32
categories: 
- 单片机
---

## 介绍

此运用的硬件是ATK 096 OLED，基于SSD1306的OLED。这里的driver全复制于原子科技的例码。

注意：每次设置完内容后必须加上（OLED_Refresh_Gram();）刷新。

<!-- more -->

### oled.c

CS：拉低时开始片选oled
WR：写入数据
RD：读取数据
D[7:0]：数据位
RST：复位
DC：0为命令位，1为数据位

以写入命令为例：DC（RS）位拉低，CS拉低，WR拉低开始读取D[7:0]数据，然后再全部拉高完成。
``` Bash
#include "oled.h"
#include "stdlib.h"
#include "delay.h"
#include "oledfont.h"
 
//刷新屏幕
void OLED_Refresh_Gram(void)
{
	u8 i,n;		    
	for(i=0;i<8;i++)  
	{  
		OLED_WR_Byte (0xb0+i,OLED_CMD); //页数设置
		OLED_WR_Byte (0x00,OLED_CMD);//低八位
		OLED_WR_Byte (0x10,OLED_CMD);//高八位
		for(n=0;n<128;n++)OLED_WR_Byte(OLED_GRAM[n][i],OLED_DATA); 
	}   
}
#if OLED_MODE==1 //8080模式
 
//cmd=1: data mode, 0: command mode
//dat: required data
void OLED_WR_Byte(u8 dat,u8 cmd)
{
	DATAOUT(dat);	
 	OLED_RS=cmd;
	OLED_CS=0;	
	OLED_WR=0;	  
	OLED_WR=1;   
	OLED_CS=1;   
	OLED_RS=1;   
} 	    	    
#else //ISP mode
void OLED_WR_Byte(u8 dat,u8 cmd)
{	
	u8 i;			  
	OLED_RS=cmd;
	OLED_CS=0;		  
	for(i=0;i<8;i++)
	{			  
		OLED_SCLK=0;
		if(dat&0x80)OLED_SDIN=1;
		else OLED_SDIN=0;
		OLED_SCLK=1;
		dat<<=1;   
	}				 
	OLED_CS=1;		  
	OLED_RS=1;   	  
} 
#endif

//开启显示  	  
void OLED_Display_On(void)
{
	OLED_WR_Byte(0X8D,OLED_CMD); //设置电荷泵
	OLED_WR_Byte(0X14,OLED_CMD); //开启
	OLED_WR_Byte(0XAF,OLED_CMD);//开启显示
}

//关闭显示
void OLED_Display_Off(void)
{
	OLED_WR_Byte(0X8D,OLED_CMD);
	OLED_WR_Byte(0X10,OLED_CMD);
	OLED_WR_Byte(0XAE,OLED_CMD);
}		   			 

//清屏  
void OLED_Clear(void)  
{  
	u8 i,n;  
	for(i=0;i<8;i++)for(n=0;n<128;n++)OLED_GRAM[n][i]=0X00;  
	OLED_Refresh_Gram();
}

//画点   
//t=1: fill, t=0: unfill
void OLED_DrawPoint(u8 x,u8 y,u8 t)
{
	u8 pos,bx,temp=0;
	if(x>127||y>63)return;
	pos=7-y/8;
	bx=y%8;
	temp=1<<(7-bx);
	if(t)OLED_GRAM[x][pos]|=temp;
	else OLED_GRAM[x][pos]&=~temp;	    
}

//填块
//t=1: fill, t=0: unfill
void OLED_Fill(u8 x1,u8 y1,u8 x2,u8 y2,u8 dot)  
{  
	u8 x,y;  
	for(x=x1;x<=x2;x++)
	{
		for(y=y1;y<=y2;y++)OLED_DrawPoint(x,y,dot);
	}													    
	OLED_Refresh_Gram();
}

//显示字符
//size=12 or 16 or 24
//mode=1: 正常显示，mode=0: 反向显示
void OLED_ShowChar(u8 x,u8 y,u8 chr,u8 size,u8 mode)
{      			    
	u8 temp,t,t1;
	u8 y0=y;
	u8 csize=(size/8+((size%8)?1:0))*(size/2);
	chr=chr-' ';	 
    for(t=0;t<csize;t++)
    {   
		if(size==12)temp=asc2_1206[chr][t];
		else if(size==16)temp=asc2_1608[chr][t];
		else if(size==24)temp=asc2_2412[chr][t];
		else return;
        for(t1=0;t1<8;t1++)
		{
			if(temp&0x80)OLED_DrawPoint(x,y,mode);
			else OLED_DrawPoint(x,y,!mode);
			temp<<=1;
			y++;
			if((y-y0)==size)
			{
				y=y0;
				x++;
				break;
			}
		}  	 
    }          
}

u32 mypow(u8 m,u8 n)
{
	u32 result=1;	 
	while(n--)result*=m;    
	return result;
}				  

//显示数字
//num: 数字（0-429467295）
//len：位数
void OLED_ShowNum(u8 x,u8 y,u32 num,u8 len,u8 size)
{         	
	u8 t,temp;
	u8 enshow=0;						   
	for(t=0;t<len;t++)
	{
		temp=(num/mypow(10,len-t-1))%10;
		if(enshow==0&&t<(len-1))
		{
			if(temp==0)
			{
				OLED_ShowChar(x+(size/2)*t,y,' ',size,1);
				continue;
			}else enshow=1; 
		 	 
		}
	 	OLED_ShowChar(x+(size/2)*t,y,temp+'0',size,1); 
	}
} 

//打印字符串
void OLED_ShowString(u8 x,u8 y,const u8 *p,u8 size)
{	
    while((*p<='~')&&(*p>=' '))
    {       
        if(x>(128-(size/2))){x=0;y+=size;}
        if(y>(64-size)){y=x=0;OLED_Clear();}
        OLED_ShowChar(x,y,*p,size,1);	 
        x+=size/2;
        p++;
    }  
	
}	
				    
void OLED_Init(void)
{ 	 		 
    GPIO_InitTypeDef  GPIO_Initure;
	
    __HAL_RCC_GPIOB_CLK_ENABLE();   
    __HAL_RCC_GPIOC_CLK_ENABLE();  
	
#if OLED_MODE==1	/8080 mode	
	
	//PC6,7,8,9  
    GPIO_Initure.Pin=GPIO_PIN_6|GPIO_PIN_7|\
					 GPIO_PIN_8|GPIO_PIN_9;	 
    GPIO_Initure.Mode=GPIO_MODE_OUTPUT_PP;
    GPIO_Initure.Pull=GPIO_PULLUP;  
    GPIO_Initure.Speed=GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOC,&GPIO_Initure);   
	//PB0-7
    GPIO_Initure.Pin=GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3|\
					 GPIO_PIN_4|GPIO_PIN_5|GPIO_PIN_6|GPIO_PIN_7;        
    HAL_GPIO_Init(GPIOB,&GPIO_Initure);   
	
	__HAL_AFIO_REMAP_SWJ_DISABLE();	
	
	OLED_WR=1;
  	OLED_RD=1; 
#else	
 
    GPIO_Initure.Pin=GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_7;
    GPIO_Initure.Mode=GPIO_MODE_OUTPUT_PP;
    GPIO_Initure.Pull=GPIO_PULLUP; 
    GPIO_Initure.Speed=GPIO_SPEED_FREQ_HIGH;
    HAL_GPIO_Init(GPIOB,&GPIO_Initure); 
	
    GPIO_Initure.Pin=GPIO_PIN_8|GPIO_PIN_9;	
	HAL_GPIO_Init(GPIOC,&GPIO_Initure);
	
	OLED_SDIN=1;
	OLED_SCLK=1;
#endif
	OLED_CS=1;
	OLED_RS=1;	 
					  
	OLED_WR_Byte(0xAE,OLED_CMD);
	OLED_WR_Byte(0xD5,OLED_CMD); 
	OLED_WR_Byte(80,OLED_CMD); 
	OLED_WR_Byte(0xA8,OLED_CMD); 
	OLED_WR_Byte(0X3F,OLED_CMD); 
	OLED_WR_Byte(0xD3,OLED_CMD);
	OLED_WR_Byte(0X00,OLED_CMD); 
	OLED_WR_Byte(0x40,OLED_CMD); 									    
	OLED_WR_Byte(0x8D,OLED_CMD); 
	OLED_WR_Byte(0x14,OLED_CMD); 
	OLED_WR_Byte(0x20,OLED_CMD); 
	OLED_WR_Byte(0x02,OLED_CMD); 
	OLED_WR_Byte(0xA1,OLED_CMD); 
	OLED_WR_Byte(0xC0,OLED_CMD); 
	OLED_WR_Byte(0xDA,OLED_CMD);
	OLED_WR_Byte(0x12,OLED_CMD); 
	OLED_WR_Byte(0x81,OLED_CMD); //亮度
	OLED_WR_Byte(0xEF,OLED_CMD); //1-255
	OLED_WR_Byte(0xD9,OLED_CMD); 
	OLED_WR_Byte(0xf1,OLED_CMD); 
	OLED_WR_Byte(0xDB,OLED_CMD); 
	OLED_WR_Byte(0x30,OLED_CMD);
	OLED_WR_Byte(0xA4,OLED_CMD); 
	OLED_WR_Byte(0xA6,OLED_CMD);     						   
	OLED_WR_Byte(0xAF,OLED_CMD); 
	OLED_Clear();
}  

```

### oled.h

``` Bash
#ifndef __OLED_H
#define __OLED_H
#include "sys.h"

//0:四线模式
//1:8080模式
#define OLED_MODE 	1
		    						  	
#define OLED_CS     PCout(9)
//#define OLED_RST  PGout(15)//已有reset位
#define OLED_RS     PCout(8)
#define OLED_WR     PCout(7)
#define OLED_RD     PCout(6)
 
//PB0~7,数据线
#define DATAOUT(x) GPIOB->ODR=(GPIOB->ODR&0xff00)|(x&0x00FF); 

//SPI通信
#define OLED_SCLK   PBout(0)
#define OLED_SDIN   PBout(1)

#define OLED_CMD  	0		//命令位
#define OLED_DATA 	1		//数据位

void OLED_WR_Byte(u8 dat,u8 cmd);	    
void OLED_Display_On(void);
void OLED_Display_Off(void);
void OLED_Refresh_Gram(void);		   
							   		    
void OLED_Init(void);
void OLED_Clear(void);
void OLED_DrawPoint(u8 x,u8 y,u8 t);
void OLED_Fill(u8 x1,u8 y1,u8 x2,u8 y2,u8 dot);
void OLED_ShowChar(u8 x,u8 y,u8 chr,u8 size,u8 mode);
void OLED_ShowNum(u8 x,u8 y,u32 num,u8 len,u8 size);
void OLED_ShowString(u8 x,u8 y,const u8 *p,u8 size);
#endif
```

### 实例

``` Bash

```
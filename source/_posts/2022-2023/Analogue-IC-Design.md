---
title: Analogue IC Design
date: 2022-11-04 12:39:39
tags:
 - 2022-2023
categories: 
 - academic material

password: frank
---

slides:[https://pipirima.top/2022-2023/Analogue-IC-Design-Slides-ee210f4e9f8f/](https://pipirima.top/2022-2023/Analogue-IC-Design-Slides-ee210f4e9f8f/)

# Introduction
The previous several slide is almost same as the slids in undergraduate and been ignored.

![101.png](101.png)
Normally in real manufactory, there have two more taps placed on two sides of MOSFET, in order to avoid body effect and let MOSFET works more like a FET.
![102.png](102.png)
A MOSFET device with multiple view directions:
![103.png](103.png)

Development of FET:
Transistor -> LOCOS -> STA -> High-K/Metal gate -> FinFET -> RibbonFET

Chips are made my many wires called "Interconnect" which influences the speed, Power, and Noise in chip.
![104.png](104.png)

There have three types of wires used in chip design
M1 for within-cell routing
M2 for vertical routing between cells
M3 for horizontal routing between cells
More deeper the chip is, Much thiner and narrower the wires is.
![105.png](105.png)

For packaging, Ball-Wedge gold wire for low currents and Wedge-Wedge aluminum for high currents
![106.png](106.png)

# FET theory
A FET(filed-effect transistor) is worked based on generated channel between source and drain terminal (by the effect of applied voltage)
![201.png](201.png)
Normally the VT for n-mos is 0.3-1.0 V. Opposite value for p-mos

Quantity of charge in the channel is
![202.png](202.png)
where C is capacitor and A is area, d is distance


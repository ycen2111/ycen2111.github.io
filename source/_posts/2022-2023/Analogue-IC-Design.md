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
![203.png](203.png)
And Cox=εox/tox, tox is thickese of oxid, εox= material permittivaty*ε0, ε0=8.854 E−12 F/m

Normally N-mos is better than P-mos as electron mobility if nearly 2-4 higher than holes. hence N-mos can be switched much faster.

![204.png](204.png)
![205.png](205.png)
Kn is the MOSFET transconductance parameter

![206.png](206.png)
the id and rds can only used on VDS is small number

![207.png](207.png)
![208.png](208.png)
the final channel width is influenced by VDS. this figure is shown cases when Vov>VDS (non-saturation)

![209.png](209.png)
![210.png](210.png)
and the final channel width will completely disappeared (pinch-off) when VDS>Vov (saturation region)

![211.png](211.png)
![212.png](212.png)

The output resistence r0 for saturated transistor is inifite, but in practice, increasing VDS beyond Vov does affect the channel. As VDS is increased, the channel pinch-off point is slightly moved away from the drain towards the source. which is called “channel-length modulation”.
the slop in channel-length modulation is = 1/r0
with “channel-length modulation” :
![213.png](213.png)
![214.png](214.png)

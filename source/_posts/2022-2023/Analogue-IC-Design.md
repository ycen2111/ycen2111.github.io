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
the slop in channel-length modulation is = 1/r0 = (1+λVDS)/λID = 1/λID
with “channel-length modulation” :
![213.png](213.png)
![214.png](214.png)

the body effect is happened when the voltage drop on body terminal is not equals voltage on source.
Normally will influence Vth voltage
![215.png](215.png)

# FET amplifiers (part1)
![301.png](301.png)
small signal can only use in AC analysis
set all DC voltage in zero
large capacitor becone short
analyse using Ohm’s Law and Kirchhoff’s Laws
get gm and rds
![304.png](304.png)

![302.png](302.png)
this the the most useful amplifier module
Rin is the amplifier inputimpedance (usually infinite for perfect MOS circuits)
Rout is the amplifier output impedance
G is the amplifier gain, usually negative

the ideal transistor plot in saturation region should be a linear current mirror for both p-type and n-type transistor
![303.png](303.png)
this slop will be horizontal if Rout is infinite

![305.png](305.png)
![306.png](306.png)

the Diode connected FET is always in saturation region
![307.png](307.png)
where VDS=VGS, AC resistence assumed as 1/gm
a Diode-connected active load is:
![308.png](308.png)
![309.png](309.png)
gm2Vout can be seen as a resistance g2. hence
![310.png](310.png)
because gm>>gds, 
Av will just be like -gm1/gm2, and
![311.png](311.png)
So the gain will be very small in this amplifier. For high gain, then the device will have disproportionately wide or long transistors
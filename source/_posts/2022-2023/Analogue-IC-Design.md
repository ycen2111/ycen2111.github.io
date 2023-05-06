---
title: Analogue IC Design
date: 2022-11-04 12:39:39
tags:
 - 2022-2023
categories: 
 - academic material
---

slides:[https://pipirima.top/2022-2023/Analogue-IC-Design-Slides-ee210f4e9f8f/](https://pipirima.top/2022-2023/Analogue-IC-Design-Slides-ee210f4e9f8f/)

<!-- more -->

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
Signal analysis steps
1. small signal can only use in AC analysis
2. set all DC voltage in zero
3. large capacitor becone short
4. analyse using Ohm’s Law and Kirchhoff’s Laws
5. get gm and rds
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
where gm is from transistor, and gds+GD is for other resistance

## Diode connected FET
the Diode connected FET is always in saturation region, which can be seen as a resistance
![307.png](307.png)
![429.png](429.png)
where VDS=VGS, AC resistence assumed as 1/gm
a Diode-connected active load is:
![308.png](308.png)
![309.png](309.png)
gm2Vout can be seen as a resistance g2. hence
![310.png](310.png)
because gm>>gds, 
Av will just be like -gm1/gm2, and
![311.png](311.png)
So the gain will be very small in this amplifier. 
For high gain, then the device will have disproportionately wide or long transistors, which will cause limited bandwidth

Which channel length modulation:
![313.png](313.png)
![312.png](312.png)

## Key points:
Gain=gm*Rl
where gm converter input voltage to input current,
and Rl converter output current into output voltage

Bandwidth=1/(Rl*Cl)
where Rl is output impedance
Cl is output load capacitor

Hence Gain-Bandwidth product (GBP)=(gm * RL ) * [1/(RL CL )] = gm /CL


## Current Source Load
![314.png](314.png)
the P-mos can be seen as current source and must in saturation region
while N-mos is best be saturation
small signal:
![315.png](315.png)
![316.png](316.png)

# FET amplifiers (part2)

## Two Transistor (CMOS) Amplifier
![401.png](401.png)
Advantage: high gain, not too many noise
Disadvantage: hard to maintain DC bias, take lot DC current

![402.png](402.png)
The current is maximum vakue if P-mos and N-mos are saturated
input voltage -> id current -> output voltage
N-mos: A->C cutoff, C->E active, E->F saturated, F->K active
Pmos: A->E Active, E->F Saturated, F->I Active, I->K cut-off
![406.png](406.png)
VM is voltage when Vin=Vout

![403.png](403.png)
(?)
Note that in Cmos Amplifier, the T-rise time will be shorter than T_fall time, as resistance in P-mos is smaller than in N-mos

small signal analysis
![404.png](404.png)
![405.png](405.png)

## Source follower (common-drain circuit)
![407.png](407.png)
1. use N-mos
2. SF has gain approximate as 1
3. Can be seen as a buffer
4. Easy to have body effect as VBS=Vout is large
![408.png](408.png)
![409.png](409.png)
which gain will slightly less than 1
So SF usually beed connect bulk and source together to limite body effect, but also will limite bandwidth

## Cascode amplifier
![410.png](410.png)
1. R3 is a current-source load, and also can be seen as a resistance
2. Vbias2 is constant, so VS2 is also constant
3. So M1 has a constant current, and no λ term in M1. Hence output resistance of M1 is very high
4. No Miller effect

![411.png](411.png)
M3 has been a resistance
![412.png](412.png)

![413.png](413.png)
the amplifier with cascode can increase its gain in factor of gm2/gDS2

![414.png](414.png)
the Vin can be ignored because only output current is interested
![415.png](415.png)
![416.png](416.png)
output resistance is only related with M1 and M2

Hence Cascode can increase Gain and output resistance in factor of gm2/gDS2

## AC circuit analysis
![417.png](417.png)
the RC circuit is a low-pass filter. It has circuit bandwidth:
![418.png](418.png)
![419.png](419.png)

So the final bandwidth is completely controlled by resistance and capacitor:
![420.png](420.png)
the small signal cna be chaned as:
![421.png](421.png)
where CM = Cgd1 + Cgd2
according to node analysis, Rout can be changed as:
![422.png](422.png)
R_parallel ≈ Rin , just the original value
R_series ≈ Rout /(G + 1), relatively small
and the small signal can be changed as:
![423.png](423.png)
![424.png](424.png)
1. two amplifiers are in cascade
2. Cin1 and Cin2 will be increased greatly based on Miller effect

## Body effect
![425.png](425.png)
Normally the bulk is connect to VDD or VSS to svoid body effect,
But Change the voltahe drop on substract will influence threshold voltage.

1. if bulk voltage drop decreased, more wider the depletion region will be
2. wider depletion region need to charge more electrics
3. Vt threshold voltage is related with depletion region's charge effect
4. So bigger body effect means bigger threshold voltage

![427.png](427.png)
φf is usually 0.35V, γ is usually 0.5(V)^(1/2)
![426.png](426.png)
gmbs is based on body effect
![428.png](428.png)

# Current mirror
Both n-type and p-type transister can be analyzed as current source
![501.png](501.png)
![502.png](502.png)
a ideal current source should have vary high output impedance and very low input impedance, means gain of amplifier will be really low -> only current, but no voltage, will be changed

## Basic current mirror
![503.png](503.png)
Rout=1/λId
Rin≈1/gm

If we assume:
Vmin(M1)=Von+Vt, than
Vmin(M2)=Von
hence both transistors must in saturation region

Small signal of M2:
![504.png](504.png)
because vin from M1 is always constant, hence Vin is a DC voltage, hence should be ignored in this case
hence M2's small signal circuit is just a resistance
Where rDS2 is rout

1. fixed Iref and M1 makes VGS2 constant
2. constant VGS2 and saturated M2 makes Ids2 constant
3. But value of VDS2 is variable, so Ids2 will also varying
So we have a small input impedance and huge output impedance (1MΩ, but still not enough to most purpose)

## Wilson current mirror
Wilson current mirror is a negative feedback system
![505.png](505.png)

1. if Iout rises, VDS2 also rises
2. VGS1 rises, but Iref not change, hence VDS1 falls
3. VGS3 falls, hence Iout falls again

current gain of Wilson current mirror is same as basic current mirror

![506.png](506.png)
![507.png](507.png)
![508.png](508.png)
So rout≈gm*rds^2

Vout(min)=2Von+VT,
as VDS2=Von+VT, VDS3=Von

## Cascode current mirror
![509.png](509.png)
![510.png](510.png)
analysis order: M1 -> M3 -> M4 -> M2
Vout(min)=2Von+VT,
and VDS1=VDS2, which mean no need to worry about channel length modulation

small signal:
![511.png](511.png)
M1 and M3 are diode connect, can directly been ignored
VG2 and VG4 are all constant, hence VG2=VG4=0
hence VGS2=0, M2 just has resistance
![512.png](512.png)
``` Bash
process:
Vo=Vds2+(Io-gm4Vgs4)*rds4
Vo=Iords2+(Io-gm4Vgs4)*rds4
Vo=Iords2+(Io+gm4*Iords2)*rds4
Ro=rds2+rds4+gm4rds2rds4
```
rout≈gm*ro^2
which is a hign output impedance

therefore,
![513.png](513.png)
If we make W/L for M2 “n” times bigger than W/L for M1, Iout = nIref

This is an important result, as we could use it to make a DAC, as different W/L ratio will result in different current output, and we could sum them together to get analodge value.

# Diff amplifier
A differential signal: Measured between two nodes that have equal and opposite signal excursions around a fixed potential. 
![601.png](601.png)
Note: the potential dash line in middle of borh signal is called 'Common Mode'(CM) level
VP is VCM

![602.png](602.png)
Common-mode rejection ratio (CMRR):
![603.png](603.png)
AVID = differential-mode voltage gain
AVCM = common-mode voltage gain
VID = differential-mode voltage (with different phase)
VIC = common-mode voltage

# Large signal:
![604.png](604.png)
Vid=vgs1-vgs2
Iss=iD1+iD2

![605.png](605.png)
because ISS is from current source, it cannot change. Hence iD1+iD2 is always constant

![607.png](607.png)
![606.png](606.png)

for differential gain:
![608.png](608.png)
![609.png](609.png)

for common mode gain:
![610.png](610.png)
so iD and vcm have no relations.

# Small signal:
![611.png](611.png)
Small signal can only analysis half part because symmetric
parallel 2*2RS is total in RS only, the output impedence in current source

![612.png](612.png)
(?)

## Diode connect load
![613.png](613.png)

## Current mirror load
![614.png](614.png)
• Vin1 and Vin2 are VCM only
• gm1 = gm2
• gm3 = gm4
• ro1 = ro2
• ro3 = ro4
• I3=I4

Common mode:
![615.png](615.png)
![616.png](616.png)

differential:
![617.png](617.png)
![618.png](618.png)
only o2 is related with differential voltage

![619.png](619.png)
the current mirror amplifier is better,
as it has almost fixed common mode gain (around 1/2)
as big differential gain
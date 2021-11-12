---
title: EEE348 Electronics and Devices
date: 2021-09-27 14:09:55
tags:
 - 2021-2022
categories: 
 - academic material

password: frank
---

# week 1

## Trends
The Moore's Law(1965):“The functionality of devices doubles every 18 months” or “the cost of the same functionality halves every 18 months”
ButIt will come to an end - due to basic physics if nothing else.

The structure of FET(Field Effect Transistor)
![101.PNG](101.PNG)
Scaling can be done as λ→λ/s (s>1)

| components | rate |
|:----|:----|
| Area(s^2) | 1/(s^2) |
| Speed(v) | s |
| Capacitance(C) | 1/s |
| Resistance(R) | s |
| RC | 1 |

## Intrinsic Limits

The problems might be appeared when reached 10nm fabrication

| Name | Problem | solution | Shortcoming |
|:----|:----|:----|:----|
| Gate Oxides | Thinner oxides means increased tunnelling| Change other materials| Have higher εr|
| Gate Electrode Material| Same with the problem in oxides| using metal electrodes| more complex processing|
| Low k Insulators| Lower permittivity are required while device scaled down| perfectelly towards 1| |
| Lithography| more shorter wavelength required(toward 157nm)| using Extreme UV(13nm soft x-rays used)| light is not powerful enough/expensive|
| Doping| Only 100 dopant atoms in the active region| 

## History

![102.PNG](102.PNG)

# week2

## Implementation technology

There have many possible ways to achieve and implementate a circuit.

Programmed logic devices(PLD):
PLD is the simplest ASIC structure.
![201.PNG](201.PNG)
![202.PNG](202.PNG)
The signals inputed from pin 1,2,3 and outputed through pin 17,18,19.
each intersections will be connected by a transistor and a switch, and controlled signals to OLMC.

Complex PLDs (CPLD):
very same to PLD but with higher gate number.
It shared some interconnect logics globally, have fast transmit speed in single macrocell but not between two cells.
![203.PNG](203.PNG)

Field Programmable Gate Array (FPGA):
FPGA is created by many configurable logic blocks(CLB). Each CLB is progeammable and can implement big range of functions. FPGA can designed by HDL, and access multiple erasing and writing process.

Masked Gate Array (MGA):
Its ICs are manufactured to your specification in a Semiconductor Fabrication Facility (Fab). all og logics are acieved by NAND gate.
![204.PNG](204.PNG)

Structured ASICs(SA):
Like a combination of FPGAs and MGA. it may have predefined RAM blocks, and other functional units already manufactured into the device

Cell-Based ASICs (or Semi-Custom):
more complex than MGAs in that the design can be composed not just of NAND gates but of gates drawn from a library of cells like NOT,AND,FF,ADD etc.

| name| gate number| delay| cost|
|:----|:----|:----|:----|
|PLD|100|1-10ns|$1-2|
|CPLD|5000|5ns|$10-50|
|FPGA|5000-5M|3-4ns|$50-3000|

## Design flows

Customer: Requirements Specification->Design Specification-> Architectural Soecification->coding in HDL->Synthesis->Placement->Routing->Design Rule

# week3

## MOS device

MOSFET is combined with Metal-Oxide-Semiconductor(MOS) and Field-Effect Transistors(FET) these two devices. It can differentiated as p-MOSFET and n-MOSFET based on differente using materials.
![301.PNG](301.PNG)

The n-MOSFET's cross-section representation is as follows:
![302.PNG](302.PNG)

|Vbb|Vds|Vgs|state|
|:----|:----|:----|:----|
|0V|0V|0V|two back-to-back diodes|
|0V|0<Vds|0<Vgs<Vt|cut-off|
|0V|0<Vds|0<Vt<Vgs|ohmic contact|
|0V|Vgs-Vt|0<Vgs<Vt|saturated(pinches-off)|

The current through source and drain can be explaied as:
![303.PNG](303.PNG)
where λ is Channel-length modulation parameter,
Kn is the value of term
![304.PNG](304.PNG)

For p-MOSFET bahaves identically to n-MOSFET but with reversed polarities. performed as:
![305.PNG](305.PNG)

But normally, less current will through p-MOSFET than the n-MOSFET with same area and environment.

## CMOS circuit

A CMOS circuit contains both the p-MOSFET and n-MOSFET. But generally less components will contained in reality than imagination.
In digital circuit, the substrate connection for n-MOSFET would be connect to negative supply and p-MOSFET is in reverse.

## Inverter Characteristics

The simpliest CMOS circuit is worked as an inverter:
![306.PNG](306.PNG)
![307.PNG](307.PNG)
when Vin=0, Vout=1;
when Vin=1, Vout=0;

## Threshold value

if we assume Vtp=-Vtn, Kp=Kn, than
Vin=Vdd/2
hence the threshold value can be seen as:
![308.PNG](308.PNG)

normally, if let Vdd=3.3V, Vt=0.7V, the threshold voltage will changed rapidly.

## Parasitics

Many paracitics components have associated in MOSFET
![309.PNG](309.PNG)
The capacitor can calculated as
![310.PNG](310.PNG)

## Body effect

Normally the stack MOSFETs have same well and share the same substrate voltage,
![311.PNG](311.PNG)
But in reality Vbb between them will be changed and Vt increases up on the stack.

## rise/fall time

![312.PNG](312.PNG)

# week4

The standard CMOS circuit
![401.PNG](401.PNG)
pull-up network→pMOSFET, pull-down netweork→nMOSFET

![402.PNG](402.PNG)
figure 2 implements an AND and figure 3 shows OR funvtion.

example:
for nand ligic gate,
Y=A'+B', Y'=A*B
![403.PNG](403.PNG)

For XOR gate,
![404.PNG](404.PNG)

## resistance and capacitance calculation
CG: capacitance value on the gate
CD: capacitance value on the drain

A=m1CG+m3CG+m6CG+m8CG
Z=m5CD+m7CD+m8CD+m9CD+m11CG+m12CG

||PULL-down|PULL-up|
|:----|:----|:----|
|X|R0/m3+R0/m4|2R0/m1 or 2R0/m2|
|Y'|R0/m8+R0/m10|2R0/m5 or 2R0/m6+2R0/m7|

value of pull-down and pull-up need to be same, assume µE/µH=2, get
m1=m2=2, m3=m4=2
m8=m10=2, m5=2, m6=m7=4.

hence A=10CG, Z=10CD+3CG

## pass transistors

using transistor as a switch to open and cloce a circuit.
![405.PNG](405.PNG)
the output resistance can be R0=5/(β N (VDD −VT ))

## transmission gate
![406.PNG](406.PNG)
R0=1/(β (VDD −VT ))

|A|G|Y|
|:----|:----|:----|
|0|0|U|
|0|1|0|
|1|0|U|
|1|1|1|
U: unknowed, Y's state can be decided if both n and p MOSFET are closed

![407.PNG](407.PNG)
In this case output will never be worried. if G=0, Y=A; if G=1.Y=B.

# Week 5

![501.PNG](501.PNG)
![502.PNG](502.PNG)
Flip-Flop and latch block diagram

implementation of ltach
![503.PNG](503.PNG)
but if G changed later than inverser, clock diagram will be in mess, hence clock generation is needed for generate some "delay" area
![504.PNG](504.PNG)

## metastability

problem will happened if D is changing while clk is raising as well. its state will became metastability and influce further functions.
this issue only happenes on asynchronous system

the property of probability is
![505.PNG](505.PNG)
where tr is the time from clk edge to the time that must output something
tc is constant associated, basically 1/GBW of the sampling circuit
T0 is constant vlaue, is related to technology and circuit design
(the T0 and tc should be small for a good design)

and the number of upsets will be
![506.PNG](506.PNG)
if upset=288, means every 1/288=3.4ms will cause a problem

in poisson distribution form, the rate of happening k times error in λ seconds is
![507.PNG](507.PNG)
λ is rT_MTTF(mean time to fail)

![508.PNG](508.PNG)
where 1-η=P(k;λ)

or
![509.PNG](509.PNG)

# Week6

a n-channel MOSFET
![601.PNG](601.PNG)

![602.PNG](602.PNG)
A: VGS=VDS=0
B: Vgs=0, VDS>0
C: VGS>0, VDS<VOV (VOV=VGS-VTo=over drain voltage)
D: VGS>0, VDS=VOV
E: VGS>0, VDS>VOV

![603.PNG](603.PNG)
![604.PNG](604.PNG)
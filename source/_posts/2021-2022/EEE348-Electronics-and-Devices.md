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
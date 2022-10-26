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

# week 7

## small signal model
![701.PNG](701.PNG)

for transconductance
![702.PNG](702.PNG)
![703.PNG](703.PNG)

## Π diagram
![704.PNG](704.PNG)

## T diagram
![705.PNG](705.PNG)

# Week 8

## Common source amplifier
a common amplifier to increase output voltage value based on a FET
![801.PNG](801.PNG)
the input Vg=Vsig+Vbias with relationship like follows:
![802.PNG](802.PNG)
the red slop have function ID=(VDD-Vd)/RD, and the x/y-axis when it cross the blue curve is seperataly the voltage output from Vout and current through transistor. the cross point need be choicen as in the saturated region and be in middle part as Vbias=2V

gain of this common source amplifier is
![803.PNG](803.PNG)

## common drain amplifier
![804.PNG](804.PNG)

Vbias=VS(best bias point)+Vov+Vto

for creayting small cignal circuit:
short-circuit any DC voltage source (also change power supply into groung)
short-circuit ant capacitors in circuit
open-circuit any constant current cource of inductors
replace NMOS with equivalent circuit

![805.PNG](805.PNG)
![806.PNG](806.PNG)

this amplifer acts like a voltage buffer, accurancy volatge is depends on Q-point.

## common gate amplifier

![807.PNG](807.PNG)
Vs=Id*Rsig
Av=vd/vsig=gm*Rd/(gm*Rsig+1)

![808.PNG](808.PNG)

have low input impedance, non inverting current, unit current gain
voltage gain is same as common source amp
can be used as a current buffer.

|type|volatage gain|
|:----|:----|
|common source|-RD*gm/r0|
|common drain|gm*Rs/(1+gm*RS)|
|common gain|gm*Rd/(gm*Rsig+1)|

# Week9

## voltage divider biasing
this circuit can provide high bias stability
![901.PNG](901.PNG)
but the current flow through M1 will be influenced by temperature with constant VGS supply
![902.PNG](902.PNG)

by adding a feedback resistor RS can provide a slop in Id diagram, for decreasing this temperature error
![903.PNG](903.PNG)
![904.PNG](904.PNG)
but this design still need large number of transistors and large Rs requires more voltage headroom to operate

## current source biasing
![905.PNG](905.PNG)
the current source have provided a stable and constant current flow id, because the voltage error in same current is smaller than the current error produced in same voltage.

but this error can still be decreased if set a FET in the source port to plot the horizontal line
![906.PNG](906.PNG)
![907.PNG](907.PNG)

# Week 10

## current mirror
![1001.PNG](1001.PNG)
current through M2 is basically same with current through M1
Iout/Imaster=(W(M2)/L(M2))/(W(M1)/L(M1))
means a constant current biasing is worked

current steering
![1002.PNG](1002.PNG)

diode connected
![1005.PNG](1005.PNG)
FET works like a diode at this time. the transistor will always in saturated region

![1006.PNG](1006.PNG)
hence the voltage and current in M2 can both been controlled based on diode connected.
![1007.PNG](1007.PNG)

dy/dx=1/r0=lamuda*Id0
because smaller slope is needed for smaller error, ro need be increased

Wilson current mirror(advanced design)
![1008.PNG](1008.PNG)
Vout↓,Im3↓,Im2↓,VGSm2↑,VGSm1↑,IR↓,V1↑,Im3↑
![1009.PNG](1009.PNG)
![1010.PNG](1010.PNG)

## Active loading
load a resistor on drain part
![1003.PNG](1003.PNG)
but it can not easily increasing voltage gain course FET will into triode region

can be solved by a FET
![1004.PNG](1004.PNG)

# Semiconductor
Adachi: [https://find.shef.ac.uk/primo-explore/fulldisplay?docid=44SFD_ALMA_DS51248442680001441&context=L&vid=44SFD_VU2&lang=en_US&search_scope=SCOP_EVERYTHING&adaptor=Local%20Search%20Engine&tab=everything&query=any,contains,adachi&offset=0](https://find.shef.ac.uk/primo-explore/fulldisplay?docid=44SFD_ALMA_DS51248442680001441&context=L&vid=44SFD_VU2&lang=en_US&search_scope=SCOP_EVERYTHING&adaptor=Local%20Search%20Engine&tab=everything&query=any,contains,adachi&offset=0)

formular sheet: [online formular sheet](https://vle.shef.ac.uk/bbcswebdav/pid-5365886-dt-content-rid-36603126_1/xid-36603126_1)
# Week13
![1301.PNG](1301.PNG)
Bolck from left to right is Metal, Semiconductor, and Insulator

|Metal|Semiconductor|Insulator|
|:----|:----|:----|
|Conduction band and valence band overlapped|Band gap changed from meV to 9 eV| Band gap larger than 9eV|
|Electrons move freely|no electrons in CB at T=0, get thermal energy kT=26meV wen T=300|Negligible electron in CB|
|good conductor|depend on number of electrons|no current conduction|

The current density is influenced by both drift and diffusion seperatly with two parts:
![1302.PNG](1302.PNG)
where q=1.6*10^-19 as a constant

Electron consentration:
![1303.PNG](1303.PNG)
Nc: effective density of state in conduction band
EC: bottom of conduction band
Ef: fermi level

chemical elements table and lattice constant:
![1304.PNG](1304.PNG)
![1305.PNG](1305.PNG)
more ↓ elements are, more smaller bandgap will have, much bigger the lattice constant is, higher electron mobility

Direct band gap semiconductors (GaAs, InGaAs) are much more efficient emitter than indirect band gap semiconductors (Si,Ge)

Semiconductors with the same lattice constant as the substrate can be grown with minimal crystal defects

# week14
Energy level on each electrons is not same with different orbital
![1401.PNG](1401.PNG)
and energy level will slightly decrease if more atoms are placed side by it.

![1402.PNG](1402.PNG)
If E0, or band gap(the difference between 4th and 5th band) is minimum (then Eg), the semiconductor has a direct bandgap
If Eg is minimum (with E0), semiconductor has an indirect bandgap.
![1403.PNG](1403.PNG)
Adachi p.135

importance of carrier mobility: High mobility increases carrier drift velocity.
![1405.PNG](1405.PNG)
Carrier velocity ν = μE (μ = mobility, E = electric field)
m is effective mass

Density of states N(E) is defined as the density of allowed energy states per energy range per unit volume.
![1406.PNG](1406.PNG)

Schrodinger equation:K+U=E,
where the total energy is given by the sum of kinetic(K) energy and potential(U) energy

![1404.PNG](1404.PNG)
some mixed elements, like AlGaAs, its gap energy will change depends on different ratio the different elemrnts it has.
like, Al0.5Ga0.5As has the middle energy between AlAs and GaAs.
AlxGa1-xAs means it has x% AlAs and (1-x)% GaAs.
(the emitted energy is E(eV)=hc/λ(um), h=6.62607015×10^（-34） J·s,c=3*10^(8))

# Week 15
Carrier concentration plays a critical role in determining how much current a semiconductor can conduct

Ef is Fermi level corresponding to the probability of electron occupancy of 0.5 in n type semiconductor:
![1501.PNG](1501.PNG)
![1502.PNG](1502.PNG)
Ec is conduction band, n is electron concentration, Nc is effictive density of states in conduction band, in room temperature kT=26meV 
the fermi level in n-type is dependent on the electron concentration
the interinsic carrier concentration ni^2=np

Doping type depends on number of groups in elements table.
N-type: in group V and VI
P-type: in group II and III
![1503.PNG](1503.PNG)
Increasing the n-type dopants will increase the conductivity ( hence reduce the resistivity) of the n-type semiconductor.

Carrier Recombination
A: Generation-recombnation due to trap levels(SRH)
B: Rafiative Recombination
C: Auger Recombination
![1504.PNG](1504.PNG)

# Week 16
The intensity of light travelling through a semiconductor is given by
![1601.PNG](1601.PNG)
x is position, alpha is the optical absorption coefficient

![1602.PNG](1602.PNG)
multiple materials can be used for maximum absorbe different wavelength. 
the wave length will reduced from top to bottom, and bandgap need also reduce to absorb them

dark current is the emitter that without absorbing any photon (band gap energy can only influence dark current)
photo current is the normal light current
the total current when the diode is illuminated (different function in formular sheet?????)
![1603.PNG](1603.PNG)
Is=short circuit current
Vov=open circuit voltage
Pm=ImVm=maximm output power

![1604.PNG](1604.PNG)

several ways to maximum fill factor: increase Im and Vm:
1.Minimise reflected light at the air/semiconductor interface since ~31% of light is reflected.
2.Maximise light absorption using a thick absorption region.
3.Reduce carrier recombination near the surface which has high density of dangling bonds.
4.Maximise generated photocurrent using materials with long minority carrier diffusion lengths
5.Minimise the dark current using low defect materials. (large bandgap and low temperature also help)

//
Iph measured photocurrent
Popt incident optical power
η quantum efficiency
G(x) optical generation rate
W depletion width
φ0 photon flux
α absorption coefficient
Rres Responsivity
Iph shot noise to 
derive the minimum optical power 
required to produce SNR =1 
x diffuse distance
vs drift velocity
tr transit time
fRC RC time limited bandwidth
A area
τ Recombination lifetime
tr Transit time
σ conductivity of the semiconductor
h Planck constant
p carrier momentum
En quantised energy level

β hole ionisation coefficients
α electron ionisation coefficients
x carrier injection position
F noise factor
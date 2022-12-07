---
title: Principle of Microelectronics
date: 2022-12-07 12:02:06
tags:
 - 2022-2023
categories: 
 - academic material
 - PDF

password: frank
---

Formular sheets and slids: (https://pipirima.top/2022-2023/Principle-of-Microelectronics-Slides-4dd36568acfc/)

# Liquid crystal display (LCD)
## EMR:
Visible light is a form of Electro-Magnetic Radiation (EMR) with wavelength in the region 390 - 750 nm (790 - 400 THz).
EMR have both electric and magnetic field components. the normal propagating traced as an ellips, but some special cases will include a circle (circularly polarized) or a straight line (linearly polarized)
![2-2-1.png](2-2-1.png)
![2-2-2.png](2-2-2.png)

## liquid crystal
“liquid crystal” describes a group of meso-phases between solid crystal and isotropic liquid that exist for a number of organic molecular materials.
![2-2-3.png](2-2-3.png)
liquid crystal is a state between liquid and solid. It can bound some moleculars, but can also rotate.

the LC moleculars are normally in two shaps: rod-like (used in LCD) and disk-like (in other applications)
The LC particles can usually be aligned by some 'surface force' when placing between two plates. We can also control their direction by electric field.Use electric force.
![2-2-4.png](2-2-4.png)

![2-2-5.png](2-2-5.png)
![2-2-6.png](2-2-6.png)
S is an order parameter that shows how well the eceltric field control LC's direction. bigger S is, more LC moleculars will face the correct direction

![2-2-7.png](2-2-7.png)
![2-2-8.png](2-2-8.png)
the dielectric permittivity  ε is a physical quantity describes how LC molecular will be effected by electric filed.
dielectric anisotropy is: Δε = εII - ε⊥
if Δε>0, LC molecular will be parallel with electric field, 
if Δε<0, it will be perpendicular with electric field.

many LC material configurations exhibit switchable birefringence, where birefringence material is one in which the refractive index alongone axis (extra-ordinary) is different to that along the other two (ordinary) perpendicular axesl that outputs two different polarized light waves, like rambow-colored plastic.

![2-2-12.png](2-2-12.png)
(a)Splay shape, k11
(b)Twist shape, k22
(c) Bend shape, k33
![2-2-13.png](2-2-13.png)

this is a basic LCD structure
![2-2-9.png](2-2-9.png)
1. Analyzer and Polarizer are all polarized board.
2. Indium Tin Oxide (ITO) electrode is a transparent conductive material,
3. Align layer can align LC particles into twisted or other shapes whenthere have no electric field
4. LC layer <1 to several µm thick
5. Modern LCD has many other structures

## Twisted Nematic (TN) Effect
![2-2-10.png](2-2-10.png)
left part can pass the light, but right part will block the light.
the twisted LC psrticles are influenced by align layer, while straight LC particles are forced by electric field

the Active-matrix liquid-crystal display (AMLCD) strcture:
![2-2-11.png](2-2-11.png)

![2-2-14.png](2-2-14.png)
Vth is the point when LC particles start to move based on electric field, which is called Freedericksz Transition
![2-2-15.png](2-2-15.png)
![2-2-16.png](2-2-16.png)

## Vertically Aligned (VA) LC
![2-2-17.png](2-2-17.png)
VALCD use negative dielectric anisotropy which are aligned perpendicular to the electric field

## In-Plane Switching (IPS) LC
![2-2-18.png](2-2-18.png)
use positive dielectric anisotropy, and creates much lower viewing angle dependence than in TN and VA displays

# LCD passive matrix addressing
LCD can be drived by active-matrix driver or passitive-matrix driver.
we want fast in active matrix, but slow in passitive matrix
![2-4-1.png](2-4-1.png)

the passive matrix:
![2-4-2.png](2-4-2.png)
• Back electrode is vertical columns
• Front electrode is horizontal rows (?)
• M*N pixels requires only M+N drivers

working process:
1. select first row
2. drive some column lines, so some pixcels on first row will turn on
3. select seond rwo, and go on

![2-4-9.png](2-4-9.png)

the real waveform of passive matrix, assume Vth=1.7V, is like:
![2-4-3.png](2-4-3.png)
where 3-1=2, Voff=((2^2+3)/4)^0.5=1.3
![2-4-4.png](2-4-4.png)
3-(-1)=4, Von=((4^2+3)/4)^0.5=2.2
![2-4-5.png](2-4-5.png)

foe example, in following figure, only point D2S2, D2S3 will turn on
S1,2,3,4 are turned one by one,
but D1234 are turned (on or off) in same time
![2-4-6.png](2-4-6.png)

discrimination ratio:
![2-4-7.png](2-4-7.png)
this will decrease rapidly with increasing number of rows N

in inverse, maximum number N ca be computed as:
![2-4-8.png](2-4-8.png)
smaller Von/Voff has, more number N can be contained in design

||advantage|disadvantage|
|:----|:----|:----|
|passive-matrix|more lines than segmented|lines limited by design|
||cost↓|when lines ↑, Limited contrast, pixcel Crosstalk, More driver requirements, more requirements for LC material|

# LCD active matrix
the active matrix can:
1. increase duty cycle
2. reduce cross-talk
3. simplify addressing waveform

![2-5-1.png](2-5-1.png)
each group is combined with 1 TFT transistor, and 1 storage cup (pixcel electrods)
Other driver process is same with passive-matrix
1. sweep column lines, and select row lines
2. if pixel is selected, TFT will turn on
3. storage cup charged
4. liquid cyrstal open

row:
![2-5-2.png](2-5-2.png)
column:
![2-5-3.png](2-5-3.png)

![2-5-4.png](2-5-4.png)
(?)

kickback(?)

# Active matrix tech
![2-6-1.png](2-6-1.png)
![2-6-2.png](2-6-2.png)
(?)

# OLED structure
OLED is quite similar with LED principle, but change those structures into orginac materials

simple OLED
this is structure of simple OLED
![2-7-1.png](2-7-1.png)
![2-7-2.png](2-7-2.png)
• LUMO is like valance band, HOMO is like conduction band
• Cathode assist electron injection
• Anode assist hole injection
• High mobility to reduce voltage and increase recombination probability
• emitted color is depended on energy gap

Simple Bilayer OLED Device
![2-7-3.png](2-7-3.png)

Advanced high-efficiency OLED Device
![2-7-4.png](2-7-4.png)

bottom and top emitting:
![2-7-5.png](2-7-5.png)
top emitter have a reflactive anode and transparent cathode
bottom emitter has a transparent anode and reflective cathode

![2-7-6.png](2-7-6.png)
Luminance proportional to current density over many decades of dynamic range

![2-7-7.png](2-7-7.png)

![2-7-8.png](2-7-8.png)
HTL's thickness will influence final emitted light's efficiency.

OLED image sticking problem: Pixels used more become dimmer sooner. life time, image will tuen yellow or grey

![2-7-9.png](2-7-9.png)
(?)

OLED zero bias, no charge injection.A (very) small current can flow due to dissociation of photo-excited excitons.
![2-7-10.png](2-7-10.png)
threshold, OLED start to turn on, Thermionic emission allows carriers over the barriers to injection (mainly dependent on temperature)
![2-7-11.png](2-7-11.png)
carrier injection, OLED under forward bias. current is limited by carrier injection and space charging
![2-7-12.png](2-7-12.png)

Charge Mobility µ is very low compared to inorganic semiconductors 
![2-7-13.png](2-7-13.png)
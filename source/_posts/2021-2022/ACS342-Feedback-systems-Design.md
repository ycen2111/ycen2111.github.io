---
title: ACS342 Feedback systems Design
date: 2021-09-27 14:08:29
tags:
 - 2021-2022
categories: 
 - academic material
---
Essentially, all models are wrong, but some are useful.
George E. P. Box

<!-- more -->

# Week1

Laplace Transform

![101.jpg](101.jpg)

Static system: output is memoryless function of the input
Dynamic system: output is function of current and past inputs

Linear functions: y(x)=x(n+1), y(x1)+y(x2)=y(x1+x2)
Continuous-time: y(k)=ay(k) (instead of y(k)=ay(k-1))
Time-invariant: shift input=shift output, y(delay)[n]=y[n-k], where y(delay)[n]=x[n+1-k], y[n-k]=x[(n-k)+1]

Kirchoff's Law
![102.PNG](102.PNG)

s-domain modelling of electrical networks
![103.PNG](103.PNG)

Laplace transform in differential:
![104.PNG](104.PNG)
![105.PNG](105.PNG)

# Week2
Transfer function:
![201.PNG](201.PNG)
For a linear system with input u(t) output y(t), G(s)=Y(s)/U(s)

combining blocks in series and feedback:
![202.PNG](202.PNG)
![203.PNG](203.PNG)
The signals and descriptions in system block:
![204.PNG](204.PNG)

![205.PNG](205.PNG)

Impulse response is inverse transform of G(s)
Step response is the inverse transform of G(s)/s

# Week3

how is a system:
Stable
Speed of respond
smooth
well track
reject noise well
feedback affect

for system stability:
A system is stable if every bounded input results in a bounded output
![301.PNG](301.PNG)

![302.PNG](302.PNG)
simple means only no-repeared value on one point

![303.PNG](303.PNG)
if all OL poles and CL poles have same signs, means it is stability

and also, if d(s)=as+b, where a and b have same sign,
![304.PNG](304.PNG)
All stable higher-order systems have 𝑎𝑛, 𝑎𝑛−1, … , 𝑎0 same sign; but not all higher-order systems with 𝑎𝑛, 𝑎𝑛−1, … , 𝑎0 same sign are stable

Routh-Hurwitz
![305.PNG](305.PNG)
![306.PNG](306.PNG)
stable if an, an-1, bn-1..... are with same sign

For System speed and smooth level:

First order system:
![307.PNG](307.PNG)
![308.PNG](308.PNG)
making sure G(s) have a 1 in denominator to find time constant
less time constant a system has, faster it is

Second order system:
![309.PNG](309.PNG)
![310.PNG](310.PNG)
![311.PNG](311.PNG)
![312.PNG](312.PNG)

# Week4

track/reject distrubances/noise

![401.PNG](401.PNG)
with input signal r(t), and output y(t),
track the r(t) if yss=lim𝑡→∞ r(t)
reject the r(t) if yss=0
We typically want a system to track 𝑟(𝑡) while rejecting 𝑑(𝑡)

if G(s)U(s) is stable,
![402.PNG](402.PNG)
![403.PNG](403.PNG)
G(0) is the steady-state gain
![404.PNG](404.PNG)

the steady-state error (ess) in response to a constant reference
![405.PNG](405.PNG)

![406.PNG](406.PNG)
![407.PNG](407.PNG)

Good tracking if KG(0) large
Good rejection only if K large

The closed-loop steady-state gain is T(0),
while open-loop steady-state gain is CG(0)=lim s→0 C(s)G(s)
CG(0) is sometimes called position error constant Kp.
If 𝐶𝐺(0) is finite, then 𝑦ss < 𝑟 and 𝑒ss > 0 for all 𝑟 > 0

# Week 5
How does feedback affect of these things

The root locus is the path (in the 𝑠-domain) traced out by the closed-loop poles as 𝐾 is varied
example:
![501.PNG](501.PNG)

for function KG(s)=K(s+z)/s(s+p1)(s+p2), (if z>P1>p2>0)
a) prepare
open-loop gain: 0,p1,p2 (n=3)
open-loop zero: z (m=1)
root locus lies on: s0=z, s1=p1, s2=p2, s3=0
range: [z,P1],[P2,0] (range should be on real axes)(gain should point to zero if possible)

notes: the range can be one point if have two same roots

b) Asymptotes:
Centre of gravity and inclined angles
![502.PNG](502.PNG)
(please check if centre of gravity is in moving range)

c) Break-away/in point:
two poles, then for some 𝐾 > 0 the locus departs from the real axis at a break-away point
two zeros, then for some 𝐾 > 0 the locus arrives at the real axis at a break-in point

![503.PNG](503.PNG)
vlaue of s is the point value on real axes. 
some of calculated vlaue will be removed if different with center of gravity

d) Departure from complex poles:
if has complex pole pairs,
![504.PNG](504.PNG)
get the initial start angle on complex poles
As the locus is symmetric about the real axis, it departs from the other complex pole. like if angle in p1 is 45, angle in p2 will be -45.

e) Intersection with imaginary axis:
using formular KG(s)/1+KG(s), let its bottom part =0, get
s(s+p1)(s+p2)+k=0,
s^3+(p1+p2)s^2+p1p2s+k=0

|:----|:----|:----|:----|
|s^3|1|p1p2|0|
|s^2|p1+p2|k|0|
|s^1|((P1+p2)p1p2-k)/(p1+p2)|0|0|
|s^0|k|0|0|

let((P1+p2)p1p2-k)=0, get K
put K into (p1+p2)s^2+K=0, get value s,
which is the cross point on imaginary axes

![505.PNG](505.PNG)
![506.PNG](506.PNG)

# Week6
Start to check whether a performance specification can met
![601.PNG](601.PNG)

𝜁: damping ratio
𝜔n: radian angle

note no steady-state performance is needed if ess/r reaches requirement

![602.PNG](602.PNG)

![603.PNG](603.PNG)
the root locus are better go to white region to meet specification (it is not satisfact in example)

the coordiantes in black block above is gaven by
![604.PNG](604.PNG)
locus root must pass it in satisfact method.

A phase-lead compensator:
![605.PNG](605.PNG)
find z: 𝑧 = 𝜁 ∗𝜔n
find p: 
![606.PNG](606.PNG)
![607.PNG](607.PNG)
the components need multiply n in case of  in power of n in roots like s^n
and any angle in negative value need add 180 to fit the requirement (like if angle=-90, need be changed as (-90+180)=90)
![608.PNG](608.PNG)

find k:
![609.PNG](609.PNG)
find the abs value for each part (square root of saperately real and imaginary value in power of 2)

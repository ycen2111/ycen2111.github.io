---
title: MAS381 Mathematics III
date: 2021-09-27 14:10:49
tags:
 - 2021-2022
categories: 
 - academic material

password: frank
---

# week1

## complex value

f(z)=f(x+iy)=u(x,y)+iv(x,y)
Re(f)=x=u(x,y)
Im(f)=y=v(x,y)

### harmonic function:
By definition a function is called harmonic if it is at least twice differentiable and it satisfies the well-known Laplace equation.
![101.PNG](101.PNG)

### Euler's formular:
![102.PNG](102.PNG)
cause
![103.PNG](103.PNG)

# week 2

## complex differentiation

A complex function f(x) is differentiable at a point z if and only if the limiting ratio quotient exists.
![201.PNG](201.PNG)

### Cauchy-Riemann equation:
a way to defferentiate a complex funtion
![104.PNG](104.PNG)
where u=real part and v=imagin part, and a function has a complex derivative f'(z) if and only if its real and imaginary parts are continuosly differentiable and satisfy the Cauchy-Riemann equation:
![105.PNG](105.PNG)
which is called the conjugate.

also, Cauchy-Riemann equation can find harmonic function as:
![106.PNG](106.PNG)

## analytical functions

A complex function f(z) is called analytic at a point z0 if it has a power series expansion
![202.PNG](202.PNG)

we can use ratio test to find wheter a complex series is convergent or not by finding the limitation value of n-th term
![203.PNG](203.PNG)
if L<1, convergent series
if L>1, divergent series
if L=1, the test is inconclusion.

for complex power series, the sequence Cn converges with a limit L. If L=0, the power series converges for all z. If L not equal 0, then
![204.PNG](204.PNG)

There are four and only four possible types of singularities of a complex function:
1. pole of order n. f(z)=(3z-2)/[(z-1)^2(z+1)(z-4)] has a pole of order 3 at z=1 and simple poles at z=-1 and 4
2.branch points.f(z) = (z − 3)^1/2 has a algebraic branch point at z = 3 and f(z) = ln(z^2 + z − 2)has logarithmic branch points where z^2 + z − 2 = 0
3.Essential singularity. the singularity is not pole or branch point.
4.singularities at infinity

## Taylor's theorem

![205.PNG](205.PNG)

If a=0, the series can called Maclaurin series.

# Week3

for the series have negative powers of (z-z0), equations can be writen like
![301.PNG](301.PNG)

## Laurent's theorem

Let function f(z) be analytical in annulus R<|z-z0|<ρ, it can be writen as
![302.PNG](302.PNG)
Where R belongs to negative part and ρ belongs to positive part.

---
title: MAS381 Mathematics III
date: 2021-09-27 14:10:49
tags:
 - 2021-2022
categories: 
 - academic material
---

<!-- more -->

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

really conplex content, remember to work the tutorial out.

# week 4

three most common form to write a complex function:
ax+by=c, 
where a,b are real numbers and x,y are variables
|z-1|=|z-b|
where a,b are complex numbers 
z=at+b
where t is real and a,b are complex quantities

![401.PNG](401.PNG)
euqation can be
(x-x0)^2+(y-y0)^2=R^2,
|z-z0|=R, z0=x0+iy0

z=x+iy=(x0+Rcosφ)+i(y0+Rsinφ)=z0+Re^iφ (0<=φ<2Pi)

## integration and Cauchy's theorem

### Newton-Leibnitz formula

the equation C: z=z(t), a<=t<=b,
![402.PNG](402.PNG)

example:
![403.PNG](403.PNG)

### using linear integration

if f(z)=u+iv=2+i, z=x+iy, than x=2t, y=t.
![404.PNG](404.PNG)

# Week5

##  Cauchy’s theorem
for two points x1=a1+ia2, x2=b1+ib2,
z=(1-t)(a1+ia2)+t(b1+ib2) (0<t<1)
or for circuit center z0=z1+iz2, radius=R,
z=z1+iz2+R(e^iφ) (0<φ<2Pi)
![501.PNG](501.PNG)

to Taylor series:
![502.PNG](502.PNG)
![503.PNG](503.PNG)

# Week6

## Residue Theorem

Let z=z0 be a singularity of the function f(z), the coefficient a is called residue of the function f(z)
![601.PNG](601.PNG)
the single residue (with single power) can be calculated as
![602.PNG](602.PNG)
but in multiple power, the function can be changed as
![603.PNG](603.PNG)

for closed contour C be the boundary of domain D,
![604.PNG](604.PNG)

for calculating real integrals, the contour C can be drawn as
![605.PNG](605.PNG)
which have ignored all results with negative imaginary.
![606.PNG](606.PNG)
where first interial is total contour results, second one is the real integrals and third one is the curve covered this domain(most cases equals to 0)

# Week7

## vector calculus

scalar field: f=x+y+z
vector field: u=(p,q,r)

for scalar field f, its gradient can be written as
![701.PNG](701.PNG)

the functions of div and curl operators are
![702.PNG](702.PNG)

grad(f)=∇(f)
div(f)=∇.f
curl(f)=∇*f

|initialize type|operator|result type|
|:----|:----|:----|
|scalar|gradient|vector|
|vector|div|scalar|
|vector|curl|vector|

like the function curl(div(u)) can not be defined cause div(u) is a scalar which can be curl which.

and there have two conditions the result will be 0:
1. for any scalar f, curl(grad(f))=0
2. for any vector u, div(curl(u))=0

for function div(grad(f))=∇.(∇(f))=fxx+fyy+fzz=∇^2(f), or called Laplancian (scalar field)
and curl(grad(f))=curl(fx,fy)=fyx-fxy=0

# Week 8

a vector field u will have a potential function p (which is ∇(p)=u), only when u is conservative:
∇*u=0

if E=(2x+xy,2y+xz,2z+xy)
![801.PNG](801.PNG)

# Week 9

## Integration along curve
a curve r=(x(t),y(t),z(t)) in the range of t(a<=t<=b),
![901.PNG](901.PNG)

![902.PNG](902.PNG)
where F=∇(p)

if F is a conservative vector fild, the potential function p for F is
![903.PNG](903.PNG)
value if a,b,c is not stable and can be choicen what ever we want. it is only valid for conservative field

if we want calculate its perdicular vector n then dt, get
![904.PNG](904.PNG)

# Week 10

## Surface Integrals

## two-dimansional divergence theorem
![1001.PNG](1001.PNG)
D is region in plane which boundary is cloased curve C. dA=r*dr*dtheta
if D is surrounding with multiple curve C, they need to be added

## Green's theorem
when dA=ndA, n is unit normal vector to D and u=(P,Q),
![1002.PNG](1002.PNG)

## three-dimansional divergence theorem
almost same with two-dimansional divergence
![1003.PNG](1003.PNG)

## stokes' theorem
![1004.PNG](1004.PNG)
cause if follows function in two-dimentional theorem, the direction of vertical vector n is cant been decided. hence two choice have in this function
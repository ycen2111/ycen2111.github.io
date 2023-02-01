---
title: Digital Converter Design in Simulink
date: 2023-01-25 11:00:26
tags:
 - 2022-2023
categories: 
 - academic material

password: frank
---

# Delta-Sigma modulation
![101.png](101.png)

input_dc is the analodge input value,
Dither source is the Guassian distribution within value between -1 and 1,
if the input_dc = 0.75 and no Gaussian noise input, the output figure shows like:

![102.png](102.png)

1. where yellow and blue curve in first figure is seperatly the input_dc and filtered curve after passing low-pass filter (which may can be seen as average value of blue wave in last figure)
2. In second figure, is the rsult of dc_input - QUANTOUT(blue wave) in last figure
3. third figure is LOOPERR + (last period's)INT1OUT. please note the mini value for both LOOPERR and INT1OUT is -0.25 (0.75-1), hence INT1OUT will decrease in step of 0.25
4. the last figure shows the signal when INT1OUT + Dither source (yellow wave) and QUANTOUT signal (blue wave). Dither source in this case is 0, hence yellow wave is completely same as third figure. when yellow wave is lower than 0, QUANTOUT will become -1, according to the Quantizer (step=2). Therefore the LOOPERR can be reset by feedback signal.
![103.png](103.png)

And the average value of QUANTOUT signal is just 0.75, same as dc_input. This is an ideal ADC.

![104.png](104.png)

tone frequency is the first peak frequency in QUANTOUT's spectrum scope. it is ususally need be filtered out by low-pass filter.
However, as tone frequency = fs/b(or 2b) which depending on vlaue of A and B (use fs/b is both A and B are even number), if B is a big number, tone frequency will be small and we need a much smaller filtered low-pass filter to remove this tone frequency, and cause a narrow pass band.

![105.png](105.png)
If dc_input is a simple number (0.4, 0.5, 0.6), B will be small number and power will be small. But the curve will swing rapidly when dither noise gain = 0.

![106.png](106.png)
the curve will be much more smoother if dither noise gain = 0.2. And reduce average power.
This is because dither breaks cycles, reduce peak spectrum value.

![107.png](107.png)
the dead zero is the range that the output signal equals zero. the dead zone range is between -1/(2A) to +1/(2A). if gain A=50, range is -0.01 to 0.01. but input and output will also match to each other
dead zone is always existed, and will influence minimum current the sensor can be used.

![108.png](108.png)
SQNR is signal quantisized noise ratio, ENOB is effictive umber of bits.
big SQNR wanted
sinfreq decreased or amplitude increased, SQNR and ENOB decreased;

the SQNR is calculate as:
![109.png](109.png)
and the figure when fre=4882.8125Hz, OSR=64, L=N=1 is:
![110.png](110.png)
the reason why many points on left side equal to 0 is just an awful tendency to tonal behaviour, and can be solved by adding some dither signal like:
![111.png](111.png)
the output signal cecomes more sommther and stable, but peak SQNR is also reduced.
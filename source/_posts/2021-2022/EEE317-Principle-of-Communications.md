---
title: EEE317 Principle of Communications
date: 2021-09-27 14:08:53
tags:
 - 2021-2022
categories: 
 - academic material

password: frank
---

# week1/2

![101.PNG](101.PNG)
Si: signal input
Ni: noice input
So: signal output
No: noice output

## Noise in AM systems

assuming have noise vlotage/current ni(t) and R=1Ω, the noice power Ni:
![102.PNG](102.PNG)
ni(t) in terms on in-phase and out-of-phase components in the baseband
![103.PNG](103.PNG)
can get:
![104.PNG](104.PNG)
where ![105.PNG](105.PNG) is the average value of nc(t)^2.

hence ![106.PNG](106.PNG)

|type|efficiency|cost|
|:----|:----|:----|
|DSB SC|High|Expensive|
|DSB LC|Low|Cheap|

## Noise performance of DSB SC using coherent detection

the input ti detectoe and time average input power signal is:
![107.PNG](107.PNG)
if the demodulator the signal using a perfectly same carrier signal, the signal outputcan be:
![108.PNG](108.PNG)
as have defined before, the input signal can simply write as the average value of ni^2(t) and no(t)=ni(t)*cos(Wct) and
![109.PNG](109.PNG)

hence the noise rations is:
![110.PNG](110.PNG)

## Noise performance of DSB LC using envelope detection

![201.PNG](201.PNG)
r(t) is the output from envelope detector. If ns(t)^2 is much larger than its denominator, hence
![202.PNG](202.PNG)
By the same calculation, get
![203.PNG](203.PNG)

## Noice in FM signal

The FM receiver can be drawn as
![204.PNG](204.PNG)
Liliter here is ideal and could removes all amplitude variations.

Input signal si(t) can be written as:
![205.PNG](205.PNG)
cA: the maximum frequency deviation(same value as ∆ω)
α: signal amplitude
β: the modulation index(β=∆ω/ωm)

and the time average output signal power is:
![206.PNG](206.PNG)
K: constant associated demodulator system

hence the noice output power is proportional as ω
![207.PNG](207.PNG)

![208.PNG](208.PNG)

## Pre-emphasis and de-emphasis FM systems

from the figure above, find the noice power density is at its highest when signal strength is at its smallest.
hence pre increase/decrease strength before modulating singal can solve it
![209.PNG](209.PNG)

# week 3
intriduction of digital communications. find the advantages and diaadvantages exsists in digital communications.

## Advantages

Channel coding: the process of adding redundant code to a message in order to help the receiver correct any errors which may have occued in transit. (like 0 001 1111, which first 0 is a checking bit without any meaning)

Source coding: Source coding is the process of modifying the way we send the data.

Multiplexing: In transmission systems we often want to make many different signals occupy the available transmission space, this is called multiplexing. 

Frequency division multiple access (FDMA): different baseband range will allocated to different user in same time.
![301.PNG](301.PNG)

Time division multiple acces (TDMA): whole baseband will allocated to user but in part of whole times.
![302.PNG](302.PNG)

Code division multiple access (CDMA): both time and baseband will be divided and allocated to different users (most effieiency way, and evry secure)
![303.PNG](303.PNG)

Encryption : data will be coded by a key and decoded by a same key when receive it.
![304.PNG](304.PNG)

Regeneration: The signal need to repeate transimited signals every regulat times and both signal and noise will strengthed and finally noise will larger than signal in analogue signal. But in channel coding every small noise will be removed while repeat the signals.
![305.PNG](305.PNG)

## Disadvantages

Bandwidth effiency: An analogue transmission system will always occupy less bandwidth than a digital system sending the same message. For some times we can using M-Ary to ease this problem.
Please note: the sample frequency in ADC need larger than 2 times of original signal frequency.

Whats more, digital signals need translate to analogue signals finally, and need synchronisation send and receive environment. It can be more complex to send a digital message.
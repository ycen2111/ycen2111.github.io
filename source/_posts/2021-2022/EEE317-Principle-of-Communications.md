---
title: EEE317 Principle of Communications
date: 2021-09-27 14:08:53
tags:
 - 2021-2022
categories: 
 - academic material

password: frank
---

# week1

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

# Week2

## entropy

The entropy, or H, is the average information carried per message of stmbol
![210.PNG](210.PNG)
like if p(0)=0.2 and p(1)=0.8, H=-(p(0)log2(p(0))+p(1)log2(p(1)))

the relationship between proporty and H is
![211.PNG](211.PNG)

## Huffman coding

![212.PNG](212.PNG)
for different appear porporty for letter ABCDE, different combination have been used to arrange them.
the bigger proporty a letter has, the less diginal number will used on it.

the average number per message Huffman code will sent can be calculated as
n'=1*0.74+2*0.12+3*0.07+4*0.06+4*0.01=1.39 bits/message
but if using entropy the value will changed as
H=-(0.74log2(0.74)+0.12log2(0.12)+...+0.01log2(0.01))=1.26 bits/message

the efficiency of Huffman codeing is 1.26/1.39=91%

## Strcuture sequences and data compression

Compression is used to reduce the number of bits required to send a piece of information.

Or can usig run-length encoding, which have combain all continous same colors into entire part(like color name + numbers) to reduce store places

But Variable data rate required - the channel bandwidth will be constant, so 
buffers are needed. 
And A bit error can cause large areas of picture to be incorrect - a low error 
rate is needed.  

## Lossless and lossy coding

run-length coding is an example of lossless coding, cause all bits and data is important in series.
Lossy coding can loss pieces of message and the rest of data can also been used. such as sound and pictures.

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

# week4

## channel coding
Probability of errors: a binary message sent with bit 0 ir 1 have a probabitity p to turn into wrong bit
![401.PNG](401.PNG)
Pε = P (0→1)× P (1) + P (1→0) P (0)

### random error
Random errors are typically caused by additive white Gaussian noise (AWGN). 
Probability density function (PDF) is determined the magnitude for Gaussian in nature
![402.PNG](402.PNG)
the funtction form of PDF is
![403.PNG](403.PNG)
which where σ is the standard deviation and a0(1) is the mean of the distribution for logic 0 (1). 

### hard decisions and soft decisions
hard decision is what figure shows above. is usually sdequate for channels with small amounts of AWGN.
soft decision is return 1 or 0 if a is bigger or smaller than am. is usually for high AWGN noise.
![404.PNG](404.PNG)

### multiple random errors
![405.PNG](405.PNG)

### parity check bits
A single bit parity check code is a simple algebraic code.

|bit|feature|
|:----|:----|
|1|odd number of bit "1"|
|0|even number of bit "1"|

### convolution coding
a more powerful technical for correction random errors.
for example, initially loaded with 000 and subjected to input data 11011

|clock pulse|D0|D1|D2|u1|u1|
|:----|:----|:----|:----|:----|:----|
|0|0|0|0|0|0|
|1|1|0|0|1|1|
|2|1|1|0|0|1|
|3|0|1|1|0|1|
|4|1|0|1|0|0|
|5|1|1|0|0|1|

where u1=D0+D1+D2, u2=D0+D2
![406.PNG](406.PNG)
the output result will changed in a constant rules hence some small errors will be found out and perhaps been solved.

### reed-solomon code
Reed-Solomon codes are in essence parity check codes, although the method by which the additional bits are derived is significantly more complex to enable burst errors corrections.
n: the final length of the code
k: the initial length of the code
t: number of symbol errors can be corrected(2t=n-k)

# Week5

Pseudonoise(PN) is a noise but in completely derministic. it can presrve and srcurity signals in channel from other influences.

## features for a good pseudomoise sequence
Balance: want roughly same number of 0 and 1
Run sequence: a sequence of consecutive bits with same value. and 1/2 of sequecy should be length of 1, 1/4 be length of 2 and 1/8 be length of 3.
Autocorrelation: have a low correlation with shifted copies with itself.

like 15-bit sequence 100110101111000,
8 of "1" and 7 of "0", achieved balance
4 of 1 length, 2 of 2 length, 1 of 3 length and 1 0f 4 length, roughlt achieved run sequence.
100110101111000
xor
010011010111100
=
110101111000100
autocorrelation of -1 (sane with other shift situations, fit the autocorrelation)

the good autocorrelation can be used in synchronisation communications cause receiver can easily find the code word by calculating correlation function between its stored PN code and the incoming data stream.

## generation PN code

a shift register connected in feedback via a modulo-2 adder can genarate PN code
![501.PNG](501.PNG)

if n=3, and initial S1=0, S2=1, S3=1, get
![502.PNG](502.PNG)
repeat 7 times (for n length, the maximum number is =2^n-1, called maximal length sequency)

|S1|S2|S3|o/p|
|:----|:----|:----|:----|
|0|1|1|1|
|0|0|1|1|
|1|0|0|0|
|0|1|0|0|
|1|0|1|1|
|1|1|0|0|
|1|1|1|1|

get output sequency 11100101.

be attention: the initialize code can't be "000" cause no "1" can be generated through "0"s

## non maximal length PN codes

"Gold code" is designed cross-correlation properties are used
and "Barker codes" are sequences which only have 2-valued autocorrelation function. for example

|bits number|Barker code sequence|
|:----|:----|
|3|110|
|5|11101|
|7|1110010|
|11|11100010010|
|13|1111100110101|

by wrapping the code with itself, get

|1|1|1|0|1|correlation|
|:----|:----|:----|:----|:----|:----|
|1|1|1|0|1|+5|
|1|1|1|1|0|+1|
|0|1|1|1|1|+1|
|1|0|1|1|1|+1|
|1|1|0|1|1|+1|
|1|1|1|0|1|+1|

only 1 and 5 these two values.

# Week6

DSSS: direct dequence S.S.
FHSS: frequency hopping S.S.

advantage of S.S. system:
Low probability of interception, interference rejection, higher data rates, and multiple access

## DSSS

![601.PNG](601.PNG)

the message m(t) will first modulated with a PN code which changes much faster than original and much similar with a noise signal.
![602.PNG](602.PNG)

hence usually this signal is useless unless reveicer have the same PN code to demodulate it.
and definitely, the PN code c(t) in receiver part need to be synchronised with incoming signal to demodulate correctly.

## search mode

![605.PNG](605.PNG)

the control logic will detectwhether PN code have schieve the synchronisation type by energy. if it is not synchronised, energy during BPF(bandpass filter) will very small and then deley time td will be adjusted. but if in synchronised mode then the energy during BPF region will be strong enough to detect.
![604.PNG](604.PNG)

## check mode

![603.PNG](603.PNG)

the check mode will compear the signal reveiced between early and late part. the synchronisation will be achieved if these two parts have identical values.
![606.PNG](606.PNG)

if PN generator is early generated, the shadow area in early part will smaller than late part and VCO will changed the time sequence to adjust it.

## noise suppression

the AWGN(additive Gaussian white noise) have finite power over an infinite bandwidth. the de-spearding operation for a ready-spreaded signal can increased power in signal and decrease influence from such white noise.
![607.PNG](607.PNG)

the jamming signal can be signal with high power and narrow bandwidth. but it can also be decreased after de-spreading.
![608.PNG](608.PNG)

## FHSS

frequency hopping spreads the data signal on one of a series of carriers occupy a really large bandwidth.it is required the bandwidth containing carrier frequency is much larger thn data bandwidth.
![609.PNG](609.PNG)

final signal will be modulated for two times and its final frequency can be drawed as
 ![610.PNG](610.PNG)
final signal frequency=f(carrier)+f(offset)

the processing gain for a frequency hopping system is given as
G=fh*Ts

slow hopping system: the duration of a message bit sorresponds to the inverse hop rate.
fast frequency hopping: would suffer a noise or jamming signal in many parts of the bandwidth.
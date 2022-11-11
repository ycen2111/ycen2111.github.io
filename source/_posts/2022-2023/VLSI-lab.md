---
title: VLSI lab
date: 2022-10-02 10:35:35
tags:
 - 2022-2023
categories: 
 - academic material

password: frank
---

# Remote Access to Linux Labs
0. Connect to University VPN
1. Open Remote Desktop Connection
2. Computer: s2314951.studentlinux.eng.ed.ac.uk
3. UserName: ED\s2314951
4. In advanced -> Setting -> Use these RD gateway server setting:
5. serverName: portico.is.ed.ac.uk
6. Ok, connect
7. quit the log in: System -> Log out

# Normal Start Cadence
1. Open Terminal
2. Type 'ssh vlx'
3. Move into that directory - 'cd AVLSIA'
4. Type 'avlsilaunch &'

# Generate new cell
1. Library Manager -> File -> New -> Library
2. File -> New -> Cell View

# Common parameters
New Instance: Create -> Instance -> Browse

|Instance|Library|Cell|
|:----|:----|:----|
|NMOS|PRIMLIB|nmosm4|
|PMOS|PRIMLIB|pmosm4|
|Voltage source|analogLib|vdc|
|multi Voltage source|analogLib|vsource|
|Current source|analogLib|idc|
|Ground|analogLib|gnd|
|Resistor|analogLib|res|
|NAND|ahdlLib|nand_gate|

change parameters: click instance -> press Q
Draw line: Create -> Wire narrow

Note: remember click "check and save" after editing

# ADE
1. Launch -> ADE_L (open ADE)
2. Analyses -> choose (choose analyses type)
3. Output -> To be plotted -> choose node or branch in schemetic (plotted wave)
4. Click run button on right bar (check again if schemetic is check and saved)
5. Session -> Save state (save ADE)
6. Session -> Load state

## .tran
Based on time flowing, just select stop time

## .dc
1. Sweep Variable -> Component Parameter -> Select Component -> click wanted component in Schemetic
2. fill Parameter type
3. Sweep Range -> fill start value and stop value
4. choose sweep type

## .ac
1. choose frequency analysis
2. choose start and stop value
3. choose logarithmic as sweep type
4. fill 5 points per decade

# Anaysis plot
Line: Marker -> Create marker -> Horizontal/Vertical
Press M to measure value on this point
And keep press D when first point is still selected, to measure distance and trend between two points
Press U to undo the operation

# Calculator
1. Tool -> Calculator
2. Press "Wave" radio button to analysis wave values
3. Press 7th icon on the bar under expression box to clear history memory
4. Click Legend on plot window to input variable wave
5. Choose functions on function panel
6. Click Evaluate the buffer to plot the result (result will directly output in expression box if the result is a constant value)
![Calculator.png](Calculator.png)

The calculated result can also be plotted automatically by placing expression in Output box in ADE_L:
Output -> Set up -> fill name -> phase expression, or press "Get Expression" (if there has an expression displayed in calculator already)

# Parametic analysis
The second variable should be set up at first if you want change two variables in one simulation
1. Let one parameter's value into letter type (like Voltage=V)
2. in ADE_L -> Variables -> Edit -> fill name and initialize value (like V=5)
3. Tools -> Parametic analysis -> fill variable name, start and stop value -> select Step mode and step value or total point number
4. Click green run button on top bar

# ADE XL
Combining multiple simulation and schmetics in one window and control them together
Start a ADE_XL: open one schmatic -> launch -> ADE_XL -> Create New View -> XXX_ADE_XL (New XL cell will be generated)

![ADE_XL.png](ADE_XL.png)
1. click 'Click to add test' to select one schematic, and load state if have
2. test editor is opened by double clicking here, Tests will automatically added from test editor
3. expression can be added by right click region here, select 'Add Expression'
4. Only expressions and set specification here, by bouble clicking the grey area
5. run the simulation. It can save up to 10 past histories
6. Output results can be checked here
![ADE_XL1_RESULT.png](ADE_XL1_RESULT.png)
7. wave polt can be displayed here

# symbol
1. in target cell, create -> Cell view -> From cellview -> OK
2. set pins
3. change the shape
4. new cell view have generated in library menu

# Mismatch simulation
in virtuoso window, Hit-Kit Utilities -> Simulation Utilities -> Model Manager
1. change the "change all" into 'monte carlo'
2. click 'Select section' making sure all parameters are end in 'mc' and click 'OK'
3. double check all model files are end in 'mc' as well, and close window
![Model_Manager.png](Model_Manager.png)

now can open previous ADE_XL file
and check the sections are really chnaged
![Model_Library.png](Model_Library.png)

Now can add new expressions by right clicking blank area in working place, and 'Add expression'
if we want measure the current when Voltage in drain terminal is 2.5V, can write as:
'value(IS("/MN0/D") 2.5)'

Now can go to monte carloanalysis.
1. change the drop down menu into conte carlo type
2. click OK after making sure everything is OK
3. start the simulation
![Monte_Carlo_sampling.png](Monte_Carlo_sampling.png)

# Set an Osillator by ring invertors
![Ring_Ocilattor.png](Ring_Ocilattor.png)
There have two global variables (svdd! and svss!) which also been set in invertor parameter.

Please note the initial condiction must be set on one wire, or the osillator will be happened
ADE_L -> simulation -> convergence aids -> initial condition -> set as 0 or 5V
and its better to choose 2.5V as a supply voltage, to drive it much similar as a real pulse signal
the little peaks which larger than supply voltage is porproated with CMOS area. less area CMOS has, lower peak the signal will have and will performed as a normal pulse signal
1[Ring_Ocilattor1.png](Ring_Ocilattor1.png)

and next can add a enable signal to control this pulse signal by NAND gate

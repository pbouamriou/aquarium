EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L Device:R_US Rb
U 1 1 5EC066C8
P 2600 2450
F 0 "Rb" V 2805 2450 50  0000 C CNN
F 1 "1k" V 2714 2450 50  0000 C CNN
F 2 "" V 2640 2440 50  0001 C CNN
F 3 "~" H 2600 2450 50  0001 C CNN
	1    2600 2450
	0    -1   -1   0   
$EndComp
$Comp
L Device:Q_NPN_CBE Q1
U 1 1 5EC080F8
P 3600 2450
F 0 "Q1" H 3791 2496 50  0000 L CNN
F 1 "2N2222A" H 3791 2405 50  0000 L CNN
F 2 "" H 3800 2550 50  0001 C CNN
F 3 "~" H 3600 2450 50  0001 C CNN
F 4 "Q" H 3600 2450 50  0001 C CNN "Spice_Primitive"
F 5 "Q2n2222a" H 3600 2450 50  0001 C CNN "Spice_Model"
F 6 "Y" H 3600 2450 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "/home/philippe/kicad/2N2222A.LIB" H 3600 2450 50  0001 C CNN "Spice_Lib_File"
	1    3600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	3400 2450 2750 2450
$Comp
L power:GND #PWR?
U 1 1 5EC08F10
P 3700 2850
F 0 "#PWR?" H 3700 2600 50  0001 C CNN
F 1 "GND" H 3705 2677 50  0000 C CNN
F 2 "" H 3700 2850 50  0001 C CNN
F 3 "" H 3700 2850 50  0001 C CNN
	1    3700 2850
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC0937A
P 1900 3100
F 0 "#PWR?" H 1900 2850 50  0001 C CNN
F 1 "GND" H 1905 2927 50  0000 C CNN
F 2 "" H 1900 3100 50  0001 C CNN
F 3 "" H 1900 3100 50  0001 C CNN
	1    1900 3100
	1    0    0    -1  
$EndComp
$Comp
L SpiceEtComptesRendus:VPULSE V2
U 1 1 5EC0B582
P 1900 2800
F 0 "V2" H 2028 2846 50  0000 L CNN
F 1 "VPULSE" H 2028 2755 50  0000 L CNN
F 2 "" H 1900 2800 50  0001 C CNN
F 3 "" H 1900 2800 50  0001 C CNN
F 4 "V" H 1900 2800 50  0001 C CNN "Spice_Primitive"
F 5 "dc 1 ac 1 0 pulse(5 0 100ms 1n 1n 500ms 1)" H 2830 2720 50  0001 C CNN "Spice_Model"
F 6 "Y" H 1900 2800 50  0001 C CNN "Spice_Netlist_Enabled"
	1    1900 2800
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 2600 1900 2450
Wire Wire Line
	1900 2450 2450 2450
$Comp
L Relay:G5V-1 K1
U 1 1 5EC0C84E
P 3900 1700
F 0 "K1" H 4330 1746 50  0000 L CNN
F 1 "G5V-1" H 4330 1655 50  0000 L CNN
F 2 "Relay_THT:Relay_SPDT_Omron_G5V-1" H 5030 1670 50  0001 C CNN
F 3 "http://omronfs.omron.com/en_US/ecb/products/pdf/en-g5v_1.pdf" H 3900 1700 50  0001 C CNN
F 4 "X" H 3900 1700 50  0001 C CNN "Spice_Primitive"
F 5 "RELAY_G5V_1" H 3900 1700 50  0001 C CNN "Spice_Model"
F 6 "Y" H 3900 1700 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "2 9" H 3900 1700 50  0001 C CNN "Spice_Node_Sequence"
	1    3900 1700
	1    0    0    -1  
$EndComp
$Comp
L Diode:1N4001 D1
U 1 1 5EC0D1B8
P 3050 1700
F 0 "D1" V 3000 1500 50  0000 L CNN
F 1 "1N4001" V 3100 1300 50  0000 L CNN
F 2 "Diode_THT:D_DO-41_SOD81_P10.16mm_Horizontal" H 3050 1525 50  0001 C CNN
F 3 "http://www.vishay.com/docs/88503/1n4001.pdf" H 3050 1700 50  0001 C CNN
F 4 "D" H 3050 1700 50  0001 C CNN "Spice_Primitive"
F 5 "D1n4001rl" H 3050 1700 50  0001 C CNN "Spice_Model"
F 6 "Y" H 3050 1700 50  0001 C CNN "Spice_Netlist_Enabled"
F 7 "2 1" H 3050 1700 50  0001 C CNN "Spice_Node_Sequence"
F 8 "/home/philippe/kicad/1N4001RL.LIB" H 3050 1700 50  0001 C CNN "Spice_Lib_File"
	1    3050 1700
	0    1    1    0   
$EndComp
Wire Wire Line
	3700 2000 3700 2150
Wire Wire Line
	3700 1450 3700 1400
Wire Wire Line
	3700 850  3050 850 
Connection ~ 3700 1400
Wire Wire Line
	3050 1850 3050 2150
Wire Wire Line
	3050 2150 3700 2150
Connection ~ 3700 2150
Wire Wire Line
	3700 2150 3700 2250
$Comp
L power:VCC #PWR?
U 1 1 5EC18D83
P 3700 800
F 0 "#PWR?" H 3700 650 50  0001 C CNN
F 1 "VCC" H 3715 973 50  0000 C CNN
F 2 "" H 3700 800 50  0001 C CNN
F 3 "" H 3700 800 50  0001 C CNN
	1    3700 800 
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 2650 3700 2850
$Comp
L Device:Battery_Cell V1
U 1 1 5EC199E5
P 1900 1750
F 0 "V1" H 2018 1846 50  0000 L CNN
F 1 "DC 5V" H 2018 1755 50  0000 L CNN
F 2 "" V 1900 1810 50  0001 C CNN
F 3 "~" V 1900 1810 50  0001 C CNN
	1    1900 1750
	1    0    0    -1  
$EndComp
NoConn ~ 4200 1400
NoConn ~ 4000 1400
NoConn ~ 4100 2000
$Comp
L power:VCC #PWR?
U 1 1 5EC1A644
P 1900 1450
F 0 "#PWR?" H 1900 1300 50  0001 C CNN
F 1 "VCC" H 1915 1623 50  0000 C CNN
F 2 "" H 1900 1450 50  0001 C CNN
F 3 "" H 1900 1450 50  0001 C CNN
	1    1900 1450
	1    0    0    -1  
$EndComp
$Comp
L power:GND #PWR?
U 1 1 5EC1AAE6
P 1900 1950
F 0 "#PWR?" H 1900 1700 50  0001 C CNN
F 1 "GND" H 1905 1777 50  0000 C CNN
F 2 "" H 1900 1950 50  0001 C CNN
F 3 "" H 1900 1950 50  0001 C CNN
	1    1900 1950
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 3000 1900 3100
Wire Wire Line
	1900 1850 1900 1950
Wire Wire Line
	1900 1450 1900 1550
Text Notes 4750 1800 0    50   ~ 0
.tran 1u 110m 90m uic\n.subckt RELAY_G5V_1 1 2\nR1 1 3 166\nL1 2 3 0.29\n.ends RELAY_G5V_1
Text GLabel 4000 2150 2    50   Output ~ 0
VCE
Wire Wire Line
	3700 2150 4000 2150
Text GLabel 1650 2450 0    50   Input ~ 0
Ve
Wire Wire Line
	1900 2450 1650 2450
Connection ~ 1900 2450
$Comp
L Device:R_US Rm
U 1 1 5EC24D60
P 3700 1100
F 0 "Rm" H 3768 1146 50  0000 L CNN
F 1 "0" H 3768 1055 50  0000 L CNN
F 2 "" V 3740 1090 50  0001 C CNN
F 3 "~" H 3700 1100 50  0001 C CNN
	1    3700 1100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3700 800  3700 850 
Connection ~ 3700 850 
Wire Wire Line
	3700 850  3700 950 
Wire Wire Line
	3700 1250 3700 1400
Wire Wire Line
	3050 850  3050 1550
$EndSCHEMATC

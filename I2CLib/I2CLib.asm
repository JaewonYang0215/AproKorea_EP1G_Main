;CodeVisionAVR C Compiler V1.24.4 Standard
;(C) Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com
;e-mail:office@hpinfotech.com

;Chip type           : ATmega128L
;Program type        : Application
;Clock frequency     : 4.000000 MHz
;Memory model        : Small
;Optimize for        : Size
;(s)printf features  : int, width
;(s)scanf features   : int, width
;External SRAM size  : 0
;Data Stack size     : 1024 byte(s)
;Heap size           : 0 byte(s)
;Promote char to int : No
;char is unsigned    : Yes
;8 bit enums         : Yes
;Enhanced core instructions    : On
;Automatic register allocation : On

	.EQU UDRE=0x5
	.EQU RXC=0x7
	.EQU USR=0xB
	.EQU UDR=0xC
	.EQU SPSR=0xE
	.EQU SPDR=0xF
	.EQU EERE=0x0
	.EQU EEWE=0x1
	.EQU EEMWE=0x2
	.EQU EECR=0x1C
	.EQU EEDR=0x1D
	.EQU EEARL=0x1E
	.EQU EEARH=0x1F
	.EQU WDTCR=0x21
	.EQU MCUCR=0x35
	.EQU RAMPZ=0x3B
	.EQU SPL=0x3D
	.EQU SPH=0x3E
	.EQU SREG=0x3F
	.EQU XMCRA=0x6D
	.EQU XMCRB=0x6C

	.DEF R0X0=R0
	.DEF R0X1=R1
	.DEF R0X2=R2
	.DEF R0X3=R3
	.DEF R0X4=R4
	.DEF R0X5=R5
	.DEF R0X6=R6
	.DEF R0X7=R7
	.DEF R0X8=R8
	.DEF R0X9=R9
	.DEF R0XA=R10
	.DEF R0XB=R11
	.DEF R0XC=R12
	.DEF R0XD=R13
	.DEF R0XE=R14
	.DEF R0XF=R15
	.DEF R0X10=R16
	.DEF R0X11=R17
	.DEF R0X12=R18
	.DEF R0X13=R19
	.DEF R0X14=R20
	.DEF R0X15=R21
	.DEF R0X16=R22
	.DEF R0X17=R23
	.DEF R0X18=R24
	.DEF R0X19=R25
	.DEF R0X1A=R26
	.DEF R0X1B=R27
	.DEF R0X1C=R28
	.DEF R0X1D=R29
	.DEF R0X1E=R30
	.DEF R0X1F=R31

	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_adc_noise_red=0x08
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C

	.MACRO __CPD1N
	CPI  R30,LOW(@0)
	LDI  R26,HIGH(@0)
	CPC  R31,R26
	LDI  R26,BYTE3(@0)
	CPC  R22,R26
	LDI  R26,BYTE4(@0)
	CPC  R23,R26
	.ENDM

	.MACRO __CPD2N
	CPI  R26,LOW(@0)
	LDI  R30,HIGH(@0)
	CPC  R27,R30
	LDI  R30,BYTE3(@0)
	CPC  R24,R30
	LDI  R30,BYTE4(@0)
	CPC  R25,R30
	.ENDM

	.MACRO __CPWRR
	CP   R@0,R@2
	CPC  R@1,R@3
	.ENDM

	.MACRO __CPWRN
	CPI  R@0,LOW(@2)
	LDI  R30,HIGH(@2)
	CPC  R@1,R30
	.ENDM

	.MACRO __ADDD1N
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	SBCI R22,BYTE3(-@0)
	SBCI R23,BYTE4(-@0)
	.ENDM

	.MACRO __ADDD2N
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	SBCI R24,BYTE3(-@0)
	SBCI R25,BYTE4(-@0)
	.ENDM

	.MACRO __SUBD1N
	SUBI R30,LOW(@0)
	SBCI R31,HIGH(@0)
	SBCI R22,BYTE3(@0)
	SBCI R23,BYTE4(@0)
	.ENDM

	.MACRO __SUBD2N
	SUBI R26,LOW(@0)
	SBCI R27,HIGH(@0)
	SBCI R24,BYTE3(@0)
	SBCI R25,BYTE4(@0)
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __DELAY_USB
	LDI  R24,LOW(@0)
__DELAY_USB_LOOP:
	DEC  R24
	BRNE __DELAY_USB_LOOP
	.ENDM

	.MACRO __DELAY_USW
	LDI  R24,LOW(@0)
	LDI  R25,HIGH(@0)
__DELAY_USW_LOOP:
	SBIW R24,1
	BRNE __DELAY_USW_LOOP
	.ENDM

	.MACRO __CLRD1S
	LDI  R30,0
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+@1)
	LDI  R31,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+@1)
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+@2)
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+@3)
	LDI  R@1,HIGH(@2+@3)
	.ENDM

	.MACRO __GETD1N
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __GETD2N
	LDI  R26,LOW(@0)
	LDI  R27,HIGH(@0)
	LDI  R24,BYTE3(@0)
	LDI  R25,BYTE4(@0)
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __GETB1MN
	LDS  R30,@0+@1
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	LDS  R22,@0+@1+2
	LDS  R23,@0+@1+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@2,@0+@1
	.ENDM

	.MACRO __GETWRMN
	LDS  R@2,@0+@1
	LDS  R@3,@0+@1+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+@1
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+@1
	LDS  R27,@0+@1+1
	LDS  R24,@0+@1+2
	LDS  R25,@0+@1+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+@1,R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+@1,R30
	STS  @0+@1+1,R31
	STS  @0+@1+2,R22
	STS  @0+@1+3,R23
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+@1,R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+@1,R@2
	STS  @0+@1+1,R@3
	.ENDM

	.MACRO __PUTBZR
	STD  Z+@1,R@0
	.ENDM

	.MACRO __PUTWZR
	STD  Z+@2,R@0
	STD  Z+@2+1,R@1
	.ENDM

	.MACRO __GETW1R
	MOV  R30,R@0
	MOV  R31,R@1
	.ENDM

	.MACRO __GETW2R
	MOV  R26,R@0
	MOV  R27,R@1
	.ENDM

	.MACRO __GETWRN
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __PUTW1R
	MOV  R@0,R30
	MOV  R@1,R31
	.ENDM

	.MACRO __PUTW2R
	MOV  R@0,R26
	MOV  R@1,R27
	.ENDM

	.MACRO __ADDWRN
	SUBI R@0,LOW(-@2)
	SBCI R@1,HIGH(-@2)
	.ENDM

	.MACRO __ADDWRR
	ADD  R@0,R@2
	ADC  R@1,R@3
	.ENDM

	.MACRO __SUBWRN
	SUBI R@0,LOW(@2)
	SBCI R@1,HIGH(@2)
	.ENDM

	.MACRO __SUBWRR
	SUB  R@0,R@2
	SBC  R@1,R@3
	.ENDM

	.MACRO __ANDWRN
	ANDI R@0,LOW(@2)
	ANDI R@1,HIGH(@2)
	.ENDM

	.MACRO __ANDWRR
	AND  R@0,R@2
	AND  R@1,R@3
	.ENDM

	.MACRO __ORWRN
	ORI  R@0,LOW(@2)
	ORI  R@1,HIGH(@2)
	.ENDM

	.MACRO __ORWRR
	OR   R@0,R@2
	OR   R@1,R@3
	.ENDM

	.MACRO __EORWRR
	EOR  R@0,R@2
	EOR  R@1,R@3
	.ENDM

	.MACRO __GETWRS
	LDD  R@0,Y+@2
	LDD  R@1,Y+@2+1
	.ENDM

	.MACRO __PUTWSR
	STD  Y+@2,R@0
	STD  Y+@2+1,R@1
	.ENDM

	.MACRO __MOVEWRR
	MOV  R@0,R@2
	MOV  R@1,R@3
	.ENDM

	.MACRO __INWR
	IN   R@0,@2
	IN   R@1,@2+1
	.ENDM

	.MACRO __OUTWR
	OUT  @2+1,R@1
	OUT  @2,R@0
	.ENDM

	.MACRO __CALL1MN
	LDS  R30,@0+@1
	LDS  R31,@0+@1+1
	ICALL
	.ENDM


	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+@1)
	LDI  R31,HIGH(2*@0+@1)
	CALL __GETW1PF
	ICALL
	.ENDM


	.MACRO __CALL2EN
	LDI  R26,LOW(@0+@1)
	LDI  R27,HIGH(@0+@1)
	CALL __EEPROMRDW
	ICALL
	.ENDM


	.MACRO __GETW1STACK
	IN   R26,SPL
	IN   R27,SPH
	ADIW R26,@0+1
	LD   R30,X+
	LD   R31,X
	.ENDM

	.MACRO __NBST
	BST  R@0,@1
	IN   R30,SREG
	LDI  R31,0x40
	EOR  R30,R31
	OUT  SREG,R30
	.ENDM


	.MACRO __PUTB1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SN
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNS
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMN
	LDS  R26,@0
	LDS  R27,@0+1
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1PMNS
	LDS  R26,@0
	LDS  R27,@0+1
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RN
	MOVW R26,R@0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RNS
	MOVW R26,R@0
	ADIW R26,@1
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RNS
	MOVW R26,R@0
	ADIW R26,@1
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RON
	MOV  R26,R@0
	MOV  R27,R@1
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	CALL __PUTDP1
	.ENDM

	.MACRO __PUTB1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X,R30
	.ENDM

	.MACRO __PUTW1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1RONS
	MOV  R26,R@0
	MOV  R27,R@1
	ADIW R26,@2
	CALL __PUTDP1
	.ENDM


	.MACRO __GETB1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R30,Z
	.ENDM

	.MACRO __GETW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z+
	LD   R23,Z
	MOVW R30,R0
	.ENDM

	.MACRO __GETB2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R26,X
	.ENDM

	.MACRO __GETW2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	.ENDM

	.MACRO __GETD2SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R1,X+
	LD   R24,X+
	LD   R25,X
	MOVW R26,R0
	.ENDM

	.MACRO __GETBRSX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	LD   R@0,Z
	.ENDM

	.MACRO __GETWRSX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	LD   R@0,Z+
	LD   R@1,Z
	.ENDM

	.MACRO __LSLW8SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
	CLR  R30
	.ENDM

	.MACRO __PUTB1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __CLRW1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __CLRD1SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	CLR  R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z+,R0
	ST   Z,R0
	.ENDM

	.MACRO __PUTB2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R26
	.ENDM

	.MACRO __PUTW2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z,R27
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z,R@1
	.ENDM

	.MACRO __PUTWSRX
	MOVW R30,R28
	SUBI R30,LOW(-@2)
	SBCI R31,HIGH(-@2)
	ST   Z+,R@0
	ST   Z,R@1
	.ENDM

	.MACRO __PUTB1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X,R30
	.ENDM

	.MACRO __PUTW1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X,R31
	.ENDM

	.MACRO __PUTD1SNX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	LD   R0,X+
	LD   R27,X
	MOV  R26,R0
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	.ENDM

	.MACRO __MULBRR
	MULS R@0,R@1
	MOV  R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOV  R30,R0
	.ENDM

	.CSEG
	.ORG 0

	.INCLUDE "I2CLib.vec"
	.INCLUDE "I2CLib.inc"

__RESET:
	CLI
	CLR  R30
	OUT  EECR,R30

;INTERRUPT VECTORS ARE PLACED
;AT THE START OF FLASH
	LDI  R31,1
	OUT  MCUCR,R31
	OUT  MCUCR,R30
	STS  XMCRB,R30
	OUT  RAMPZ,R30

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,13
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(0x1000)
	LDI  R25,HIGH(0x1000)
	LDI  R26,LOW(0x100)
	LDI  R27,HIGH(0x100)
__CLEAR_SRAM:
	ST   X+,R30
	SBIW R24,1
	BRNE __CLEAR_SRAM

;GLOBAL VARIABLES INITIALIZATION
	LDI  R30,LOW(__GLOBAL_INI_TBL*2)
	LDI  R31,HIGH(__GLOBAL_INI_TBL*2)
__GLOBAL_INI_NEXT:
	LPM  R24,Z+
	LPM  R25,Z+
	SBIW R24,0
	BREQ __GLOBAL_INI_END
	LPM  R26,Z+
	LPM  R27,Z+
	LPM  R0,Z+
	LPM  R1,Z+
	MOVW R22,R30
	MOVW R30,R0
__GLOBAL_INI_LOOP:
	LPM  R0,Z+
	ST   X+,R0
	SBIW R24,1
	BRNE __GLOBAL_INI_LOOP
	MOVW R30,R22
	RJMP __GLOBAL_INI_NEXT
__GLOBAL_INI_END:

;STACK POINTER INITIALIZATION
	LDI  R30,LOW(0x10FF)
	OUT  SPL,R30
	LDI  R30,HIGH(0x10FF)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(0x500)
	LDI  R29,HIGH(0x500)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500
;       1 #include "I2CLib/I2CLib.h"                  
;       2 
;       3 BYTE 
;       4 I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
;       5 {

	.CSEG
;       6      WORD i;
;       7 	
;       8 #ifdef CFG_I2C_HIGH_ADDRESS
;       9    if( address > 0x1fff)
;      10 	   return ERROR;
;      11 #else
;      12    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
;      13 	   return ERROR;
;      14 #endif 
;      15      /* Start */
;      16      I2C_Start();  
;      17 	 	   
;      18      /*Device Address & Write mode */
;      19      I2C_ShiftOut( 0xa0 | (BYTE)((ChipAddr<<1)&0x0e) );
;      20      I2C_Ack();
;      21      
;      22 #ifdef CFG_I2C_HIGH_ADDRESS
;      23      I2C_ShiftOut( (address>>8)&0xff ); /* High Address */
;      24      I2C_Ack();       
;      25 #endif 
;      26      
;      27      I2C_ShiftOut( address&0xff );   /* Low Address */
;      28 	 
;      29      for( i=0; i< Count; i++ )
;      30      {
;      31 	/* Data Read  */
;      32 	I2C_OutAck();
;      33 	I2C_ShiftOut( Data[i] );
;      34      }
;      35      I2C_Ack();
;      36 
;      37 	 /** bring SDA high while clock is high */
;      38      I2C_Stop();
;      39 
;      40      for( i=0; i<500; i++ ) 
;      41 	       i2c_delay();		/* 10mSec delay(no test) */
;      42 
;      43      return OK;
;      44 }
;      45 
;      46 BYTE 
;      47 I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
;      48 {
;      49    WORD i;
;      50 
;      51 #ifdef CFG_I2C_HIGH_ADDRESS
;      52    if( address > 0x1fff)
;      53 	   return ERROR;
;      54 #else
;      55    if( address > 0xff)
;	ChipAddr -> Y+5
;	address -> Y+3
;	dat -> Y+2
;	i -> R16,R17
;      56 	   return ERROR;
;      57 #endif 
;      58   
;      59    I2C_Start();  // Start
;      60 
;      61    // Device Address & Write mode
;      62    I2C_ShiftOut( 0xa0 | (BYTE)((ChipAddr<<1)&0x0e) );
;      63    I2C_Ack();
;      64 #ifdef   CFG_I2C_HIGH_ADDRESS
;      65    // High Address 
;      66    I2C_ShiftOut( (address>>8)&0xff );
;      67    I2C_Ack();
;      68 #endif
;      69    // Low Address 
;      70    I2C_ShiftOut( address&0xff );
;      71    I2C_Ack();
;      72    
;      73    I2C_ShiftOut( dat );     // write data 
;      74    I2C_Ack();
;      75 
;      76    // bring SDA high while clock is high 
;      77    I2C_Stop();
;      78 	
;      79    for( i=0; i<400; i++ ) 
;      80 	    i2c_delay();		//10mSec delay(no test) 
;      81 
;      82    return OK;
;      83 }
;      84 
;      85 void i2c_delay(void)
;      86 {
;      87      #asm( "nop" );
;      88      #asm( "nop" );
;      89      #asm( "nop" );
;      90      #asm( "nop" );
;      91      #asm( "nop" );
;      92      #asm( "nop" );
;      93 }
;      94 
;      95 BYTE I2C_Ack(void )
;      96 {
;      97       BYTE Ack;
;      98 	
;      99       HIGH_SDA;    
;	Ack -> R16
;     100       /*LOW_SCLK; */
;     101 
;     102       /*i2c_delay(); */	 
;     103       HIGH_SCLK;
;     104       Ack = PINA.4;//&0x80;	     
;     105       i2c_delay();
;     106       LOW_SCLK; 
;     107 	
;     108       if( Ack ) 
;     109 	    return ERROR;
;     110 	
;     111       return OK; 
;     112 }
;     113 
;     114 BYTE I2C_OutAck( void  )
;     115 {
;     116 	 BYTE Ack;
;     117 	
;     118 	 LOW_SDA;    
;	Ack -> R16
;     119 	 /*LOW_SCLK; */
;     120 
;     121 	 /*i2c_delay(); */	 
;     122          HIGH_SCLK;
;     123 	 Ack = PINA.4;//ioport1&0x80;	     
;     124 	 i2c_delay();
;     125 	 LOW_SCLK; 
;     126 	
;     127 	 if( Ack ) 
;     128 	    return ERROR;
;     129 	
;     130 	 return OK; 
;     131 }
;     132 
;     133 BYTE 
;     134 I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
;     135 {
;     136      WORD i;
;     137 	
;     138 #ifdef CFG_I2C_HIGH_ADDRESS
;     139    if( address > 0x1fff)
;     140 	   return ERROR;
;     141 #else
;     142    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
;     143 	   return ERROR;
;     144 #endif 
;     145      /* Start */
;     146      I2C_Start();  
;     147 	 	   
;     148      // Device Address & Write mod
;     149      I2C_ShiftOut(  0xa0 | (BYTE)((ChipAddr<<1)&0x0e) );
;     150      I2C_Ack();   
;     151      
;     152 #ifdef CFG_I2C_HIGH_ADDRESS 
;     153      // High Address 
;     154      I2C_ShiftOut( (address>>8)&0xff ); 
;     155      I2C_Ack();
;     156 #endif
;     157      // Low Address 
;     158      I2C_ShiftOut( address&0xff );   
;     159 	 
;     160      I2C_Ack();
;     161 
;     162      /* Start */
;     163      I2C_Start();  
;     164      /*Device Address & Read mode */
;     165      I2C_ShiftOut( 0xa1 |(BYTE)((ChipAddr<<1)&0x0e) );
;     166 
;     167      for( i=0; i< Count; i++ )
;     168      {
;     169 	 /* Data Read  */
;     170 	 I2C_OutAck();
;     171 	 Data[i] = I2C_ShiftIn();
;     172      }
;     173 
;     174      I2C_Ack();
;     175      /** bring SDA high while clock is high */
;     176      I2C_Stop();
;     177 
;     178      return OK;
;     179 }
;     180 
;     181 BYTE I2C_Read( BYTE ChipAddr, WORD address )
;     182 {
;     183      BYTE Dat;
;     184 	
;     185 #ifdef CFG_I2C_HIGH_ADDRESS
;     186    if( address > 0x1fff)
;     187 	   return ERROR;
;     188 #else
;     189    if( address > 0xff)
;	ChipAddr -> Y+3
;	address -> Y+1
;	Dat -> R16
;     190 	   return ERROR;
;     191 #endif 
;     192  
;     193      I2C_Start();   // Start 
;     194 	   
;     195      /*Device Address & Write mode */
;     196      I2C_ShiftOut( 0xa0 | (BYTE)((ChipAddr<<1)&0x0e) );
;     197      I2C_Ack();    
;     198      
;     199 #ifdef CFG_I2C_HIGH_ADDRESS	
;     200      // High Address 
;     201      I2C_ShiftOut( (address>>8)&0xff );
;     202      I2C_Ack();
;     203 #endif 
;     204 
;     205      // Low Address 
;     206      I2C_ShiftOut( address&0xff );
;     207 	
;     208      I2C_Ack();
;     209   
;     210      // Start 
;     211      I2C_Start();  
;     212   
;     213      // Device Address & Read mode 
;     214      I2C_ShiftOut( 0xa1| (BYTE)((ChipAddr<<1)&0x0e)  );
;     215 	
;     216      I2C_Ack();
;     217 	
;     218       // Data Read  
;     219       Dat = I2C_ShiftIn();
;     220 	
;     221       I2C_Ack();
;     222 
;     223       /** bring SDA high while clock is high */
;     224       I2C_Stop();
;     225 	
;     226      return Dat;
;     227 }
;     228 
;     229 void I2C_Start(void )
;     230 {
;     231     HIGH_SDA;    /* high serial data  */
;     232     HIGH_SCLK;   /* high serial clock */
;     233     i2c_delay();
;     234     LOW_SDA;     /* low  serial data */
;     235     i2c_delay();
;     236     LOW_SCLK;    /* low  serial clock */
;     237     i2c_delay();
;     238 }
;     239 
;     240 void I2C_Stop( void )
;     241 {
;     242     
;     243    LOW_SCLK;
;     244    LOW_SDA;      /* low serial data */
;     245    i2c_delay();
;     246    HIGH_SCLK;    /* high serial clock */
;     247    i2c_delay();
;     248    HIGH_SDA;     /* high serial data	  */
;     249 }
;     250 
;     251 void I2C_ShiftOut( BYTE dat )
;     252 {
;     253      BYTE i,temp;
;     254 	
;     255      for( i=0; i<8; i++ )
;	dat -> Y+2
;	i -> R16
;	temp -> R17
;     256      {
;     257         /* right shift */
;     258         temp = dat & ( 0x80>>i );
;     259 	
;     260        if( temp )  HIGH_SDA;    /* high data   */   
;     261        else        LOW_SDA;
;     262        i2c_delay(); 
;     263        HIGH_SCLK;              /* high clock   */  
;     264        i2c_delay();
;     265        LOW_SCLK;               /* low clock    */ 
;     266        i2c_delay();
;     267      }
;     268 }
;     269 
;     270 BYTE I2C_ShiftIn( void )
;     271 {
;     272    BYTE i=0,temp;
;     273    BYTE Dat=0;
;     274 	
;     275    for( i=0; i<8; i++ )
;	i -> R16
;	temp -> R17
;	Dat -> R18
;     276    {	      
;     277       HIGH_SDA;
;     278       HIGH_SCLK;         /* high serial clock	*/	 
;     279      
;     280       temp = PINA.4;//&0x80;
;     281       Dat |= ( temp>>i ); 
;     282           
;     283       i2c_delay();
;     284       LOW_SCLK;          /* low serial clock; */
;     285       i2c_delay();
;     286    }	
;     287    return Dat;
;     288 } 
;     289 /*****************************************************
;     290 This program was produced by the
;     291 CodeWizardAVR V1.24.4 Standard
;     292 Automatic Program Generator
;     293 © Copyright 1998-2004 Pavel Haiduc, HP InfoTech s.r.l.
;     294 http://www.hpinfotech.com
;     295 e-mail:office@hpinfotech.com
;     296 
;     297 Project : 
;     298 Version : 
;     299 Date    : 2007-11-12
;     300 Author  : spy516                          
;     301 Company : tbk                             
;     302 Comments: 
;     303 
;     304 
;     305 Chip type           : ATmega128L
;     306 Program type        : Application
;     307 Clock frequency     : 4.000000 MHz
;     308 Memory model        : Small
;     309 External SRAM size  : 0
;     310 Data Stack size     : 1024
;     311 *****************************************************/
;     312 
;     313 #include <mega128.h>      
;     314 #include <DELAY.H>
;     315 #include "UserDefine.h"
;     316 
;     317 void  Init_System( void );
;     318 void  Init_Port( void );
;     319 
;     320 // Declare your global variables here
;     321 
;     322 void main(void )
;     323 {  
_main:
;     324    WORD CountH,CountV;  
;     325    BYTE flicker;
;     326    
;     327    Init_System( );
;	CountH -> R16,R17
;	CountV -> R18,R19
;	flicker -> R20
	RCALL _Init_System
;     328    
;     329    HIGH_VSYNC;
	SBI  0x15,0
;     330    HIGH_HSYNC;
	SBI  0x15,1
;     331    
;     332    CountV = 0;
	__GETWRN 18,19,0
;     333    CountH = 0;
	__GETWRN 16,17,0
;     334    flicker = 0;
	LDI  R20,LOW(0)
;     335     
;     336    while ( 1 )
_0x1D:
;     337    {
;     338       // Place your code here
;     339       
;     340       //delay_us(10);         
;     341       LOW_HSYNC;
	CBI  0x15,1
;     342       delay_us(3); 
	__DELAY_USB 4
;     343       HIGH_HSYNC;
	SBI  0x15,1
;     344       delay_us( 65 );     
	__DELAY_USB 87
;     345        
;     346       CountH++;   
	__ADDWRN 16,17,1
;     347       
;     348       //delay_us(10); 
;     349                   
;     350       if( CountH >= 9000 )   
	__CPWRN 16,17,9000
	BRLO _0x20
;     351       { 
;     352          // LOW_LED;                          
;     353          
;     354          CountH = 0;    
	__GETWRN 16,17,0
;     355  
;     356          delay_us(450); 
	__DELAY_USW 450
;     357            
;     358          LOW_VSYNC;
	CBI  0x15,0
;     359          delay_us(64);  
	__DELAY_USB 85
;     360             
;     361          HIGH_VSYNC;    
	SBI  0x15,0
;     362             
;     363          delay_us( 450 );       
	__DELAY_USW 450
;     364 
;     365       }
;     366        
;     367 
;     368    };
_0x20:
	RJMP _0x1D
;     369 }        
_0x21:
	RJMP _0x21
;     370 
;     371 
;     372 void Init_Port( void )
;     373 {
_Init_Port:
;     374 // Declare your local variables here
;     375 
;     376 // Input/Output Ports initialization
;     377 // Port A initialization
;     378 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     379 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     380 PORTA=0x00;
	LDI  R30,LOW(0)
	OUT  0x1B,R30
;     381 DDRA=0x00;
	OUT  0x1A,R30
;     382 
;     383 // Port B initialization
;     384 // Func7=In Func6=In Func5=Out Func4=In Func3=In Func2=In Func1=In Func0=In 
;     385 // State7=T State6=T State5=1 State4=T State3=T State2=T State1=T State0=T 
;     386 PORTB=0x40;
	LDI  R30,LOW(64)
	OUT  0x18,R30
;     387 DDRB=0x40;
	OUT  0x17,R30
;     388 
;     389 // Port C initialization
;     390 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     391 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     392 PORTC=0x03;
	LDI  R30,LOW(3)
	OUT  0x15,R30
;     393 DDRC=0x0f;
	LDI  R30,LOW(15)
	OUT  0x14,R30
;     394 
;     395 // Port D initialization
;     396 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     397 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     398 PORTD=0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
;     399 DDRD=0x00;
	OUT  0x11,R30
;     400 
;     401 // Port E initialization
;     402 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     403 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     404 PORTE=0x00;
	OUT  0x3,R30
;     405 DDRE=0x00;
	OUT  0x2,R30
;     406 
;     407 // Port F initialization
;     408 // Func7=In Func6=In Func5=In Func4=In Func3=In Func2=In Func1=In Func0=In 
;     409 // State7=T State6=T State5=T State4=T State3=T State2=T State1=T State0=T 
;     410 PORTF=0x00;
	STS  0x62,R30
;     411 DDRF=0x00;
	STS  0x61,R30
;     412 
;     413 // Port G initialization
;     414 // Func4=In Func3=In Func2=In Func1=In Func0=In 
;     415 // State4=T State3=T State2=T State1=T State0=T 
;     416 PORTG=0x00;
	STS  0x65,R30
;     417 DDRG=0x00;
	STS  0x64,R30
;     418 
;     419 // Timer/Counter 0 initialization
;     420 // Clock source: System Clock
;     421 // Clock value: Timer 0 Stopped
;     422 // Mode: Normal top=FFh
;     423 // OC0 output: Disconnected
;     424 ASSR=0x00;
	OUT  0x30,R30
;     425 TCCR0=0x00;
	OUT  0x33,R30
;     426 TCNT0=0x00;
	OUT  0x32,R30
;     427 OCR0=0x00;
	OUT  0x31,R30
;     428 
;     429 // Timer/Counter 1 initialization
;     430 // Clock source: System Clock
;     431 // Clock value: Timer 1 Stopped
;     432 // Mode: Normal top=FFFFh
;     433 // OC1A output: Discon.
;     434 // OC1B output: Discon.
;     435 // OC1C output: Discon.
;     436 // Noise Canceler: Off
;     437 // Input Capture on Falling Edge
;     438 TCCR1A=0x00;
	OUT  0x2F,R30
;     439 TCCR1B=0x00;
	OUT  0x2E,R30
;     440 TCNT1H=0x00;
	OUT  0x2D,R30
;     441 TCNT1L=0x00;
	OUT  0x2C,R30
;     442 ICR1H=0x00;
	OUT  0x27,R30
;     443 ICR1L=0x00;
	OUT  0x26,R30
;     444 OCR1AH=0x00;
	OUT  0x2B,R30
;     445 OCR1AL=0x00;
	OUT  0x2A,R30
;     446 OCR1BH=0x00;
	OUT  0x29,R30
;     447 OCR1BL=0x00;
	OUT  0x28,R30
;     448 OCR1CH=0x00;
	STS  0x79,R30
;     449 OCR1CL=0x00;
	STS  0x78,R30
;     450 
;     451 // Timer/Counter 2 initialization
;     452 // Clock source: System Clock
;     453 // Clock value: Timer 2 Stopped
;     454 // Mode: Normal top=FFh
;     455 // OC2 output: Disconnected
;     456 TCCR2=0x00;
	OUT  0x25,R30
;     457 TCNT2=0x00;
	OUT  0x24,R30
;     458 OCR2=0x00;
	OUT  0x23,R30
;     459 
;     460 // Timer/Counter 3 initialization
;     461 // Clock source: System Clock
;     462 // Clock value: Timer 3 Stopped
;     463 // Mode: Normal top=FFFFh
;     464 // Noise Canceler: Off
;     465 // Input Capture on Falling Edge
;     466 // OC3A output: Discon.
;     467 // OC3B output: Discon.
;     468 // OC3C output: Discon.
;     469 TCCR3A=0x00;
	STS  0x8B,R30
;     470 TCCR3B=0x00;
	STS  0x8A,R30
;     471 TCNT3H=0x00;
	STS  0x89,R30
;     472 TCNT3L=0x00;
	STS  0x88,R30
;     473 ICR3H=0x00;
	STS  0x81,R30
;     474 ICR3L=0x00;
	STS  0x80,R30
;     475 OCR3AH=0x00;
	STS  0x87,R30
;     476 OCR3AL=0x00;
	STS  0x86,R30
;     477 OCR3BH=0x00;
	STS  0x85,R30
;     478 OCR3BL=0x00;
	STS  0x84,R30
;     479 OCR3CH=0x00;
	STS  0x83,R30
;     480 OCR3CL=0x00;
	STS  0x82,R30
;     481 
;     482 // External Interrupt(s) initialization
;     483 // INT0: Off
;     484 // INT1: Off
;     485 // INT2: Off
;     486 // INT3: Off
;     487 // INT4: Off
;     488 // INT5: Off
;     489 // INT6: Off
;     490 // INT7: Off
;     491 EICRA=0x00;
	STS  0x6A,R30
;     492 EICRB=0x00;
	OUT  0x3A,R30
;     493 EIMSK=0x00;
	OUT  0x39,R30
;     494 
;     495 // Timer(s)/Counter(s) Interrupt(s) initialization
;     496 TIMSK=0x00;
	OUT  0x37,R30
;     497 ETIMSK=0x00;
	STS  0x7D,R30
;     498 
;     499    // Analog Comparator initialization
;     500    // Analog Comparator: Off
;     501    // Analog Comparator Input Capture by Timer/Counter 1: Off
;     502    ACSR=0x80;
	LDI  R30,LOW(128)
	OUT  0x8,R30
;     503    SFIOR=0x00;  
	LDI  R30,LOW(0)
	OUT  0x20,R30
;     504 }       
	RET
;     505 void Init_System( void )
;     506 {
_Init_System:
;     507    Init_Port();
	RCALL _Init_Port
;     508 }
	RET

__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:

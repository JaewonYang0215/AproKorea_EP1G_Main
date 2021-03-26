
;CodeVisionAVR C Compiler V3.12 Advanced
;(C) Copyright 1998-2014 Pavel Haiduc, HP InfoTech s.r.l.
;http://www.hpinfotech.com

;Build configuration    : Release
;Chip type              : ATmega128
;Program type           : Application
;Clock frequency        : 16.000000 MHz
;Memory model           : Small
;Optimize for           : Size
;(s)printf features     : int, width
;(s)scanf features      : int, width
;External RAM size      : 0
;Data Stack size        : 1024 byte(s)
;Heap size              : 0 byte(s)
;Promote 'char' to 'int': No
;'char' is unsigned     : Yes
;8 bit enums            : No
;Global 'const' stored in FLASH: Yes
;Enhanced function parameter passing: Yes
;Enhanced core instructions: On
;Automatic register allocation for global variables: On
;Smart register allocation: On

	#define _MODEL_SMALL_

	#pragma AVRPART ADMIN PART_NAME ATmega128
	#pragma AVRPART MEMORY PROG_FLASH 131072
	#pragma AVRPART MEMORY EEPROM 4096
	#pragma AVRPART MEMORY INT_SRAM SIZE 4096
	#pragma AVRPART MEMORY INT_SRAM START_ADDR 0x100

	#define CALL_SUPPORTED 1

	.LISTMAC
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

	.EQU __SRAM_START=0x0100
	.EQU __SRAM_END=0x10FF
	.EQU __DSTACK_SIZE=0x0400
	.EQU __HEAP_SIZE=0x0000
	.EQU __CLEAR_SRAM_SIZE=__SRAM_END-__SRAM_START+1

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

	.MACRO __ADDB1MN
	SUBI R30,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDB2MN
	SUBI R26,LOW(-@0-(@1))
	.ENDM

	.MACRO __ADDW1MN
	SUBI R30,LOW(-@0-(@1))
	SBCI R31,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW2MN
	SUBI R26,LOW(-@0-(@1))
	SBCI R27,HIGH(-@0-(@1))
	.ENDM

	.MACRO __ADDW1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	.ENDM

	.MACRO __ADDD1FN
	SUBI R30,LOW(-2*@0-(@1))
	SBCI R31,HIGH(-2*@0-(@1))
	SBCI R22,BYTE3(-2*@0-(@1))
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

	.MACRO __ANDBMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ANDWMNN
	LDS  R30,@0+(@1)
	ANDI R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ANDI R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ANDD1N
	ANDI R30,LOW(@0)
	ANDI R31,HIGH(@0)
	ANDI R22,BYTE3(@0)
	ANDI R23,BYTE4(@0)
	.ENDM

	.MACRO __ANDD2N
	ANDI R26,LOW(@0)
	ANDI R27,HIGH(@0)
	ANDI R24,BYTE3(@0)
	ANDI R25,BYTE4(@0)
	.ENDM

	.MACRO __ORBMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	.ENDM

	.MACRO __ORWMNN
	LDS  R30,@0+(@1)
	ORI  R30,LOW(@2)
	STS  @0+(@1),R30
	LDS  R30,@0+(@1)+1
	ORI  R30,HIGH(@2)
	STS  @0+(@1)+1,R30
	.ENDM

	.MACRO __ORD1N
	ORI  R30,LOW(@0)
	ORI  R31,HIGH(@0)
	ORI  R22,BYTE3(@0)
	ORI  R23,BYTE4(@0)
	.ENDM

	.MACRO __ORD2N
	ORI  R26,LOW(@0)
	ORI  R27,HIGH(@0)
	ORI  R24,BYTE3(@0)
	ORI  R25,BYTE4(@0)
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

	.MACRO __GETD1S
	LDD  R30,Y+@0
	LDD  R31,Y+@0+1
	LDD  R22,Y+@0+2
	LDD  R23,Y+@0+3
	.ENDM

	.MACRO __GETD2S
	LDD  R26,Y+@0
	LDD  R27,Y+@0+1
	LDD  R24,Y+@0+2
	LDD  R25,Y+@0+3
	.ENDM

	.MACRO __PUTD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R31
	STD  Y+@0+2,R22
	STD  Y+@0+3,R23
	.ENDM

	.MACRO __PUTD2S
	STD  Y+@0,R26
	STD  Y+@0+1,R27
	STD  Y+@0+2,R24
	STD  Y+@0+3,R25
	.ENDM

	.MACRO __PUTDZ2
	STD  Z+@0,R26
	STD  Z+@0+1,R27
	STD  Z+@0+2,R24
	STD  Z+@0+3,R25
	.ENDM

	.MACRO __CLRD1S
	STD  Y+@0,R30
	STD  Y+@0+1,R30
	STD  Y+@0+2,R30
	STD  Y+@0+3,R30
	.ENDM

	.MACRO __POINTB1MN
	LDI  R30,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW1MN
	LDI  R30,LOW(@0+(@1))
	LDI  R31,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTD1M
	LDI  R30,LOW(@0)
	LDI  R31,HIGH(@0)
	LDI  R22,BYTE3(@0)
	LDI  R23,BYTE4(@0)
	.ENDM

	.MACRO __POINTW1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	LDI  R22,BYTE3(2*@0+(@1))
	LDI  R23,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTB2MN
	LDI  R26,LOW(@0+(@1))
	.ENDM

	.MACRO __POINTW2MN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	.ENDM

	.MACRO __POINTW2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	.ENDM

	.MACRO __POINTD2FN
	LDI  R26,LOW(2*@0+(@1))
	LDI  R27,HIGH(2*@0+(@1))
	LDI  R24,BYTE3(2*@0+(@1))
	LDI  R25,BYTE4(2*@0+(@1))
	.ENDM

	.MACRO __POINTBRM
	LDI  R@0,LOW(@1)
	.ENDM

	.MACRO __POINTWRM
	LDI  R@0,LOW(@2)
	LDI  R@1,HIGH(@2)
	.ENDM

	.MACRO __POINTBRMN
	LDI  R@0,LOW(@1+(@2))
	.ENDM

	.MACRO __POINTWRMN
	LDI  R@0,LOW(@2+(@3))
	LDI  R@1,HIGH(@2+(@3))
	.ENDM

	.MACRO __POINTWRFN
	LDI  R@0,LOW(@2*2+(@3))
	LDI  R@1,HIGH(@2*2+(@3))
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

	.MACRO __GETB1MN
	LDS  R30,@0+(@1)
	.ENDM

	.MACRO __GETB1HMN
	LDS  R31,@0+(@1)
	.ENDM

	.MACRO __GETW1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	.ENDM

	.MACRO __GETD1MN
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	LDS  R22,@0+(@1)+2
	LDS  R23,@0+(@1)+3
	.ENDM

	.MACRO __GETBRMN
	LDS  R@0,@1+(@2)
	.ENDM

	.MACRO __GETWRMN
	LDS  R@0,@2+(@3)
	LDS  R@1,@2+(@3)+1
	.ENDM

	.MACRO __GETWRZ
	LDD  R@0,Z+@2
	LDD  R@1,Z+@2+1
	.ENDM

	.MACRO __GETD2Z
	LDD  R26,Z+@0
	LDD  R27,Z+@0+1
	LDD  R24,Z+@0+2
	LDD  R25,Z+@0+3
	.ENDM

	.MACRO __GETB2MN
	LDS  R26,@0+(@1)
	.ENDM

	.MACRO __GETW2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	.ENDM

	.MACRO __GETD2MN
	LDS  R26,@0+(@1)
	LDS  R27,@0+(@1)+1
	LDS  R24,@0+(@1)+2
	LDS  R25,@0+(@1)+3
	.ENDM

	.MACRO __PUTB1MN
	STS  @0+(@1),R30
	.ENDM

	.MACRO __PUTW1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	.ENDM

	.MACRO __PUTD1MN
	STS  @0+(@1),R30
	STS  @0+(@1)+1,R31
	STS  @0+(@1)+2,R22
	STS  @0+(@1)+3,R23
	.ENDM

	.MACRO __PUTB1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRB
	.ENDM

	.MACRO __PUTW1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRW
	.ENDM

	.MACRO __PUTD1EN
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMWRD
	.ENDM

	.MACRO __PUTBR0MN
	STS  @0+(@1),R0
	.ENDM

	.MACRO __PUTBMRN
	STS  @0+(@1),R@2
	.ENDM

	.MACRO __PUTWMRN
	STS  @0+(@1),R@2
	STS  @0+(@1)+1,R@3
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

	.MACRO __PUTBSR
	STD  Y+@1,R@0
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
	LDS  R30,@0+(@1)
	LDS  R31,@0+(@1)+1
	ICALL
	.ENDM

	.MACRO __CALL1FN
	LDI  R30,LOW(2*@0+(@1))
	LDI  R31,HIGH(2*@0+(@1))
	CALL __GETW1PF
	ICALL
	.ENDM

	.MACRO __CALL2EN
	PUSH R26
	PUSH R27
	LDI  R26,LOW(@0+(@1))
	LDI  R27,HIGH(@0+(@1))
	CALL __EEPROMRDW
	POP  R27
	POP  R26
	ICALL
	.ENDM

	.MACRO __CALL2EX
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	CALL __EEPROMRDD
	ICALL
	.ENDM

	.MACRO __GETW1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R31,Z
	MOV  R30,R0
	.ENDM

	.MACRO __GETD1STACK
	IN   R30,SPL
	IN   R31,SPH
	ADIW R30,@0+1
	LD   R0,Z+
	LD   R1,Z+
	LD   R22,Z
	MOVW R30,R0
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

	.MACRO __GETB1HSX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	LD   R31,Z
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

	.MACRO __GETBRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@1)
	SBCI R27,HIGH(-@1)
	LD   R@0,X
	.ENDM

	.MACRO __GETWRSX2
	MOVW R26,R28
	SUBI R26,LOW(-@2)
	SBCI R27,HIGH(-@2)
	LD   R@0,X+
	LD   R@1,X
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
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X,R30
	.ENDM

	.MACRO __CLRD1SX
	MOVW R26,R28
	SUBI R26,LOW(-@0)
	SBCI R27,HIGH(-@0)
	ST   X+,R30
	ST   X+,R30
	ST   X+,R30
	ST   X,R30
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

	.MACRO __PUTD2SX
	MOVW R30,R28
	SUBI R30,LOW(-@0)
	SBCI R31,HIGH(-@0)
	ST   Z+,R26
	ST   Z+,R27
	ST   Z+,R24
	ST   Z,R25
	.ENDM

	.MACRO __PUTBSRX
	MOVW R30,R28
	SUBI R30,LOW(-@1)
	SBCI R31,HIGH(-@1)
	ST   Z,R@0
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
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRRU
	MUL  R@0,R@1
	MOVW R30,R0
	.ENDM

	.MACRO __MULBRR0
	MULS R@0,R@1
	.ENDM

	.MACRO __MULBRRU0
	MUL  R@0,R@1
	.ENDM

	.MACRO __MULBNWRU
	LDI  R26,@2
	MUL  R26,R@0
	MOVW R30,R0
	MUL  R26,R@1
	ADD  R31,R0
	.ENDM

;NAME DEFINITIONS FOR GLOBAL VARIABLES ALLOCATED TO REGISTERS
	.DEF _gOldUartTime1ms=R4
	.DEF _gOldUartTime1ms_msb=R5
	.DEF _rx_wr_index1=R7
	.DEF _rx_rd_index1=R6
	.DEF _rx_counter1=R9
	.DEF _rx_buffer_overflow1=R8
	.DEF _mRcvErrFlag=R11
	.DEF _gAD_Channel=R10

	.CSEG
	.ORG 0x00

;START OF CODE MARKER
__START_OF_CODE:

;INTERRUPT VECTORS
	JMP  __RESET
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _usart1_rx_isr
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  0x00

_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0

_0x80003:
	.DB  LOW(_IPC_RCV_MODE),HIGH(_IPC_RCV_MODE),LOW(_IPC_RCV_RUN),HIGH(_IPC_RCV_RUN),LOW(_IPC_RCV_LEVEL),HIGH(_IPC_RCV_LEVEL),LOW(_IPC_RCV_VOLTAGE),HIGH(_IPC_RCV_VOLTAGE)
	.DB  LOW(_IPC_RCV_CURRENT),HIGH(_IPC_RCV_CURRENT),LOW(_IPC_RCV_TEMP_INT),HIGH(_IPC_RCV_TEMP_INT),LOW(_IPC_RCV_TEMP_EXT),HIGH(_IPC_RCV_TEMP_EXT),LOW(_IPC_RCV_PLATE),HIGH(_IPC_RCV_PLATE)
	.DB  LOW(_IPC_RCV_HEATSINK),HIGH(_IPC_RCV_HEATSINK),LOW(_IPC_RCV_REF_VOL),HIGH(_IPC_RCV_REF_VOL),LOW(_IPC_RCV_REF_CUR),HIGH(_IPC_RCV_REF_CUR),LOW(_IPC_RCV_REF_TEMP),HIGH(_IPC_RCV_REF_TEMP)
_0x80012:
	.DB  LOW(_IPC_SND_MODE),HIGH(_IPC_SND_MODE),LOW(_IPC_SND_RUN),HIGH(_IPC_SND_RUN),LOW(_IPC_SND_LEVEL),HIGH(_IPC_SND_LEVEL),LOW(_IPC_SND_VOLTAGE),HIGH(_IPC_SND_VOLTAGE)
	.DB  LOW(_IPC_SND_CURRENT),HIGH(_IPC_SND_CURRENT),LOW(_IPC_SND_TEMP_INT),HIGH(_IPC_SND_TEMP_INT),LOW(_IPC_SND_TEMP_EXT),HIGH(_IPC_SND_TEMP_EXT),LOW(_IPC_SND_PLATE),HIGH(_IPC_SND_PLATE)
	.DB  LOW(_IPC_SND_HEATSINK),HIGH(_IPC_SND_HEATSINK),LOW(_IPC_SND_REF_VOL),HIGH(_IPC_SND_REF_VOL),LOW(_IPC_SND_REF_CUR),HIGH(_IPC_SND_REF_CUR),LOW(_IPC_SND_REF_TEMP),HIGH(_IPC_SND_REF_TEMP)
_0x2080060:
	.DB  0x1
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x08
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x18
	.DW  _IPCRcvfun
	.DW  _0x80003*2

	.DW  0x18
	.DW  _IPCSndfun
	.DW  _0x80012*2

	.DW  0x01
	.DW  __seed_G104
	.DW  _0x2080060*2

_0xFFFFFFFF:
	.DW  0

#define __GLOBAL_INI_TBL_PRESENT 1

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

;DISABLE WATCHDOG
	LDI  R31,0x18
	OUT  WDTCR,R31
	OUT  WDTCR,R30

;CLEAR R2-R14
	LDI  R24,(14-2)+1
	LDI  R26,2
	CLR  R27
__CLEAR_REG:
	ST   X+,R30
	DEC  R24
	BRNE __CLEAR_REG

;CLEAR SRAM
	LDI  R24,LOW(__CLEAR_SRAM_SIZE)
	LDI  R25,HIGH(__CLEAR_SRAM_SIZE)
	LDI  R26,LOW(__SRAM_START)
	LDI  R27,HIGH(__SRAM_START)
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

	OUT  RAMPZ,R24

;HARDWARE STACK POINTER INITIALIZATION
	LDI  R30,LOW(__SRAM_END-__HEAP_SIZE)
	OUT  SPL,R30
	LDI  R30,HIGH(__SRAM_END-__HEAP_SIZE)
	OUT  SPH,R30

;DATA STACK POINTER INITIALIZATION
	LDI  R28,LOW(__SRAM_START+__DSTACK_SIZE)
	LDI  R29,HIGH(__SRAM_START+__DSTACK_SIZE)

	JMP  _main

	.ESEG
	.ORG 0

	.DSEG
	.ORG 0x500

	.CSEG
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include  "I2CLib.h"
;
;BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
; 0000 0006 {

	.CSEG
; 0000 0007      WORD i;
; 0000 0008 
; 0000 0009 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 000A    if( address > 0x1fff)
; 0000 000B        return ERROR;
; 0000 000C #else
; 0000 000D    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 0000 000E        return ERROR;
; 0000 000F #endif
; 0000 0010      /* Start */
; 0000 0011      I2C_Start();
; 0000 0012      /*Device Address & Write mode */
; 0000 0013      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0000 0014      I2C_Ack();
; 0000 0015 
; 0000 0016 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 0017      I2C_ShiftOut( (address>>8)&0xff ); /* High Address */
; 0000 0018      I2C_Ack();
; 0000 0019 #endif
; 0000 001A 
; 0000 001B      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );   /* Low Address */
; 0000 001C      I2C_Ack();
; 0000 001D 
; 0000 001E      for( i=0; i< Count; i++ )
; 0000 001F      {
; 0000 0020     /* Data Read  */
; 0000 0021     I2C_ShiftOut( Data[i] );
; 0000 0022            I2C_Ack();
; 0000 0023      }
; 0000 0024     // I2C_Ack();
; 0000 0025 
; 0000 0026      /** bring SDA high while clock is high */
; 0000 0027      I2C_Stop();
; 0000 0028 
; 0000 0029      //for( i=0; i<500; i++ )
; 0000 002A            i2c_delay();        /* 10mSec delay(no test) */
; 0000 002B 
; 0000 002C      return OK;
; 0000 002D }
;
;
;BYTE I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
; 0000 0031 {
_I2C_Write:
; .FSTART _I2C_Write
; 0000 0032    //WORD i;
; 0000 0033 
; 0000 0034 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 0035    if( address > 0x1fff)
; 0000 0036        return ERROR;
; 0000 0037 #else
; 0000 0038    if( address > 0xff)
	ST   -Y,R26
;	ChipAddr -> Y+3
;	address -> Y+1
;	dat -> Y+0
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	BRLO _0x7
; 0000 0039        return ERROR;
	LDI  R30,LOW(255)
	JMP  _0x20A0006
; 0000 003A #endif
; 0000 003B 
; 0000 003C    I2C_Start();  // Start
_0x7:
	RCALL _I2C_Start
; 0000 003D 
; 0000 003E    // Device Address & Write mode
; 0000 003F    I2C_ShiftOut( ChipAddr&0xfe );
	LDD  R30,Y+3
	ANDI R30,0xFE
	MOV  R26,R30
	CALL SUBOPT_0x0
; 0000 0040    I2C_Ack();
; 0000 0041 
; 0000 0042 #ifdef   CFG_I2C_HIGH_ADDRESS
; 0000 0043    // High Address
; 0000 0044    I2C_ShiftOut( (address>>8)&0xff );
; 0000 0045    I2C_Ack();
; 0000 0046 #endif
; 0000 0047 
; 0000 0048    // Low Address
; 0000 0049    I2C_ShiftOut( address&0xff );
	LDD  R30,Y+1
	MOV  R26,R30
	CALL SUBOPT_0x0
; 0000 004A    I2C_Ack();
; 0000 004B 
; 0000 004C    I2C_ShiftOut( dat );     // write data
	LD   R26,Y
	CALL SUBOPT_0x0
; 0000 004D    I2C_Ack();
; 0000 004E 
; 0000 004F    // bring SDA high while clock is high
; 0000 0050    I2C_Stop();
	RCALL _I2C_Stop
; 0000 0051 
; 0000 0052    //for( i=0; i<400; i++ )
; 0000 0053         i2c_delay();        //10mSec delay(no test)
	RCALL _i2c_delay
; 0000 0054 
; 0000 0055    return OK;
	LDI  R30,LOW(0)
	JMP  _0x20A0006
; 0000 0056 }
; .FEND
;
;void i2c_delay(void)
; 0000 0059 {
_i2c_delay:
; .FSTART _i2c_delay
; 0000 005A   // int i;
; 0000 005B 
; 0000 005C //   for( i=0; i<10;i++ )    //
; 0000 005D  //    for( i=0; i<2;i++ )    //
; 0000 005E 
; 0000 005F        #asm( "nop" );
	nop
; 0000 0060 }
	RET
; .FEND
;
;BYTE I2C_Ack(void )
; 0000 0063 {
_I2C_Ack:
; .FSTART _I2C_Ack
; 0000 0064      BYTE Ack;
; 0000 0065 
; 0000 0066      HIGH_SDA;
	ST   -Y,R17
;	Ack -> R17
	SBI  0x1B,0
; 0000 0067 
; 0000 0068      I2C_R_MODE; //DDRC.2 = 0;
	CBI  0x1A,0
; 0000 0069      HIGH_SCLK;
	CALL SUBOPT_0x1
; 0000 006A      i2c_delay();
; 0000 006B      Ack = IN_SDA;
	MOV  R17,R30
; 0000 006C      i2c_delay();
	RCALL _i2c_delay
; 0000 006D      LOW_SCLK;
	CBI  0x1B,1
; 0000 006E 
; 0000 006F      I2C_W_MODE; //DDRC.2 = 1;
	SBI  0x1A,0
; 0000 0070      i2c_delay();
	RCALL _i2c_delay
; 0000 0071 
; 0000 0072      if( Ack )
	CPI  R17,0
	BREQ _0x12
; 0000 0073         return ERROR;
	LDI  R30,LOW(255)
	RJMP _0x20A000D
; 0000 0074 
; 0000 0075      return OK;
_0x12:
	LDI  R30,LOW(0)
_0x20A000D:
	LD   R17,Y+
	RET
; 0000 0076 }
; .FEND
;
;BYTE I2C_OutAck( BYTE Flag  )
; 0000 0079 {
; 0000 007A        //BYTE Ack;
; 0000 007B 
; 0000 007C        if( Flag )    HIGH_SDA;
;	Flag -> Y+0
; 0000 007D         else        LOW_SDA;
; 0000 007E        /*LOW_SCLK; */
; 0000 007F 
; 0000 0080        /*i2c_delay(); */
; 0000 0081        HIGH_SCLK;
; 0000 0082       // Ack = IN_SDA;//ioport1&0x80;
; 0000 0083        i2c_delay();
; 0000 0084        LOW_SCLK;
; 0000 0085 
; 0000 0086        i2c_delay();
; 0000 0087 
; 0000 0088        //if( Ack )
; 0000 0089 //    return ERROR;
; 0000 008A 
; 0000 008B        return OK;
; 0000 008C }
;
;
;BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
; 0000 0090 {
; 0000 0091      WORD i;
; 0000 0092 
; 0000 0093 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 0094    if( address > 0x1fff)
; 0000 0095        return ERROR;
; 0000 0096 #else
; 0000 0097    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 0000 0098        return ERROR;
; 0000 0099 #endif
; 0000 009A      /* Start */
; 0000 009B      I2C_Start();
; 0000 009C      // Device Address & Write mod
; 0000 009D      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0000 009E      I2C_Ack();
; 0000 009F 
; 0000 00A0 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 00A1      // High Address
; 0000 00A2      I2C_ShiftOut( (address>>8)&0xff );
; 0000 00A3      I2C_Ack();
; 0000 00A4 #endif
; 0000 00A5      // Low Address
; 0000 00A6      I2C_ShiftOut( address&0xff );
; 0000 00A7      I2C_Ack();
; 0000 00A8 
; 0000 00A9      /* Start */
; 0000 00AA      I2C_Start();
; 0000 00AB      /*Device Address & Read mode */
; 0000 00AC      I2C_ShiftOut( 0x01|(BYTE)(ChipAddr&0xff) );
; 0000 00AD      I2C_Ack();
; 0000 00AE 
; 0000 00AF      for( i=0; i< Count-1; i++ )
; 0000 00B0      {
; 0000 00B1      /* Data Read  */
; 0000 00B2      Data[i] = I2C_ShiftIn();
; 0000 00B3            // I2C_Ack();
; 0000 00B4            I2C_OutAck( FALSE );
; 0000 00B5      }
; 0000 00B6       Data[i] =    I2C_ShiftIn();
; 0000 00B7       I2C_OutAck( TRUE );
; 0000 00B8      //I2C_Ack();
; 0000 00B9      /** bring SDA high while clock is high */
; 0000 00BA      I2C_Stop();
; 0000 00BB 
; 0000 00BC      return OK;
; 0000 00BD }
;
;BYTE I2C_Read( BYTE ChipAddr, WORD address )
; 0000 00C0 {
; 0000 00C1      BYTE Dat;
; 0000 00C2 
; 0000 00C3 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 00C4    if( address > 0x1fff)
; 0000 00C5        return ERROR;
; 0000 00C6 #else
; 0000 00C7    if( address > 0xff)
;	ChipAddr -> Y+3
;	address -> Y+1
;	Dat -> R17
; 0000 00C8        return ERROR;
; 0000 00C9 #endif
; 0000 00CA 
; 0000 00CB      I2C_Start();   // Start
; 0000 00CC 
; 0000 00CD      /*Device Address & Write mode */
; 0000 00CE      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0000 00CF      I2C_Ack();
; 0000 00D0 
; 0000 00D1 #ifdef CFG_I2C_HIGH_ADDRESS
; 0000 00D2      // High Address
; 0000 00D3      I2C_ShiftOut( (address>>8)&0xff );
; 0000 00D4      I2C_Ack();
; 0000 00D5 #endif
; 0000 00D6 
; 0000 00D7      // Low Address
; 0000 00D8      I2C_ShiftOut( address&0xff );
; 0000 00D9      I2C_Ack();
; 0000 00DA 
; 0000 00DB      // Start
; 0000 00DC      I2C_Start();
; 0000 00DD      // Device Address & Read mode
; 0000 00DE      I2C_ShiftOut( 0x01| (BYTE)(ChipAddr&0xff) );
; 0000 00DF 
; 0000 00E0      I2C_Ack();
; 0000 00E1 
; 0000 00E2       // Data Read
; 0000 00E3       Dat = I2C_ShiftIn();
; 0000 00E4       I2C_Ack();
; 0000 00E5 
; 0000 00E6       /** bring SDA high while clock is high */
; 0000 00E7       I2C_Stop();
; 0000 00E8 
; 0000 00E9      return Dat;
; 0000 00EA }
;/*
;BYTE I2C_Read( BYTE ChipAddr, WORD address )
;{
;     BYTE Dat;
;
;#ifdef CFG_I2C_HIGH_ADDRESS
;   if( address > 0x1fff)
;       return ERROR;
;#else
;   if( address > 0xff)
;       return ERROR;
;#endif
;
;     I2C_Start();   // Start
;
;     //Device Address & Write mode
;     I2C_ShiftOut(  (BYTE)((ChipAddr<<1)&0x0e) );
;     I2C_Ack();
;
;#ifdef CFG_I2C_HIGH_ADDRESS
;     // High Address
;     I2C_ShiftOut( (address>>8)&0xff );
;     I2C_Ack();
;#endif
;
;     // Low Address
;     I2C_ShiftOut( address&0xff );
;
;     I2C_Ack();
;
;     // Start
;     I2C_Start();
;
;     // Device Address & Read mode
;     I2C_ShiftOut( 0x01| (BYTE)((ChipAddr<<1)&0x0e)  );
;
;     I2C_Ack();
;
;      // Data Read
;      Dat = I2C_ShiftIn();
;
;      I2C_Ack();
;
;      // bring SDA high while clock is high
;            I2C_Stop();
;
;     return Dat;
;}
;*/
;void I2C_Start(void )
; 0000 011D {
_I2C_Start:
; .FSTART _I2C_Start
; 0000 011E       HIGH_SDA;    /* high serial data  */
	SBI  0x1B,0
; 0000 011F       HIGH_SCLK;   /* high serial clock */
	SBI  0x1B,1
; 0000 0120       i2c_delay();
	RCALL _i2c_delay
; 0000 0121       LOW_SDA;     /* low  serial data */
	CBI  0x1B,0
; 0000 0122       i2c_delay();
	CALL SUBOPT_0x2
; 0000 0123       LOW_SCLK;    /* low  serial clock */
; 0000 0124       i2c_delay();
; 0000 0125 }
	RET
; .FEND
;
;void I2C_Stop( void )
; 0000 0128 {
_I2C_Stop:
; .FSTART _I2C_Stop
; 0000 0129      LOW_SCLK;
	CBI  0x1B,1
; 0000 012A      LOW_SDA;      /* low serial data */
	CBI  0x1B,0
; 0000 012B      i2c_delay();
	RCALL _i2c_delay
; 0000 012C      HIGH_SCLK;    /* high serial clock */
	SBI  0x1B,1
; 0000 012D      i2c_delay();
	RCALL _i2c_delay
; 0000 012E      HIGH_SDA;     /* high serial data      */
	SBI  0x1B,0
; 0000 012F }
	RET
; .FEND
;
;void I2C_ShiftOut( BYTE dat )
; 0000 0132 {
_I2C_ShiftOut:
; .FSTART _I2C_ShiftOut
; 0000 0133      BYTE i,temp;
; 0000 0134 
; 0000 0135      for( i=0; i<8; i++ )
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	dat -> Y+2
;	i -> R17
;	temp -> R16
	LDI  R17,LOW(0)
_0x33:
	CPI  R17,8
	BRSH _0x34
; 0000 0136      {
; 0000 0137         /* right shift */
; 0000 0138         temp = dat & ( 0x80>>i );
	MOV  R30,R17
	LDI  R26,LOW(128)
	CALL __LSRB12
	LDD  R26,Y+2
	AND  R30,R26
	MOV  R16,R30
; 0000 0139 
; 0000 013A        if( temp )   HIGH_SDA;    /* high data   */
	CPI  R16,0
	BREQ _0x35
	SBI  0x1B,0
; 0000 013B        else         LOW_SDA;
	RJMP _0x38
_0x35:
	CBI  0x1B,0
; 0000 013C        i2c_delay();
_0x38:
	RCALL _i2c_delay
; 0000 013D        HIGH_SCLK;              /* high clock   */
	SBI  0x1B,1
; 0000 013E        i2c_delay();
	CALL SUBOPT_0x2
; 0000 013F        LOW_SCLK;               /* low clock    */
; 0000 0140        i2c_delay();
; 0000 0141      }
	SUBI R17,-1
	RJMP _0x33
_0x34:
; 0000 0142 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
;
;BYTE I2C_ShiftIn( void )
; 0000 0145 {
_I2C_ShiftIn:
; .FSTART _I2C_ShiftIn
; 0000 0146      BYTE i=0,temp;
; 0000 0147      BYTE Dat=0;
; 0000 0148 
; 0000 0149      HIGH_SDA;
	CALL __SAVELOCR4
;	i -> R17
;	temp -> R16
;	Dat -> R19
	LDI  R17,0
	LDI  R19,0
	SBI  0x1B,0
; 0000 014A      I2C_R_MODE;      // input mode
	CBI  0x1A,0
; 0000 014B      for( i=0; i<8; i++ )
	LDI  R17,LOW(0)
_0x44:
	CPI  R17,8
	BRSH _0x45
; 0000 014C      {
; 0000 014D           //  HIGH_SDA;
; 0000 014E           HIGH_SCLK;         /* high serial clock    */
	CALL SUBOPT_0x1
; 0000 014F           i2c_delay();
; 0000 0150 
; 0000 0151           temp = IN_SDA;     // &0x80;
	MOV  R16,R30
; 0000 0152           Dat |= ( temp<<(7-i) );
	LDI  R30,LOW(7)
	SUB  R30,R17
	MOV  R26,R16
	CALL __LSLB12
	OR   R19,R30
; 0000 0153 
; 0000 0154           i2c_delay();
	CALL SUBOPT_0x2
; 0000 0155           LOW_SCLK;          /* low serial clock; */
; 0000 0156           i2c_delay();
; 0000 0157      }
	SUBI R17,-1
	RJMP _0x44
_0x45:
; 0000 0158 
; 0000 0159       I2C_W_MODE;   // output mode
	SBI  0x1A,0
; 0000 015A 
; 0000 015B      return Dat;
	MOV  R30,R19
	CALL __LOADLOCR4
	JMP  _0x20A0006
; 0000 015C }
; .FEND
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <string.h>
;#include <delay.h>
;#include <float.h>
;
;#include "TCN75.h"
;#include "../I2cLib/I2CLib.h"
;
;
;void TCN75_init( void )
; 0001 000C {

	.CSEG
_TCN75_init:
; .FSTART _TCN75_init
; 0001 000D     I2C_Write( TCN75_CHIP_ADDR, ACCESS_CONFIG , 0x00 );
	LDI  R30,LOW(144)
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _I2C_Write
; 0001 000E }
	RET
; .FEND
;
;int TCN75_Read( void )
; 0001 0011 {
_TCN75_Read:
; .FSTART _TCN75_Read
; 0001 0012      WORD temp;
; 0001 0013      BYTE temperaturMSB, temperaturLSB;
; 0001 0014      int Rval;
; 0001 0015 
; 0001 0016      I2C_Start();   // Start
	CALL __SAVELOCR6
;	temp -> R16,R17
;	temperaturMSB -> R19
;	temperaturLSB -> R18
;	Rval -> R20,R21
	RCALL _I2C_Start
; 0001 0017 
; 0001 0018      /*Device Address & Write mode */
; 0001 0019      I2C_ShiftOut( TCN75_CHIP_ADDR );
	LDI  R26,LOW(144)
	CALL SUBOPT_0x0
; 0001 001A      I2C_Ack();
; 0001 001B 
; 0001 001C      // Low Address
; 0001 001D      I2C_ShiftOut( 0 ); // Pointer Byte TEMP Register selection
	LDI  R26,LOW(0)
	CALL SUBOPT_0x0
; 0001 001E      I2C_Ack();
; 0001 001F 
; 0001 0020      // Start
; 0001 0021      I2C_Start();
	RCALL _I2C_Start
; 0001 0022      // Device Address & Read mode
; 0001 0023      I2C_ShiftOut( 0x01| TCN75_CHIP_ADDR );
	LDI  R26,LOW(145)
	CALL SUBOPT_0x0
; 0001 0024 
; 0001 0025      I2C_Ack();
; 0001 0026 
; 0001 0027       // Data Read
; 0001 0028       temperaturMSB = I2C_ShiftIn();
	RCALL _I2C_ShiftIn
	MOV  R19,R30
; 0001 0029       I2C_Ack();
	RCALL _I2C_Ack
; 0001 002A       temperaturLSB = I2C_ShiftIn();
	RCALL _I2C_ShiftIn
	MOV  R18,R30
; 0001 002B       I2C_Ack();
	RCALL _I2C_Ack
; 0001 002C 
; 0001 002D       /** bring SDA high while clock is high */
; 0001 002E       I2C_Stop();
	RCALL _I2C_Stop
; 0001 002F 
; 0001 0030       temp = ((WORD)temperaturMSB<<1)&0x1fe|(temperaturLSB>>7&0x01);
	MOV  R30,R19
	LDI  R31,0
	LSL  R30
	ROL  R31
	ANDI R30,LOW(0x1FE)
	ANDI R31,HIGH(0x1FE)
	MOVW R26,R30
	MOV  R30,R18
	ROL  R30
	LDI  R30,0
	ROL  R30
	ANDI R30,LOW(0x1)
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R16,R30
; 0001 0031 
; 0001 0032       // MyPrint( "MSB =%x, MLSB= %X\r\n", temperaturMSB, temperaturLSB );
; 0001 0033 
; 0001 0034       if( temp > 0x0fa ) Rval = 0;
	__CPWRN 16,17,251
	BRLO _0x20003
	__GETWRN 20,21,0
; 0001 0035       else               Rval = (int)((float)temp*0.5f);
	RJMP _0x20004
_0x20003:
	MOVW R30,R16
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x3F000000
	CALL __MULF12
	CALL __CFD1
	MOVW R20,R30
; 0001 0036 
; 0001 0037       if( Rval > 150 ) Rval = 150;
_0x20004:
	__CPWRN 20,21,151
	BRLT _0x20005
	__GETWRN 20,21,150
; 0001 0038 
; 0001 0039       return Rval;
_0x20005:
	MOVW R30,R20
	CALL __LOADLOCR6
	RJMP _0x20A000C
; 0001 003A  }
; .FEND
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <string.h>
;#include <delay.h>
;#include <float.h>
;
;#include "DAC7611.h"
;#include "../I2cLib/I2CLib.h"
;
;void DAC7611_init( void )
; 0002 000B {

	.CSEG
_DAC7611_init:
; .FSTART _DAC7611_init
; 0002 000C    DAC7611_Write( 0 );
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _DAC7611_Write
; 0002 000D }
	RET
; .FEND
;
;void DAC7611_WriteVoltage( int data )
; 0002 0010 {
_DAC7611_WriteVoltage:
; .FSTART _DAC7611_WriteVoltage
; 0002 0011    WORD temp;
; 0002 0012    //float cal;
; 0002 0013 
; 0002 0014   // cal = 4.095f /5.0f * (float)data / 10.0f;
; 0002 0015    temp = (WORD)(4095.0f* (float)data /100.0f);
	CALL SUBOPT_0x3
;	data -> Y+2
;	temp -> R16,R17
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x457FF000
	CALL SUBOPT_0x4
	__GETD1N 0x42C80000
	CALL __DIVF21
	CALL __CFD1U
	MOVW R16,R30
; 0002 0016 
; 0002 0017    DAC7611_Write( temp );
	MOVW R26,R16
	RCALL _DAC7611_Write
; 0002 0018 }
	JMP  _0x20A0005
; .FEND
;
;void DAC7611_Write( WORD data )
; 0002 001B {
_DAC7611_Write:
; .FSTART _DAC7611_Write
; 0002 001C      int i;
; 0002 001D      WORD temp;
; 0002 001E 
; 0002 001F      HIGH_LD;
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	data -> Y+4
;	i -> R16,R17
;	temp -> R18,R19
	SBI  0x1B,3
; 0002 0020      HIGH_SCLK;
	SBI  0x1B,1
; 0002 0021      LOW_CS;
	CBI  0x1B,2
; 0002 0022 
; 0002 0023      for( i=0; i<12; i++ )
	__GETWRN 16,17,0
_0x4000A:
	__CPWRN 16,17,12
	BRGE _0x4000B
; 0002 0024      {
; 0002 0025         /* right shift */
; 0002 0026        temp = data & ( 0x800>>i );
	MOV  R30,R16
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	CALL __LSRW12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	AND  R30,R26
	AND  R31,R27
	MOVW R18,R30
; 0002 0027 
; 0002 0028        if( temp ) HIGH_SDA;    /* high data  */
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x4000C
	SBI  0x1B,0
; 0002 0029        else       LOW_SDA;
	RJMP _0x4000F
_0x4000C:
	CBI  0x1B,0
; 0002 002A 
; 0002 002B        i2c_delay();
_0x4000F:
	CALL SUBOPT_0x2
; 0002 002C        LOW_SCLK;          /* high clock */
; 0002 002D        i2c_delay();
; 0002 002E        HIGH_SCLK;         /* low clock    */
	SBI  0x1B,1
; 0002 002F        i2c_delay();
	CALL _i2c_delay
; 0002 0030      }
	__ADDWRN 16,17,1
	RJMP _0x4000A
_0x4000B:
; 0002 0031 
; 0002 0032      HIGH_CS;
	SBI  0x1B,2
; 0002 0033 
; 0002 0034      LOW_LD;
	CBI  0x1B,3
; 0002 0035      i2c_delay();
	CALL _i2c_delay
; 0002 0036      HIGH_LD;
	SBI  0x1B,3
; 0002 0037 }
	CALL __LOADLOCR4
_0x20A000C:
	ADIW R28,6
	RET
; .FEND
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <string.h>
;#include <delay.h>
;#include <float.h>
;#include <math.h>
;
;#include "ADS1248.h"
;
;extern int gExtTemp;
;extern int gVoltage;
;extern int gCurrent;
;extern int gCurTemp;
;
;void ADS1248_WriteByte( BYTE data );
;BYTE ADS1248_ReadByte( void  );
;void ADS1248_WriteRegByte( BYTE addr, BYTE Data );
;BYTE ADS1248_ReadRegByte( BYTE addr );
;void ADS1248_StopReadCommand(void );
;void ADS1248_ReadContinueCommand( void );
;void ADS1248ResetCommand( void );
;void ADS1248_ChangeChannel(  BYTE Ch );
;
;void ADS1248_init( void )
; 0003 0019 {

	.CSEG
_ADS1248_init:
; .FSTART _ADS1248_init
; 0003 001A    // SPI initialization
; 0003 001B    // SPI Type: Master
; 0003 001C    // SPI Clock Rate: 1000.000 kHz
; 0003 001D    // SPI Clock Phase: Cycle Half
; 0003 001E    // SPI Clock Polarity: Low
; 0003 001F    // SPI Data Order: MSB First
; 0003 0020    SPCR=0x55;
	LDI  R30,LOW(85)
	OUT  0xD,R30
; 0003 0021    SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 0003 0022 
; 0003 0023    ADS1248_StopReadCommand(  );
	RCALL _ADS1248_StopReadCommand
; 0003 0024    ADS1248ResetCommand(  );
	RCALL _ADS1248ResetCommand
; 0003 0025    ADS1248_WriteRegByte( 0, 0x05 );
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(5)
	RCALL _ADS1248_WriteRegByte
; 0003 0026    ADS1248_WriteRegByte( 2, 0x28 ); // 20140318 0x20 -> 0x08로
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(40)
	RCALL _ADS1248_WriteRegByte
; 0003 0027    // System Control Register 0
; 0003 0028    //PGA : 1
; 0003 0029    //DOR :  0101 = 160SPS , 1000 = 1000SPS , 0011 = 40SP
; 0003 002A    ADS1248_WriteRegByte(  3, 0x03 );
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _ADS1248_WriteRegByte
; 0003 002B }
	RET
; .FEND
;
;void AD_ReadExTTemp( void )
; 0003 002E {
_AD_ReadExTTemp:
; .FSTART _AD_ReadExTTemp
; 0003 002F    float fTemp;
; 0003 0030    DWORD rTemp;
; 0003 0031    int   cTemp;
; 0003 0032 
; 0003 0033    rTemp = ADS1248_ADConvertData(  );
	SBIW R28,8
	CALL SUBOPT_0x5
;	fTemp -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 0003 0034    fTemp =  5.0f*(float)rTemp/8388608.0f;
	CALL SUBOPT_0x6
	CALL SUBOPT_0x7
; 0003 0035 
; 0003 0036    if( fTemp >= 1.0f ) fTemp -= 1.0f;
	CALL SUBOPT_0x8
	__GETD1N 0x3F800000
	CALL __CMPF12
	BRLO _0x60003
	__GETD1S 6
	__GETD2N 0x3F800000
	CALL __SUBF12
	CALL SUBOPT_0x7
; 0003 0037    fTemp = fTemp - (100.0f-(float)gCurTemp)*0.015f;
_0x60003:
	LDS  R30,_gCurTemp
	LDS  R31,_gCurTemp+1
	CALL __CWD1
	CALL __CDF1
	__GETD2N 0x42C80000
	CALL __SWAPD12
	CALL __SUBF12
	__GETD2N 0x3C75C28F
	CALL __MULF12
	CALL SUBOPT_0x8
	CALL __SWAPD12
	CALL __SUBF12
	CALL SUBOPT_0x7
; 0003 0038    cTemp = (int)(fTemp/0.019f*10.0f);
	CALL SUBOPT_0x8
	__GETD1N 0x3C9BA5E3
	CALL __DIVF21
	__GETD2N 0x41200000
	CALL __MULF12
	CALL __CFD1
	MOVW R16,R30
; 0003 0039 
; 0003 003A    if( cTemp > 1500 ) cTemp =  1500;
	__CPWRN 16,17,1501
	BRLT _0x60004
	__GETWRN 16,17,1500
; 0003 003B    if( cTemp < 0 )    cTemp = 0;
_0x60004:
	TST  R17
	BRPL _0x60005
	__GETWRN 16,17,0
; 0003 003C 
; 0003 003D    gExtTemp = cTemp;
_0x60005:
	__PUTWMRN _gExtTemp,0,16,17
; 0003 003E }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
;
;void AD_ReadVoltage( void )
; 0003 0041 {
_AD_ReadVoltage:
; .FSTART _AD_ReadVoltage
; 0003 0042     float fTemp, fPin, fWatt;
; 0003 0043     float fV2;
; 0003 0044     DWORD rTemp;
; 0003 0045     int   cTemp;
; 0003 0046 
; 0003 0047     rTemp = ADS1248_ADConvertData(  );
	SBIW R28,20
	CALL SUBOPT_0x5
;	fTemp -> Y+18
;	fPin -> Y+14
;	fWatt -> Y+10
;	fV2 -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 0003 0048     fTemp = 5.0f*(float)rTemp/8388608.0f ;
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
; 0003 0049 
; 0003 004A    // fPin = fTemp/0.025f-90.0f;
; 0003 004B    // fWatt = pow( 10.0f, fPin/10.0f );
; 0003 004C 
; 0003 004D    // fV2 = sqrt( fWatt*189689.79f);
; 0003 004E 
; 0003 004F    // cTemp = (int)(fV2*12.5f);
; 0003 0050 
; 0003 0051     gVoltage = fTemp*10; //cTemp;
	LDI  R26,LOW(_gVoltage)
	LDI  R27,HIGH(_gVoltage)
	RJMP _0x20A000B
; 0003 0052 }
; .FEND
;
;void AD_ReadCurrent( void )
; 0003 0055 {
_AD_ReadCurrent:
; .FSTART _AD_ReadCurrent
; 0003 0056   float fTemp, fPin, fWatt;
; 0003 0057   float  fI2;
; 0003 0058   DWORD rTemp;
; 0003 0059   int   cTemp;
; 0003 005A 
; 0003 005B   rTemp = ADS1248_ADConvertData(  );
	SBIW R28,20
	CALL SUBOPT_0x5
;	fTemp -> Y+18
;	fPin -> Y+14
;	fWatt -> Y+10
;	fI2 -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 0003 005C   fTemp = 5.0f*(float)rTemp/8388608.0f ;
	CALL SUBOPT_0x6
	CALL SUBOPT_0x9
; 0003 005D 
; 0003 005E   //fPin = fTemp/0.025f-90.0f;
; 0003 005F   //fWatt = pow( 10.0f, fPin/10.0f );
; 0003 0060 
; 0003 0061  // fI2 = sqrt(fWatt*0.001f/9091.1752f)*1000.0f;
; 0003 0062  // cTemp = (int)(fI2*1000.0f);
; 0003 0063   gCurrent = fTemp*10; //cTemp;
	LDI  R26,LOW(_gCurrent)
	LDI  R27,HIGH(_gCurrent)
_0x20A000B:
	CALL __CFD1
	ST   X+,R30
	ST   X,R31
; 0003 0064 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,22
	RET
; .FEND
;
;void ADS1248_ChangeChannel(  BYTE Ch )
; 0003 0067 {
_ADS1248_ChangeChannel:
; .FSTART _ADS1248_ChangeChannel
; 0003 0068    LOW_ADS1248_CS1;
	ST   -Y,R26
;	Ch -> Y+0
	CBI  0x15,1
; 0003 0069    ADS1248_WriteRegByte( 0, 0x05|((Ch&0x07)<<3 ));
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDD  R30,Y+1
	ANDI R30,LOW(0x7)
	LSL  R30
	LSL  R30
	LSL  R30
	ORI  R30,LOW(0x5)
	MOV  R26,R30
	RCALL _ADS1248_WriteRegByte
; 0003 006A 
; 0003 006B    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 0003 006C }
	JMP  _0x20A0004
; .FEND
;
;void ADS1248_ReadContinueCommand( void )
; 0003 006F {
; 0003 0070    LOW_ADS1248_CS1;
; 0003 0071    ADS1248_WriteByte( CMD_ADS1248_RDATC )  ; // command
; 0003 0072 
; 0003 0073    HIGH_ADS1248_CS1;
; 0003 0074    delay_ms( 10 );
; 0003 0075 }
;
;void ADS1248_StopReadCommand( void )
; 0003 0078 {
_ADS1248_StopReadCommand:
; .FSTART _ADS1248_StopReadCommand
; 0003 0079    LOW_ADS1248_CS1;
	CBI  0x15,1
; 0003 007A 
; 0003 007B    ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command
	LDI  R26,LOW(22)
	RCALL _ADS1248_WriteByte
; 0003 007C 
; 0003 007D    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 0003 007E    delay_ms( 10 );
	CALL SUBOPT_0xA
; 0003 007F }
	RET
; .FEND
;
;BYTE  ADS1248_ReadRegByte( BYTE addr )
; 0003 0082 {
; 0003 0083    BYTE temp;
; 0003 0084 
; 0003 0085    LOW_ADS1248_CS1;
;	addr -> Y+1
;	temp -> R17
; 0003 0086 
; 0003 0087    ADS1248_WriteByte( CMD_ADS1248_RREG|(addr&0x0f) );
; 0003 0088    ADS1248_WriteByte( 0x00 );
; 0003 0089    temp = ADS1248_ReadByte();
; 0003 008A 
; 0003 008B    HIGH_ADS1248_CS1;
; 0003 008C 
; 0003 008D    delay_ms( 1 );
; 0003 008E 
; 0003 008F    return temp;
; 0003 0090 }
;
;void  ADS1248_WriteRegByte( BYTE addr, BYTE Data )
; 0003 0093 {
_ADS1248_WriteRegByte:
; .FSTART _ADS1248_WriteRegByte
; 0003 0094    LOW_ADS1248_CS1;
	ST   -Y,R26
;	addr -> Y+1
;	Data -> Y+0
	CBI  0x15,1
; 0003 0095 
; 0003 0096    //delay_us( 5 );
; 0003 0097    ADS1248_WriteByte( CMD_ADS1248_WREG|(addr&0x0f) );
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	ORI  R30,0x40
	MOV  R26,R30
	RCALL _ADS1248_WriteByte
; 0003 0098    ADS1248_WriteByte( 0x00 );
	LDI  R26,LOW(0)
	RCALL _ADS1248_WriteByte
; 0003 0099    ADS1248_WriteByte( Data );
	LD   R26,Y
	RCALL _ADS1248_WriteByte
; 0003 009A    delay_us( 10 );
	__DELAY_USB 53
; 0003 009B 
; 0003 009C    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 0003 009D    //delay_us( 10 );
; 0003 009E }
	RJMP _0x20A000A
; .FEND
;
;
;DWORD ADS1248_ADConvertData( void )
; 0003 00A2 {
_ADS1248_ADConvertData:
; .FSTART _ADS1248_ADConvertData
; 0003 00A3    DWORD temp;
; 0003 00A4    BYTE AD1, AD2, AD3;
; 0003 00A5 
; 0003 00A6    LOW_ADS1248_CS1;
	SBIW R28,4
	CALL __SAVELOCR4
;	temp -> Y+4
;	AD1 -> R17
;	AD2 -> R16
;	AD3 -> R19
	CBI  0x15,1
; 0003 00A7    // delay_us( 500 );
; 0003 00A8    //ADS1248_WriteByte( CMD_ADS1248_RDATC );
; 0003 00A9    ADS1248_WriteByte( CMD_ADS1248_RDAT );
	LDI  R26,LOW(18)
	RCALL _ADS1248_WriteByte
; 0003 00AA   // SPDR;
; 0003 00AB   // delay_ms( 2 );
; 0003 00AC 
; 0003 00AD    AD1 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R17,R30
; 0003 00AE    AD2 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R16,R30
; 0003 00AF    AD3 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R19,R30
; 0003 00B0    temp = ((DWORD)AD1)<<16|((DWORD)AD2)<<8|(DWORD)AD3 ;
	MOV  R30,R17
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __LSLD16
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOV  R26,R16
	CLR  R27
	CLR  R24
	CLR  R25
	LDI  R30,LOW(8)
	CALL __LSLD12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ORD12
	MOVW R26,R30
	MOVW R24,R22
	MOV  R30,R19
	CLR  R31
	CLR  R22
	CLR  R23
	CALL __ORD12
	__PUTD1S 4
; 0003 00B1 
; 0003 00B2   // ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command
; 0003 00B3 
; 0003 00B4    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 0003 00B5    return temp;
	RJMP _0x20A0007
; 0003 00B6 }
; .FEND
;
;void ADS1248ResetCommand( void )
; 0003 00B9 {
_ADS1248ResetCommand:
; .FSTART _ADS1248ResetCommand
; 0003 00BA 
; 0003 00BB   HIGH_ADS1248_CS1;
	SBI  0x15,1
; 0003 00BC 
; 0003 00BD 
; 0003 00BE   ADS1248_WriteByte( CMD_ADS1248_RESET );
	LDI  R26,LOW(6)
	RCALL _ADS1248_WriteByte
; 0003 00BF 
; 0003 00C0   delay_ms( 10 );
	CALL SUBOPT_0xA
; 0003 00C1 
; 0003 00C2   LOW_ADS1248_CS1;
	CBI  0x15,1
; 0003 00C3 }
	RET
; .FEND
;
;BYTE ADS1248_ReadByte( void  )
; 0003 00C6 {
_ADS1248_ReadByte:
; .FSTART _ADS1248_ReadByte
; 0003 00C7    BYTE temp;
; 0003 00C8 
; 0003 00C9    SPDR=0x00;
	ST   -Y,R17
;	temp -> R17
	LDI  R30,LOW(0)
	OUT  0xF,R30
; 0003 00CA    while(!(SPSR&0x80));
_0x60022:
	SBIS 0xE,7
	RJMP _0x60022
; 0003 00CB    temp=SPDR;
	IN   R17,15
; 0003 00CC 
; 0003 00CD    return temp;
	MOV  R30,R17
	JMP  _0x20A0001
; 0003 00CE }
; .FEND
;
;void ADS1248_WriteByte(BYTE data )
; 0003 00D1 {
_ADS1248_WriteByte:
; .FSTART _ADS1248_WriteByte
; 0003 00D2    SPDR = data;
	ST   -Y,R26
;	data -> Y+0
	LD   R30,Y
	OUT  0xF,R30
; 0003 00D3    while(!(SPSR&0x80));
_0x60025:
	SBIS 0xE,7
	RJMP _0x60025
; 0003 00D4 }
	JMP  _0x20A0004
; .FEND
;
;#include <stdio.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include "IPCLib.h"
;#include <string.h>
;#include <math.h>
;#include "../Uart/uart.h"
;#include "../I2CLib/I2CLIb.h"
;#include "../InADC/InAdc.h"
;#include "../DAC7611/DAC7611.h"
;
;extern BYTE gEqRtaMode;
;extern WORD goldTime1ms;
;extern WORD gTime1ms;
;extern int gExtTemp;
;extern int gVoltage;
;extern int gCurrent;
;extern int gIntTemp;
;extern int gPlateVol;
;extern int gHeatSinkVol;
;extern int gRefCur;
;extern int gRefVol;
;extern int gRefTemp;
;extern int gMode;
;extern int gRunFlag;
;extern int gLevel;
;
;BYTE IPC_RCV_MODE( LPIPC_HEADER pHead );
;BYTE IPC_RCV_RUN( LPIPC_HEADER pHead );
;BYTE IPC_RCV_LEVEL( LPIPC_HEADER pHead );
;BYTE IPC_RCV_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC_RCV_CURRENT( LPIPC_HEADER pHead );
;BYTE IPC_RCV_TEMP_INT( LPIPC_HEADER pHead );
;BYTE IPC_RCV_TEMP_EXT( LPIPC_HEADER pHead );
;BYTE IPC_RCV_PLATE( LPIPC_HEADER pHead);
;BYTE IPC_RCV_HEATSINK( LPIPC_HEADER pHead);
;BYTE IPC_RCV_REF_VOL( LPIPC_HEADER pHead);
;BYTE IPC_RCV_REF_CUR( LPIPC_HEADER pHead);
;BYTE IPC_RCV_REF_TEMP( LPIPC_HEADER pHead);
;
;typedef BYTE(*RunFun) (LPIPC_HEADER pHead );
;
;RunFun IPCRcvfun[]=
;{
;     IPC_RCV_MODE,
;     IPC_RCV_RUN,
;     IPC_RCV_LEVEL,
;     IPC_RCV_VOLTAGE,
;     IPC_RCV_CURRENT,
;     IPC_RCV_TEMP_INT,
;     IPC_RCV_TEMP_EXT,
;     IPC_RCV_PLATE,
;     IPC_RCV_HEATSINK,
;     IPC_RCV_REF_VOL,
;     IPC_RCV_REF_CUR,
;     IPC_RCV_REF_TEMP
;};

	.DSEG
;
;BYTE IPC_RCV_MODE( LPIPC_HEADER pHead )
; 0004 003A {

	.CSEG
_IPC_RCV_MODE:
; .FSTART _IPC_RCV_MODE
; 0004 003B    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 003C }
; .FEND
;
;BYTE IPC_RCV_RUN( LPIPC_HEADER pHead )
; 0004 003F {
_IPC_RCV_RUN:
; .FSTART _IPC_RCV_RUN
; 0004 0040    gRunFlag =  pHead->data1;
	CALL SUBOPT_0xB
;	*pHead -> Y+0
	CALL SUBOPT_0xC
; 0004 0041    gRunFlag = gRunFlag?1:0;
	BREQ _0x80004
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	RJMP _0x80005
_0x80004:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
_0x80005:
	CALL SUBOPT_0xC
; 0004 0042 
; 0004 0043    if( gRunFlag )
	BREQ _0x80007
; 0004 0044    {
; 0004 0045      DAC7611_WriteVoltage(gLevel);
	CALL SUBOPT_0xD
	CALL _DAC7611_WriteVoltage
; 0004 0046      LOW_START_RY;
	LDS  R30,101
	ANDI R30,0XF7
	STS  101,R30
; 0004 0047      HIGH_PWM;
	SBI  0x1B,4
; 0004 0048    }
; 0004 0049    else
	RJMP _0x8000A
_0x80007:
; 0004 004A    {
; 0004 004B      DAC7611_WriteVoltage(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _DAC7611_WriteVoltage
; 0004 004C      HIGH_START_RY;
	LDS  R30,101
	ORI  R30,8
	STS  101,R30
; 0004 004D      LOW_PWM;
	CBI  0x1B,4
; 0004 004E    }
_0x8000A:
; 0004 004F 
; 0004 0050 
; 0004 0051    return TRUE;
	RJMP _0x20A0009
; 0004 0052 }
; .FEND
;BYTE IPC_RCV_LEVEL( LPIPC_HEADER pHead )
; 0004 0054 {
_IPC_RCV_LEVEL:
; .FSTART _IPC_RCV_LEVEL
; 0004 0055    gLevel =  pHead->data1;
	CALL SUBOPT_0xB
;	*pHead -> Y+0
	STS  _gLevel,R30
	STS  _gLevel+1,R31
; 0004 0056    if(gLevel > 100 ) gLevel = 100;
	CALL SUBOPT_0xD
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLT _0x8000D
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _gLevel,R30
	STS  _gLevel+1,R31
; 0004 0057 
; 0004 0058    if( gRunFlag )
_0x8000D:
	LDS  R30,_gRunFlag
	LDS  R31,_gRunFlag+1
	SBIW R30,0
	BREQ _0x8000E
; 0004 0059    {
; 0004 005A      DAC7611_WriteVoltage(gLevel);
	CALL SUBOPT_0xD
	CALL _DAC7611_WriteVoltage
; 0004 005B    }
; 0004 005C 
; 0004 005D    return TRUE;
_0x8000E:
	RJMP _0x20A0009
; 0004 005E }
; .FEND
;BYTE IPC_RCV_VOLTAGE( LPIPC_HEADER pHead )
; 0004 0060 {
_IPC_RCV_VOLTAGE:
; .FSTART _IPC_RCV_VOLTAGE
; 0004 0061    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 0062 }
; .FEND
;
;BYTE IPC_RCV_CURRENT( LPIPC_HEADER pHead )
; 0004 0065 {
_IPC_RCV_CURRENT:
; .FSTART _IPC_RCV_CURRENT
; 0004 0066    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 0067 }
; .FEND
;BYTE IPC_RCV_TEMP_INT( LPIPC_HEADER pHead )
; 0004 0069 {
_IPC_RCV_TEMP_INT:
; .FSTART _IPC_RCV_TEMP_INT
; 0004 006A    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 006B }
; .FEND
;BYTE IPC_RCV_TEMP_EXT( LPIPC_HEADER pHead )
; 0004 006D {
_IPC_RCV_TEMP_EXT:
; .FSTART _IPC_RCV_TEMP_EXT
; 0004 006E    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 006F }
; .FEND
;
;BYTE IPC_RCV_PLATE( LPIPC_HEADER pHead )
; 0004 0072 {
_IPC_RCV_PLATE:
; .FSTART _IPC_RCV_PLATE
; 0004 0073    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 0074 }
; .FEND
;
;BYTE IPC_RCV_HEATSINK( LPIPC_HEADER pHead )
; 0004 0077 {
_IPC_RCV_HEATSINK:
; .FSTART _IPC_RCV_HEATSINK
; 0004 0078    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A0009
; 0004 0079 }
; .FEND
;
;BYTE IPC_RCV_REF_VOL( LPIPC_HEADER pHead )
; 0004 007C {
_IPC_RCV_REF_VOL:
; .FSTART _IPC_RCV_REF_VOL
; 0004 007D    gRefVol =  pHead->data1;
	CALL SUBOPT_0xB
;	*pHead -> Y+0
	STS  _gRefVol,R30
	STS  _gRefVol+1,R31
; 0004 007E    if(gRefVol > 20 ) gRefVol = 20;
	LDS  R26,_gRefVol
	LDS  R27,_gRefVol+1
	SBIW R26,21
	BRLT _0x8000F
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	STS  _gRefVol,R30
	STS  _gRefVol+1,R31
; 0004 007F 
; 0004 0080    return TRUE;
_0x8000F:
	RJMP _0x20A0009
; 0004 0081 }
; .FEND
;
;BYTE IPC_RCV_REF_CUR( LPIPC_HEADER pHead )
; 0004 0084 {
_IPC_RCV_REF_CUR:
; .FSTART _IPC_RCV_REF_CUR
; 0004 0085    gRefCur =  pHead->data1;
	CALL SUBOPT_0xB
;	*pHead -> Y+0
	STS  _gRefCur,R30
	STS  _gRefCur+1,R31
; 0004 0086    if(gRefCur > 100 ) gRefCur = 100;
	LDS  R26,_gRefCur
	LDS  R27,_gRefCur+1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLT _0x80010
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _gRefCur,R30
	STS  _gRefCur+1,R31
; 0004 0087    return TRUE;
_0x80010:
	RJMP _0x20A0009
; 0004 0088 }
; .FEND
;
;BYTE IPC_RCV_REF_TEMP( LPIPC_HEADER pHead )
; 0004 008B {
_IPC_RCV_REF_TEMP:
; .FSTART _IPC_RCV_REF_TEMP
; 0004 008C    gRefTemp =  pHead->data1;
	CALL SUBOPT_0xB
;	*pHead -> Y+0
	STS  _gRefTemp,R30
	STS  _gRefTemp+1,R31
; 0004 008D    if(gRefTemp > 10 ) gRefTemp = 10;
	LDS  R26,_gRefTemp
	LDS  R27,_gRefTemp+1
	SBIW R26,11
	BRLT _0x80011
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	STS  _gRefTemp,R30
	STS  _gRefTemp+1,R31
; 0004 008E    return TRUE;
_0x80011:
	RJMP _0x20A0009
; 0004 008F }
; .FEND
;BYTE IPC_SND_MODE( LPIPC_HEADER pHead );
;BYTE IPC_SND_RUN( LPIPC_HEADER pHead );
;BYTE IPC_SND_LEVEL( LPIPC_HEADER pHead );
;BYTE IPC_SND_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC_SND_CURRENT( LPIPC_HEADER pHead );
;BYTE IPC_SND_TEMP_INT( LPIPC_HEADER pHead );
;BYTE IPC_SND_TEMP_EXT( LPIPC_HEADER pHead );
;BYTE IPC_SND_PLATE( LPIPC_HEADER pHead);
;BYTE IPC_SND_HEATSINK( LPIPC_HEADER pHead);
;BYTE IPC_SND_REF_VOL( LPIPC_HEADER pHead);
;BYTE IPC_SND_REF_CUR( LPIPC_HEADER pHead);
;BYTE IPC_SND_REF_TEMP( LPIPC_HEADER pHead);
;
;typedef BYTE(*SenFun) (LPIPC_HEADER pHead);
;
;SenFun IPCSndfun[]=
;{
;     IPC_SND_MODE,
;     IPC_SND_RUN,
;     IPC_SND_LEVEL,
;     IPC_SND_VOLTAGE,
;     IPC_SND_CURRENT,
;     IPC_SND_TEMP_INT,
;     IPC_SND_TEMP_EXT,
;     IPC_SND_PLATE,
;     IPC_SND_HEATSINK,
;     IPC_SND_REF_VOL,
;     IPC_SND_REF_CUR,
;     IPC_SND_REF_TEMP
;};

	.DSEG
;
;BYTE IPC_SND_MODE( LPIPC_HEADER pHead )
; 0004 00B0 {

	.CSEG
_IPC_SND_MODE:
; .FSTART _IPC_SND_MODE
; 0004 00B1    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00B2    pHead->data1 = (BYTE)((gMode>>8)&0xff);  //
	LDS  R30,_gMode
	LDS  R31,_gMode+1
	CALL SUBOPT_0xF
; 0004 00B3    pHead->data2 = (BYTE)(gMode&0xff);
	LDS  R30,_gMode
	RJMP _0x20A0008
; 0004 00B4 
; 0004 00B5    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00B6 
; 0004 00B7    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00B8    return TRUE;
; 0004 00B9 }
; .FEND
;BYTE IPC_SND_RUN( LPIPC_HEADER pHead )
; 0004 00BB {
_IPC_SND_RUN:
; .FSTART _IPC_SND_RUN
; 0004 00BC     pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00BD    pHead->data1 = (BYTE)((gRunFlag>>8)&0xff);  //
	LDS  R30,_gRunFlag
	LDS  R31,_gRunFlag+1
	CALL SUBOPT_0xF
; 0004 00BE    pHead->data2 = (BYTE)(gRunFlag&0xff);
	LDS  R30,_gRunFlag
	RJMP _0x20A0008
; 0004 00BF 
; 0004 00C0    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00C1 
; 0004 00C2    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00C3    return TRUE;
; 0004 00C4 }
; .FEND
;
;BYTE IPC_SND_LEVEL( LPIPC_HEADER pHead )
; 0004 00C7 {
_IPC_SND_LEVEL:
; .FSTART _IPC_SND_LEVEL
; 0004 00C8     pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00C9    pHead->data1 = (BYTE)((gLevel>>8)&0xff);  //
	LDS  R30,_gLevel
	LDS  R31,_gLevel+1
	CALL SUBOPT_0xF
; 0004 00CA    pHead->data2 = (BYTE)(gLevel&0xff);
	LDS  R30,_gLevel
	RJMP _0x20A0008
; 0004 00CB 
; 0004 00CC    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00CD 
; 0004 00CE    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00CF    return TRUE;
; 0004 00D0 }
; .FEND
;BYTE IPC_SND_VOLTAGE( LPIPC_HEADER pHead )
; 0004 00D2 {
_IPC_SND_VOLTAGE:
; .FSTART _IPC_SND_VOLTAGE
; 0004 00D3    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00D4    pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  //
	LDS  R30,_gVoltage
	LDS  R31,_gVoltage+1
	CALL SUBOPT_0xF
; 0004 00D5    pHead->data2 = (BYTE)(gVoltage&0xff);
	LDS  R30,_gVoltage
	RJMP _0x20A0008
; 0004 00D6 
; 0004 00D7    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00D8 
; 0004 00D9    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00DA 
; 0004 00DB    return TRUE;
; 0004 00DC }
; .FEND
;
;BYTE IPC_SND_CURRENT( LPIPC_HEADER pHead )
; 0004 00DF {
_IPC_SND_CURRENT:
; .FSTART _IPC_SND_CURRENT
; 0004 00E0    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00E1    pHead->data1 = (BYTE)((gCurrent>>8)&0xff);  //
	LDS  R30,_gCurrent
	LDS  R31,_gCurrent+1
	CALL SUBOPT_0xF
; 0004 00E2    pHead->data2 = (BYTE)(gCurrent&0xff);
	LDS  R30,_gCurrent
	RJMP _0x20A0008
; 0004 00E3 
; 0004 00E4    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00E5 
; 0004 00E6    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00E7 
; 0004 00E8    return TRUE;
; 0004 00E9 
; 0004 00EA }
; .FEND
;
;BYTE IPC_SND_TEMP_INT( LPIPC_HEADER pHead )
; 0004 00ED {
_IPC_SND_TEMP_INT:
; .FSTART _IPC_SND_TEMP_INT
; 0004 00EE    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00EF    pHead->data1 = (BYTE)((gIntTemp>>8)&0xff);  //
	LDS  R30,_gIntTemp
	LDS  R31,_gIntTemp+1
	CALL SUBOPT_0xF
; 0004 00F0    pHead->data2 = (BYTE)(gIntTemp&0xff);
	LDS  R30,_gIntTemp
	RJMP _0x20A0008
; 0004 00F1 
; 0004 00F2    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 00F3 
; 0004 00F4    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 00F5    return TRUE;
; 0004 00F6 
; 0004 00F7 }
; .FEND
;
;BYTE IPC_SND_TEMP_EXT( LPIPC_HEADER pHead )
; 0004 00FA {
_IPC_SND_TEMP_EXT:
; .FSTART _IPC_SND_TEMP_EXT
; 0004 00FB 
; 0004 00FC    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 00FD    pHead->data1 = (BYTE)((gExtTemp>>8)&0xff);  //
	LDS  R30,_gExtTemp
	LDS  R31,_gExtTemp+1
	CALL SUBOPT_0xF
; 0004 00FE    pHead->data2 = (BYTE)(gExtTemp&0xff);
	LDS  R30,_gExtTemp
	RJMP _0x20A0008
; 0004 00FF 
; 0004 0100    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 0101 
; 0004 0102    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 0103 
; 0004 0104    return TRUE;
; 0004 0105 
; 0004 0106 }
; .FEND
;
;BYTE IPC_SND_PLATE( LPIPC_HEADER pHead )
; 0004 0109 {
_IPC_SND_PLATE:
; .FSTART _IPC_SND_PLATE
; 0004 010A    gPlateVol = read_adc( (BYTE)ADC_PLATE);
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	LDI  R26,LOW(4)
	CALL _read_adc
	STS  _gPlateVol,R30
	STS  _gPlateVol+1,R31
; 0004 010B 
; 0004 010C    pHead->Command = SYS_OK;
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,2
	LDI  R30,LOW(128)
	ST   X,R30
; 0004 010D    pHead->data1 = (BYTE)((gPlateVol>>8)&0xff);  //
	LDS  R30,_gPlateVol
	LDS  R31,_gPlateVol+1
	CALL SUBOPT_0xF
; 0004 010E    pHead->data2 = (BYTE)(gPlateVol&0xff);
	LDS  R30,_gPlateVol
	RJMP _0x20A0008
; 0004 010F 
; 0004 0110    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 0111 
; 0004 0112    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 0113 
; 0004 0114    return TRUE;
; 0004 0115 }
; .FEND
;
;BYTE IPC_SND_HEATSINK( LPIPC_HEADER pHead )
; 0004 0118 {
_IPC_SND_HEATSINK:
; .FSTART _IPC_SND_HEATSINK
; 0004 0119    gHeatSinkVol = read_adc( (BYTE)ADC_HEAT);
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	LDI  R26,LOW(5)
	CALL _read_adc
	STS  _gHeatSinkVol,R30
	STS  _gHeatSinkVol+1,R31
; 0004 011A 
; 0004 011B    pHead->Command = SYS_OK;
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,2
	LDI  R30,LOW(128)
	ST   X,R30
; 0004 011C    pHead->data1 = (BYTE)((gHeatSinkVol>>8)&0xff);  //
	LDS  R30,_gHeatSinkVol
	LDS  R31,_gHeatSinkVol+1
	CALL SUBOPT_0xF
; 0004 011D    pHead->data2 = (BYTE)(gHeatSinkVol&0xff);
	LDS  R30,_gHeatSinkVol
	RJMP _0x20A0008
; 0004 011E 
; 0004 011F    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 0120 
; 0004 0121    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 0122 
; 0004 0123    return TRUE;
; 0004 0124 }
; .FEND
;
;BYTE IPC_SND_REF_VOL( LPIPC_HEADER pHead )
; 0004 0127 {
_IPC_SND_REF_VOL:
; .FSTART _IPC_SND_REF_VOL
; 0004 0128   // gHeatSinkVol = read_adc( (BYTE)ADC_HEAT);
; 0004 0129 
; 0004 012A    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 012B    pHead->data1 = (BYTE)((gRefVol>>8)&0xff);  //
	LDS  R30,_gRefVol
	LDS  R31,_gRefVol+1
	CALL SUBOPT_0xF
; 0004 012C    pHead->data2 = (BYTE)(gRefVol&0xff);
	LDS  R30,_gRefVol
	RJMP _0x20A0008
; 0004 012D 
; 0004 012E    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 012F 
; 0004 0130    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 0131 
; 0004 0132    return TRUE;
; 0004 0133 }
; .FEND
;
;BYTE IPC_SND_REF_CUR( LPIPC_HEADER pHead )
; 0004 0136 {
_IPC_SND_REF_CUR:
; .FSTART _IPC_SND_REF_CUR
; 0004 0137   // gHeatSinkVol = read_adc( (BYTE)ADC_HEAT);
; 0004 0138 
; 0004 0139    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 013A    pHead->data1 = (BYTE)((gRefCur>>8)&0xff);  //
	LDS  R30,_gRefCur
	LDS  R31,_gRefCur+1
	CALL SUBOPT_0xF
; 0004 013B    pHead->data2 = (BYTE)(gRefCur&0xff);
	LDS  R30,_gRefCur
	RJMP _0x20A0008
; 0004 013C 
; 0004 013D    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
; 0004 013E 
; 0004 013F    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0004 0140 
; 0004 0141    return TRUE;
; 0004 0142 }
; .FEND
;BYTE IPC_SND_REF_TEMP( LPIPC_HEADER pHead )
; 0004 0144 {
_IPC_SND_REF_TEMP:
; .FSTART _IPC_SND_REF_TEMP
; 0004 0145   // gHeatSinkVol = read_adc( (BYTE)ADC_HEAT);
; 0004 0146 
; 0004 0147    pHead->Command = SYS_OK;
	CALL SUBOPT_0xE
;	*pHead -> Y+0
; 0004 0148    pHead->data1 = (BYTE)((gRefTemp>>8)&0xff);  //
	LDS  R30,_gRefTemp
	LDS  R31,_gRefTemp+1
	CALL SUBOPT_0xF
; 0004 0149    pHead->data2 = (BYTE)(gRefTemp&0xff);
	LDS  R30,_gRefTemp
_0x20A0008:
	__PUTB1SNS 0,4
; 0004 014A 
; 0004 014B    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	LD   R30,Y
	LDD  R31,Y+1
	CALL SUBOPT_0x10
	__PUTB1SNS 0,5
; 0004 014C 
; 0004 014D    IPC_SendData( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	RCALL _IPC_SendData
; 0004 014E 
; 0004 014F    return TRUE;
_0x20A0009:
	LDI  R30,LOW(1)
_0x20A000A:
	ADIW R28,2
	RET
; 0004 0150 }
; .FEND
;
;
;BYTE MakeCrc( BYTE *Data, int Len )
; 0004 0154 {
_MakeCrc:
; .FSTART _MakeCrc
; 0004 0155      int i;
; 0004 0156      BYTE CRC;
; 0004 0157 
; 0004 0158      CRC = 0;
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	*Data -> Y+6
;	Len -> Y+4
;	i -> R16,R17
;	CRC -> R19
	LDI  R19,LOW(0)
; 0004 0159 
; 0004 015A      for( i=0; i<Len ; i++ )
	__GETWRN 16,17,0
_0x80014:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x80015
; 0004 015B           CRC += Data[i];
	MOVW R30,R16
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ADD  R19,R30
	__ADDWRN 16,17,1
	RJMP _0x80014
_0x80015:
; 0004 015D return CRC;
	MOV  R30,R19
_0x20A0007:
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; 0004 015E }
; .FEND
;
;void IPC_RunProcess( void )
; 0004 0161 {
_IPC_RunProcess:
; .FSTART _IPC_RunProcess
; 0004 0162      BYTE RcvHead[30];
; 0004 0163      BYTE RcvByte;
; 0004 0164      BYTE  Crc,RcvCrc;
; 0004 0165      LPIPC_HEADER pHead;
; 0004 0166 
; 0004 0167   //   while( TRUE )
; 0004 0168      {
	SBIW R28,30
	CALL __SAVELOCR6
;	RcvHead -> Y+6
;	RcvByte -> R17
;	Crc -> R16
;	RcvCrc -> R19
;	*pHead -> R20,R21
; 0004 0169         RcvByte = IPC_RcvData_Interrupt( RcvHead, sizeof( IPC_HEADER ) );
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	RCALL _IPC_RcvData_Interrupt
	MOV  R17,R30
; 0004 016A         pHead = ( LPIPC_HEADER )RcvHead;
	MOVW R30,R28
	ADIW R30,6
	MOVW R20,R30
; 0004 016B 
; 0004 016C          Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
	MOVW R30,R28
	ADIW R30,6
	CALL SUBOPT_0x10
	MOV  R16,R30
; 0004 016D          RcvCrc = pHead->checksum;
	MOVW R30,R20
	LDD  R19,Z+5
; 0004 016E 
; 0004 016F          if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
; 0004 0170               pHead->stx == 0x02 && pHead->etx == 0x03 )
	CPI  R17,7
	BRNE _0x80017
	CP   R16,R19
	BRNE _0x80017
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0x2)
	BRNE _0x80017
	MOVW R30,R20
	LDD  R26,Z+6
	CPI  R26,LOW(0x3)
	BREQ _0x80018
_0x80017:
	RJMP _0x80016
_0x80018:
; 0004 0171          {
; 0004 0172               if( pHead->RWflag ==  IPC_MODE_READ )
	MOVW R30,R20
	LDD  R26,Z+1
	CPI  R26,LOW(0x52)
	BRNE _0x80019
; 0004 0173                    IPC_SndProcess( RcvHead );
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_SndProcess
; 0004 0174               else IPC_RcvProcess( RcvHead );
	RJMP _0x8001A
_0x80019:
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_RcvProcess
; 0004 0175 
; 0004 0176           }
_0x8001A:
; 0004 0177           else
	RJMP _0x8001B
_0x80016:
; 0004 0178           {
; 0004 0179              IPC_Send_Response( RcvHead, SYS_ERROR);
	MOVW R30,R28
	ADIW R30,6
	CALL SUBOPT_0x11
; 0004 017A              IPC_ResetCount1();
	RCALL _IPC_ResetCount1
; 0004 017B           }
_0x8001B:
; 0004 017C 
; 0004 017D      }
; 0004 017E 
; 0004 017F }
	CALL __LOADLOCR6
	ADIW R28,36
	RET
; .FEND
; void IPC_Send_Response( BYTE *Data, BYTE Res )
; 0004 0181 {
_IPC_Send_Response:
; .FSTART _IPC_Send_Response
; 0004 0182      LPIPC_HEADER mLpHead;
; 0004 0183 
; 0004 0184      mLpHead = (LPIPC_HEADER)Data;
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*Data -> Y+3
;	Res -> Y+2
;	*mLpHead -> R16,R17
	__GETWRS 16,17,3
; 0004 0185 
; 0004 0186      mLpHead->Command = Res;
	LDD  R30,Y+2
	__PUTB1RNS 16,2
; 0004 0187      mLpHead->data1 = 0;
	MOVW R26,R16
	ADIW R26,3
	LDI  R30,LOW(0)
	ST   X,R30
; 0004 0188      mLpHead->data2 = 0;
	MOVW R26,R16
	ADIW R26,4
	ST   X,R30
; 0004 0189      mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );
	ST   -Y,R17
	ST   -Y,R16
	LDI  R26,LOW(5)
	LDI  R27,0
	RCALL _MakeCrc
	__PUTB1RNS 16,5
; 0004 018A 
; 0004 018B      IPC_SendData( Data, sizeof( IPC_HEADER ) );
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	RCALL _IPC_SendData
; 0004 018C }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0002
; .FEND
;
;void IPC_RcvProcess( BYTE *Data )
; 0004 018F {
_IPC_RcvProcess:
; .FSTART _IPC_RcvProcess
; 0004 0190       LPIPC_HEADER pHead;
; 0004 0191 
; 0004 0192       pHead   = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x3
;	*Data -> Y+2
;	*pHead -> R16,R17
	__GETWRS 16,17,2
; 0004 0193       if(  pHead->Command < sizeof(IPCRcvfun)/2 )
	MOVW R30,R16
	LDD  R26,Z+2
	CPI  R26,LOW(0xC)
	BRSH _0x8001C
; 0004 0194       {
; 0004 0195              if( IPCRcvfun[pHead->Command]( pHead ) == TRUE )        //  Run Command
	LDD  R30,Z+2
	LDI  R26,LOW(_IPCRcvfun)
	LDI  R27,HIGH(_IPCRcvfun)
	CALL SUBOPT_0x12
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,LOW(0x1)
	BRNE _0x8001D
; 0004 0196              {
; 0004 0197                  IPC_Send_Response( Data, SYS_OK );
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(128)
	RJMP _0x80023
; 0004 0198              }
; 0004 0199              else
_0x8001D:
; 0004 019A              {
; 0004 019B                  IPC_Send_Response( Data, SYS_ERROR);
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(129)
_0x80023:
	RCALL _IPC_Send_Response
; 0004 019C               }
; 0004 019D        }
; 0004 019E        else
	RJMP _0x8001F
_0x8001C:
; 0004 019F        {
; 0004 01A0            IPC_Send_Response( Data, SYS_ERROR );
	CALL SUBOPT_0x13
; 0004 01A1         }
_0x8001F:
; 0004 01A2 
; 0004 01A3 }
	RJMP _0x20A0005
; .FEND
;
;
;void IPC_SndProcess( BYTE *Data )
; 0004 01A7 {
_IPC_SndProcess:
; .FSTART _IPC_SndProcess
; 0004 01A8       LPIPC_HEADER pHead;
; 0004 01A9 
; 0004 01AA       pHead = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x3
;	*Data -> Y+2
;	*pHead -> R16,R17
	__GETWRS 16,17,2
; 0004 01AB       if(   pHead->Command < sizeof(IPCSndfun)/2  )
	MOVW R30,R16
	LDD  R26,Z+2
	CPI  R26,LOW(0xC)
	BRSH _0x80020
; 0004 01AC       {
; 0004 01AD           if( IPCSndfun[pHead->Command]( pHead ) == FALSE )        //  Run Command
	LDD  R30,Z+2
	LDI  R26,LOW(_IPCSndfun)
	LDI  R27,HIGH(_IPCSndfun)
	CALL SUBOPT_0x12
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,0
	BRNE _0x80021
; 0004 01AE               IPC_Send_Response( Data, SYS_ERROR );
	CALL SUBOPT_0x13
; 0004 01AF       }
_0x80021:
; 0004 01B0       else
	RJMP _0x80022
_0x80020:
; 0004 01B1       {
; 0004 01B2            IPC_Send_Response( Data, SYS_ERROR );
	CALL SUBOPT_0x13
; 0004 01B3       }
_0x80022:
; 0004 01B4 }
_0x20A0005:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A0006:
	ADIW R28,4
	RET
; .FEND
;#include <stdarg.h>
;#include <stdio.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include "uart.h"
;
;#define RXB8 1
;#define TXB8 0
;#define UPE  2
;#define OVR  3
;#define FE   4
;#define UDRE 5
;#define RXC  7
;
;#define FRAMING_ERROR (1<<FE)
;#define PARITY_ERROR (1<<UPE)
;#define DATA_OVERRUN (1<<OVR)
;#define DATA_REGISTER_EMPTY (1<<UDRE)
;#define RX_COMPLETE (1<<RXC)
;
;extern WORD  gTime1ms;
;
;WORD gOldUartTime1ms=0;
;
;// Get a character from the USART1 Receiver
;// USART1 Receiver buffer
;#define RX_BUFFER_SIZE1 250
;char rx_buffer1[RX_BUFFER_SIZE1];
;unsigned char rx_wr_index1=0,rx_rd_index1=0,rx_counter1=0;
;// This flag is set on USART1 Receiver buffer overflow
;BOOL rx_buffer_overflow1=FALSE;
;char mRcvErrFlag = 0;
;
;// USART1 Receiver interrupt service routine
;//#pragma vector =USART1_RXC_vect
;interrupt [USART1_RXC] void usart1_rx_isr(void)
; 0005 0023 {

	.CSEG
_usart1_rx_isr:
; .FSTART _usart1_rx_isr
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0005 0024    char status,data;
; 0005 0025    status = UCSR1A;
	ST   -Y,R17
	ST   -Y,R16
;	status -> R17
;	data -> R16
	LDS  R17,155
; 0005 0026    data   = UDR1;
	LDS  R16,156
; 0005 0027 
; 0005 0028    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0 )
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0xA0003
; 0005 0029    {
; 0005 002A       rx_buffer1[rx_wr_index1++]=data;
	MOV  R30,R7
	INC  R7
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer1)
	SBCI R31,HIGH(-_rx_buffer1)
	ST   Z,R16
; 0005 002B       if (rx_wr_index1 == RX_BUFFER_SIZE1) rx_wr_index1=0;
	LDI  R30,LOW(250)
	CP   R30,R7
	BRNE _0xA0004
	CLR  R7
; 0005 002C       if (++rx_counter1 == RX_BUFFER_SIZE1)
_0xA0004:
	INC  R9
	LDI  R30,LOW(250)
	CP   R30,R9
	BRNE _0xA0005
; 0005 002D       {
; 0005 002E          rx_counter1 = 0;
	CLR  R9
; 0005 002F          rx_buffer_overflow1 = TRUE;
	LDI  R30,LOW(1)
	MOV  R8,R30
; 0005 0030       }
; 0005 0031       gOldUartTime1ms = gTime1ms;
_0xA0005:
	__GETWRMN 4,5,0,_gTime1ms
; 0005 0032    }
; 0005 0033 }
_0xA0003:
	LD   R16,Y+
	LD   R17,Y+
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;// Get a character from the USART1 Receiver buffer
;//#pragma used+
;char getchar1( void )
; 0005 0038 {
_getchar1:
; .FSTART _getchar1
; 0005 0039    char data;
; 0005 003A    //while (rx_counter1==0);
; 0005 003B     if( rx_counter1 >0 )
	ST   -Y,R17
;	data -> R17
	LDI  R30,LOW(0)
	CP   R30,R9
	BRSH _0xA0006
; 0005 003C     {
; 0005 003D       data = rx_buffer1[rx_rd_index1++];
	MOV  R30,R6
	INC  R6
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer1)
	SBCI R31,HIGH(-_rx_buffer1)
	LD   R17,Z
; 0005 003E       if (rx_rd_index1 == RX_BUFFER_SIZE1) rx_rd_index1=0;
	LDI  R30,LOW(250)
	CP   R30,R6
	BRNE _0xA0007
	CLR  R6
; 0005 003F 
; 0005 0040        #asm("cli")
_0xA0007:
	cli
; 0005 0041        --rx_counter1;
	DEC  R9
; 0005 0042        #asm("sei")
	sei
; 0005 0043        mRcvErrFlag = 0;
	CLR  R11
; 0005 0044        return data;
	MOV  R30,R17
	JMP  _0x20A0001
; 0005 0045     }
; 0005 0046     else
_0xA0006:
; 0005 0047     {
; 0005 0048        mRcvErrFlag = 1;
	LDI  R30,LOW(1)
	MOV  R11,R30
; 0005 0049        return 0;
	LDI  R30,LOW(0)
	JMP  _0x20A0001
; 0005 004A     }
; 0005 004B }
; .FEND
;
;//#pragma used-
;
;BYTE  IPC_Get_RxCount1( void )
; 0005 0050 {
_IPC_Get_RxCount1:
; .FSTART _IPC_Get_RxCount1
; 0005 0051    return rx_counter1;
	MOV  R30,R9
	RET
; 0005 0052 }
; .FEND
;
;void IPC_ResetCount1( void )
; 0005 0055 {
_IPC_ResetCount1:
; .FSTART _IPC_ResetCount1
; 0005 0056    #asm("cli")
	cli
; 0005 0057    rx_counter1 = 0;
	CLR  R9
; 0005 0058    rx_rd_index1 = 0;
	CLR  R6
; 0005 0059    rx_wr_index1 = 0;
	CLR  R7
; 0005 005A    #asm("sei")
	sei
; 0005 005B 
; 0005 005C }
	RET
; .FEND
;char Mygetchar( BYTE flag )
; 0005 005E {
; 0005 005F       WORD oldTime1ms;
; 0005 0060       char status,data;
; 0005 0061 
; 0005 0062       while ( 1 )
;	flag -> Y+4
;	oldTime1ms -> R16,R17
;	status -> R19
;	data -> R18
; 0005 0063       {
; 0005 0064           if( flag )
; 0005 0065                oldTime1ms = gTime1ms;
; 0005 0066 
; 0005 0067           while ( ((status=UCSR1A) & RX_COMPLETE) == 0 )
; 0005 0068           {
; 0005 0069               if( flag )
; 0005 006A               {
; 0005 006B                   if( (gTime1ms - oldTime1ms) > 300 ) //old 300
; 0005 006C                  {
; 0005 006D                       return 0;
; 0005 006E                  }
; 0005 006F               }
; 0005 0070 
; 0005 0071 
; 0005 0072           };
; 0005 0073 
; 0005 0074 
; 0005 0075           data = UDR1;
; 0005 0076           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0005 0077           return data;
; 0005 0078       };
; 0005 0079 }
;
;char Tgetchar( void )
; 0005 007C {
; 0005 007D       char status,data;
; 0005 007E       while ( 1 )
;	status -> R17
;	data -> R16
; 0005 007F       {
; 0005 0080           while ( ((status=UCSR1A) & RX_COMPLETE)==0 );
; 0005 0081               data = UDR1;
; 0005 0082           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0005 0083          return data;
; 0005 0084       };
; 0005 0085 }
;
;void Tputchar( char c )
; 0005 0088 {
_Tputchar:
; .FSTART _Tputchar
; 0005 0089      while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R26
;	c -> Y+0
_0xA001A:
	LDS  R30,155
	ANDI R30,LOW(0x20)
	BREQ _0xA001A
; 0005 008A      UDR1 = c;
	LD   R30,Y
	STS  156,R30
; 0005 008B }
_0x20A0004:
	ADIW R28,1
	RET
; .FEND
;
;void Usrprintf( char  *string )
; 0005 008E {
; 0005 008F     while( *string != '\0' )
;	*string -> Y+0
; 0005 0090     {
; 0005 0091         Tputchar(*string++);
; 0005 0092     }
; 0005 0093 }
;
;void FlashUsrprintf( const char *string )
; 0005 0096 {
; 0005 0097     while( *string != '\0' )
;	*string -> Y+0
; 0005 0098     {
; 0005 0099         Tputchar(*string++);
; 0005 009A     }
; 0005 009B }
;
;void MyPrint( char flash* format, ...)
; 0005 009E {
; 0005 009F       char str[100];
; 0005 00A0 
; 0005 00A1       va_list arg;
; 0005 00A2       va_start(arg, format);
;	*format -> Y+102
;	str -> Y+2
;	*arg -> R16,R17
; 0005 00A3 
; 0005 00A4       vsprintf( str, format, arg);
; 0005 00A5       va_end(arg);
; 0005 00A6 
; 0005 00A7       Usrprintf( str ); // putchar1()를 스트링으로 전송하는 함수입니다.-아래 기술할께요~
; 0005 00A8 }
;
;BYTE RcvRemocon( void )
; 0005 00AB {
; 0005 00AC    BYTE temp;
; 0005 00AD    BYTE RCV_BUFFER[5];
; 0005 00AE    int i;
; 0005 00AF 
; 0005 00B0    if( Tgetchar() != 0x02 )
;	temp -> R17
;	RCV_BUFFER -> Y+4
;	i -> R18,R19
; 0005 00B1        return ERROR;
; 0005 00B2 
; 0005 00B3    for( i=0; i< 4; i++ )
; 0005 00B4        RCV_BUFFER[i] = getchar();
; 0005 00B6 temp = 0;
; 0005 00B7    for( i=0; i< 3; i++ )
; 0005 00B8            temp ^=  RCV_BUFFER[i];
; 0005 00BA if( temp ==  RCV_BUFFER[3] )
; 0005 00BB           return  RCV_BUFFER[0];
; 0005 00BC    else return ERROR;
; 0005 00BD }
;
;BYTE  IPC_RcvData( BYTE *Buffer, BYTE len )
; 0005 00C0 {
; 0005 00C1    BYTE i=0;
; 0005 00C2 
; 0005 00C3    while( i < len )
;	*Buffer -> Y+2
;	len -> Y+1
;	i -> R17
; 0005 00C4    {
; 0005 00C5         Buffer[i] = Mygetchar(i);
; 0005 00C6 
; 0005 00C7        /* if( i == 0)
; 0005 00C8         {
; 0005 00C9           if( Buffer[i] != S_Address )
; 0005 00CA              break;
; 0005 00CB         }
; 0005 00CC         */
; 0005 00CD         i++;
; 0005 00CE 
; 0005 00CF    }
; 0005 00D0     return  i;
; 0005 00D1 }
;
;BYTE  IPC_RcvData_Interrupt( BYTE *Buffer, BYTE len )
; 0005 00D4 {
_IPC_RcvData_Interrupt:
; .FSTART _IPC_RcvData_Interrupt
; 0005 00D5    BYTE i=0;
; 0005 00D6    char dat = 0;
; 0005 00D7    WORD oldTime1ms;
; 0005 00D8    oldTime1ms = gTime1ms;
	ST   -Y,R26
	CALL __SAVELOCR4
;	*Buffer -> Y+5
;	len -> Y+4
;	i -> R17
;	dat -> R16
;	oldTime1ms -> R18,R19
	LDI  R17,0
	LDI  R16,0
	__GETWRMN 18,19,0,_gTime1ms
; 0005 00D9 
; 0005 00DA    while( i < len )
_0xA002F:
	LDD  R30,Y+4
	CP   R17,R30
	BRSH _0xA0031
; 0005 00DB    {
; 0005 00DC        dat = getchar1();
	RCALL _getchar1
	MOV  R16,R30
; 0005 00DD        if( mRcvErrFlag == 0  )
	TST  R11
	BRNE _0xA0032
; 0005 00DE        {
; 0005 00DF           Buffer[i] = dat;
	MOV  R30,R17
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
; 0005 00E0           i++;
	SUBI R17,-1
; 0005 00E1        }
; 0005 00E2        if( (gTime1ms - oldTime1ms) > 3000 ) //old 300
_0xA0032:
	LDS  R26,_gTime1ms
	LDS  R27,_gTime1ms+1
	SUB  R26,R18
	SBC  R27,R19
	CPI  R26,LOW(0xBB9)
	LDI  R30,HIGH(0xBB9)
	CPC  R27,R30
	BRLO _0xA0033
; 0005 00E3        {
; 0005 00E4           IPC_ResetCount1();
	RCALL _IPC_ResetCount1
; 0005 00E5           return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0003
; 0005 00E6        }
; 0005 00E7    }
_0xA0033:
	RJMP _0xA002F
_0xA0031:
; 0005 00E8    return  i;
	MOV  R30,R17
_0x20A0003:
	CALL __LOADLOCR4
	ADIW R28,7
	RET
; 0005 00E9 }
; .FEND
;
;BYTE IPC_SendData( BYTE *Buffer, BYTE len )
; 0005 00EC {
_IPC_SendData:
; .FSTART _IPC_SendData
; 0005 00ED    BYTE i,j;
; 0005 00EE    i= 0;
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	*Buffer -> Y+3
;	len -> Y+2
;	i -> R17
;	j -> R16
	LDI  R17,LOW(0)
; 0005 00EF    while( i < len )
_0xA0034:
	LDD  R30,Y+2
	CP   R17,R30
	BRSH _0xA0036
; 0005 00F0    {
; 0005 00F1      Tputchar(Buffer[i++]);
	MOV  R30,R17
	SUBI R17,-1
	LDD  R26,Y+3
	LDD  R27,Y+3+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL _Tputchar
; 0005 00F2    }
	RJMP _0xA0034
_0xA0036:
; 0005 00F3 
; 0005 00F4    return  i;
	MOV  R30,R17
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0002
; 0005 00F5 }
; .FEND
;#include <stdio.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include "SpiLib.h"
;
;BYTE Spi_ReadByte( void  )
; 0006 0005 {

	.CSEG
; 0006 0006    BYTE temp;
; 0006 0007 
; 0006 0008    SPDR = 0xff;
;	temp -> R17
; 0006 0009    while(!(SPSR&0x80));
; 0006 000A    temp=SPDR;
; 0006 000B 
; 0006 000C    return temp;
; 0006 000D }
;
;void Spi_WriteByte(BYTE data )
; 0006 0010 {
; 0006 0011    SPDR = data;
;	data -> Y+0
; 0006 0012    while(!(SPSR&0x80));
; 0006 0013    data = SPDR;
; 0006 0014 }
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <delay.h>
;#include "InAdc.h"
;
;#define ADC_VREF_TYPE 0x00
;
;// Read the AD conversion result
;int read_adc( BYTE adc_input )
; 0007 0009 {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0007 000A   WORD temp;
; 0007 000B   int  RetVal;
; 0007 000C 
; 0007 000D   ADMUX = adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
	CALL __SAVELOCR4
;	adc_input -> Y+4
;	temp -> R16,R17
;	RetVal -> R18,R19
	LDD  R30,Y+4
	OUT  0x7,R30
; 0007 000E   // Delay needed for the stabilization of the ADC input voltage
; 0007 000F   delay_us(10);
	__DELAY_USB 53
; 0007 0010   // Start the AD conversion
; 0007 0011   ADCSRA|=0x40;
	SBI  0x6,6
; 0007 0012   // Wait for the AD conversion to complete
; 0007 0013   while ((ADCSRA & 0x10)==0);
_0xE0003:
	SBIS 0x6,4
	RJMP _0xE0003
; 0007 0014   ADCSRA |=0x10;
	SBI  0x6,4
; 0007 0015 
; 0007 0016  // return ADCW;
; 0007 0017   temp  = ADCW;
	__INWR 16,17,4
; 0007 0018 
; 0007 0019   RetVal =  (int)(5.0f*10.0f*(float)temp/1024.0f);
	MOVW R30,R16
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x42480000
	CALL SUBOPT_0x4
	__GETD1N 0x44800000
	CALL __DIVF21
	CALL __CFD1
	MOVW R18,R30
; 0007 001A 
; 0007 001B   return RetVal;
	CALL __LOADLOCR4
_0x20A0002:
	ADIW R28,5
	RET
; 0007 001C }
; .FEND
;#include <mega128.h>
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif
;#include <stdio.h>
;#include <delay.h>
;#include <math.h>
;
;#include "TCN75/TCN75.h"
;#include "DAC7611/DAC7611.h"
;#include "ADS1248/ADS1248.h"
;#include "Uart/uart.h"
;#include "IPC/IPClib.h"
;
;// Variables
;int gExtTemp;
;int gIntTemp;
;int gVoltage;
;int gCurrent;
;int gCurTemp;
;int gPlateVol;
;int gHeatSinkVol;
;int gRefCur;
;int gRefVol;
;int gRefTemp;
;int gMode;
;int gRunFlag;
;int gLevel;
;BYTE gAD_Channel = 0;
;
;WORD gTime1ms;
;WORD goldTime1ms;
;BYTE WaitEvent( void );
;void ADCProcessor( void );
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0008 0023 {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0008 0024 // Place your code here
; 0008 0025     // Reinitialize Timer 0 value
; 0008 0026     TCNT0 = 0x06;   //1ms
	LDI  R30,LOW(6)
	OUT  0x32,R30
; 0008 0027     // Place your code here
; 0008 0028     gTime1ms++;
	LDI  R26,LOW(_gTime1ms)
	LDI  R27,HIGH(_gTime1ms)
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
; 0008 0029 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;void PortInit( void )
; 0008 002C {
_PortInit:
; .FSTART _PortInit
; 0008 002D 
; 0008 002E     // PORTA
; 0008 002F     // bit 7 : DSP STR3    out
; 0008 0030     // bit 6 : Encoder 1   in
; 0008 0031     // bit 5 : Encoder 0   in
; 0008 0032     // bit 4 : PWM ON/OFF  out
; 0008 0033     // bit 3 : DAC7611 LD  out
; 0008 0034     // bit 2 : DAC7611 CS  out
; 0008 0035     // bit 1 : DAC7611 CLK out
; 0008 0036     // bit 0 : DAC7611 SDI out
; 0008 0037     DDRA    = 0x9f;
	LDI  R30,LOW(159)
	OUT  0x1A,R30
; 0008 0038     PORTA   = 0x04;
	LDI  R30,LOW(4)
	OUT  0x1B,R30
; 0008 0039 
; 0008 003A     DDRB    = 0xf7;
	LDI  R30,LOW(247)
	OUT  0x17,R30
; 0008 003B     PORTB   = 0xe0;
	LDI  R30,LOW(224)
	OUT  0x18,R30
; 0008 003C 
; 0008 003D     //PORTC
; 0008 003E     //bit 7~4: CD4094
; 0008 003F     //bit 3: NC
; 0008 0040     //bit 2: ads1248 RESET
; 0008 0041     //bit 1: ADS1248 CS
; 0008 0042     //bit 0: ADS1248 DRDY
; 0008 0043     DDRC    = 0xff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0008 0044     PORTC   = 0x04;
	LDI  R30,LOW(4)
	OUT  0x15,R30
; 0008 0045 
; 0008 0046     DDRD    = 0x91;
	LDI  R30,LOW(145)
	OUT  0x11,R30
; 0008 0047     PORTD   = 0x01;
	LDI  R30,LOW(1)
	OUT  0x12,R30
; 0008 0048 
; 0008 0049     DDRE    = 0x12;
	LDI  R30,LOW(18)
	OUT  0x2,R30
; 0008 004A     //PORTE   = 0x54;
; 0008 004B 
; 0008 004C     DDRF    = 0x00;
	LDI  R30,LOW(0)
	STS  97,R30
; 0008 004D     PORTF   = 0x00;
	STS  98,R30
; 0008 004E 
; 0008 004F     DDRG    = 0xff;
	LDI  R30,LOW(255)
	STS  100,R30
; 0008 0050     PORTG   = 0x08;
	LDI  R30,LOW(8)
	STS  101,R30
; 0008 0051 
; 0008 0052     // Timer/Counter 0 initialization
; 0008 0053     // Clock source: System Clock
; 0008 0054     // Clock value: 250.000 kHz
; 0008 0055     // Mode: Normal top=0xFF
; 0008 0056     // OC0 output: Disconnected
; 0008 0057     // Timer Period: 1 ms
; 0008 0058     ASSR=0;
	LDI  R30,LOW(0)
	OUT  0x30,R30
; 0008 0059     TCCR0=0x04;
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0008 005A     TCNT0=0x06;
	LDI  R30,LOW(6)
	OUT  0x32,R30
; 0008 005B     OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x31,R30
; 0008 005C 
; 0008 005D    // Timer(s)/Counter(s) Interrupt(s) initialization
; 0008 005E    TIMSK=0x01;
	LDI  R30,LOW(1)
	OUT  0x37,R30
; 0008 005F    ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
; 0008 0060 
; 0008 0061    // USART1 initialization
; 0008 0062    // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0008 0063    // USART1 Receiver: On
; 0008 0064    // USART1 Transmitter: On
; 0008 0065    // USART1 Mode: Asynchronous
; 0008 0066    // USART1 Baud Rate: 57600 (Double Speed Mode)
; 0008 0067    UCSR1A=0x02;
	LDI  R30,LOW(2)
	STS  155,R30
; 0008 0068    UCSR1B=0x98;
	LDI  R30,LOW(152)
	STS  154,R30
; 0008 0069    UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  157,R30
; 0008 006A    UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  152,R30
; 0008 006B    UBRR1L=0x22;
	LDI  R30,LOW(34)
	STS  153,R30
; 0008 006C 
; 0008 006D   // ADC initialization
; 0008 006E   // ADC Clock frequency: 1000.000 kHz
; 0008 006F   // ADC Voltage Reference: AREF pin
; 0008 0070   ADMUX  = 0x00 & 0xff;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0008 0071   ADCSRA = 0x84;
	LDI  R30,LOW(132)
	OUT  0x6,R30
; 0008 0072 }
	RET
; .FEND
;
;void SystemInit( void )
; 0008 0075 {
_SystemInit:
; .FSTART _SystemInit
; 0008 0076   PortInit();
	RCALL _PortInit
; 0008 0077   gExtTemp = 0;
	LDI  R30,LOW(0)
	STS  _gExtTemp,R30
	STS  _gExtTemp+1,R30
; 0008 0078   gIntTemp = 0;
	STS  _gIntTemp,R30
	STS  _gIntTemp+1,R30
; 0008 0079   gVoltage = 0;
	STS  _gVoltage,R30
	STS  _gVoltage+1,R30
; 0008 007A   gCurrent = 0;
	STS  _gCurrent,R30
	STS  _gCurrent+1,R30
; 0008 007B   gCurTemp = 0;
	STS  _gCurTemp,R30
	STS  _gCurTemp+1,R30
; 0008 007C   gPlateVol = 0;
	STS  _gPlateVol,R30
	STS  _gPlateVol+1,R30
; 0008 007D   gHeatSinkVol = 0;
	STS  _gHeatSinkVol,R30
	STS  _gHeatSinkVol+1,R30
; 0008 007E   gRefCur = 0;
	STS  _gRefCur,R30
	STS  _gRefCur+1,R30
; 0008 007F   gRefVol = 0;
	STS  _gRefVol,R30
	STS  _gRefVol+1,R30
; 0008 0080   gRefTemp = 0;
	STS  _gRefTemp,R30
	STS  _gRefTemp+1,R30
; 0008 0081   gMode = 0;
	STS  _gMode,R30
	STS  _gMode+1,R30
; 0008 0082   gRunFlag = 0;
	STS  _gRunFlag,R30
	STS  _gRunFlag+1,R30
; 0008 0083   gLevel = 0;
	STS  _gLevel,R30
	STS  _gLevel+1,R30
; 0008 0084 
; 0008 0085   LOW_ADS1248_RESET;
	CBI  0x15,2
; 0008 0086   delay_ms(10);
	CALL SUBOPT_0xA
; 0008 0087   HIGH_ADS1248_RESET;
	SBI  0x15,2
; 0008 0088 
; 0008 0089   TCN75_init();
	CALL _TCN75_init
; 0008 008A   DAC7611_init(  );
	CALL _DAC7611_init
; 0008 008B   ADS1248_init();
	CALL _ADS1248_init
; 0008 008C 
; 0008 008D }
	RET
; .FEND
;
;void ADCProcessor( void )
; 0008 0090 {
_ADCProcessor:
; .FSTART _ADCProcessor
; 0008 0091      BYTE mRealCh;
; 0008 0092 
; 0008 0093      if( gAD_Channel == 0 ) AD_ReadExTTemp();
	ST   -Y,R17
;	mRealCh -> R17
	TST  R10
	BRNE _0x100007
	CALL _AD_ReadExTTemp
; 0008 0094      else if( gAD_Channel == 1 ) AD_ReadVoltage();
	RJMP _0x100008
_0x100007:
	LDI  R30,LOW(1)
	CP   R30,R10
	BRNE _0x100009
	CALL _AD_ReadVoltage
; 0008 0095      else if( gAD_Channel == 2 ) AD_ReadCurrent();
	RJMP _0x10000A
_0x100009:
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x10000B
	CALL _AD_ReadCurrent
; 0008 0096 
; 0008 0097      gAD_Channel++;
_0x10000B:
_0x10000A:
_0x100008:
	INC  R10
; 0008 0098      if( gAD_Channel >=  3 )
	LDI  R30,LOW(3)
	CP   R10,R30
	BRLO _0x10000C
; 0008 0099         gAD_Channel = 0;
	CLR  R10
; 0008 009A 
; 0008 009B      if( gAD_Channel == 0 ) mRealCh = 0;
_0x10000C:
	TST  R10
	BRNE _0x10000D
	LDI  R17,LOW(0)
; 0008 009C      else if( gAD_Channel == 1 ) mRealCh = 6;
	RJMP _0x10000E
_0x10000D:
	LDI  R30,LOW(1)
	CP   R30,R10
	BRNE _0x10000F
	LDI  R17,LOW(6)
; 0008 009D      else if( gAD_Channel == 2 ) mRealCh = 7;
	RJMP _0x100010
_0x10000F:
	LDI  R30,LOW(2)
	CP   R30,R10
	BRNE _0x100011
	LDI  R17,LOW(7)
; 0008 009E      else  mRealCh = 8;
	RJMP _0x100012
_0x100011:
	LDI  R17,LOW(8)
; 0008 009F 
; 0008 00A0      ADS1248_ChangeChannel( mRealCh );
_0x100012:
_0x100010:
_0x10000E:
	MOV  R26,R17
	CALL _ADS1248_ChangeChannel
; 0008 00A1 }
_0x20A0001:
	LD   R17,Y+
	RET
; .FEND
;
;
;BYTE WaitEvent( void )
; 0008 00A5 {
_WaitEvent:
; .FSTART _WaitEvent
; 0008 00A6 
; 0008 00A7     while ( 1 )
_0x100013:
; 0008 00A8     {
; 0008 00A9        if( IPC_Get_RxCount1() >=  sizeof( IPC_HEADER ) )
	CALL _IPC_Get_RxCount1
	CPI  R30,LOW(0x7)
	BRLO _0x100016
; 0008 00AA        {
; 0008 00AB            goldTime1ms = gTime1ms;
	CALL SUBOPT_0x14
	STS  _goldTime1ms,R30
	STS  _goldTime1ms+1,R31
; 0008 00AC            return EVN_RCVUART;
	LDI  R30,LOW(1)
	RET
; 0008 00AD        }
; 0008 00AE        else if( (gTime1ms-goldTime1ms) > 300 ) // 50=200ms
_0x100016:
	LDS  R26,_goldTime1ms
	LDS  R27,_goldTime1ms+1
	CALL SUBOPT_0x14
	SUB  R30,R26
	SBC  R31,R27
	CPI  R30,LOW(0x12D)
	LDI  R26,HIGH(0x12D)
	CPC  R31,R26
	BRLO _0x100018
; 0008 00AF        {
; 0008 00B0          /* if( (gTime1ms- gOldUartTime1ms) > 6000 )
; 0008 00B1           {
; 0008 00B2              gOldUartTime1ms = gTime1ms;
; 0008 00B3              if( IPC_Get_RxCount1() > 0 )
; 0008 00B4              {
; 0008 00B5                 IPC_ResetCount1();
; 0008 00B6              }
; 0008 00B7           }
; 0008 00B8           */
; 0008 00B9           goldTime1ms = gTime1ms;
	CALL SUBOPT_0x14
	STS  _goldTime1ms,R30
	STS  _goldTime1ms+1,R31
; 0008 00BA 
; 0008 00BB           return EVN_TIMEOVER;
	LDI  R30,LOW(2)
	RET
; 0008 00BC        }
; 0008 00BD     }
_0x100018:
	RJMP _0x100013
; 0008 00BE }
; .FEND
;
;void main()
; 0008 00C1 {
_main:
; .FSTART _main
; 0008 00C2    BYTE wEvent;
; 0008 00C3    BOOL mFlacker=FALSE;
; 0008 00C4 
; 0008 00C5    SystemInit( );
;	wEvent -> R17
;	mFlacker -> R16
	LDI  R16,0
	RCALL _SystemInit
; 0008 00C6    // Global enable interrupts
; 0008 00C7    #asm("sei");
	sei
; 0008 00C8 
; 0008 00C9    while ( TRUE )
_0x100019:
; 0008 00CA    {
; 0008 00CB       wEvent = WaitEvent();
	RCALL _WaitEvent
	MOV  R17,R30
; 0008 00CC       if( wEvent == EVN_RCVUART )
	CPI  R17,1
	BRNE _0x10001C
; 0008 00CD       {
; 0008 00CE            IPC_RunProcess( );
	CALL _IPC_RunProcess
; 0008 00CF       }
; 0008 00D0       else if(wEvent == EVN_TIMEOVER )
	RJMP _0x10001D
_0x10001C:
	CPI  R17,2
	BRNE _0x10001E
; 0008 00D1       {
; 0008 00D2            mFlacker = mFlacker?FALSE:TRUE;
	CPI  R16,0
	BREQ _0x10001F
	LDI  R30,LOW(0)
	RJMP _0x100020
_0x10001F:
	LDI  R30,LOW(1)
_0x100020:
	MOV  R16,R30
; 0008 00D3            if(  mFlacker ) {HIGH_WARRING_LED;}
	CPI  R16,0
	BREQ _0x100022
	LDS  R30,98
	ORI  R30,0x40
	RJMP _0x100025
; 0008 00D4            else { LOW_WARRING_LED;}
_0x100022:
	LDS  R30,98
	ANDI R30,0xBF
_0x100025:
	STS  98,R30
; 0008 00D5 
; 0008 00D6            //AD_ReadExTTemp();
; 0008 00D7            ADCProcessor();
	RCALL _ADCProcessor
; 0008 00D8            gIntTemp = TCN75_Read();
	CALL _TCN75_Read
	STS  _gIntTemp,R30
	STS  _gIntTemp+1,R31
; 0008 00D9       }
; 0008 00DA    }
_0x10001E:
_0x10001D:
	RJMP _0x100019
; 0008 00DB }
_0x100024:
	RJMP _0x100024
; .FEND
;
	#ifndef __SLEEP_DEFINED__
	#define __SLEEP_DEFINED__
	.EQU __se_bit=0x20
	.EQU __sm_mask=0x1C
	.EQU __sm_powerdown=0x10
	.EQU __sm_powersave=0x18
	.EQU __sm_standby=0x14
	.EQU __sm_ext_standby=0x1C
	.EQU __sm_adc_noise_red=0x08
	.SET power_ctrl_reg=mcucr
	#endif

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.DSEG
_gExtTemp:
	.BYTE 0x2
_gVoltage:
	.BYTE 0x2
_gCurrent:
	.BYTE 0x2
_gCurTemp:
	.BYTE 0x2
_goldTime1ms:
	.BYTE 0x2
_gTime1ms:
	.BYTE 0x2
_gIntTemp:
	.BYTE 0x2
_gPlateVol:
	.BYTE 0x2
_gHeatSinkVol:
	.BYTE 0x2
_gRefCur:
	.BYTE 0x2
_gRefVol:
	.BYTE 0x2
_gRefTemp:
	.BYTE 0x2
_gMode:
	.BYTE 0x2
_gRunFlag:
	.BYTE 0x2
_gLevel:
	.BYTE 0x2
_IPCRcvfun:
	.BYTE 0x18
_IPCSndfun:
	.BYTE 0x18
_rx_buffer1:
	.BYTE 0xFA
__seed_G104:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x0:
	CALL _I2C_ShiftOut
	JMP  _I2C_Ack

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	SBI  0x1B,1
	CALL _i2c_delay
	LDI  R30,0
	SBIC 0x19,0
	LDI  R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2:
	CALL _i2c_delay
	CBI  0x1B,1
	JMP  _i2c_delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4:
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:33 WORDS
SUBOPT_0x5:
	ST   -Y,R17
	ST   -Y,R16
	CALL _ADS1248_ADConvertData
	__PUTD1S 2
	CALL __CDF1U
	__GETD2N 0x40A00000
	RJMP SUBOPT_0x4

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x6:
	__GETD1N 0x4B000000
	CALL __DIVF21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x8:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x9:
	__PUTD1S 18
	__GETD2S 18
	__GETD1N 0x41200000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	LDI  R26,LOW(10)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0xB:
	ST   -Y,R27
	ST   -Y,R26
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R30,Z+3
	LDI  R31,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0xC:
	STS  _gRunFlag,R30
	STS  _gRunFlag+1,R31
	SBIW R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	LDS  R26,_gLevel
	LDS  R27,_gLevel+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:42 WORDS
SUBOPT_0xE:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,2
	LDI  R30,LOW(128)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 12 TIMES, CODE SIZE REDUCTION:41 WORDS
SUBOPT_0xF:
	CALL __ASRW8
	__PUTB1SNS 0,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5)
	LDI  R27,0
	JMP  _MakeCrc

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x11:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(129)
	JMP  _IPC_Send_Response

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x12:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	RJMP SUBOPT_0x11

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x14:
	LDS  R30,_gTime1ms
	LDS  R31,_gTime1ms+1
	RET


	.CSEG
_delay_ms:
	adiw r26,0
	breq __delay_ms1
__delay_ms0:
	__DELAY_USW 0xFA0
	wdr
	sbiw r26,1
	brne __delay_ms0
__delay_ms1:
	ret

__ROUND_REPACK:
	TST  R21
	BRPL __REPACK
	CPI  R21,0x80
	BRNE __ROUND_REPACK0
	SBRS R30,0
	RJMP __REPACK
__ROUND_REPACK0:
	ADIW R30,1
	ADC  R22,R25
	ADC  R23,R25
	BRVS __REPACK1

__REPACK:
	LDI  R21,0x80
	EOR  R21,R23
	BRNE __REPACK0
	PUSH R21
	RJMP __ZERORES
__REPACK0:
	CPI  R21,0xFF
	BREQ __REPACK1
	LSL  R22
	LSL  R0
	ROR  R21
	ROR  R22
	MOV  R23,R21
	RET
__REPACK1:
	PUSH R21
	TST  R0
	BRMI __REPACK2
	RJMP __MAXRES
__REPACK2:
	RJMP __MINRES

__UNPACK:
	LDI  R21,0x80
	MOV  R1,R25
	AND  R1,R21
	LSL  R24
	ROL  R25
	EOR  R25,R21
	LSL  R21
	ROR  R24

__UNPACK1:
	LDI  R21,0x80
	MOV  R0,R23
	AND  R0,R21
	LSL  R22
	ROL  R23
	EOR  R23,R21
	LSL  R21
	ROR  R22
	RET

__CFD1U:
	SET
	RJMP __CFD1U0
__CFD1:
	CLT
__CFD1U0:
	PUSH R21
	RCALL __UNPACK1
	CPI  R23,0x80
	BRLO __CFD10
	CPI  R23,0xFF
	BRCC __CFD10
	RJMP __ZERORES
__CFD10:
	LDI  R21,22
	SUB  R21,R23
	BRPL __CFD11
	NEG  R21
	CPI  R21,8
	BRTC __CFD19
	CPI  R21,9
__CFD19:
	BRLO __CFD17
	SER  R30
	SER  R31
	SER  R22
	LDI  R23,0x7F
	BLD  R23,7
	RJMP __CFD15
__CFD17:
	CLR  R23
	TST  R21
	BREQ __CFD15
__CFD18:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R21
	BRNE __CFD18
	RJMP __CFD15
__CFD11:
	CLR  R23
__CFD12:
	CPI  R21,8
	BRLO __CFD13
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R23
	SUBI R21,8
	RJMP __CFD12
__CFD13:
	TST  R21
	BREQ __CFD15
__CFD14:
	LSR  R23
	ROR  R22
	ROR  R31
	ROR  R30
	DEC  R21
	BRNE __CFD14
__CFD15:
	TST  R0
	BRPL __CFD16
	RCALL __ANEGD1
__CFD16:
	POP  R21
	RET

__CDF1U:
	SET
	RJMP __CDF1U0
__CDF1:
	CLT
__CDF1U0:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __CDF10
	CLR  R0
	BRTS __CDF11
	TST  R23
	BRPL __CDF11
	COM  R0
	RCALL __ANEGD1
__CDF11:
	MOV  R1,R23
	LDI  R23,30
	TST  R1
__CDF12:
	BRMI __CDF13
	DEC  R23
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R1
	RJMP __CDF12
__CDF13:
	MOV  R30,R31
	MOV  R31,R22
	MOV  R22,R1
	PUSH R21
	RCALL __REPACK
	POP  R21
__CDF10:
	RET

__SWAPACC:
	PUSH R20
	MOVW R20,R30
	MOVW R30,R26
	MOVW R26,R20
	MOVW R20,R22
	MOVW R22,R24
	MOVW R24,R20
	MOV  R20,R0
	MOV  R0,R1
	MOV  R1,R20
	POP  R20
	RET

__UADD12:
	ADD  R30,R26
	ADC  R31,R27
	ADC  R22,R24
	RET

__NEGMAN1:
	COM  R30
	COM  R31
	COM  R22
	SUBI R30,-1
	SBCI R31,-1
	SBCI R22,-1
	RET

__SUBF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129
	LDI  R21,0x80
	EOR  R1,R21

__ADDF120:
	CPI  R23,0x80
	BREQ __ADDF128
__ADDF121:
	MOV  R21,R23
	SUB  R21,R25
	BRVS __ADDF1211
	BRPL __ADDF122
	RCALL __SWAPACC
	RJMP __ADDF121
__ADDF122:
	CPI  R21,24
	BRLO __ADDF123
	CLR  R26
	CLR  R27
	CLR  R24
__ADDF123:
	CPI  R21,8
	BRLO __ADDF124
	MOV  R26,R27
	MOV  R27,R24
	CLR  R24
	SUBI R21,8
	RJMP __ADDF123
__ADDF124:
	TST  R21
	BREQ __ADDF126
__ADDF125:
	LSR  R24
	ROR  R27
	ROR  R26
	DEC  R21
	BRNE __ADDF125
__ADDF126:
	MOV  R21,R0
	EOR  R21,R1
	BRMI __ADDF127
	RCALL __UADD12
	BRCC __ADDF129
	ROR  R22
	ROR  R31
	ROR  R30
	INC  R23
	BRVC __ADDF129
	RJMP __MAXRES
__ADDF128:
	RCALL __SWAPACC
__ADDF129:
	RCALL __REPACK
	POP  R21
	RET
__ADDF1211:
	BRCC __ADDF128
	RJMP __ADDF129
__ADDF127:
	SUB  R30,R26
	SBC  R31,R27
	SBC  R22,R24
	BREQ __ZERORES
	BRCC __ADDF1210
	COM  R0
	RCALL __NEGMAN1
__ADDF1210:
	TST  R22
	BRMI __ADDF129
	LSL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVC __ADDF1210

__ZERORES:
	CLR  R30
	CLR  R31
	CLR  R22
	CLR  R23
	POP  R21
	RET

__MINRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	SER  R23
	POP  R21
	RET

__MAXRES:
	SER  R30
	SER  R31
	LDI  R22,0x7F
	LDI  R23,0x7F
	POP  R21
	RET

__MULF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BREQ __ZERORES
	CPI  R25,0x80
	BREQ __ZERORES
	EOR  R0,R1
	SEC
	ADC  R23,R25
	BRVC __MULF124
	BRLT __ZERORES
__MULF125:
	TST  R0
	BRMI __MINRES
	RJMP __MAXRES
__MULF124:
	PUSH R0
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R17
	CLR  R18
	CLR  R25
	MUL  R22,R24
	MOVW R20,R0
	MUL  R24,R31
	MOV  R19,R0
	ADD  R20,R1
	ADC  R21,R25
	MUL  R22,R27
	ADD  R19,R0
	ADC  R20,R1
	ADC  R21,R25
	MUL  R24,R30
	RCALL __MULF126
	MUL  R27,R31
	RCALL __MULF126
	MUL  R22,R26
	RCALL __MULF126
	MUL  R27,R30
	RCALL __MULF127
	MUL  R26,R31
	RCALL __MULF127
	MUL  R26,R30
	ADD  R17,R1
	ADC  R18,R25
	ADC  R19,R25
	ADC  R20,R25
	ADC  R21,R25
	MOV  R30,R19
	MOV  R31,R20
	MOV  R22,R21
	MOV  R21,R18
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	POP  R0
	TST  R22
	BRMI __MULF122
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	RJMP __MULF123
__MULF122:
	INC  R23
	BRVS __MULF125
__MULF123:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__MULF127:
	ADD  R17,R0
	ADC  R18,R1
	ADC  R19,R25
	RJMP __MULF128
__MULF126:
	ADD  R18,R0
	ADC  R19,R1
__MULF128:
	ADC  R20,R25
	ADC  R21,R25
	RET

__DIVF21:
	PUSH R21
	RCALL __UNPACK
	CPI  R23,0x80
	BRNE __DIVF210
	TST  R1
__DIVF211:
	BRPL __DIVF219
	RJMP __MINRES
__DIVF219:
	RJMP __MAXRES
__DIVF210:
	CPI  R25,0x80
	BRNE __DIVF218
__DIVF217:
	RJMP __ZERORES
__DIVF218:
	EOR  R0,R1
	SEC
	SBC  R25,R23
	BRVC __DIVF216
	BRLT __DIVF217
	TST  R0
	RJMP __DIVF211
__DIVF216:
	MOV  R23,R25
	PUSH R17
	PUSH R18
	PUSH R19
	PUSH R20
	CLR  R1
	CLR  R17
	CLR  R18
	CLR  R19
	CLR  R20
	CLR  R21
	LDI  R25,32
__DIVF212:
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	CPC  R20,R17
	BRLO __DIVF213
	SUB  R26,R30
	SBC  R27,R31
	SBC  R24,R22
	SBC  R20,R17
	SEC
	RJMP __DIVF214
__DIVF213:
	CLC
__DIVF214:
	ROL  R21
	ROL  R18
	ROL  R19
	ROL  R1
	ROL  R26
	ROL  R27
	ROL  R24
	ROL  R20
	DEC  R25
	BRNE __DIVF212
	MOVW R30,R18
	MOV  R22,R1
	POP  R20
	POP  R19
	POP  R18
	POP  R17
	TST  R22
	BRMI __DIVF215
	LSL  R21
	ROL  R30
	ROL  R31
	ROL  R22
	DEC  R23
	BRVS __DIVF217
__DIVF215:
	RCALL __ROUND_REPACK
	POP  R21
	RET

__CMPF12:
	TST  R25
	BRMI __CMPF120
	TST  R23
	BRMI __CMPF121
	CP   R25,R23
	BRLO __CMPF122
	BRNE __CMPF121
	CP   R26,R30
	CPC  R27,R31
	CPC  R24,R22
	BRLO __CMPF122
	BREQ __CMPF123
__CMPF121:
	CLZ
	CLC
	RET
__CMPF122:
	CLZ
	SEC
	RET
__CMPF123:
	SEZ
	CLC
	RET
__CMPF120:
	TST  R23
	BRPL __CMPF122
	CP   R25,R23
	BRLO __CMPF121
	BRNE __CMPF122
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	BRLO __CMPF122
	BREQ __CMPF123
	RJMP __CMPF121

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGD1:
	COM  R31
	COM  R22
	COM  R23
	NEG  R30
	SBCI R31,-1
	SBCI R22,-1
	SBCI R23,-1
	RET

__LSLB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSLB12R
__LSLB12L:
	LSL  R30
	DEC  R0
	BRNE __LSLB12L
__LSLB12R:
	RET

__LSRB12:
	TST  R30
	MOV  R0,R30
	MOV  R30,R26
	BREQ __LSRB12R
__LSRB12L:
	LSR  R30
	DEC  R0
	BRNE __LSRB12L
__LSRB12R:
	RET

__LSRW12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	BREQ __LSRW12R
__LSRW12L:
	LSR  R31
	ROR  R30
	DEC  R0
	BRNE __LSRW12L
__LSRW12R:
	RET

__LSLD12:
	TST  R30
	MOV  R0,R30
	MOVW R30,R26
	MOVW R22,R24
	BREQ __LSLD12R
__LSLD12L:
	LSL  R30
	ROL  R31
	ROL  R22
	ROL  R23
	DEC  R0
	BRNE __LSLD12L
__LSLD12R:
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__LSLD16:
	MOV  R22,R30
	MOV  R23,R31
	LDI  R30,0
	LDI  R31,0
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
	RET

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__SWAPD12:
	MOV  R1,R24
	MOV  R24,R22
	MOV  R22,R1
	MOV  R1,R25
	MOV  R25,R23
	MOV  R23,R1

__SWAPW12:
	MOV  R1,R27
	MOV  R27,R31
	MOV  R31,R1

__SWAPB12:
	MOV  R1,R26
	MOV  R26,R30
	MOV  R30,R1
	RET

__SAVELOCR6:
	ST   -Y,R21
__SAVELOCR5:
	ST   -Y,R20
__SAVELOCR4:
	ST   -Y,R19
__SAVELOCR3:
	ST   -Y,R18
__SAVELOCR2:
	ST   -Y,R17
	ST   -Y,R16
	RET

__LOADLOCR6:
	LDD  R21,Y+5
__LOADLOCR5:
	LDD  R20,Y+4
__LOADLOCR4:
	LDD  R19,Y+3
__LOADLOCR3:
	LDD  R18,Y+2
__LOADLOCR2:
	LDD  R17,Y+1
	LD   R16,Y
	RET

;END OF CODE MARKER
__END_OF_CODE:

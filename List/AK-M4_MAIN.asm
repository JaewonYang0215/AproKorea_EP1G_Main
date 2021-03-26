
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
	.DEF _gExtTemp=R4
	.DEF _gExtTemp_msb=R5
	.DEF _gVoltage=R6
	.DEF _gVoltage_msb=R7
	.DEF _gCurrent=R8
	.DEF _gCurrent_msb=R9
	.DEF _buzzer_freq=R10
	.DEF _buzzer_freq_msb=R11
	.DEF _buzzer_data=R12
	.DEF _buzzer_data_msb=R13

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
	JMP  _TIM2_OVF_vect_Proc
	JMP  0x00
	JMP  0x00
	JMP  0x00
	JMP  _TIMER1_OVF_vect_Proc
	JMP  0x00
	JMP  _TIMER0_OVF_vect_Proc
	JMP  0x00
	JMP  _USART0_RXC_vect_Proc
	JMP  _USART_DRE0_vect_Proc
	JMP  _USART0_TXC_vect_Proc
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

_FndNum:
	.DB  0x3F,0x6,0x5B,0x4F,0x66,0x6D,0x7D,0x7
	.DB  0x7F,0x6F
_FndHigh:
	.DB  0x40,0x76,0x40
_BUZNOTES:
	.DB  0xF,0x0,0x0,0x0,0xF,0x0,0x0,0x0
	.DB  0xF,0x0,0x0,0x0,0xF,0x0,0x0,0x0
	.DB  0xF,0x0,0x0,0x0,0xF,0x0,0x0,0x0
	.DB  0xF,0x0,0x0,0x0,0x2,0x0,0x0,0x0
	.DB  0x4,0x0,0x0,0x0,0x7,0x0,0x0,0x0
	.DB  0xA,0x0,0x0,0x0,0xF,0x0,0x0,0x0
	.DB  0xA,0x0,0x0,0x0
_BUZDURATIONS:
	.DB  0x1,0x0,0x1,0x0,0x1,0x0,0x19,0x0
	.DB  0x19,0x0,0x19,0x0,0x19,0x0,0x19,0x0
	.DB  0x19,0x0,0x19,0x0,0xA,0x0,0xA,0x0
	.DB  0xA,0x0
_ECHOS:
	.DB  0x1,0x0,0x0,0x0,0x1,0x0,0x0,0x0
	.DB  0x1,0x0,0x0,0x0,0xB4,0x0,0x0,0x0
	.DB  0x78,0x0,0x0,0x0,0x64,0x0,0x0,0x0
	.DB  0x50,0x0,0x0,0x0,0x3C,0x0,0x0,0x0
	.DB  0x14,0x0,0x0,0x0,0x14,0x0,0x0,0x0
	.DB  0x1,0x0,0x0,0x0,0x1,0x0,0x0,0x0
	.DB  0x1,0x0,0x0,0x0
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

_0x2080060:
	.DB  0x1
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __DUMY_H__
;#include "dumy.h"
;#endif
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;
;//******************************************************************************
;// Local Functions
;//******************************************************************************
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __IO_H__
;#include "io.h"
;#endif
;
;#ifndef __TIME_H__
;#include "time.h"
;#endif
;
;#ifndef __FND_H__
;#include "fnd.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;
;#ifndef __ACTION_H__
;#include "action.h"
;#endif
;
;#ifndef __EEPROM_H__
;#include "eeprom.h"
;#endif
;
;#include "../TCN75/TCN75.h"
;#include "../DAC7611/DAC7611.h"
;#include "../ADS1248/ADS1248.h"
;//******************************************************************************
;// Variables
;//******************************************************************************
;volatile Uchar gFlag_maintime;
;int gExtTemp;
;int gVoltage;
;int gCurrent;
;
;/*****************************[_MAIN    START_]******************************/
;void main()
; 0001 002F {

	.CSEG
_main:
; .FSTART _main
; 0001 0030   IO_Port_Init();
	RCALL _IO_Port_Init
; 0001 0031 
; 0001 0032   TIME_CountInit();
	CALL _TIME_CountInit
; 0001 0033   USART_Init(76800);
	LDI  R26,LOW(11264)
	LDI  R27,HIGH(11264)
	CALL _USART_Init
; 0001 0034   IO_Data_Init();
	RCALL _IO_Data_Init
; 0001 0035 
; 0001 0036   LOW_ADS1248_RESET;
	CBI  0x15,2
; 0001 0037   delay_ms(10);
	CALL SUBOPT_0x0
; 0001 0038   HIGH_ADS1248_RESET;
	SBI  0x15,2
; 0001 0039 
; 0001 003A   TCN75_init();
	CALL _TCN75_init
; 0001 003B   DAC7611_init(  );
	CALL _DAC7611_init
; 0001 003C   ADS1248_init();
	CALL _ADS1248_init
; 0001 003D 
; 0001 003E    Eeprom_Read_Control_Proc();//save data Read!
	CALL _Eeprom_Read_Control_Proc
; 0001 003F   delay_ms(100);
	LDI  R26,LOW(100)
	LDI  R27,0
	CALL _delay_ms
; 0001 0040 
; 0001 0041   #asm("sei")//7/14일 수정
	sei
; 0001 0042     while(1)
_0x20007:
; 0001 0043     {
; 0001 0044         if(gFlag_maintime)
	LDS  R30,_gFlag_maintime
	CPI  R30,0
	BREQ _0x2000A
; 0001 0045         {
; 0001 0046             gFlag_maintime=0;
	LDI  R30,LOW(0)
	STS  _gFlag_maintime,R30
; 0001 0047             TIME_TimeControl();
	CALL _TIME_TimeControl
; 0001 0048             TIME_TimeCalculatorControl();
	CALL _TIME_TimeCalculatorControl
; 0001 0049             IO_input();
	RCALL _IO_input
; 0001 004A             ACTION_Schedule();
	CALL _ACTION_Schedule
; 0001 004B 
; 0001 004C             UART_Packet_TX_RX();
	CALL _UART_Packet_TX_RX
; 0001 004D         }
; 0001 004E     }
_0x2000A:
	RJMP _0x20007
; 0001 004F 
; 0001 0050 
; 0001 0051 
; 0001 0052 }
_0x2000B:
	RJMP _0x2000B
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __IO_H__
;#include "io.h"
;#endif
;
;#ifndef __FND_H__
;#include "fnd.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#ifndef __ADC_H__
;#include "adc.h"
;#endif
;
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;Uchar key_time[10],key_repeat[10];
;
;volatile Uchar cut_in_de_flag,coa_in_de_flag,bip_in_de_flag;
;volatile int fan_data=0,plate_data;
;
;extern UART_DATA UD;
;volatile Uchar buzzer_cut_hand_flag,buzzer_coa_hand_flag,buzzer_cut_foot_flag,buzzer_coa_foot_flag,buzzer_bip_flag;
;extern volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,bu ...
;extern volatile Uchar blink_flag;
;extern int gExtTemp;
;extern Uchar bipol_relay_time;
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;void _cut_start_hand_botton_(void);
;void _cut_start_foot_botton_(void);
;void _coa_start_hand_botton_(void);
;void _coa_start_foot_botton_(void);
;void _bipol_start_foot_botton_(void);
;void _stop_calc_(void);
;
;void _cut_encoder_botton_(void);
;void _coa_encoder_botton_(void);
;void _bipol_encoder_botton_(void);
;void _warning_status_(void);
;void _mode_led_display_(void);
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;void IO_Port_Init( void )
; 0002 003B {

	.CSEG
_IO_Port_Init:
; .FSTART _IO_Port_Init
; 0002 003C 
; 0002 003D     // PORTA
; 0002 003E     // bit 7 : DSP STR3    out
; 0002 003F     // bit 6 : Encoder 1   in
; 0002 0040     // bit 5 : Encoder 0   in
; 0002 0041     // bit 4 : PWM ON/OFF  out
; 0002 0042     // bit 3 : DAC7611 LD  out
; 0002 0043     // bit 2 : DAC7611 CS  out
; 0002 0044     // bit 1 : DAC7611 CLK out
; 0002 0045     // bit 0 : DAC7611 SDI out
; 0002 0046     DDRA    = 0x9f;
	LDI  R30,LOW(159)
	OUT  0x1A,R30
; 0002 0047     PORTA   = 0x04;
	LDI  R30,LOW(4)
	OUT  0x1B,R30
; 0002 0048 
; 0002 0049     DDRB    = 0xf7;
	LDI  R30,LOW(247)
	OUT  0x17,R30
; 0002 004A     PORTB   = 0xe0;
	LDI  R30,LOW(224)
	OUT  0x18,R30
; 0002 004B 
; 0002 004C     //PORTC
; 0002 004D     //bit 7~4: CD4094
; 0002 004E     //bit 3: NC
; 0002 004F     //bit 2: ads1248 RESET
; 0002 0050     //bit 1: ADS1248 CS
; 0002 0051     //bit 0: ADS1248 DRDY
; 0002 0052     DDRC    = 0xff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0002 0053     PORTC   = 0x04;
	LDI  R30,LOW(4)
	OUT  0x15,R30
; 0002 0054 
; 0002 0055     DDRD    = 0x91;
	LDI  R30,LOW(145)
	OUT  0x11,R30
; 0002 0056     PORTD   = 0x01;
	LDI  R30,LOW(1)
	OUT  0x12,R30
; 0002 0057 
; 0002 0058     DDRE    = 0x12;
	LDI  R30,LOW(18)
	OUT  0x2,R30
; 0002 0059     //PORTE   = 0x54;
; 0002 005A 
; 0002 005B     DDRF    = 0xC0;
	LDI  R30,LOW(192)
	STS  97,R30
; 0002 005C     // PORTF   = 0x00;
; 0002 005D 
; 0002 005E     DDRG    = 0xff;
	LDI  R30,LOW(255)
	STS  100,R30
; 0002 005F     PORTG   = 0x10;
	LDI  R30,LOW(16)
	RJMP _0x20A0013
; 0002 0060 }
; .FEND
;
;//******************************************************************************
;void IO_Data_Init(void)
; 0002 0064 {
_IO_Data_Init:
; .FSTART _IO_Data_Init
; 0002 0065 
; 0002 0066     //led display init
; 0002 0067     Clrbit(UD.led_mode, LED_CUT);
	CALL SUBOPT_0x1
; 0002 0068     Clrbit(UD.led_mode, LED_COA);
; 0002 0069     Clrbit(UD.led_mode, LED_BIPOLAR);
; 0002 006A 
; 0002 006B     Setbit(STATUS_LED_PORT, WARNING_LED);//active low
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
; 0002 006C     Setbit(STATUS_LED_PORT, ACTIVE_LED); //active low
	LDS  R30,98
	ORI  R30,0x80
	STS  98,R30
; 0002 006D 
; 0002 006E     UD.alram_mode = ALRAM_OFF;
	LDI  R30,LOW(0)
	__PUTB1MN _UD,14
; 0002 006F 
; 0002 0070     cut_in_de_flag=UP_DOWN_5;
	LDI  R30,LOW(1)
	STS  _cut_in_de_flag,R30
; 0002 0071     coa_in_de_flag=UP_DOWN_5;
	STS  _coa_in_de_flag,R30
; 0002 0072     bip_in_de_flag=UP_DOWN_5;
	STS  _bip_in_de_flag,R30
; 0002 0073 
; 0002 0074     blink_flag=0;
	LDI  R30,LOW(0)
	STS  _blink_flag,R30
; 0002 0075 
; 0002 0076     IO_SET_bipol_monopol_power_sel();
	RCALL _IO_SET_bipol_monopol_power_sel
; 0002 0077     IO_CLR_monopol_watt_sel();
	RCALL _IO_CLR_monopol_watt_sel
; 0002 0078     IO_SET_watt_protect();
	RCALL _IO_SET_watt_protect
; 0002 0079 
; 0002 007A 
; 0002 007B     IO_SET_monopol_foot_sig_out();
	CALL SUBOPT_0x2
; 0002 007C     IO_SET_monopol_hand_sig_out();
; 0002 007D 
; 0002 007E }
	RET
; .FEND
;
;//******************************************************************************
;void IO_input (void)
; 0002 0082  {
_IO_input:
; .FSTART _IO_input
; 0002 0083     // _cut_start_hand_botton_();
; 0002 0084     // _coa_start_hand_botton_();
; 0002 0085    //  _cut_start_foot_botton_();
; 0002 0086    //  _coa_start_foot_botton_();
; 0002 0087      _bipol_start_foot_botton_();
	RCALL __bipol_start_foot_botton_
; 0002 0088 
; 0002 0089 
; 0002 008A     _stop_calc_();
	RCALL __stop_calc_
; 0002 008B     if(UD.startflag==STOP)
	__GETB1MN _UD,12
	CPI  R30,0
	BRNE _0x40003
; 0002 008C     {
; 0002 008D        // _cut_encoder_botton_();
; 0002 008E        // _coa_encoder_botton_();
; 0002 008F         _bipol_encoder_botton_();
	RCALL __bipol_encoder_botton_
; 0002 0090     }
; 0002 0091     _warning_status_();
_0x40003:
	RCALL __warning_status_
; 0002 0092     _mode_led_display_();
	RCALL __mode_led_display_
; 0002 0093  }
	RET
; .FEND
;//******************************************************************************
;void IO_SET_bipol_monopol_power_sel(void)
; 0002 0096 {
_IO_SET_bipol_monopol_power_sel:
; .FSTART _IO_SET_bipol_monopol_power_sel
; 0002 0097     Setbit(BIPOL_MONOPOL_POWER_SEL_PORT,BIPOL_MONOPOL_POWER_SEL);
	SBI  0x18,6
; 0002 0098 }
	RET
; .FEND
;//******************************************************************************
;void IO_CLR_bipol_monopol_power_sel(void)
; 0002 009B {
_IO_CLR_bipol_monopol_power_sel:
; .FSTART _IO_CLR_bipol_monopol_power_sel
; 0002 009C     Clrbit(BIPOL_MONOPOL_POWER_SEL_PORT,BIPOL_MONOPOL_POWER_SEL);
	CBI  0x18,6
; 0002 009D }
	RET
; .FEND
;
;//******************************************************************************
;void IO_SET_monopol_foot_sig_out(void)
; 0002 00A1 {
_IO_SET_monopol_foot_sig_out:
; .FSTART _IO_SET_monopol_foot_sig_out
; 0002 00A2     Setbit(MONOPOL_FOOT_SIG_OUT_PORT,MONOPOL_FOOT_SIG_OUT);
	SBI  0x12,0
; 0002 00A3 }
	RET
; .FEND
;//******************************************************************************
;void IO_CLR_monopol_foot_sig_out(void)
; 0002 00A6 {
_IO_CLR_monopol_foot_sig_out:
; .FSTART _IO_CLR_monopol_foot_sig_out
; 0002 00A7     Clrbit(MONOPOL_FOOT_SIG_OUT_PORT,MONOPOL_FOOT_SIG_OUT);
	CBI  0x12,0
; 0002 00A8 }
	RET
; .FEND
;
;//******************************************************************************
;void IO_SET_monopol_hand_sig_out(void)
; 0002 00AC {
_IO_SET_monopol_hand_sig_out:
; .FSTART _IO_SET_monopol_hand_sig_out
; 0002 00AD     Setbit(MONOPOL_HAND_SIG_OUT_PORT,MONOPOL_HAND_SIG_OUT);
	SBI  0x12,4
; 0002 00AE }
	RET
; .FEND
;//******************************************************************************
;void IO_CLR_monopol_hand_sig_out(void)
; 0002 00B1 {
_IO_CLR_monopol_hand_sig_out:
; .FSTART _IO_CLR_monopol_hand_sig_out
; 0002 00B2     Clrbit(MONOPOL_HAND_SIG_OUT_PORT,MONOPOL_HAND_SIG_OUT);
	CBI  0x12,4
; 0002 00B3 }
	RET
; .FEND
;
;//******************************************************************************
;void IO_SET_monopol_watt_sel(void)
; 0002 00B7 {
_IO_SET_monopol_watt_sel:
; .FSTART _IO_SET_monopol_watt_sel
; 0002 00B8     Setbit(BIPOL_MONOPOL_WATT_SEL_PORT,BIPOL_MONOPOL_WATT_SEL);
	SBI  0x18,5
; 0002 00B9 }
	RET
; .FEND
;//******************************************************************************
;void IO_CLR_monopol_watt_sel(void)
; 0002 00BC {
_IO_CLR_monopol_watt_sel:
; .FSTART _IO_CLR_monopol_watt_sel
; 0002 00BD     Clrbit(BIPOL_MONOPOL_WATT_SEL_PORT,BIPOL_MONOPOL_WATT_SEL);
	CBI  0x18,5
; 0002 00BE }
	RET
; .FEND
;
;//******************************************************************************
;void IO_SET_watt_protect( void)   //high low 변경 active high로... 프로그램 전체 안하고 출력만 수정
; 0002 00C2 {
_IO_SET_watt_protect:
; .FSTART _IO_SET_watt_protect
; 0002 00C3     Clrbit( OVER_WATT_PROTECT_PORT,OVER_WATT_PROTECT );
	CBI  0x18,7
; 0002 00C4 }
	RET
; .FEND
;//******************************************************************************
;void IO_CLR_watt_protect(void)
; 0002 00C7 {
_IO_CLR_watt_protect:
; .FSTART _IO_CLR_watt_protect
; 0002 00C8     Setbit(OVER_WATT_PROTECT_PORT,OVER_WATT_PROTECT);
	SBI  0x18,7
; 0002 00C9 }
	RET
; .FEND
;
;//******************************************************************************
;void IO_SET_monopol_spray_cont_relay(void)
; 0002 00CD {
_IO_SET_monopol_spray_cont_relay:
; .FSTART _IO_SET_monopol_spray_cont_relay
; 0002 00CE     Setbit(MONOPOL_SPRAY_CONT_RELAY_PORT,MONOPOL_SPRAY_CONT_RELAY);
	LDS  R30,101
	ORI  R30,0x10
	RJMP _0x20A0013
; 0002 00CF }
; .FEND
;//******************************************************************************
;void IO_CLR_monopol_spray_cont_relay(void)
; 0002 00D2 {
_IO_CLR_monopol_spray_cont_relay:
; .FSTART _IO_CLR_monopol_spray_cont_relay
; 0002 00D3     Clrbit(MONOPOL_SPRAY_CONT_RELAY_PORT,MONOPOL_SPRAY_CONT_RELAY);
	LDS  R30,101
	ANDI R30,0xEF
_0x20A0013:
	STS  101,R30
; 0002 00D4 }
	RET
; .FEND
;//******************************************************************************
;void IO_spray_relay(Uchar val)
; 0002 00D7 {
_IO_spray_relay:
; .FSTART _IO_spray_relay
; 0002 00D8     if(val==HIGH)
	ST   -Y,R26
;	val -> Y+0
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x40004
; 0002 00D9     {
; 0002 00DA         Setbit(SPRAY_RELAY_PORT,SPRAY_RELAY);
	LDS  R30,101
	ORI  R30,8
	RJMP _0x400B0
; 0002 00DB     }
; 0002 00DC     else if(val==LOW)
_0x40004:
	LD   R30,Y
	CPI  R30,0
	BRNE _0x40006
; 0002 00DD     {
; 0002 00DE         Clrbit(SPRAY_RELAY_PORT,SPRAY_RELAY);
	LDS  R30,101
	ANDI R30,0XF7
_0x400B0:
	STS  101,R30
; 0002 00DF     }
; 0002 00E0 }
_0x40006:
	RJMP _0x20A0012
; .FEND
;
;//2016-06-11
;void Temp_over_detect_function_(void)
; 0002 00E4 {
_Temp_over_detect_function_:
; .FSTART _Temp_over_detect_function_
; 0002 00E5     if( gExtTemp > 600 )
	LDI  R30,LOW(600)
	LDI  R31,HIGH(600)
	CP   R30,R4
	CPC  R31,R5
	BRGE _0x40007
; 0002 00E6     {
; 0002 00E7         UD.alram_mode=FAN_ERROR_ALARM;
	LDI  R30,LOW(3)
	CALL SUBOPT_0x3
; 0002 00E8         UD.startflag = STOP;
; 0002 00E9         UD.warning_status = WARNING_BLINK_ON;
; 0002 00EA         buzzer_fan_error_flag=1;
	STS  _buzzer_fan_error_flag,R30
; 0002 00EB     }
; 0002 00EC     else
	RJMP _0x40008
_0x40007:
; 0002 00ED     {
; 0002 00EE         if(UD.alram_mode==FAN_ERROR_ALARM)
	__GETB2MN _UD,14
	CPI  R26,LOW(0x3)
	BRNE _0x40009
; 0002 00EF         {
; 0002 00F0             UD.alram_mode=ALRAM_OFF;
	CALL SUBOPT_0x4
; 0002 00F1             if(UD.warning_status==WARNING_BLINK_ON)
	SBIW R26,3
	BRNE _0x4000A
; 0002 00F2             {
; 0002 00F3                 UD.warning_status=WARNING_BLINK_OFF;
	CALL SUBOPT_0x5
; 0002 00F4             }
; 0002 00F5         }
_0x4000A:
; 0002 00F6     }
_0x40009:
_0x40008:
; 0002 00F7 }
	RET
; .FEND
;
;
;//******************************************************************************
;void IO_over_watt_detect_function_(void)
; 0002 00FC {
_IO_over_watt_detect_function_:
; .FSTART _IO_over_watt_detect_function_
; 0002 00FD 
; 0002 00FE     if(Chkbit(OVER_WATT_DETECT_PORT, OVER_WATT_DETECT))
	SBIS 0x0,3
	RJMP _0x4000B
; 0002 00FF     {
; 0002 0100       IO_SET_watt_protect();
	RCALL _IO_SET_watt_protect
; 0002 0101       UD.startflag=STOP;
	LDI  R30,LOW(0)
	__PUTB1MN _UD,12
; 0002 0102       UD.warning_status=WARNING_ON;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	__PUTW1MN _UD,16
; 0002 0103       UD.alram_mode = OVER_POWER_ALRAM;
	__PUTB1MN _UD,14
; 0002 0104       buzzer_over_watt_flag=1;
	STS  _buzzer_over_watt_flag,R30
; 0002 0105     }
; 0002 0106     else
	RJMP _0x4000C
_0x4000B:
; 0002 0107     {   if(UD.startflag==RUN)
	__GETB2MN _UD,12
	CPI  R26,LOW(0x1)
	BRNE _0x4000D
; 0002 0108         {
; 0002 0109            IO_SET_watt_protect();
	RCALL _IO_SET_watt_protect
; 0002 010A         }
; 0002 010B         else
	RJMP _0x4000E
_0x4000D:
; 0002 010C         {
; 0002 010D             IO_CLR_watt_protect();
	RCALL _IO_CLR_watt_protect
; 0002 010E         }
_0x4000E:
; 0002 010F 
; 0002 0110         if( UD.alram_mode == OVER_POWER_ALRAM )
	__GETB2MN _UD,14
	CPI  R26,LOW(0x1)
	BRNE _0x4000F
; 0002 0111         {
; 0002 0112             UD.alram_mode = ALRAM_OFF;
	CALL SUBOPT_0x4
; 0002 0113             if(UD.warning_status==WARNING_ON)
	SBIW R26,1
	BRNE _0x40010
; 0002 0114             {
; 0002 0115                UD.warning_status=WARNING_OFF;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _UD,16
; 0002 0116             }
; 0002 0117         }
_0x40010:
; 0002 0118     }
_0x4000F:
_0x4000C:
; 0002 0119 
; 0002 011A }
	RET
; .FEND
;//******************************************************************************
; void IO_plate_error_function_(void)
; 0002 011D {
_IO_plate_error_function_:
; .FSTART _IO_plate_error_function_
; 0002 011E     AD_Convert_Calculator_Proc(PLATE_DETECT_ADC);
	LDI  R26,LOW(4)
	CALL _AD_Convert_Calculator_Proc
; 0002 011F 
; 0002 0120     if(plate_data>=200)
	CALL SUBOPT_0x6
	BRLT _0x40011
; 0002 0121     {
; 0002 0122       UD.alram_mode=PLATE_ALRAM;UD.startflag=STOP; UD.warning_status=WARNING_BLINK_ON;buzzer_plate_alram_flag=1;
	LDI  R30,LOW(2)
	CALL SUBOPT_0x3
	STS  _buzzer_plate_alram_flag,R30
; 0002 0123     }
; 0002 0124     else if(plate_data<200)
	RJMP _0x40012
_0x40011:
	CALL SUBOPT_0x6
	BRGE _0x40013
; 0002 0125     {
; 0002 0126         if(UD.alram_mode==PLATE_ALRAM)
	__GETB2MN _UD,14
	CPI  R26,LOW(0x2)
	BRNE _0x40014
; 0002 0127         {
; 0002 0128             UD.alram_mode=ALRAM_OFF;
	CALL SUBOPT_0x4
; 0002 0129             if(UD.warning_status==WARNING_BLINK_ON){UD.warning_status=WARNING_BLINK_OFF;}
	SBIW R26,3
	BRNE _0x40015
	CALL SUBOPT_0x5
; 0002 012A         }
_0x40015:
; 0002 012B 
; 0002 012C     }
_0x40014:
; 0002 012D }
_0x40013:
_0x40012:
	RET
; .FEND
;//******************************************************************************
; void IO_fan_error_function_(void)
; 0002 0130 {
; 0002 0131     AD_Convert_Calculator_Proc(FAN_ERROR_TEMP_ADC);
; 0002 0132 
; 0002 0133     if(fan_data>=62){UD.alram_mode=FAN_ERROR_ALARM;UD.startflag=STOP; UD.warning_status=WARNING_BLINK_ON;buzzer_fan_erro ...
; 0002 0134     else if(fan_data<62)
; 0002 0135     {
; 0002 0136         if(UD.alram_mode==FAN_ERROR_ALARM)
; 0002 0137         {
; 0002 0138             UD.alram_mode=ALRAM_OFF;
; 0002 0139             if(UD.warning_status==WARNING_BLINK_ON){UD.warning_status=WARNING_BLINK_OFF;}
; 0002 013A         }
; 0002 013B     }
; 0002 013C 
; 0002 013D }
;//******************************************************************************
;// Local Functions
;//******************************************************************************
; void _cut_start_hand_botton_(void)
; 0002 0142 {
; 0002 0143 
; 0002 0144         if(!Chkbit(MONOPOL_HAND_CUT_START_SW_PORT, MONOPOL_HAND_CUT_START_SW))
; 0002 0145         {
; 0002 0146             key_time[0]++;
; 0002 0147             if(key_time[0]>5)
; 0002 0148             {
; 0002 0149                 key_time[0]=5;
; 0002 014A             // buzzer_cut_hand_flag=1;
; 0002 014B                if(UD.startflag==STOP)
; 0002 014C                {
; 0002 014D 
; 0002 014E                 if(UD.alram_mode==ALRAM_OFF)
; 0002 014F                 {
; 0002 0150                     if(key_repeat[0]==0)
; 0002 0151                     {
; 0002 0152                         key_repeat[0]=1;
; 0002 0153                         UD.startflag=RUN;
; 0002 0154 
; 0002 0155                         if(UD.cut_mode == F_BLEND_OFF){UD.action_mode=BLEND_OFF_HAND;}
; 0002 0156                         else if(UD.cut_mode == F_BLEND_1){UD.action_mode=BLEND_1_HAND;}
; 0002 0157                         else if(UD.cut_mode == F_BLEND_2){UD.action_mode=BLEND_2_HAND;}
; 0002 0158 
; 0002 0159 
; 0002 015A                        UD.cut_hand_start=RUN;
; 0002 015B                        /*  UD.mono_bi_sel=MONOPOLAR;
; 0002 015C                         UD.cut_coa_sel=CUT;
; 0002 015D                         */
; 0002 015E                     }
; 0002 015F                  }
; 0002 0160                  else
; 0002 0161                  {
; 0002 0162                     UD.cut_hand_start=STOP;
; 0002 0163                     buzzer_cut_hand_flag=0;
; 0002 0164                  }
; 0002 0165                }
; 0002 0166             }
; 0002 0167         }
; 0002 0168         else
; 0002 0169         {
; 0002 016A             key_time[0]=0;
; 0002 016B             key_repeat[0]=0;
; 0002 016C             UD.cut_hand_start=STOP;
; 0002 016D             buzzer_cut_hand_flag=0;
; 0002 016E         }
; 0002 016F }
;//******************************************************************************
;void _coa_start_hand_botton_(void)
; 0002 0172 {
; 0002 0173     if(!Chkbit(MONOPOL_HAND_COA_START_SW_PORT, MONOPOL_HAND_COA_START_SW))
; 0002 0174     {
; 0002 0175         key_time[1]++;
; 0002 0176         if(key_time[1]>5)
; 0002 0177         {
; 0002 0178              key_time[1]=5;
; 0002 0179             if(UD.startflag==STOP)
; 0002 017A             {
; 0002 017B             //buzzer_coa_hand_flag=1;
; 0002 017C              if(UD.alram_mode==ALRAM_OFF)
; 0002 017D              {
; 0002 017E                 if(key_repeat[1]==0)
; 0002 017F                 {
; 0002 0180                     key_repeat[1]=1;
; 0002 0181                     UD.startflag=RUN;
; 0002 0182                     if(UD.coa_mode == F_CONTACT){UD.action_mode=CONTACT_HAND;}
; 0002 0183                     else if(UD.coa_mode == F_SPRAY){UD.action_mode=SPRAY_HAND;}
; 0002 0184 
; 0002 0185                     UD.coa_hand_start=RUN;
; 0002 0186                    /* UD.mono_bi_sel=MONOPOLAR;
; 0002 0187                     UD.cut_coa_sel=COA;
; 0002 0188                     */
; 0002 0189                 }
; 0002 018A 
; 0002 018B              }
; 0002 018C              else
; 0002 018D              {
; 0002 018E                 UD.coa_hand_start=STOP;
; 0002 018F                 buzzer_coa_hand_flag=0;
; 0002 0190              }
; 0002 0191              }
; 0002 0192         }
; 0002 0193     }
; 0002 0194     else{key_time[1]=0;key_repeat[1]=0;UD.coa_hand_start=STOP;buzzer_coa_hand_flag=0;}
; 0002 0195 
; 0002 0196 }
;
;//******************************************************************************
;void _cut_start_foot_botton_(void)
; 0002 019A {
; 0002 019B 
; 0002 019C     if(!Chkbit(MONOPOL_FOOT_CUT_START_SW_PORT, MONOPOL_FOOT_CUT_START_SW))
; 0002 019D     {
; 0002 019E         key_time[2]++;
; 0002 019F         if(key_time[2]>5)
; 0002 01A0         {
; 0002 01A1              key_time[2]=5;
; 0002 01A2             //buzzer_cut_foot_flag=1;
; 0002 01A3             if(UD.startflag==STOP)
; 0002 01A4             {
; 0002 01A5             if(UD.alram_mode==ALRAM_OFF)
; 0002 01A6             {
; 0002 01A7                 if(key_repeat[2]==0)
; 0002 01A8                 {
; 0002 01A9                     key_repeat[2]=1;
; 0002 01AA                     UD.startflag=RUN;
; 0002 01AB                     if(UD.cut_mode == F_BLEND_OFF){UD.action_mode=BLEND_OFF_FOOT;}
; 0002 01AC                     else if(UD.cut_mode == F_BLEND_1){UD.action_mode=BLEND_1_FOOT;}
; 0002 01AD                     else if(UD.cut_mode == F_BLEND_2){UD.action_mode=BLEND_2_FOOT;}
; 0002 01AE 
; 0002 01AF                     UD.cut_foot_start=RUN;
; 0002 01B0                     /* UD.mono_bi_sel=MONOPOLAR;
; 0002 01B1                     UD.cut_coa_sel=CUT;
; 0002 01B2                      */
; 0002 01B3                 }
; 0002 01B4             }
; 0002 01B5             else
; 0002 01B6             {
; 0002 01B7                 UD.cut_foot_start=STOP;
; 0002 01B8                 buzzer_cut_foot_flag=0;
; 0002 01B9             }
; 0002 01BA             }
; 0002 01BB         }
; 0002 01BC     }
; 0002 01BD     else{key_time[2]=0;key_repeat[2]=0;UD.cut_foot_start=STOP;buzzer_cut_foot_flag=0;}
; 0002 01BE 
; 0002 01BF }
;//******************************************************************************
;void _coa_start_foot_botton_(void)
; 0002 01C2 {
; 0002 01C3    if(!Chkbit(MONOPOL_FOOT_COA_START_SW_PORT, MONOPOL_FOOT_COA_START_SW))
; 0002 01C4     {
; 0002 01C5         key_time[3]++;
; 0002 01C6         if(key_time[3]>5)
; 0002 01C7         {
; 0002 01C8             key_time[3]=5;
; 0002 01C9             if(UD.startflag==STOP)
; 0002 01CA             {
; 0002 01CB             //buzzer_coa_foot_flag=1;
; 0002 01CC             if(UD.alram_mode==ALRAM_OFF)
; 0002 01CD             {
; 0002 01CE                 if(key_repeat[3]==0)
; 0002 01CF                 {
; 0002 01D0                     key_repeat[3]=1;
; 0002 01D1                     UD.startflag=RUN;
; 0002 01D2                     if(UD.coa_mode == F_CONTACT){UD.action_mode=CONTACT_FOOT;}
; 0002 01D3                     else if(UD.coa_mode == F_SPRAY){UD.action_mode=SPRAY_FOOT;}
; 0002 01D4 
; 0002 01D5                     UD.coa_foot_start=RUN;
; 0002 01D6                    /* UD.mono_bi_sel=MONOPOLAR;
; 0002 01D7                     UD.cut_coa_sel=COA;
; 0002 01D8                     */
; 0002 01D9                 }
; 0002 01DA             }
; 0002 01DB             else
; 0002 01DC             {
; 0002 01DD                 UD.coa_foot_start=STOP;
; 0002 01DE                 buzzer_coa_foot_flag=0;
; 0002 01DF             }
; 0002 01E0             }
; 0002 01E1         }
; 0002 01E2     }
; 0002 01E3     else{key_time[3]=0;key_repeat[3]=0;UD.coa_foot_start=STOP;buzzer_coa_foot_flag=0;}
; 0002 01E4 
; 0002 01E5 }
;//******************************************************************************
;void _bipol_start_foot_botton_(void)
; 0002 01E8 {
__bipol_start_foot_botton_:
; .FSTART __bipol_start_foot_botton_
; 0002 01E9 
; 0002 01EA     if(!Chkbit(BIPOL_FOOT_START_SW_PORT, BIPOL_FOOT_START_SW))
	SBIC 0x10,1
	RJMP _0x40047
; 0002 01EB     {
; 0002 01EC         key_time[4]++;
	__GETB1MN _key_time,4
	SUBI R30,-LOW(1)
	__PUTB1MN _key_time,4
	SUBI R30,LOW(1)
; 0002 01ED         if(key_time[4]>5)
	__GETB2MN _key_time,4
	CPI  R26,LOW(0x6)
	BRSH PC+2
	RJMP _0x40048
; 0002 01EE         {
; 0002 01EF             key_time[4]=5;
	LDI  R30,LOW(5)
	__PUTB1MN _key_time,4
; 0002 01F0             if(UD.startflag==STOP)
	__GETB1MN _UD,12
	CPI  R30,0
	BRNE _0x40049
; 0002 01F1             {
; 0002 01F2            // buzzer_bip_flag=1;
; 0002 01F3             if(UD.alram_mode==ALRAM_OFF)
	__GETB1MN _UD,14
	CPI  R30,0
	BRNE _0x4004A
; 0002 01F4             {
; 0002 01F5                 if(key_repeat[4]==0)
	__GETB1MN _key_repeat,4
	CPI  R30,0
	BRNE _0x4004B
; 0002 01F6                 {
; 0002 01F7                     key_repeat[4]=1;
	LDI  R30,LOW(1)
	__PUTB1MN _key_repeat,4
; 0002 01F8                     if(UD.bipol_mode == F_IMP_SENSE_OFF)
	__GETB2MN _UD,10
	CPI  R26,LOW(0x6)
	BRNE _0x4004C
; 0002 01F9                     {
; 0002 01FA                        UD.action_mode=IMP_SENSE_OFF;
	LDI  R30,LOW(11)
	__PUTB1MN _UD,15
; 0002 01FB                        UD.startflag=RUN;
	LDI  R30,LOW(1)
	__PUTB1MN _UD,12
; 0002 01FC                        UD.bipol_foot_start=RUN;
	RJMP _0x400B5
; 0002 01FD                     }
; 0002 01FE                     else if(UD.bipol_mode == F_IMP_SENSE_ON)
_0x4004C:
	__GETB2MN _UD,10
	CPI  R26,LOW(0x7)
	BRNE _0x4004E
; 0002 01FF                     {
; 0002 0200                         UD.action_mode=IMP_SENSE_ON;
	LDI  R30,LOW(12)
	__PUTB1MN _UD,15
; 0002 0201                         if(UD.alram_mode == ALRAM_OFF)
	__GETB1MN _UD,14
	CPI  R30,0
	BRNE _0x4004F
; 0002 0202                         {
; 0002 0203                             UD.startflag = RUN;
	LDI  R30,LOW(1)
	__PUTB1MN _UD,12
; 0002 0204                             UD.bipol_foot_start = RUN;
	RJMP _0x400B5
; 0002 0205                         }
; 0002 0206                         else if(UD.alram_mode==IMPEDANCE_OVER)
_0x4004F:
	__GETB2MN _UD,14
	CPI  R26,LOW(0x4)
	BRNE _0x40051
; 0002 0207                         {
; 0002 0208                             UD.startflag = STOP;
	LDI  R30,LOW(0)
	__PUTB1MN _UD,12
; 0002 0209                             UD.bipol_foot_start = STOP;
_0x400B5:
	__PUTB1MN _UD,5
; 0002 020A                         }
; 0002 020B                     }
_0x40051:
; 0002 020C 
; 0002 020D                   /*  UD.mono_bi_sel=BIPOLAR;
; 0002 020E                     */
; 0002 020F                 }
_0x4004E:
; 0002 0210             }
_0x4004B:
; 0002 0211             else
	RJMP _0x40052
_0x4004A:
; 0002 0212             {
; 0002 0213                 UD.bipol_foot_start=STOP;
	CALL SUBOPT_0x7
; 0002 0214                 buzzer_bip_flag=0;
; 0002 0215                 if(UD.alram_mode==IMPEDANCE_OVER)
	__GETB2MN _UD,14
	CPI  R26,LOW(0x4)
	BRNE _0x40053
; 0002 0216                 {
; 0002 0217                     UD.alram_mode=ALRAM_OFF;
	LDI  R30,LOW(0)
	__PUTB1MN _UD,14
; 0002 0218                 }
; 0002 0219             }
_0x40053:
_0x40052:
; 0002 021A             }
; 0002 021B         }
_0x40049:
; 0002 021C     }
_0x40048:
; 0002 021D     else
	RJMP _0x40054
_0x40047:
; 0002 021E     {
; 0002 021F        key_time[4]=0;key_repeat[4]=0;UD.bipol_foot_start=STOP;buzzer_bip_flag=0;
	LDI  R30,LOW(0)
	__PUTB1MN _key_time,4
	__PUTB1MN _key_repeat,4
	CALL SUBOPT_0x7
; 0002 0220     }
_0x40054:
; 0002 0221 
; 0002 0222 }
	RET
; .FEND
;
;//******************************************************************************
; void _stop_calc_(void)
; 0002 0226 {
__stop_calc_:
; .FSTART __stop_calc_
; 0002 0227     if((UD.cut_hand_start==STOP && UD.coa_hand_start==STOP && UD.cut_foot_start==STOP && UD.coa_foot_start==STOP && UD.b ...
	__GETB2MN _UD,6
	CPI  R26,LOW(0x0)
	BRNE _0x40056
	__GETB2MN _UD,7
	CPI  R26,LOW(0x0)
	BRNE _0x40056
	__GETB2MN _UD,3
	CPI  R26,LOW(0x0)
	BRNE _0x40056
	__GETB2MN _UD,4
	CPI  R26,LOW(0x0)
	BRNE _0x40056
	__GETB2MN _UD,5
	CPI  R26,LOW(0x0)
	BREQ _0x40058
_0x40056:
	__GETB2MN _UD,14
	CPI  R26,LOW(0x0)
	BREQ _0x40055
_0x40058:
; 0002 0228     {
; 0002 0229         UD.startflag=STOP;
	LDI  R30,LOW(0)
	__PUTB1MN _UD,12
; 0002 022A          bipol_relay_time=0;
	STS  _bipol_relay_time,R30
; 0002 022B     }
; 0002 022C }
_0x40055:
	RET
; .FEND
;
;//******************************************************************************
; void _cut_encoder_botton_(void)
; 0002 0230 {
; 0002 0231     if(!Chkbit(ENC_CUT_PUSH_PORT, ENC_CUT_PUSH))
; 0002 0232     {
; 0002 0233         key_time[5]++;
; 0002 0234         if(key_time[5]<200 && key_repeat[5]==0)
; 0002 0235         {
; 0002 0236             key_repeat[5]=1;
; 0002 0237         }
; 0002 0238         else if(key_time[5]>=200 && key_repeat[5]==1)
; 0002 0239         {
; 0002 023A             if((UD.cut_foot_start==STOP) || (UD.cut_hand_start==STOP))
; 0002 023B             {
; 0002 023C                 key_time[5]=200;
; 0002 023D                 key_repeat[5]=2;
; 0002 023E             }
; 0002 023F         }
; 0002 0240 
; 0002 0241         if(key_time[5]>=200 && key_repeat[5]==2)
; 0002 0242         {
; 0002 0243             key_repeat[5]=3;
; 0002 0244             buzzer_start_flag=1;
; 0002 0245             if(cut_in_de_flag==UP_DOWN_5){cut_in_de_flag=UP_DOWN_1;}
; 0002 0246             else if(cut_in_de_flag==UP_DOWN_1){cut_in_de_flag=UP_DOWN_5;}
; 0002 0247         }
; 0002 0248     }
; 0002 0249     else
; 0002 024A     {
; 0002 024B         if(key_time[5]<200 && key_repeat[5]==1)
; 0002 024C         {
; 0002 024D             /*if(UD.cut_mode == F_BLEND_OFF){UD.cut_mode=F_BLEND_1;}
; 0002 024E             else if(UD.cut_mode == F_BLEND_1){UD.cut_mode=F_BLEND_2;}
; 0002 024F             else{UD.cut_mode=F_BLEND_OFF;}
; 0002 0250             */
; 0002 0251         }
; 0002 0252         key_time[5]=0;
; 0002 0253         key_repeat[5]=0;
; 0002 0254     }
; 0002 0255 
; 0002 0256 }
;//******************************************************************************
; void _coa_encoder_botton_(void)
; 0002 0259 {
; 0002 025A     if(!Chkbit(ENC_COA_PUSH_PORT, ENC_COA_PUSH))
; 0002 025B     {
; 0002 025C         key_time[6]++;
; 0002 025D         if(key_time[6]<200 && key_repeat[6]==0)
; 0002 025E         {
; 0002 025F             key_repeat[6]=1;
; 0002 0260         }
; 0002 0261         else if(key_time[6]>=200 && key_repeat[6]==1)
; 0002 0262         {
; 0002 0263             if((UD.coa_foot_start==STOP) || (UD.coa_hand_start==STOP))
; 0002 0264             {
; 0002 0265                 key_time[6]=200;
; 0002 0266                 key_repeat[6]=2;
; 0002 0267             }
; 0002 0268         }
; 0002 0269 
; 0002 026A         if(key_time[6]>=200 && key_repeat[6]==2)
; 0002 026B         {
; 0002 026C             key_repeat[6]=3;
; 0002 026D 
; 0002 026E             buzzer_start_flag=1;
; 0002 026F             if(coa_in_de_flag==UP_DOWN_5){coa_in_de_flag=UP_DOWN_1;}
; 0002 0270             else if(coa_in_de_flag==UP_DOWN_1){coa_in_de_flag=UP_DOWN_5;}
; 0002 0271         }
; 0002 0272     }
; 0002 0273     else
; 0002 0274     {
; 0002 0275         if(key_time[6]<200 && key_repeat[6]==1)
; 0002 0276         {
; 0002 0277         /*
; 0002 0278             if(UD.coa_mode == F_CONTACT)
; 0002 0279             {
; 0002 027A                 UD.coa_mode=F_SPRAY;
; 0002 027B 
; 0002 027C             }
; 0002 027D             else
; 0002 027E             {
; 0002 027F                 UD.coa_mode=F_CONTACT;
; 0002 0280 
; 0002 0281             }
; 0002 0282             */
; 0002 0283         }
; 0002 0284         key_time[6]=0;
; 0002 0285         key_repeat[6]=0;
; 0002 0286     }
; 0002 0287 }
;//******************************************************************************
; void _bipol_encoder_botton_(void)
; 0002 028A {
__bipol_encoder_botton_:
; .FSTART __bipol_encoder_botton_
; 0002 028B     if(!Chkbit(ENC_CUT_PUSH_PORT, ENC_CUT_PUSH))
	SBIC 0x16,0
	RJMP _0x40084
; 0002 028C //    if(!Chkbit(ENC_BIP_PUSH_PORT, ENC_BIP_PUSH))
; 0002 028D     {
; 0002 028E         key_time[7]++;
	__GETB1MN _key_time,7
	SUBI R30,-LOW(1)
	__PUTB1MN _key_time,7
; 0002 028F         if(key_time[7]<200 && key_repeat[7]==0)
	__GETB2MN _key_time,7
	CPI  R26,LOW(0xC8)
	BRSH _0x40086
	__GETB2MN _key_repeat,7
	CPI  R26,LOW(0x0)
	BREQ _0x40087
_0x40086:
	RJMP _0x40085
_0x40087:
; 0002 0290         {
; 0002 0291             key_repeat[7]=1;
	LDI  R30,LOW(1)
	RJMP _0x400BA
; 0002 0292         }
; 0002 0293         else if(key_time[7]>=200 && key_repeat[7]==1)
_0x40085:
	__GETB2MN _key_time,7
	CPI  R26,LOW(0xC8)
	BRLO _0x4008A
	__GETB2MN _key_repeat,7
	CPI  R26,LOW(0x1)
	BREQ _0x4008B
_0x4008A:
	RJMP _0x40089
_0x4008B:
; 0002 0294         {
; 0002 0295             if(UD.bipol_foot_start==STOP)
	__GETB1MN _UD,5
	CPI  R30,0
	BRNE _0x4008C
; 0002 0296             {
; 0002 0297                 key_time[7]=200;
	LDI  R30,LOW(200)
	__PUTB1MN _key_time,7
; 0002 0298                 key_repeat[7]=2;
	LDI  R30,LOW(2)
_0x400BA:
	__PUTB1MN _key_repeat,7
; 0002 0299             }
; 0002 029A         }
_0x4008C:
; 0002 029B 
; 0002 029C         if(key_time[7]>=200 && key_repeat[7]==2)
_0x40089:
	__GETB2MN _key_time,7
	CPI  R26,LOW(0xC8)
	BRLO _0x4008E
	__GETB2MN _key_repeat,7
	CPI  R26,LOW(0x2)
	BREQ _0x4008F
_0x4008E:
	RJMP _0x4008D
_0x4008F:
; 0002 029D         {
; 0002 029E             key_repeat[7]=3;
	LDI  R30,LOW(3)
	__PUTB1MN _key_repeat,7
; 0002 029F 
; 0002 02A0             buzzer_start_flag=1;
	LDI  R30,LOW(1)
	STS  _buzzer_start_flag,R30
; 0002 02A1             if(bip_in_de_flag==UP_DOWN_5){bip_in_de_flag=UP_DOWN_1;}
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0x40090
	LDI  R30,LOW(2)
	RJMP _0x400BB
; 0002 02A2             else if(bip_in_de_flag==UP_DOWN_1){bip_in_de_flag=UP_DOWN_5;}
_0x40090:
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0x40092
	LDI  R30,LOW(1)
_0x400BB:
	STS  _bip_in_de_flag,R30
; 0002 02A3         }
_0x40092:
; 0002 02A4     }
_0x4008D:
; 0002 02A5     else
	RJMP _0x40093
_0x40084:
; 0002 02A6     {
; 0002 02A7         if(key_time[7]<200 && key_repeat[7]==1)
; 0002 02A8         {
; 0002 02A9           /*  if(UD.bipol_mode == F_IMP_SENSE_OFF)
; 0002 02AA             {
; 0002 02AB                 UD.bipol_mode=F_IMP_SENSE_ON;
; 0002 02AC             }
; 0002 02AD             else
; 0002 02AE             {
; 0002 02AF                 UD.bipol_mode=F_IMP_SENSE_OFF;
; 0002 02B0             }
; 0002 02B1             */
; 0002 02B2         }
; 0002 02B3         key_time[7]=0;
	LDI  R30,LOW(0)
	__PUTB1MN _key_time,7
; 0002 02B4         key_repeat[7]=0;
	__PUTB1MN _key_repeat,7
; 0002 02B5     }
_0x40093:
; 0002 02B6 }
	RET
; .FEND
;
;//******************************************************************************
; void _warning_status_(void)
; 0002 02BA {
__warning_status_:
; .FSTART __warning_status_
; 0002 02BB    /* if()
; 0002 02BC     {
; 0002 02BD         UD.warning_status=WARNING_OFF;
; 0002 02BE     }
; 0002 02BF     else
; 0002 02C0     {
; 0002 02C1         UD.warning_status=WARNING_ON;
; 0002 02C2     }
; 0002 02C3     */
; 0002 02C4 }
	RET
; .FEND
;
;//******************************************************************************
; void _mode_led_display_(void)
; 0002 02C8 {
__mode_led_display_:
; .FSTART __mode_led_display_
; 0002 02C9     if(UD.startflag==RUN)
	__GETB2MN _UD,12
	CPI  R26,LOW(0x1)
	BRNE _0x40097
; 0002 02CA     {
; 0002 02CB         if((UD.action_mode == BLEND_OFF_HAND) || (UD.action_mode == BLEND_1_HAND) || (UD.action_mode == BLEND_2_HAND)||( ...
	__GETB2MN _UD,15
	CPI  R26,LOW(0x1)
	BREQ _0x40099
	__GETB2MN _UD,15
	CPI  R26,LOW(0x2)
	BREQ _0x40099
	__GETB2MN _UD,15
	CPI  R26,LOW(0x3)
	BREQ _0x40099
	__GETB2MN _UD,15
	CPI  R26,LOW(0x4)
	BREQ _0x40099
	__GETB2MN _UD,15
	CPI  R26,LOW(0x5)
	BREQ _0x40099
	__GETB2MN _UD,15
	CPI  R26,LOW(0x6)
	BRNE _0x40098
_0x40099:
; 0002 02CC         {
; 0002 02CD             Setbit(UD.led_mode, LED_CUT);
	__GETB1MN _UD,1
	ORI  R30,0x80
	RJMP _0x400BC
; 0002 02CE         }
; 0002 02CF         else if((UD.action_mode == CONTACT_HAND)||(UD.action_mode == SPRAY_HAND)||(UD.action_mode == CONTACT_FOOT)||(UD. ...
_0x40098:
	__GETB2MN _UD,15
	CPI  R26,LOW(0x7)
	BREQ _0x4009D
	__GETB2MN _UD,15
	CPI  R26,LOW(0x8)
	BREQ _0x4009D
	__GETB2MN _UD,15
	CPI  R26,LOW(0x9)
	BREQ _0x4009D
	__GETB2MN _UD,15
	CPI  R26,LOW(0xA)
	BRNE _0x4009C
_0x4009D:
; 0002 02D0         {
; 0002 02D1             Setbit(UD.led_mode, LED_COA);
	__GETB1MN _UD,1
	ORI  R30,0x40
	RJMP _0x400BC
; 0002 02D2         }
; 0002 02D3         else if((UD.action_mode == IMP_SENSE_OFF)||(UD.action_mode == IMP_SENSE_ON))
_0x4009C:
	__GETB2MN _UD,15
	CPI  R26,LOW(0xB)
	BREQ _0x400A1
	__GETB2MN _UD,15
	CPI  R26,LOW(0xC)
	BRNE _0x400A0
_0x400A1:
; 0002 02D4         {
; 0002 02D5             Setbit(UD.led_mode, LED_BIPOLAR);
	__GETB1MN _UD,1
	ORI  R30,0x20
_0x400BC:
	__PUTB1MN _UD,1
; 0002 02D6         }
; 0002 02D7     }
_0x400A0:
; 0002 02D8     else if(UD.startflag==STOP)
	RJMP _0x400A3
_0x40097:
	__GETB1MN _UD,12
	CPI  R30,0
	BRNE _0x400A4
; 0002 02D9     {
; 0002 02DA         Clrbit(UD.led_mode, LED_CUT);
	CALL SUBOPT_0x1
; 0002 02DB         Clrbit(UD.led_mode, LED_COA);
; 0002 02DC         Clrbit(UD.led_mode, LED_BIPOLAR);
; 0002 02DD     }
; 0002 02DE 
; 0002 02DF     if(UD.cut_mode == F_BLEND_OFF){Clrbit(UD.led_mode, LED_BLEND1);Clrbit(UD.led_mode, LED_BLEND2);}
_0x400A4:
_0x400A3:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x1)
	BRNE _0x400A5
	CALL SUBOPT_0x8
	ANDI R30,0XF7
	RJMP _0x400BD
; 0002 02E0     else if(UD.cut_mode == F_BLEND_1){Setbit(UD.led_mode, LED_BLEND1);Clrbit(UD.led_mode, LED_BLEND2);}
_0x400A5:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x2)
	BRNE _0x400A7
	__GETB1MN _UD,1
	ORI  R30,0x10
	CALL SUBOPT_0x9
	ANDI R30,0XF7
	RJMP _0x400BD
; 0002 02E1     else if(UD.cut_mode == F_BLEND_2){Clrbit(UD.led_mode, LED_BLEND1);Setbit(UD.led_mode, LED_BLEND2);}
_0x400A7:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x3)
	BRNE _0x400A9
	CALL SUBOPT_0x8
	ORI  R30,8
_0x400BD:
	__PUTB1MN _UD,1
; 0002 02E2 
; 0002 02E3     if(UD.coa_mode == F_CONTACT){Setbit(UD.led_mode, LED_CONTACT);Clrbit(UD.led_mode, LED_SPRAY);}
_0x400A9:
	__GETB2MN _UD,9
	CPI  R26,LOW(0x4)
	BRNE _0x400AA
	__GETB1MN _UD,1
	ORI  R30,4
	CALL SUBOPT_0x9
	ANDI R30,0xFD
	RJMP _0x400BE
; 0002 02E4     else if(UD.coa_mode == F_SPRAY){Clrbit(UD.led_mode, LED_CONTACT);Setbit(UD.led_mode, LED_SPRAY);}
_0x400AA:
	__GETB2MN _UD,9
	CPI  R26,LOW(0x5)
	BRNE _0x400AC
	__GETB1MN _UD,1
	ANDI R30,0xFB
	CALL SUBOPT_0x9
	ORI  R30,2
_0x400BE:
	__PUTB1MN _UD,1
; 0002 02E5 
; 0002 02E6     if(UD.bipol_mode == F_IMP_SENSE_OFF){Clrbit(UD.led_mode, LED_IMP_SENSE);}
_0x400AC:
	__GETB2MN _UD,10
	CPI  R26,LOW(0x6)
	BRNE _0x400AD
	__GETB1MN _UD,1
	ANDI R30,0xFE
	RJMP _0x400BF
; 0002 02E7     else if(UD.bipol_mode == F_IMP_SENSE_ON ){Setbit(UD.led_mode, LED_IMP_SENSE);}
_0x400AD:
	__GETB2MN _UD,10
	CPI  R26,LOW(0x7)
	BRNE _0x400AF
	__GETB1MN _UD,1
	ORI  R30,1
_0x400BF:
	__PUTB1MN _UD,1
; 0002 02E8 }
_0x400AF:
	RET
; .FEND
;
;
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __TIME_H__
;#include "time.h"
;#endif
;
;
;#ifndef __FND_H__
;#include "fnd.h"
;#endif
;
;#ifndef __ENCODER_H__
;#include "encoder.h"
;#endif
;
;#ifndef __BUZZER_H__
;#include "buzzer.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#ifndef __EEPROM_H__
;#include "eeprom.h"
;#endif
;
;/*
;#ifndef __IO_H__
;#include "io.h"
;#endif
;
;
;*/
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;BaseTimerCount          Time;
;TIMEFLAG                TF;
;
;volatile Uchar timer0_count;
;volatile Uchar blink_flag,blink_warring_flag;
;volatile Uchar impedance_check_time=0;
;
;
;Uint buzzer_freq,buzzer_data;
;
;extern volatile Uchar gFlag_maintime;
;extern volatile Uint currentperiod;
;extern volatile Uchar  buzzeractionflag;
;extern volatile Uchar buzzer_cut_hand_flag,buzzer_coa_hand_flag,buzzer_cut_foot_flag,buzzer_coa_foot_flag,buzzer_bip_fla ...
;extern volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,bu ...
;extern volatile Uchar impedance_check_flag;
;extern UART_DATA UD;
;extern BYTE gReadIntTempFlag;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;void TIME_TimeControl( void )
; 0003 0041 {

	.CSEG
_TIME_TimeControl:
; .FSTART _TIME_TimeControl
; 0003 0042     TF.Bflag &= 0xC0;
	LDS  R30,_TF
	ANDI R30,LOW(0xC0)
	STS  _TF,R30
; 0003 0043 
; 0003 0044     if(++Time.time1count != MSEC100) return;
	LDS  R26,_Time
	SUBI R26,-LOW(1)
	STS  _Time,R26
	CPI  R26,LOW(0xA)
	BREQ _0x60003
	RET
; 0003 0045     Time.time1count = 0;
_0x60003:
	LDI  R30,LOW(0)
	STS  _Time,R30
; 0003 0046     TF.flag.msec100flag = 1;
	LDS  R30,_TF
	ORI  R30,1
	STS  _TF,R30
; 0003 0047 
; 0003 0048     if(++Time.time2count != MSEC500) return;
	__GETB1MN _Time,1
	SUBI R30,-LOW(1)
	__PUTB1MN _Time,1
	CPI  R30,LOW(0x5)
	BREQ _0x60004
	RET
; 0003 0049     Time.time2count = 0;
_0x60004:
	LDI  R30,LOW(0)
	__PUTB1MN _Time,1
; 0003 004A     TF.flag.msec500flag=1;
	LDS  R30,_TF
	ORI  R30,2
	STS  _TF,R30
; 0003 004B 
; 0003 004C     if(++Time.time3count != SEC) return;
	__GETB1MN _Time,2
	SUBI R30,-LOW(1)
	__PUTB1MN _Time,2
	CPI  R30,LOW(0x2)
	BREQ _0x60005
	RET
; 0003 004D     Time.time3count = 0;
_0x60005:
	LDI  R30,LOW(0)
	__PUTB1MN _Time,2
; 0003 004E     TF.flag.secflag=1;
	LDS  R30,_TF
	ORI  R30,4
	STS  _TF,R30
; 0003 004F 
; 0003 0050     if(++Time.time4count != MIN) return;
	__GETB1MN _Time,3
	SUBI R30,-LOW(1)
	__PUTB1MN _Time,3
	CPI  R30,LOW(0x3C)
	BREQ _0x60006
	RET
; 0003 0051     Time.time4count = 0;
_0x60006:
	LDI  R30,LOW(0)
	__PUTB1MN _Time,3
; 0003 0052     TF.flag.minflag=1;
	LDS  R30,_TF
	ORI  R30,8
	STS  _TF,R30
; 0003 0053 
; 0003 0054     if(++Time.time5count != MIN10) return;
	__GETB1MN _Time,4
	SUBI R30,-LOW(1)
	__PUTB1MN _Time,4
	CPI  R30,LOW(0xA)
	BREQ _0x60007
	RET
; 0003 0055     Time.time5count = 0;
_0x60007:
	LDI  R30,LOW(0)
	__PUTB1MN _Time,4
; 0003 0056     TF.flag.min10flag=1;
	LDS  R30,_TF
	ORI  R30,0x10
	STS  _TF,R30
; 0003 0057 
; 0003 0058     if(++Time.time6count != HOUR) return;
	__GETB1MN _Time,5
	SUBI R30,-LOW(1)
	__PUTB1MN _Time,5
	CPI  R30,LOW(0x6)
	BREQ _0x60008
	RET
; 0003 0059     Time.time6count = 0;
_0x60008:
	LDI  R30,LOW(0)
	__PUTB1MN _Time,5
; 0003 005A     TF.flag.hourflag=1;
	LDS  R30,_TF
	ORI  R30,0x20
	STS  _TF,R30
; 0003 005B }
	RET
; .FEND
;
;void TIME_TimeCalculatorControl( void )
; 0003 005E {
_TIME_TimeCalculatorControl:
; .FSTART _TIME_TimeCalculatorControl
; 0003 005F     BUZZER_action();
	CALL _BUZZER_action
; 0003 0060 
; 0003 0061     if( TF.flag.secflag )
	LDS  R30,_TF
	ANDI R30,LOW(0x4)
; 0003 0062     {
; 0003 0063 
; 0003 0064     }
; 0003 0065     if(TF.flag.msec100flag)
	LDS  R30,_TF
	ANDI R30,LOW(0x1)
	BREQ _0x6000A
; 0003 0066     {
; 0003 0067       Eeprom_Write_Control_Proc();//100ms마다 data 확인
	CALL _Eeprom_Write_Control_Proc
; 0003 0068     }
; 0003 0069     if(TF.flag.msec500flag)
_0x6000A:
	LDS  R30,_TF
	ANDI R30,LOW(0x2)
	BRNE PC+2
	RJMP _0x6000B
; 0003 006A     {
; 0003 006B         gReadIntTempFlag = ON;
	LDI  R30,LOW(1)
	STS  _gReadIntTempFlag,R30
; 0003 006C 
; 0003 006D         if( UD.startflag==RUN )
	__GETB2MN _UD,12
	CPI  R26,LOW(0x1)
	BRNE _0x6000C
; 0003 006E         {
; 0003 006F             if(UD.bipol_foot_start==RUN)
	__GETB2MN _UD,5
	CPI  R26,LOW(0x1)
	BRNE _0x6000D
; 0003 0070             {
; 0003 0071                 if(impedance_check_time>=2)
	LDS  R26,_impedance_check_time
	CPI  R26,LOW(0x2)
	BRLO _0x6000E
; 0003 0072                 {
; 0003 0073                     impedance_check_time=2;
	LDI  R30,LOW(2)
	STS  _impedance_check_time,R30
; 0003 0074                     impedance_check_flag=ON;
	LDI  R30,LOW(1)
	STS  _impedance_check_flag,R30
; 0003 0075                 }
; 0003 0076                 else
	RJMP _0x6000F
_0x6000E:
; 0003 0077                 {
; 0003 0078                     impedance_check_time++;
	LDS  R30,_impedance_check_time
	SUBI R30,-LOW(1)
	STS  _impedance_check_time,R30
; 0003 0079                 }
_0x6000F:
; 0003 007A             }
; 0003 007B         }
_0x6000D:
; 0003 007C         else
	RJMP _0x60010
_0x6000C:
; 0003 007D         {
; 0003 007E             impedance_check_time=0;
	LDI  R30,LOW(0)
	STS  _impedance_check_time,R30
; 0003 007F             impedance_check_flag=OFF;
	STS  _impedance_check_flag,R30
; 0003 0080         }
_0x60010:
; 0003 0081 
; 0003 0082         //
; 0003 0083         if(UD.startflag==RUN)
	__GETB2MN _UD,12
	CPI  R26,LOW(0x1)
	BRNE _0x60011
; 0003 0084         {
; 0003 0085             if(blink_flag == OFF)
	LDS  R30,_blink_flag
	CPI  R30,0
	BRNE _0x60012
; 0003 0086             {
; 0003 0087                 blink_flag = ON;
	LDI  R30,LOW(1)
	CALL SUBOPT_0xA
; 0003 0088                 Clrbit(STATUS_LED_PORT, ACTIVE_LED);//active low
	ANDI R30,0x7F
	RJMP _0x60042
; 0003 0089             }
; 0003 008A             else if(blink_flag == ON)
_0x60012:
	LDS  R26,_blink_flag
	CPI  R26,LOW(0x1)
	BRNE _0x60014
; 0003 008B             {
; 0003 008C                 blink_flag = OFF;
	LDI  R30,LOW(0)
	CALL SUBOPT_0xA
; 0003 008D                 Setbit(STATUS_LED_PORT, ACTIVE_LED);//active low
	ORI  R30,0x80
_0x60042:
	STS  98,R30
; 0003 008E             }
; 0003 008F         }
_0x60014:
; 0003 0090         else
	RJMP _0x60015
_0x60011:
; 0003 0091         {
; 0003 0092             blink_flag = OFF;
	LDI  R30,LOW(0)
	CALL SUBOPT_0xA
; 0003 0093             Setbit(STATUS_LED_PORT, ACTIVE_LED);//active low
	ORI  R30,0x80
	STS  98,R30
; 0003 0094         }
_0x60015:
; 0003 0095 
; 0003 0096         if(UD.warning_status==WARNING_ON)
	CALL SUBOPT_0xB
	SBIW R26,1
	BRNE _0x60016
; 0003 0097         {
; 0003 0098             Clrbit(STATUS_LED_PORT, WARNING_LED);//active low
	LDS  R30,98
	ANDI R30,0xBF
	RJMP _0x60043
; 0003 0099         }
; 0003 009A         else if(UD.warning_status==WARNING_OFF)
_0x60016:
	__GETW1MN _UD,16
	SBIW R30,0
	BREQ _0x60044
; 0003 009B         {
; 0003 009C              Setbit(STATUS_LED_PORT, WARNING_LED);//active low
; 0003 009D         }
; 0003 009E         else if(UD.warning_status==WARNING_BLINK_ON)
	CALL SUBOPT_0xB
	SBIW R26,3
	BRNE _0x6001A
; 0003 009F         {
; 0003 00A0             if(blink_warring_flag == OFF)
	LDS  R30,_blink_warring_flag
	CPI  R30,0
	BRNE _0x6001B
; 0003 00A1             {
; 0003 00A2                 blink_warring_flag = ON;
	LDI  R30,LOW(1)
	STS  _blink_warring_flag,R30
; 0003 00A3                 Clrbit(STATUS_LED_PORT, WARNING_LED);//active low
	LDS  R30,98
	ANDI R30,0xBF
	RJMP _0x60045
; 0003 00A4             }
; 0003 00A5             else if(blink_warring_flag == ON)
_0x6001B:
	LDS  R26,_blink_warring_flag
	CPI  R26,LOW(0x1)
	BRNE _0x6001D
; 0003 00A6             {
; 0003 00A7                 blink_warring_flag = OFF;
	LDI  R30,LOW(0)
	STS  _blink_warring_flag,R30
; 0003 00A8                 Setbit(STATUS_LED_PORT, WARNING_LED);//active low
	LDS  R30,98
	ORI  R30,0x40
_0x60045:
	STS  98,R30
; 0003 00A9             }
; 0003 00AA         }
_0x6001D:
; 0003 00AB         else if(UD.warning_status==WARNING_BLINK_OFF)
	RJMP _0x6001E
_0x6001A:
	CALL SUBOPT_0xB
	SBIW R26,2
	BRNE _0x6001F
; 0003 00AC         {
; 0003 00AD               blink_warring_flag = OFF;
	LDI  R30,LOW(0)
	STS  _blink_warring_flag,R30
; 0003 00AE              Setbit(STATUS_LED_PORT, WARNING_LED);//active low
_0x60044:
	LDS  R30,98
	ORI  R30,0x40
_0x60043:
	STS  98,R30
; 0003 00AF         }
; 0003 00B0 
; 0003 00B1     }
_0x6001F:
_0x6001E:
; 0003 00B2 }
_0x6000B:
	RET
; .FEND
;
;//******************************************************************************
;Uint TIME_CountInit(void)
; 0003 00B6 {
_TIME_CountInit:
; .FSTART _TIME_CountInit
; 0003 00B7     TIMSK   = 0x45;
	LDI  R30,LOW(69)
	OUT  0x37,R30
; 0003 00B8 
; 0003 00B9     TCCR0   = 0x04;         // CS12:0(bit2:0) 64(100) -> 64/Clk
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0003 00BA     TCNT0   = 0xe6;         // 64/16=4 100/4 = 25=0x19 0xff-0x19=0xe6 100us
	LDI  R30,LOW(230)
	OUT  0x32,R30
; 0003 00BB 
; 0003 00BC     TCCR1A  = 0x00;         // Timer/Counter 1 Control Register
	LDI  R30,LOW(0)
	OUT  0x2F,R30
; 0003 00BD     TCCR1B  = 0x03;         // 64/16= 4 10000/4 = 2500    ==>0x09c4  0xffff-0x09c4= 0xf63b          10ms
	LDI  R30,LOW(3)
	OUT  0x2E,R30
; 0003 00BE                             // 64/16= 4 1000/4 = 250    ==>0x0fa  0xffff-0x00fa= 0xff05          1ms
; 0003 00BF     TCNT1   = 0xf63b;
	LDI  R30,LOW(63035)
	LDI  R31,HIGH(63035)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
; 0003 00C0 
; 0003 00C1 
; 0003 00C2     TCCR2   = 0x04;         // 8/16 = 0.5  10/0.5 = 20 = 0x14  0xff-0x14=0xeb 10us
	LDI  R30,LOW(4)
	OUT  0x25,R30
; 0003 00C3     TCNT2   =0xeb;// 0xfd;
	LDI  R30,LOW(235)
	OUT  0x24,R30
; 0003 00C4 
; 0003 00C5 
; 0003 00C6    // ETIFR=0x04;
; 0003 00C7     TCCR3A=0x32;
	CALL SUBOPT_0xC
; 0003 00C8     TCCR3B=0x1A;
; 0003 00C9 
; 0003 00CA     //freq set
; 0003 00CB     ICR3H=0x00;
; 0003 00CC     ICR3L=0x3C;//33khz
; 0003 00CD 
; 0003 00CE     //duty set
; 0003 00CF     OCR3BH=0x00;
; 0003 00D0     OCR3BL=0x3a;
	LDI  R30,LOW(58)
	STS  132,R30
; 0003 00D1 
; 0003 00D2     return TIMER_ERR_NONE;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RET
; 0003 00D3 }
; .FEND
;
;//******************************************************************************
;void TIME_pwm_33Khz_setting(Uchar mode)
; 0003 00D7 {
_TIME_pwm_33Khz_setting:
; .FSTART _TIME_pwm_33Khz_setting
; 0003 00D8 //    TCCR3A=0x32;
; 0003 00D9 //    TCCR3B=0x1A;
; 0003 00DA 
; 0003 00DB     switch(mode)
	ST   -Y,R26
;	mode -> Y+0
	LD   R30,Y
; 0003 00DC     {
; 0003 00DD         case F_BLEND_OFF:
	CPI  R30,LOW(0x1)
	BRNE _0x60023
; 0003 00DE                         TCCR3A=0x02;
	CALL SUBOPT_0xD
; 0003 00DF                         Setbit(PWM_33KHZ_PORT, PWM_33KHZ);
; 0003 00E0                         break;
	RJMP _0x60022
; 0003 00E1         case F_BLEND_1:
_0x60023:
	CPI  R30,LOW(0x2)
	BRNE _0x60024
; 0003 00E2                         TCCR3A=0x32;
	CALL SUBOPT_0xC
; 0003 00E3                         TCCR3B=0x1A;
; 0003 00E4                         //freq set
; 0003 00E5                         ICR3H=0x00;
; 0003 00E6                         ICR3L=0x3C;//33khz
; 0003 00E7 
; 0003 00E8                         //duty set
; 0003 00E9                         OCR3BH=0x00;
; 0003 00EA                         OCR3BL=0x0c;
	LDI  R30,LOW(12)
	STS  132,R30
; 0003 00EB                         break;
	RJMP _0x60022
; 0003 00EC         case F_BLEND_2:
_0x60024:
	CPI  R30,LOW(0x3)
	BRNE _0x60025
; 0003 00ED                         TCCR3A=0x32;
	CALL SUBOPT_0xC
; 0003 00EE                         TCCR3B=0x1A;
; 0003 00EF                         //freq set
; 0003 00F0                         ICR3H=0x00;
; 0003 00F1                         ICR3L=0x3C;//33khz
; 0003 00F2 
; 0003 00F3                         //duty set
; 0003 00F4                         OCR3BH=0x00;
; 0003 00F5                         OCR3BL=0x1E;
	LDI  R30,LOW(30)
	STS  132,R30
; 0003 00F6                         break;
	RJMP _0x60022
; 0003 00F7         case F_CONTACT:
_0x60025:
	CPI  R30,LOW(0x4)
	BRNE _0x60026
; 0003 00F8                         TCCR3A=0x32;
	CALL SUBOPT_0xC
; 0003 00F9                         TCCR3B=0x1A;
; 0003 00FA                         //freq set
; 0003 00FB                         ICR3H=0x00;
; 0003 00FC                         //2016-01-22
; 0003 00FD                         ICR3L=0x3C;//33khz
; 0003 00FE                         //ICR3L=0x2E;//43khz
; 0003 00FF 
; 0003 0100                         //duty set
; 0003 0101                         OCR3BH=0x00;
; 0003 0102                         //OCR3BL=0x38;
; 0003 0103                         OCR3BL=0x2C;  //2016-01-22
	LDI  R30,LOW(44)
	STS  132,R30
; 0003 0104                         break;
	RJMP _0x60022
; 0003 0105         case F_SPRAY:
_0x60026:
	CPI  R30,LOW(0x5)
	BRNE _0x60027
; 0003 0106                         TCCR3A=0x32;
	CALL SUBOPT_0xC
; 0003 0107                         TCCR3B=0x1A;
; 0003 0108                         //freq set
; 0003 0109                         ICR3H=0x00;
; 0003 010A                         ICR3L=0x3C;//33khz
; 0003 010B 
; 0003 010C                         //duty set
; 0003 010D                         OCR3BH=0x00;
; 0003 010E                         OCR3BL=0x31; // 2016-01-22 org : 0x2E
	LDI  R30,LOW(49)
	STS  132,R30
; 0003 010F                         break;
	RJMP _0x60022
; 0003 0110         case F_IMP_SENSE_OFF:
_0x60027:
	CPI  R30,LOW(0x6)
	BRNE _0x60028
; 0003 0111                         TCCR3A=0x02;
	CALL SUBOPT_0xD
; 0003 0112                         Setbit(PWM_33KHZ_PORT, PWM_33KHZ);
; 0003 0113                         break;
	RJMP _0x60022
; 0003 0114         case F_IMP_SENSE_ON:
_0x60028:
	CPI  R30,LOW(0x7)
	BRNE _0x60029
; 0003 0115                         TCCR3A=0x02;
	CALL SUBOPT_0xD
; 0003 0116                         Setbit(PWM_33KHZ_PORT, PWM_33KHZ);
; 0003 0117                         break;
	RJMP _0x60022
; 0003 0118         case F_TOTAL_STOP:
_0x60029:
	CPI  R30,LOW(0x8)
	BRNE _0x60022
; 0003 0119                         TCCR3A=0x02;
	LDI  R30,LOW(2)
	STS  139,R30
; 0003 011A                         Clrbit(PWM_33KHZ_PORT, PWM_33KHZ);
	CBI  0x3,4
; 0003 011B                         break;
; 0003 011C     }
_0x60022:
; 0003 011D 
; 0003 011E 
; 0003 011F }
_0x20A0012:
	ADIW R28,1
	RET
; .FEND
;
;//******************************************************************************
;// Interrupt Functions
;//******************************************************************************
;interrupt [TIM0_OVF] void TIMER0_OVF_vect_Proc(void)
; 0003 0125  {
_TIMER0_OVF_vect_Proc:
; .FSTART _TIMER0_OVF_vect_Proc
	CALL SUBOPT_0xE
; 0003 0126     TCNT0   = 0xe6;
	LDI  R30,LOW(230)
	OUT  0x32,R30
; 0003 0127     if(UD.startflag==STOP){ ENCODER();}
	__GETB1MN _UD,12
	CPI  R30,0
	BRNE _0x6002B
	CALL _ENCODER
; 0003 0128 
; 0003 0129     if(buzzer_up_flag || buzzer_down_flag || buzzer_start_flag||buzzer_plate_alram_flag||buzzer_fan_error_flag||buzzer_o ...
_0x6002B:
	LDS  R30,_buzzer_up_flag
	CPI  R30,0
	BRNE _0x6002D
	LDS  R30,_buzzer_down_flag
	CPI  R30,0
	BRNE _0x6002D
	LDS  R30,_buzzer_start_flag
	CPI  R30,0
	BRNE _0x6002D
	LDS  R30,_buzzer_plate_alram_flag
	CPI  R30,0
	BRNE _0x6002D
	LDS  R30,_buzzer_fan_error_flag
	CPI  R30,0
	BRNE _0x6002D
	LDS  R30,_buzzer_over_watt_flag
	CPI  R30,0
	BREQ _0x6002C
_0x6002D:
; 0003 012A     {
; 0003 012B         if(timer0_count>currentperiod)
	LDS  R30,_currentperiod
	LDS  R31,_currentperiod+1
	LDS  R26,_timer0_count
	LDI  R27,0
	CP   R30,R26
	CPC  R31,R27
	BRSH _0x6002F
; 0003 012C         {
; 0003 012D             timer0_count=0;
	LDI  R30,LOW(0)
	STS  _timer0_count,R30
; 0003 012E             if(buzzeractionflag)
	LDS  R30,_buzzeractionflag
	CPI  R30,0
	BREQ _0x60030
; 0003 012F             {
; 0003 0130                 SPEAKER_PORT ^= BUZZERMASK;
	IN   R30,0x18
	LDI  R26,LOW(16)
	EOR  R30,R26
	OUT  0x18,R30
; 0003 0131             }
; 0003 0132         }
_0x60030:
; 0003 0133         else
	RJMP _0x60031
_0x6002F:
; 0003 0134         {
; 0003 0135             timer0_count++;
	LDS  R30,_timer0_count
	SUBI R30,-LOW(1)
	STS  _timer0_count,R30
; 0003 0136         }
_0x60031:
; 0003 0137     }
; 0003 0138     else if(buzzer_cut_hand_flag || buzzer_coa_hand_flag ||buzzer_cut_foot_flag || buzzer_coa_foot_flag || buzzer_bip_fl ...
	RJMP _0x60032
_0x6002C:
	LDS  R30,_buzzer_cut_hand_flag
	CPI  R30,0
	BRNE _0x60034
	LDS  R30,_buzzer_coa_hand_flag
	CPI  R30,0
	BRNE _0x60034
	LDS  R30,_buzzer_cut_foot_flag
	CPI  R30,0
	BRNE _0x60034
	LDS  R30,_buzzer_coa_foot_flag
	CPI  R30,0
	BRNE _0x60034
	LDS  R30,_buzzer_bip_flag
	CPI  R30,0
	BREQ _0x60033
_0x60034:
; 0003 0139     {
; 0003 013A         if(buzzer_cut_hand_flag||buzzer_cut_foot_flag){buzzer_data=12;}//500hz
	LDS  R30,_buzzer_cut_hand_flag
	CPI  R30,0
	BRNE _0x60037
	LDS  R30,_buzzer_cut_foot_flag
	CPI  R30,0
	BREQ _0x60036
_0x60037:
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	RJMP _0x60046
; 0003 013B         else if(buzzer_coa_hand_flag||buzzer_coa_foot_flag){buzzer_data=15;}//400hz
_0x60036:
	LDS  R30,_buzzer_coa_hand_flag
	CPI  R30,0
	BRNE _0x6003B
	LDS  R30,_buzzer_coa_foot_flag
	CPI  R30,0
	BREQ _0x6003A
_0x6003B:
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	RJMP _0x60046
; 0003 013C         else if(buzzer_bip_flag){buzzer_data=20;}//300hz
_0x6003A:
	LDS  R30,_buzzer_bip_flag
	CPI  R30,0
	BREQ _0x6003E
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
_0x60046:
	MOVW R12,R30
; 0003 013D 
; 0003 013E         if(++buzzer_freq >=buzzer_data){buzzer_freq=0;}
_0x6003E:
	MOVW R30,R10
	ADIW R30,1
	MOVW R10,R30
	CP   R30,R12
	CPC  R31,R13
	BRLO _0x6003F
	CLR  R10
	CLR  R11
; 0003 013F         if(buzzer_freq <(buzzer_data/2)){Setbit(SPEAKER_PORT, SPEAKER);}
_0x6003F:
	MOVW R30,R12
	LSR  R31
	ROR  R30
	CP   R10,R30
	CPC  R11,R31
	BRSH _0x60040
	SBI  0x18,4
; 0003 0140         else{Clrbit(SPEAKER_PORT,SPEAKER);}
	RJMP _0x60041
_0x60040:
	CBI  0x18,4
_0x60041:
; 0003 0141 
; 0003 0142     }
; 0003 0143  }
_0x60033:
_0x60032:
	RJMP _0x60047
; .FEND
;
;interrupt [TIM1_OVF] void TIMER1_OVF_vect_Proc(void)
; 0003 0146  {
_TIMER1_OVF_vect_Proc:
; .FSTART _TIMER1_OVF_vect_Proc
	ST   -Y,R30
	ST   -Y,R31
; 0003 0147     TCNT1   = 0xf63b;
	LDI  R30,LOW(63035)
	LDI  R31,HIGH(63035)
	OUT  0x2C+1,R31
	OUT  0x2C,R30
; 0003 0148     gFlag_maintime=1;
	LDI  R30,LOW(1)
	STS  _gFlag_maintime,R30
; 0003 0149  }
	LD   R31,Y+
	LD   R30,Y+
	RETI
; .FEND
;
;interrupt [TIM2_OVF] void TIM2_OVF_vect_Proc(void)
; 0003 014C  {
_TIM2_OVF_vect_Proc:
; .FSTART _TIM2_OVF_vect_Proc
	CALL SUBOPT_0xE
; 0003 014D     TCNT2   = 0xeb;
	LDI  R30,LOW(235)
	OUT  0x24,R30
; 0003 014E     Fnd_Display_Schedule();
	RCALL _Fnd_Display_Schedule
; 0003 014F  }
_0x60047:
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	LD   R25,Y+
	LD   R24,Y+
	LD   R23,Y+
	LD   R22,Y+
	LD   R15,Y+
	LD   R1,Y+
	LD   R0,Y+
	RETI
; .FEND
;
;
;
;
;
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __FND_H__
;#include "fnd.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#include "../I2CLib/I2CLib.h"
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;
;Uchar count=0;
;const char FndNum[10]={0x3f,0x06,0x5b,0x4f,0x66,0x6d,0x7d,0x07,0x7f,0x6f};
;const char FndHigh[3] = { 0x40, 0x76, 0x40 };
;BYTE DspMem[10]={0,0,0,0,0,0,0,0,0,0};
;extern UART_DATA UD;
;extern int gCurTemp;
;extern int gExtTemp;
;extern int gVoltage;
;extern int gCurrent;
;//extern volatile Uint imp_value,imp_vol,imp_cur;
;
;void DSP_ShiftOut( BYTE dat );               /* Data Shift Out  */
;void Sel_ShiftOut( BYTE bSel, BYTE bDat );
;void DspDatToMemory( void );
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;
;void DSP_ShiftOut( BYTE dat )
; 0004 002A {

	.CSEG
_DSP_ShiftOut:
; .FSTART _DSP_ShiftOut
; 0004 002B      BYTE i,temp;
; 0004 002C 
; 0004 002D      for( i=0; i<8; i++ )
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	dat -> Y+2
;	i -> R17
;	temp -> R16
	LDI  R17,LOW(0)
_0x80004:
	CPI  R17,8
	BRSH _0x80005
; 0004 002E      {
; 0004 002F         /* right shift */
; 0004 0030         temp = dat & ( 0x80>>i );
	CALL SUBOPT_0xF
; 0004 0031 
; 0004 0032        if( temp ){   HIGH_DSP_DAT; }
	BREQ _0x80006
	LDS  R30,101
	ORI  R30,4
	RJMP _0x8003E
; 0004 0033        else{         LOW_DSP_DAT;   }
_0x80006:
	LDS  R30,101
	ANDI R30,0xFB
_0x8003E:
	STS  101,R30
; 0004 0034 
; 0004 0035        HIGH_DSP_CLK;
	SBI  0x15,7
; 0004 0036 
; 0004 0037        LOW_DSP_CLK;
	CBI  0x15,7
; 0004 0038 
; 0004 0039      }
	SUBI R17,-1
	RJMP _0x80004
_0x80005:
; 0004 003A }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,3
	RET
; .FEND
;
;void Sel_ShiftOut( BYTE bSel, BYTE bDat )
; 0004 003D {
_Sel_ShiftOut:
; .FSTART _Sel_ShiftOut
; 0004 003E    DSP_ShiftOut( bDat );
	ST   -Y,R26
;	bSel -> Y+1
;	bDat -> Y+0
	LD   R26,Y
	RCALL _DSP_ShiftOut
; 0004 003F 
; 0004 0040    if( bSel == 0 )
	LDD  R30,Y+1
	CPI  R30,0
	BRNE _0x8000C
; 0004 0041    {
; 0004 0042       HIGH_DSP_STR1;
	SBI  0x15,4
; 0004 0043       LOW_DSP_STR1;
	CBI  0x15,4
; 0004 0044    }
; 0004 0045    else if( bSel == 1 )
	RJMP _0x80011
_0x8000C:
	LDD  R26,Y+1
	CPI  R26,LOW(0x1)
	BRNE _0x80012
; 0004 0046    {
; 0004 0047       HIGH_DSP_STR2;
	SBI  0x15,5
; 0004 0048       LOW_DSP_STR2;
	CBI  0x15,5
; 0004 0049    }
; 0004 004A    else if( bSel == 2 )
	RJMP _0x80017
_0x80012:
	LDD  R26,Y+1
	CPI  R26,LOW(0x2)
	BRNE _0x80018
; 0004 004B    {
; 0004 004C       HIGH_DSP_STR3;
	SBI  0x1B,7
; 0004 004D       LOW_DSP_STR3;
	CBI  0x1B,7
; 0004 004E    }
; 0004 004F }
_0x80018:
_0x80017:
_0x80011:
	ADIW R28,2
	RET
; .FEND
;
;void DspDatToMemory( void )
; 0004 0052 {
_DspDatToMemory:
; .FSTART _DspDatToMemory
; 0004 0053     Uchar temp,temp1;
; 0004 0054     /*
; 0004 0055     if(UD.cut_mode == F_BLEND_OFF)
; 0004 0056     {
; 0004 0057         temp = UD.cut_blend_off_power/100;
; 0004 0058         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 0059         else temp1 = 0;
; 0004 005A 
; 0004 005B         DspMem[1] = temp1;
; 0004 005C 
; 0004 005D         temp  = UD.cut_blend_off_power%100;
; 0004 005E         if( (temp/10) > 0 ||temp1!=0) temp1 = FndNum[temp/10];
; 0004 005F         else temp1 = 0;
; 0004 0060         DspMem[2] = temp1;
; 0004 0061 
; 0004 0062         DspMem[3] = FndNum[temp%10];
; 0004 0063 
; 0004 0064     }
; 0004 0065     else if(UD.cut_mode == F_BLEND_1)
; 0004 0066     {
; 0004 0067         temp = UD.cut_blend_1_power/100;
; 0004 0068         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 0069         else temp1 = 0;
; 0004 006A 
; 0004 006B         DspMem[1] = temp1;
; 0004 006C 
; 0004 006D         temp  = UD.cut_blend_1_power%100;
; 0004 006E         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
; 0004 006F         else temp1 = 0;
; 0004 0070         DspMem[2] = temp1;
; 0004 0071 
; 0004 0072         DspMem[3] = FndNum[temp%10];
; 0004 0073     }
; 0004 0074     else
; 0004 0075     {
; 0004 0076         temp = UD.cut_blend_2_power/100;
; 0004 0077         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 0078         else temp1 = 0;
; 0004 0079 
; 0004 007A         DspMem[1] = temp1;
; 0004 007B 
; 0004 007C         temp  = UD.cut_blend_2_power%100;
; 0004 007D         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
; 0004 007E         else temp1 = 0;
; 0004 007F         DspMem[2] = temp1;
; 0004 0080 
; 0004 0081         DspMem[3] = FndNum[temp%10];
; 0004 0082     }
; 0004 0083     */
; 0004 0084 
; 0004 0085         temp = UD.imp_sense_power/100;
	ST   -Y,R17
	ST   -Y,R16
;	temp -> R17
;	temp1 -> R16
	CALL SUBOPT_0x10
	CALL SUBOPT_0x11
; 0004 0086         if( temp > 0 ) temp1 = FndNum[temp];
	BRLO _0x8001D
	CALL SUBOPT_0x12
; 0004 0087         else temp1 = 0;
	RJMP _0x8001E
_0x8001D:
	LDI  R16,LOW(0)
; 0004 0088 
; 0004 0089         DspMem[1] = temp1;
_0x8001E:
	__PUTBMRN _DspMem,1,16
; 0004 008A 
; 0004 008B         temp  = UD.imp_sense_power%100;
	CALL SUBOPT_0x10
	CALL SUBOPT_0x13
; 0004 008C         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
	BRNE _0x80020
	CPI  R16,0
	BREQ _0x8001F
_0x80020:
	CALL SUBOPT_0x14
; 0004 008D         else temp1 = 0;
	RJMP _0x80022
_0x8001F:
	LDI  R16,LOW(0)
; 0004 008E         DspMem[2] = temp1;
_0x80022:
	__PUTBMRN _DspMem,2,16
; 0004 008F 
; 0004 0090         DspMem[3] = FndNum[temp%10];
	CALL SUBOPT_0x15
	LPM  R0,Z
	__PUTBR0MN _DspMem,3
; 0004 0091 
; 0004 0092         if( gExtTemp > 1000 )
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CP   R30,R4
	CPC  R31,R5
	BRGE _0x80023
; 0004 0093         {
; 0004 0094           DspMem[4] = FndHigh[0];
	LDI  R30,LOW(_FndHigh*2)
	LDI  R31,HIGH(_FndHigh*2)
	LPM  R0,Z
	__PUTBR0MN _DspMem,4
; 0004 0095           DspMem[5] = FndHigh[1];
	__POINTW1FN _FndHigh,1
	LPM  R0,Z
	__PUTBR0MN _DspMem,5
; 0004 0096           DspMem[6] = FndHigh[2];
	__POINTW1FN _FndHigh,2
	RJMP _0x8003F
; 0004 0097         }
; 0004 0098         else
_0x80023:
; 0004 0099         {
; 0004 009A           temp = gExtTemp/1000;
	MOVW R26,R4
	LDI  R30,LOW(1000)
	LDI  R31,HIGH(1000)
	CALL SUBOPT_0x11
; 0004 009B           if( temp > 0 ) temp1 = FndNum[temp];
	BRLO _0x80025
	CALL SUBOPT_0x12
; 0004 009C           else temp1 = 0;
	RJMP _0x80026
_0x80025:
	LDI  R16,LOW(0)
; 0004 009D 
; 0004 009E           DspMem[4] = temp1;
_0x80026:
	__PUTBMRN _DspMem,4,16
; 0004 009F 
; 0004 00A0           temp  = (gExtTemp/10)%100;
	MOVW R26,R4
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	MOVW R26,R30
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL SUBOPT_0x13
; 0004 00A1           if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
	BRNE _0x80028
	CPI  R16,0
	BREQ _0x80027
_0x80028:
	CALL SUBOPT_0x14
; 0004 00A2           else temp1 = 0;
	RJMP _0x8002A
_0x80027:
	LDI  R16,LOW(0)
; 0004 00A3           DspMem[5] = temp1;
_0x8002A:
	__PUTBMRN _DspMem,5,16
; 0004 00A4 
; 0004 00A5           DspMem[6] = FndNum[temp%10];
	CALL SUBOPT_0x15
_0x8003F:
	LPM  R0,Z
	__PUTBR0MN _DspMem,6
; 0004 00A6         }
; 0004 00A7         //
; 0004 00A8 
; 0004 00A9         temp = UD.coa_contact_power/100;
	CALL SUBOPT_0x16
	CALL SUBOPT_0x11
; 0004 00AA         if( temp > 0 ) temp1 = FndNum[temp];
	BRLO _0x8002B
	CALL SUBOPT_0x12
; 0004 00AB         else temp1 = 0;
	RJMP _0x8002C
_0x8002B:
	LDI  R16,LOW(0)
; 0004 00AC 
; 0004 00AD         DspMem[7] = temp1;
_0x8002C:
	__PUTBMRN _DspMem,7,16
; 0004 00AE 
; 0004 00AF         temp  = UD.coa_contact_power%100;
	CALL SUBOPT_0x16
	CALL SUBOPT_0x13
; 0004 00B0         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
	BRNE _0x8002E
	CPI  R16,0
	BREQ _0x8002D
_0x8002E:
	CALL SUBOPT_0x14
; 0004 00B1         else temp1 = 0;
	RJMP _0x80030
_0x8002D:
	LDI  R16,LOW(0)
; 0004 00B2         DspMem[8] = temp1;
_0x80030:
	__PUTBMRN _DspMem,8,16
; 0004 00B3 
; 0004 00B4         DspMem[9] = FndNum[temp%10];
	CALL SUBOPT_0x15
	LPM  R0,Z
	__PUTBR0MN _DspMem,9
; 0004 00B5 
; 0004 00B6         /*
; 0004 00B7     if(UD.coa_mode == F_CONTACT)
; 0004 00B8     {
; 0004 00B9         temp = UD.coa_contact_power/100;
; 0004 00BA         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 00BB         else temp1 = 0;
; 0004 00BC 
; 0004 00BD         DspMem[4] = temp1;
; 0004 00BE 
; 0004 00BF         temp  = UD.coa_contact_power%100;
; 0004 00C0         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
; 0004 00C1         else temp1 = 0;
; 0004 00C2         DspMem[5] = temp1;
; 0004 00C3 
; 0004 00C4         DspMem[6] = FndNum[temp%10];
; 0004 00C5 
; 0004 00C6     }
; 0004 00C7     else
; 0004 00C8     {
; 0004 00C9         temp = UD.coa_spray_power/100;
; 0004 00CA         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 00CB         else temp1 = 0;
; 0004 00CC 
; 0004 00CD         DspMem[4] = temp1;
; 0004 00CE 
; 0004 00CF         temp  = UD.coa_spray_power%100;
; 0004 00D0         if( (temp/10) > 0||temp1!=0 ) temp1 = FndNum[temp/10];
; 0004 00D1         else temp1 = 0;
; 0004 00D2         DspMem[5] = temp1;
; 0004 00D3 
; 0004 00D4         DspMem[6] = FndNum[temp%10];
; 0004 00D5     }
; 0004 00D6     */
; 0004 00D7     /*
; 0004 00D8     if(UD.bipol_mode == F_IMP_SENSE_OFF)
; 0004 00D9     {
; 0004 00DA         temp = UD.imp_sense_power/100;
; 0004 00DB         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 00DC         else temp1 = 0;
; 0004 00DD 
; 0004 00DE         DspMem[7] = temp1;
; 0004 00DF 
; 0004 00E0         temp  = UD.imp_sense_power%100;
; 0004 00E1         if( (temp/10) > 0 ||temp1!=0) temp1 = FndNum[temp/10];
; 0004 00E2         else temp1 = 0;
; 0004 00E3         DspMem[8] = temp1;
; 0004 00E4 
; 0004 00E5         DspMem[9] = FndNum[temp%10];
; 0004 00E6     }
; 0004 00E7     else
; 0004 00E8     {
; 0004 00E9         temp = UD.imp_sense_power/100;
; 0004 00EA         if( temp > 0 ) temp1 = FndNum[temp];
; 0004 00EB         else temp1 = 0;
; 0004 00EC 
; 0004 00ED         DspMem[7] = temp1;
; 0004 00EE 
; 0004 00EF         temp  = UD.imp_sense_power%100;
; 0004 00F0         if( (temp/10) > 0 ||  temp1 !=0  ) temp1 = FndNum[temp/10];
; 0004 00F1         else temp1 = 0;
; 0004 00F2         DspMem[8] = temp1;
; 0004 00F3 
; 0004 00F4         DspMem[9] = FndNum[temp%10];
; 0004 00F5 
; 0004 00F6     }
; 0004 00F7     */
; 0004 00F8 
; 0004 00F9     DspMem[0] = UD.led_mode;
	__GETB1MN _UD,1
	STS  _DspMem,R30
; 0004 00FA }
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void Fnd_Display_Schedule( void )
; 0004 00FD {
_Fnd_Display_Schedule:
; .FSTART _Fnd_Display_Schedule
; 0004 00FE   if( count == 0 )
	LDS  R30,_count
	CPI  R30,0
	BRNE _0x80031
; 0004 00FF   {
; 0004 0100      DspDatToMemory();
	RCALL _DspDatToMemory
; 0004 0101 
; 0004 0102      Sel_ShiftOut( 1, 0 );
	CALL SUBOPT_0x17
; 0004 0103      HIGH_DSP_OE;
	SBI  0x15,6
; 0004 0104   }
; 0004 0105   else
	RJMP _0x80034
_0x80031:
; 0004 0106   {
; 0004 0107     LOW_DSP_OE;
	CBI  0x15,6
; 0004 0108   }
_0x80034:
; 0004 0109 
; 0004 010A   Sel_ShiftOut( 0,DspMem[count] );
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDS  R30,_count
	LDI  R31,0
	SUBI R30,LOW(-_DspMem)
	SBCI R31,HIGH(-_DspMem)
	LD   R26,Z
	RCALL _Sel_ShiftOut
; 0004 010B 
; 0004 010C   if( count == 0 )
	LDS  R30,_count
	CPI  R30,0
	BRNE _0x80037
; 0004 010D   {
; 0004 010E      Sel_ShiftOut( 1, 0 );
	CALL SUBOPT_0x17
; 0004 010F      Sel_ShiftOut( 2, 2 );
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(2)
	RJMP _0x80040
; 0004 0110   }
; 0004 0111   else if( count == 1 )
_0x80037:
	LDS  R26,_count
	CPI  R26,LOW(0x1)
	BRNE _0x80039
; 0004 0112   {
; 0004 0113      Sel_ShiftOut( 1, 0 );
	CALL SUBOPT_0x17
; 0004 0114      Sel_ShiftOut( 2, 1 );
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(1)
	RJMP _0x80040
; 0004 0115   }
; 0004 0116   else
_0x80039:
; 0004 0117   {
; 0004 0118      Sel_ShiftOut( 1, 0x80>>(count-2) );
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDS  R30,_count
	SUBI R30,LOW(2)
	LDI  R26,LOW(128)
	CALL __LSRB12
	MOV  R26,R30
	RCALL _Sel_ShiftOut
; 0004 0119      Sel_ShiftOut( 2, 0 );
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(0)
_0x80040:
	RCALL _Sel_ShiftOut
; 0004 011A   }
; 0004 011B 
; 0004 011C   count++;
	LDS  R30,_count
	SUBI R30,-LOW(1)
	STS  _count,R30
; 0004 011D   if( count > 9 ) count = 0;
	LDS  R26,_count
	CPI  R26,LOW(0xA)
	BRLO _0x8003B
	LDI  R30,LOW(0)
	STS  _count,R30
; 0004 011E 
; 0004 011F   HIGH_DSP_OE;
_0x8003B:
	SBI  0x15,6
; 0004 0120 }
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __ENCODER_H__
;#include "encoder.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;
;volatile int s1,s0,s2,s3,s4,s5;
;
;extern volatile Uchar cut_in_de_flag,coa_in_de_flag,bip_in_de_flag;
;extern UART_DATA UD;
;extern volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,bu ...
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;//******************************************************************************
;void ENCODER(void)
; 0005 001D {

	.CSEG
_ENCODER:
; .FSTART _ENCODER
; 0005 001E     s0 = s1;                              //
	CALL SUBOPT_0x18
	STS  _s0,R30
	STS  _s0+1,R31
; 0005 001F     s1 = 0;// ((PINE &0x0C)>>2);
	LDI  R30,LOW(0)
	STS  _s1,R30
	STS  _s1+1,R30
; 0005 0020     if( s1==3 )
	LDS  R26,_s1
	LDS  R27,_s1+1
	SBIW R26,3
	BREQ PC+2
	RJMP _0xA0003
; 0005 0021     {
; 0005 0022         if( s1-s0==1 )
	CALL SUBOPT_0x19
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xA0004
; 0005 0023         {
; 0005 0024             if(UD.cut_mode == F_BLEND_OFF)
	__GETB2MN _UD,8
	CPI  R26,LOW(0x1)
	BRNE _0xA0005
; 0005 0025             {
; 0005 0026 
; 0005 0027                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA0006
; 0005 0028                 {
; 0005 0029                     UD.cut_blend_off_power=UD.cut_blend_off_power-5;
	CALL SUBOPT_0x1A
	SBIW R30,5
	CALL SUBOPT_0x1B
; 0005 002A                     if(UD.cut_blend_off_power<=0){UD.cut_blend_off_power=0;}
	CALL SUBOPT_0x1C
	BRLT _0xA0007
	CALL SUBOPT_0x1D
; 0005 002B                 }
_0xA0007:
; 0005 002C                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA0008
_0xA0006:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0009
; 0005 002D                 {
; 0005 002E                     UD.cut_blend_off_power--;
	__POINTW2MN _UD,18
	CALL SUBOPT_0x1E
; 0005 002F                     if(UD.cut_blend_off_power<=0){UD.cut_blend_off_power=0;}
	CALL SUBOPT_0x1C
	BRLT _0xA000A
	CALL SUBOPT_0x1D
; 0005 0030                 }
_0xA000A:
; 0005 0031                 buzzer_down_flag=1;
_0xA0009:
_0xA0008:
	RJMP _0xA0051
; 0005 0032 
; 0005 0033             }
; 0005 0034             else if(UD.cut_mode == F_BLEND_1)
_0xA0005:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x2)
	BRNE _0xA000C
; 0005 0035             {
; 0005 0036                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA000D
; 0005 0037                 {
; 0005 0038                     UD.cut_blend_1_power=UD.cut_blend_1_power-5;
	CALL SUBOPT_0x1F
	SBIW R30,5
	CALL SUBOPT_0x20
; 0005 0039                     if(UD.cut_blend_1_power<=0){UD.cut_blend_1_power=0;}
	CALL SUBOPT_0x21
	BRLT _0xA000E
	CALL SUBOPT_0x22
; 0005 003A                 }
_0xA000E:
; 0005 003B                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA000F
_0xA000D:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0010
; 0005 003C                 {
; 0005 003D                     UD.cut_blend_1_power--;
	__POINTW2MN _UD,20
	CALL SUBOPT_0x1E
; 0005 003E                     if(UD.cut_blend_1_power<=0){UD.cut_blend_1_power=0;}
	CALL SUBOPT_0x21
	BRLT _0xA0011
	CALL SUBOPT_0x22
; 0005 003F                 }
_0xA0011:
; 0005 0040                 buzzer_down_flag=1;
_0xA0010:
_0xA000F:
	RJMP _0xA0051
; 0005 0041             }
; 0005 0042             else if(UD.cut_mode == F_BLEND_2)
_0xA000C:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x3)
	BRNE _0xA0013
; 0005 0043             {
; 0005 0044                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA0014
; 0005 0045                 {
; 0005 0046                     UD.cut_blend_2_power=UD.cut_blend_2_power-5;
	CALL SUBOPT_0x23
	SBIW R30,5
	CALL SUBOPT_0x24
; 0005 0047                     if(UD.cut_blend_2_power<=0){UD.cut_blend_2_power=0;}
	CALL SUBOPT_0x25
	BRLT _0xA0015
	CALL SUBOPT_0x26
; 0005 0048                 }
_0xA0015:
; 0005 0049                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA0016
_0xA0014:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0017
; 0005 004A                 {
; 0005 004B                     UD.cut_blend_2_power--;
	__POINTW2MN _UD,22
	CALL SUBOPT_0x1E
; 0005 004C                     if(UD.cut_blend_2_power<=0){UD.cut_blend_2_power=0;}
	CALL SUBOPT_0x25
	BRLT _0xA0018
	CALL SUBOPT_0x26
; 0005 004D                 }
_0xA0018:
; 0005 004E                 buzzer_down_flag=1;
_0xA0017:
_0xA0016:
_0xA0051:
	LDI  R30,LOW(1)
	STS  _buzzer_down_flag,R30
; 0005 004F             }
; 0005 0050 
; 0005 0051         } //-
_0xA0013:
; 0005 0052         else if(s1-s0==2)
	RJMP _0xA0019
_0xA0004:
	CALL SUBOPT_0x19
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BREQ PC+2
	RJMP _0xA001A
; 0005 0053         {
; 0005 0054             if(UD.cut_mode == F_BLEND_OFF)
	__GETB2MN _UD,8
	CPI  R26,LOW(0x1)
	BRNE _0xA001B
; 0005 0055             {
; 0005 0056                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA001C
; 0005 0057                 {
; 0005 0058                     UD.cut_blend_off_power=UD.cut_blend_off_power+5;
	CALL SUBOPT_0x1A
	ADIW R30,5
	CALL SUBOPT_0x1B
; 0005 0059                     if(UD.cut_blend_off_power>=400){UD.cut_blend_off_power=400;}
	CALL SUBOPT_0x27
	BRLT _0xA001D
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	CALL SUBOPT_0x1B
; 0005 005A                 }
_0xA001D:
; 0005 005B                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA001E
_0xA001C:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA001F
; 0005 005C                 {
; 0005 005D                     UD.cut_blend_off_power++;
	__POINTW2MN _UD,18
	CALL SUBOPT_0x28
; 0005 005E                     if(UD.cut_blend_off_power>=400){UD.cut_blend_off_power=400;}
	CALL SUBOPT_0x27
	BRLT _0xA0020
	LDI  R30,LOW(400)
	LDI  R31,HIGH(400)
	CALL SUBOPT_0x1B
; 0005 005F                 }
_0xA0020:
; 0005 0060                 buzzer_up_flag=1;
_0xA001F:
_0xA001E:
	RJMP _0xA0052
; 0005 0061             }
; 0005 0062             else if(UD.cut_mode == F_BLEND_1)
_0xA001B:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x2)
	BRNE _0xA0022
; 0005 0063             {
; 0005 0064                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA0023
; 0005 0065                 {
; 0005 0066                     UD.cut_blend_1_power=UD.cut_blend_1_power+5;
	CALL SUBOPT_0x1F
	ADIW R30,5
	CALL SUBOPT_0x20
; 0005 0067                     if(UD.cut_blend_1_power>=230){UD.cut_blend_1_power=230;}
	CALL SUBOPT_0x29
	BRLT _0xA0024
	LDI  R30,LOW(230)
	LDI  R31,HIGH(230)
	CALL SUBOPT_0x20
; 0005 0068                 }
_0xA0024:
; 0005 0069                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA0025
_0xA0023:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0026
; 0005 006A                 {
; 0005 006B                     UD.cut_blend_1_power++;
	__POINTW2MN _UD,20
	CALL SUBOPT_0x28
; 0005 006C                     if(UD.cut_blend_1_power>=230){UD.cut_blend_1_power=230;}
	CALL SUBOPT_0x29
	BRLT _0xA0027
	LDI  R30,LOW(230)
	LDI  R31,HIGH(230)
	CALL SUBOPT_0x20
; 0005 006D                 }
_0xA0027:
; 0005 006E                 buzzer_up_flag=1;
_0xA0026:
_0xA0025:
	RJMP _0xA0052
; 0005 006F             }
; 0005 0070             else if(UD.cut_mode == F_BLEND_2)
_0xA0022:
	__GETB2MN _UD,8
	CPI  R26,LOW(0x3)
	BRNE _0xA0029
; 0005 0071             {
; 0005 0072                 if(cut_in_de_flag==UP_DOWN_5)
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA002A
; 0005 0073                 {
; 0005 0074                     UD.cut_blend_2_power=UD.cut_blend_2_power+5;
	CALL SUBOPT_0x23
	ADIW R30,5
	CALL SUBOPT_0x24
; 0005 0075                     if(UD.cut_blend_2_power>=180){UD.cut_blend_2_power=180;}
	CALL SUBOPT_0x2A
	BRLT _0xA002B
	LDI  R30,LOW(180)
	LDI  R31,HIGH(180)
	CALL SUBOPT_0x24
; 0005 0076                 }
_0xA002B:
; 0005 0077                 else if(cut_in_de_flag==UP_DOWN_1)
	RJMP _0xA002C
_0xA002A:
	LDS  R26,_cut_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA002D
; 0005 0078                 {
; 0005 0079                     UD.cut_blend_2_power++;
	__POINTW2MN _UD,22
	CALL SUBOPT_0x28
; 0005 007A                     if(UD.cut_blend_2_power>=180){UD.cut_blend_2_power=180;}
	CALL SUBOPT_0x2A
	BRLT _0xA002E
	LDI  R30,LOW(180)
	LDI  R31,HIGH(180)
	CALL SUBOPT_0x24
; 0005 007B                 }
_0xA002E:
; 0005 007C                 buzzer_up_flag=1;
_0xA002D:
_0xA002C:
_0xA0052:
	LDI  R30,LOW(1)
	STS  _buzzer_up_flag,R30
; 0005 007D             }
; 0005 007E         }  //+
_0xA0029:
; 0005 007F     }
_0xA001A:
_0xA0019:
; 0005 0080 
; 0005 0081 
; 0005 0082     s2=s3; //temp level
_0xA0003:
	CALL SUBOPT_0x2B
	STS  _s2,R30
	STS  _s2+1,R31
; 0005 0083     s3=((PINE &0x60)>>5);
	IN   R30,0x1
	ANDI R30,LOW(0x60)
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LDI  R31,0
	STS  _s3,R30
	STS  _s3+1,R31
; 0005 0084     if(s3==3)
	LDS  R26,_s3
	LDS  R27,_s3+1
	SBIW R26,3
	BRNE _0xA002F
; 0005 0085     {
; 0005 0086         if(s3-s2==1) //down
	CALL SUBOPT_0x2C
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xA0030
; 0005 0087         {
; 0005 0088             UD.coa_contact_power--;
	__POINTW2MN _UD,24
	CALL SUBOPT_0x1E
; 0005 0089             if( UD.coa_contact_power<0 )
	__GETB2MN _UD,25
	TST  R26
	BRPL _0xA0031
; 0005 008A             {
; 0005 008B                UD.coa_contact_power=0;
	CALL SUBOPT_0x2D
; 0005 008C             }
; 0005 008D             buzzer_down_flag=1;
_0xA0031:
	LDI  R30,LOW(1)
	STS  _buzzer_down_flag,R30
; 0005 008E 
; 0005 008F         }  //-
; 0005 0090         if(s3-s2==2) //up
_0xA0030:
	CALL SUBOPT_0x2C
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xA0032
; 0005 0091         {
; 0005 0092            UD.coa_contact_power++;
	__POINTW2MN _UD,24
	CALL SUBOPT_0x28
; 0005 0093            if(UD.coa_contact_power>4)
	__GETW2MN _UD,24
	SBIW R26,5
	BRLT _0xA0033
; 0005 0094            {
; 0005 0095              UD.coa_contact_power=4;
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	__PUTW1MN _UD,24
; 0005 0096            }
; 0005 0097            buzzer_up_flag=1;
_0xA0033:
	LDI  R30,LOW(1)
	STS  _buzzer_up_flag,R30
; 0005 0098 
; 0005 0099         }  //+
; 0005 009A     }
_0xA0032:
; 0005 009B 
; 0005 009C     s4=s5;  //POWER
_0xA002F:
	CALL SUBOPT_0x2E
	STS  _s4,R30
	STS  _s4+1,R31
; 0005 009D     s5= ((PINA &0x60)>>5 );   //PORTA.5 ~PORTA.6
	IN   R30,0x19
	ANDI R30,LOW(0x60)
	SWAP R30
	ANDI R30,0xF
	LSR  R30
	LDI  R31,0
	STS  _s5,R30
	STS  _s5+1,R31
; 0005 009E     if(s5==3)
	LDS  R26,_s5
	LDS  R27,_s5+1
	SBIW R26,3
	BREQ PC+2
	RJMP _0xA0034
; 0005 009F     {
; 0005 00A0         if(s5-s4==1)
	CALL SUBOPT_0x2F
	CPI  R30,LOW(0x1)
	LDI  R26,HIGH(0x1)
	CPC  R31,R26
	BRNE _0xA0035
; 0005 00A1         {
; 0005 00A2             if(UD.bipol_mode == F_IMP_SENSE_OFF)
	__GETB2MN _UD,10
	CPI  R26,LOW(0x6)
	BRNE _0xA0036
; 0005 00A3             {
; 0005 00A4                 if(bip_in_de_flag==UP_DOWN_5)
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA0037
; 0005 00A5                 {
; 0005 00A6                     UD.imp_sense_power=UD.imp_sense_power-5;
	CALL SUBOPT_0x30
; 0005 00A7                      if(UD.imp_sense_power<=0){UD.imp_sense_power=0;}
	BRLT _0xA0038
	CALL SUBOPT_0x31
; 0005 00A8                 }
_0xA0038:
; 0005 00A9                 else if(bip_in_de_flag==UP_DOWN_1)
	RJMP _0xA0039
_0xA0037:
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA003A
; 0005 00AA                 {
; 0005 00AB                     UD.imp_sense_power--;
	__POINTW2MN _UD,28
	CALL SUBOPT_0x1E
; 0005 00AC                      if(UD.imp_sense_power<=0){UD.imp_sense_power=0;}
	CALL SUBOPT_0x32
	BRLT _0xA003B
	CALL SUBOPT_0x31
; 0005 00AD                 }
_0xA003B:
; 0005 00AE                 buzzer_down_flag=1;
_0xA003A:
_0xA0039:
	RJMP _0xA0053
; 0005 00AF             }
; 0005 00B0             else if(UD.bipol_mode == F_IMP_SENSE_ON)
_0xA0036:
	__GETB2MN _UD,10
	CPI  R26,LOW(0x7)
	BRNE _0xA003D
; 0005 00B1             {
; 0005 00B2                 if(bip_in_de_flag==UP_DOWN_5)
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA003E
; 0005 00B3                 {
; 0005 00B4                     UD.imp_sense_power=UD.imp_sense_power-5;
	CALL SUBOPT_0x30
; 0005 00B5                      if(UD.imp_sense_power<=0){UD.imp_sense_power=0;}
	BRLT _0xA003F
	CALL SUBOPT_0x31
; 0005 00B6                 }
_0xA003F:
; 0005 00B7                 else if(bip_in_de_flag==UP_DOWN_1)
	RJMP _0xA0040
_0xA003E:
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0041
; 0005 00B8                 {
; 0005 00B9                     UD.imp_sense_power--;
	__POINTW2MN _UD,28
	CALL SUBOPT_0x1E
; 0005 00BA                      if(UD.imp_sense_power<=0){UD.imp_sense_power=0;}
	CALL SUBOPT_0x32
	BRLT _0xA0042
	CALL SUBOPT_0x31
; 0005 00BB                 }
_0xA0042:
; 0005 00BC                 buzzer_down_flag=1;
_0xA0041:
_0xA0040:
_0xA0053:
	LDI  R30,LOW(1)
	STS  _buzzer_down_flag,R30
; 0005 00BD             }
; 0005 00BE         }  //-
_0xA003D:
; 0005 00BF         if(s5-s4==2)
_0xA0035:
	CALL SUBOPT_0x2F
	CPI  R30,LOW(0x2)
	LDI  R26,HIGH(0x2)
	CPC  R31,R26
	BRNE _0xA0043
; 0005 00C0         {
; 0005 00C1             if(UD.bipol_mode == F_IMP_SENSE_OFF)
	__GETB2MN _UD,10
	CPI  R26,LOW(0x6)
	BRNE _0xA0044
; 0005 00C2             {
; 0005 00C3                 if(bip_in_de_flag==UP_DOWN_5)
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA0045
; 0005 00C4                 {
; 0005 00C5                     UD.imp_sense_power=UD.imp_sense_power+5;
	CALL SUBOPT_0x33
; 0005 00C6                      if(UD.imp_sense_power>=20){UD.imp_sense_power=20;}
	BRLT _0xA0046
	CALL SUBOPT_0x34
; 0005 00C7                 }
_0xA0046:
; 0005 00C8                 else if(bip_in_de_flag==UP_DOWN_1)
	RJMP _0xA0047
_0xA0045:
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA0048
; 0005 00C9                 {
; 0005 00CA                     UD.imp_sense_power++;
	__POINTW2MN _UD,28
	CALL SUBOPT_0x28
; 0005 00CB                      if(UD.imp_sense_power>=20){UD.imp_sense_power=20;}
	__GETW2MN _UD,28
	SBIW R26,20
	BRLT _0xA0049
	CALL SUBOPT_0x34
; 0005 00CC                 }
_0xA0049:
; 0005 00CD                 buzzer_up_flag=1;
_0xA0048:
_0xA0047:
	RJMP _0xA0054
; 0005 00CE             }
; 0005 00CF             else if(UD.bipol_mode == F_IMP_SENSE_ON)
_0xA0044:
	__GETB2MN _UD,10
	CPI  R26,LOW(0x7)
	BRNE _0xA004B
; 0005 00D0             {
; 0005 00D1                 if(bip_in_de_flag==UP_DOWN_5)
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x1)
	BRNE _0xA004C
; 0005 00D2                 {
; 0005 00D3                     UD.imp_sense_power=UD.imp_sense_power+5;
	CALL SUBOPT_0x33
; 0005 00D4                     if(UD.imp_sense_power>=20){UD.imp_sense_power=20;}
	BRLT _0xA004D
	CALL SUBOPT_0x34
; 0005 00D5                 }
_0xA004D:
; 0005 00D6                 else if(bip_in_de_flag==UP_DOWN_1)
	RJMP _0xA004E
_0xA004C:
	LDS  R26,_bip_in_de_flag
	CPI  R26,LOW(0x2)
	BRNE _0xA004F
; 0005 00D7                 {
; 0005 00D8                     UD.imp_sense_power++;
	__POINTW2MN _UD,28
	CALL SUBOPT_0x28
; 0005 00D9                     if(UD.imp_sense_power>=20){UD.imp_sense_power=20;}
	CALL SUBOPT_0x35
	SBIW R26,20
	BRLT _0xA0050
	CALL SUBOPT_0x34
; 0005 00DA                 }
_0xA0050:
; 0005 00DB                 buzzer_up_flag=1;
_0xA004F:
_0xA004E:
_0xA0054:
	LDI  R30,LOW(1)
	STS  _buzzer_up_flag,R30
; 0005 00DC             }
; 0005 00DD         } //+
_0xA004B:
; 0005 00DE     }
_0xA0043:
; 0005 00DF }
_0xA0034:
	RET
; .FEND
;
;//******************************************************************************
;// Local Functions
;//******************************************************************************
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
;#include <string.h>
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#ifndef __TIME_H__
;#include "time.h"
;#endif
;
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;Uint _SetBaudrate_(Uint baud);
;//******************************************************************************
;// Variables
;//******************************************************************************
;Uchar TXdata[TX_SIZE+1];
;Uchar txquefront,txquetail;
;Uchar txreadytime;
;Uchar datasendflag;
;
;Uchar RXdata[RX_SIZE+1];
;Uchar rxquefront,rxquetail;
;Uchar receivedelay;
;Uchar txtemp;
;Uchar receiveflag;
;//Uchar receiveerrortime;
;
;UART_DATA UD;
;extern TIMEFLAG     TF;
;extern volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,bu ...
;
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;Uint USART_Init(Uint baud0_speed)
; 0006 0028 {

	.CSEG
_USART_Init:
; .FSTART _USART_Init
; 0006 0029     Uint baud0_value;
; 0006 002A 
; 0006 002B     baud0_value = _SetBaudrate_(baud0_speed);
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	baud0_speed -> Y+2
;	baud0_value -> R16,R17
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	RCALL __SetBaudrate_
	MOVW R16,R30
; 0006 002C 
; 0006 002D     //ATMEGA128 <-> x
; 0006 002E     UBRR0H  = 0x00;         /* USART0 Baud Rate Register High */
	LDI  R30,LOW(0)
	STS  144,R30
; 0006 002F     UBRR0L  = baud0_value;  /* USART0 Baud Rate Register Low   */   //     9600
	OUT  0x9,R16
; 0006 0030     UCSR0A  = 0x00;         /* USART0 Control and Status Register A */
	OUT  0xB,R30
; 0006 0031     UCSR0B  = 0xD8;         /* USART0 Control and Status Register B */
	LDI  R30,LOW(216)
	OUT  0xA,R30
; 0006 0032    // UCSR0C  = 0x00;
; 0006 0033     return USART_ERR_NONE;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP _0x20A0011
; 0006 0034 }
; .FEND
;
;//******************************************************************************
;void UART_Packet_TX_RX(void)
; 0006 0038 {
_UART_Packet_TX_RX:
; .FSTART _UART_Packet_TX_RX
; 0006 0039     Uchar count;
; 0006 003A     Uchar calc_rx_checksum,calc_tx_checksum;
; 0006 003B 
; 0006 003C     if(txreadytime >= 10)
	CALL __SAVELOCR4
;	count -> R17
;	calc_rx_checksum -> R16
;	calc_tx_checksum -> R19
	LDS  R26,_txreadytime
	CPI  R26,LOW(0xA)
	BRLO _0xC0003
; 0006 003D     {
; 0006 003E         txreadytime=0;
	LDI  R30,LOW(0)
	STS  _txreadytime,R30
; 0006 003F         /*
; 0006 0040         Sys.dspstatusreport=DSF.Bflag;
; 0006 0041         */
; 0006 0042         UD.command[TX_DATCHK]=0x5A;
	LDI  R30,LOW(90)
	__PUTB1MN _UD,45
; 0006 0043         calc_tx_checksum=0;
	LDI  R19,LOW(0)
; 0006 0044         for(count = 0; count < TX_CHKSUM; count++)
	LDI  R17,LOW(0)
_0xC0005:
	CPI  R17,46
	BRSH _0xC0006
; 0006 0045         {
; 0006 0046             TXdata[count] = UD.command[count];
	MOV  R26,R17
	LDI  R27,0
	SUBI R26,LOW(-_TXdata)
	SBCI R27,HIGH(-_TXdata)
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_UD)
	SBCI R31,HIGH(-_UD)
	LD   R30,Z
	ST   X,R30
; 0006 0047             calc_tx_checksum ^= UD.command[count];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_UD)
	SBCI R31,HIGH(-_UD)
	LD   R30,Z
	EOR  R19,R30
; 0006 0048         }
	SUBI R17,-1
	RJMP _0xC0005
_0xC0006:
; 0006 0049         TXdata[TX_CHKSUM]=calc_tx_checksum;
	__PUTBMRN _TXdata,46,19
; 0006 004A 
; 0006 004B         txquefront=TX_SIZE;
	LDI  R30,LOW(47)
	CALL SUBOPT_0x36
; 0006 004C         txquetail=0;
; 0006 004D         datasendflag=1;
	LDI  R30,LOW(1)
	STS  _datasendflag,R30
; 0006 004E         UDR0 = TXdata[txquetail++];
	CALL SUBOPT_0x37
; 0006 004F     }
; 0006 0050     else //if(TF.flag.msec100flag)
	RJMP _0xC0007
_0xC0003:
; 0006 0051     {
; 0006 0052          txreadytime++;
	LDS  R30,_txreadytime
	SUBI R30,-LOW(1)
	STS  _txreadytime,R30
; 0006 0053     }
_0xC0007:
; 0006 0054   /*
; 0006 0055     if(receiveerrortime > 10)
; 0006 0056     {
; 0006 0057        // buzzer_down_flag=1;
; 0006 0058         //receiveerrflag=1;
; 0006 0059     }
; 0006 005A     else if(TF.flag.secflag)
; 0006 005B     {
; 0006 005C         receiveerrortime++;
; 0006 005D     }
; 0006 005E     */
; 0006 005F     if(!receiveflag) return;
	LDS  R30,_receiveflag
	CPI  R30,0
	BRNE _0xC0008
	CALL __LOADLOCR4
	RJMP _0x20A0010
; 0006 0060     txreadytime=0;
_0xC0008:
	LDI  R30,LOW(0)
	STS  _txreadytime,R30
; 0006 0061 
; 0006 0062     if(receivedelay >= RECCHKDEY)
	LDS  R26,_receivedelay
	CPI  R26,LOW(0x1)
	BRLO _0xC0009
; 0006 0063     {
; 0006 0064         receivedelay=0;
	STS  _receivedelay,R30
; 0006 0065         receiveflag=0;
	STS  _receiveflag,R30
; 0006 0066         calc_rx_checksum=0;
	LDI  R16,LOW(0)
; 0006 0067         for(count = 0; count < RX_CHKSUM; count++)
	LDI  R17,LOW(0)
_0xC000B:
	CPI  R17,46
	BRSH _0xC000C
; 0006 0068         {
; 0006 0069             calc_rx_checksum ^= RXdata[count];
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_RXdata)
	SBCI R31,HIGH(-_RXdata)
	LD   R30,Z
	EOR  R16,R30
; 0006 006A         }
	SUBI R17,-1
	RJMP _0xC000B
_0xC000C:
; 0006 006B 
; 0006 006C 
; 0006 006D         if(calc_rx_checksum==RXdata[RX_CHKSUM]&& RXdata[RX_DATCHK]==0x5A)
	__GETB1MN _RXdata,46
	CP   R30,R16
	BRNE _0xC000E
	__GETB2MN _RXdata,45
	CPI  R26,LOW(0x5A)
	BREQ _0xC000F
_0xC000E:
	RJMP _0xC000D
_0xC000F:
; 0006 006E         {
; 0006 006F             for(count = RECODELEN;count < RX_DATCHK; count++)
	LDI  R17,LOW(36)
_0xC0011:
	CPI  R17,45
	BRSH _0xC0012
; 0006 0070             {
; 0006 0071                 UD.command[count] = RXdata[count];
	MOV  R26,R17
	LDI  R27,0
	SUBI R26,LOW(-_UD)
	SBCI R27,HIGH(-_UD)
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_RXdata)
	SBCI R31,HIGH(-_RXdata)
	LD   R30,Z
	ST   X,R30
; 0006 0072             }
	SUBI R17,-1
	RJMP _0xC0011
_0xC0012:
; 0006 0073 
; 0006 0074             /*
; 0006 0075             RSF.Bflag= Sys.reystatusreport;
; 0006 0076             ER.Bflag = Sys.errorreport;
; 0006 0077             Do1.Bflag= Sys.Do1statusvalue;   //20
; 0006 0078             Do2.Bflag= Sys.Do2statusvalue;   //21
; 0006 0079             Di1.Bflag= Sys.Di1statusvalue;   //22
; 0006 007A             Di2.Bflag= Sys.Di2statusvalue;   //23
; 0006 007B             */
; 0006 007C 
; 0006 007D             //receiveerrortime=0;
; 0006 007E             // Msg.receiveerrflag=0;
; 0006 007F         }
; 0006 0080         rxquefront=0;
_0xC000D:
	LDI  R30,LOW(0)
	STS  _rxquefront,R30
; 0006 0081         rxquetail=0;
	STS  _rxquetail,R30
; 0006 0082     }
; 0006 0083     else
	RJMP _0xC0013
_0xC0009:
; 0006 0084     {
; 0006 0085         receivedelay++;
	LDS  R30,_receivedelay
	SUBI R30,-LOW(1)
	STS  _receivedelay,R30
; 0006 0086     }
_0xC0013:
; 0006 0087 }
	CALL __LOADLOCR4
	RJMP _0x20A0010
; .FEND
;//******************************************************************************
;// Interrupt Functions
;//******************************************************************************
;
;interrupt [USART0_RXC] void USART0_RXC_vect_Proc(void)
; 0006 008D {
_USART0_RXC_vect_Proc:
; .FSTART _USART0_RXC_vect_Proc
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0006 008E    if(datasendflag)
	LDS  R30,_datasendflag
	CPI  R30,0
	BREQ _0xC0014
; 0006 008F     {
; 0006 0090         txtemp = UDR0;
	IN   R30,0xC
	STS  _txtemp,R30
; 0006 0091         rxquefront=0;
	LDI  R30,LOW(0)
	STS  _rxquefront,R30
; 0006 0092     }
; 0006 0093     else
	RJMP _0xC0015
_0xC0014:
; 0006 0094     {
; 0006 0095         RXdata[rxquefront++] = UDR0;
	LDS  R30,_rxquefront
	SUBI R30,-LOW(1)
	STS  _rxquefront,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_RXdata)
	SBCI R31,HIGH(-_RXdata)
	MOVW R26,R30
	IN   R30,0xC
	ST   X,R30
; 0006 0096         if(rxquefront >= RX_SIZE+1)
	LDS  R26,_rxquefront
	CPI  R26,LOW(0x30)
	BRLO _0xC0016
; 0006 0097         {
; 0006 0098             rxquefront=0;
	LDI  R30,LOW(0)
	STS  _rxquefront,R30
; 0006 0099         }
; 0006 009A 
; 0006 009B         receivedelay=0;
_0xC0016:
	LDI  R30,LOW(0)
	STS  _receivedelay,R30
; 0006 009C         receiveflag=1;
	LDI  R30,LOW(1)
	STS  _receiveflag,R30
; 0006 009D     }
_0xC0015:
; 0006 009E }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;//******************************************************************************
;interrupt [USART0_DRE] void USART_DRE0_vect_Proc(void)
; 0006 00A1 {
_USART_DRE0_vect_Proc:
; .FSTART _USART_DRE0_vect_Proc
; 0006 00A2 }
	RETI
; .FEND
;//******************************************************************************
;interrupt [USART0_TXC] void USART0_TXC_vect_Proc(void)
; 0006 00A5 {
_USART0_TXC_vect_Proc:
; .FSTART _USART0_TXC_vect_Proc
	ST   -Y,R26
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0006 00A6   if(txquefront != txquetail)
	LDS  R30,_txquetail
	LDS  R26,_txquefront
	CP   R30,R26
	BREQ _0xC0017
; 0006 00A7     {
; 0006 00A8         UDR0 = TXdata[txquetail++];
	CALL SUBOPT_0x37
; 0006 00A9         if(txquetail >= TX_SIZE)
	LDS  R26,_txquetail
	CPI  R26,LOW(0x2F)
	BRLO _0xC0018
; 0006 00AA         {
; 0006 00AB             txquefront = 0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x36
; 0006 00AC             txquetail=0;
; 0006 00AD             datasendflag=0;
	LDI  R30,LOW(0)
	STS  _datasendflag,R30
; 0006 00AE         }
; 0006 00AF     }
_0xC0018:
; 0006 00B0     else
	RJMP _0xC0019
_0xC0017:
; 0006 00B1     {
; 0006 00B2         txquefront = 0;
	LDI  R30,LOW(0)
	CALL SUBOPT_0x36
; 0006 00B3         txquetail=0;
; 0006 00B4         datasendflag=0;
	LDI  R30,LOW(0)
	STS  _datasendflag,R30
; 0006 00B5     }
_0xC0019:
; 0006 00B6 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R26,Y+
	RETI
; .FEND
;//******************************************************************************
;// Local Functions
;//******************************************************************************
;Uint _SetBaudrate_(Uint baud)
; 0006 00BB {
__SetBaudrate_:
; .FSTART __SetBaudrate_
; 0006 00BC     //fosc=16Mhz 일때
; 0006 00BD 
; 0006 00BE     Uint baud_speed;
; 0006 00BF 
; 0006 00C0     switch(baud)
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	baud -> Y+2
;	baud_speed -> R16,R17
	LDD  R30,Y+2
	LDD  R31,Y+2+1
; 0006 00C1     {
; 0006 00C2         case 2400:
	CPI  R30,LOW(0x960)
	LDI  R26,HIGH(0x960)
	CPC  R31,R26
	BRNE _0xC001D
; 0006 00C3             baud_speed=416;
	__GETWRN 16,17,416
; 0006 00C4             break;
	RJMP _0xC001C
; 0006 00C5         case 4800:
_0xC001D:
	CPI  R30,LOW(0x12C0)
	LDI  R26,HIGH(0x12C0)
	CPC  R31,R26
	BRNE _0xC001E
; 0006 00C6             baud_speed=207;
	__GETWRN 16,17,207
; 0006 00C7             break;
	RJMP _0xC001C
; 0006 00C8         case 9600:
_0xC001E:
	CPI  R30,LOW(0x2580)
	LDI  R26,HIGH(0x2580)
	CPC  R31,R26
	BRNE _0xC001F
; 0006 00C9             baud_speed=103;
	__GETWRN 16,17,103
; 0006 00CA             break;
	RJMP _0xC001C
; 0006 00CB         case 14400:
_0xC001F:
	CPI  R30,LOW(0x3840)
	LDI  R26,HIGH(0x3840)
	CPC  R31,R26
	BRNE _0xC0020
; 0006 00CC             baud_speed=68;
	__GETWRN 16,17,68
; 0006 00CD             break;
	RJMP _0xC001C
; 0006 00CE         case 19200:
_0xC0020:
	CPI  R30,LOW(0x4B00)
	LDI  R26,HIGH(0x4B00)
	CPC  R31,R26
	BRNE _0xC0021
; 0006 00CF             baud_speed=51;
	__GETWRN 16,17,51
; 0006 00D0             break;
	RJMP _0xC001C
; 0006 00D1         case 28800:
_0xC0021:
	CPI  R30,LOW(0x7080)
	LDI  R26,HIGH(0x7080)
	CPC  R31,R26
	BRNE _0xC0022
; 0006 00D2             baud_speed=34;
	__GETWRN 16,17,34
; 0006 00D3             break;
	RJMP _0xC001C
; 0006 00D4         case 38400:
_0xC0022:
	CPI  R30,LOW(0x9600)
	LDI  R26,HIGH(0x9600)
	CPC  R31,R26
	BRNE _0xC0023
; 0006 00D5             baud_speed=25;
	__GETWRN 16,17,25
; 0006 00D6             break;
	RJMP _0xC001C
; 0006 00D7         case 57600:
_0xC0023:
	CPI  R30,LOW(0xE100)
	LDI  R26,HIGH(0xE100)
	CPC  R31,R26
	BRNE _0xC0024
; 0006 00D8             baud_speed=16;
	__GETWRN 16,17,16
; 0006 00D9             break;
	RJMP _0xC001C
; 0006 00DA         case 76800:
_0xC0024:
	CPI  R30,LOW(0x12C00)
	LDI  R26,HIGH(0x12C00)
	CPC  R31,R26
	BRNE _0xC0025
; 0006 00DB             baud_speed=12;
	__GETWRN 16,17,12
; 0006 00DC             break;
	RJMP _0xC001C
; 0006 00DD         case 115200:
_0xC0025:
	CPI  R30,LOW(0x1C200)
	LDI  R26,HIGH(0x1C200)
	CPC  R31,R26
	BRNE _0xC0026
; 0006 00DE             baud_speed=8;
	__GETWRN 16,17,8
; 0006 00DF             break;
	RJMP _0xC001C
; 0006 00E0        case 250000:  //7/14일 수정
_0xC0026:
	CPI  R30,LOW(0x3D090)
	LDI  R26,HIGH(0x3D090)
	CPC  R31,R26
	BRNE _0xC0028
; 0006 00E1             baud_speed=3;
	__GETWRN 16,17,3
; 0006 00E2             break;
; 0006 00E3 
; 0006 00E4         default:
_0xC0028:
; 0006 00E5             break;
; 0006 00E6     }
_0xC001C:
; 0006 00E7 
; 0006 00E8     return baud_speed;
	MOVW R30,R16
_0x20A0011:
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A0010:
	ADIW R28,4
	RET
; 0006 00E9 }
; .FEND
;
;
;
;
;
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
;
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __BUZZER_H__
;#include "buzzer.h"
;#endif
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;flash Uint BUZNOTES[26] = {
;        _DO, 0x00,
;        _DO, 0x00,
;        _DO, 0x00,
;        _DO, 0x00,
;        _DO, 0x00,
;        _DO, 0x00,
;        _DO, 0x00,
;         2, 0x00,
;         4, 0x00,
;         7, 0x00,
;         10, 0x00,
;         15, 0x00,
;        _D3, 0x00,
;};
;
;flash Uchar BUZDURATIONS[26] = {
;         1, 0x00,
;         1, 0x00,
;         1,  0x00,
;         25, 0x00,
;         25, 0x00,
;         25, 0x00,
;         25, 0x00,
;         25, 0x00,
;         25, 0x00,
;         25, 0x00,
;         10, 0x00,
;         10, 0x00,
;         10, 0x00,
;};
;
;flash Uint ECHOS[26] = {
;         1, 0x00,
;         1, 0x00,
;         1, 0x00,
;         180, 0x00,
;         120, 0x00,
;         100, 0x00,
;         80, 0x00,
;         60, 0x00,
;         20, 0x00,
;         20, 0x00,
;         1, 0x00,
;         1, 0x00,
;         1, 0x00,
;};
;
;volatile Uchar  buzzeractionflag;
;
;Uchar noteindex;
;volatile Uchar currentduration;
;volatile Uint buzznoteecho;
;
;Uchar buzzer_count;
;
;volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,buzzer_ov ...
;volatile Uint currentperiod;
;
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;void _buzzer_out_count_(void);
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;Uint BUZZER_action(void)
; 0007 0053 {

	.CSEG
_BUZZER_action:
; .FSTART _BUZZER_action
; 0007 0054    if(currentduration)
	LDS  R30,_currentduration
	CPI  R30,0
	BREQ _0xE0003
; 0007 0055     {
; 0007 0056         currentduration--;
	LDS  R30,_currentduration
	SUBI R30,LOW(1)
	STS  _currentduration,R30
; 0007 0057     }
; 0007 0058     else if(buzznoteecho)
	RJMP _0xE0004
_0xE0003:
	LDS  R30,_buzznoteecho
	LDS  R31,_buzznoteecho+1
	SBIW R30,0
	BREQ _0xE0005
; 0007 0059     {
; 0007 005A         buzznoteecho--;
	LDI  R26,LOW(_buzznoteecho)
	LDI  R27,HIGH(_buzznoteecho)
	CALL SUBOPT_0x1E
; 0007 005B         Clrbit(SPEAKER_PORT, SPEAKER); buzzeractionflag=0;
	CBI  0x18,4
	LDI  R30,LOW(0)
	STS  _buzzeractionflag,R30
; 0007 005C     }
; 0007 005D     /*
; 0007 005E     else if(buzzer_cut_flag)
; 0007 005F     {
; 0007 0060         buzzer_count = noteindex;
; 0007 0061         _buzzer_out_count_();
; 0007 0062     }
; 0007 0063     else if(buzzer_coa_flag)
; 0007 0064     {
; 0007 0065         buzzer_count = noteindex+2;
; 0007 0066         _buzzer_out_count_();
; 0007 0067 
; 0007 0068     }
; 0007 0069     else if(buzzer_bip_flag)
; 0007 006A     {
; 0007 006B         buzzer_count = noteindex+4;
; 0007 006C         _buzzer_out_count_();
; 0007 006D 
; 0007 006E     }
; 0007 006F     */
; 0007 0070     /*  else if(buzzer_20hz_flag)
; 0007 0071     {
; 0007 0072         buzzer_count = noteindex+6;
; 0007 0073         _buzzer_out_count_();
; 0007 0074 
; 0007 0075     }
; 0007 0076     else if(buzzer_50hz_flag)
; 0007 0077     {
; 0007 0078         buzzer_count = noteindex+8;
; 0007 0079         _buzzer_out_count_();
; 0007 007A 
; 0007 007B     }
; 0007 007C     else if(buzzer_75hz_flag)
; 0007 007D     {
; 0007 007E         buzzer_count = noteindex+10;
; 0007 007F         _buzzer_out_count_();
; 0007 0080 
; 0007 0081     }
; 0007 0082     else if(buzzer_100hz_flag)
; 0007 0083     {
; 0007 0084         buzzer_count = noteindex+12;
; 0007 0085         _buzzer_out_count_();
; 0007 0086 
; 0007 0087     } */
; 0007 0088     else if(buzzer_over_watt_flag)
	RJMP _0xE0006
_0xE0005:
	LDS  R30,_buzzer_over_watt_flag
	CPI  R30,0
	BREQ _0xE0007
; 0007 0089     {
; 0007 008A         buzzer_count = noteindex+14;
	LDS  R30,_noteindex
	SUBI R30,-LOW(14)
	CALL SUBOPT_0x38
; 0007 008B         _buzzer_out_count_();
; 0007 008C 
; 0007 008D     }
; 0007 008E     else if(buzzer_plate_alram_flag)
	RJMP _0xE0008
_0xE0007:
	LDS  R30,_buzzer_plate_alram_flag
	CPI  R30,0
	BREQ _0xE0009
; 0007 008F     {
; 0007 0090         buzzer_count = noteindex+16;
	LDS  R30,_noteindex
	SUBI R30,-LOW(16)
	CALL SUBOPT_0x38
; 0007 0091         _buzzer_out_count_();
; 0007 0092 
; 0007 0093     }
; 0007 0094     else if(buzzer_fan_error_flag)
	RJMP _0xE000A
_0xE0009:
	LDS  R30,_buzzer_fan_error_flag
	CPI  R30,0
	BREQ _0xE000B
; 0007 0095     {
; 0007 0096         buzzer_count = noteindex+18;
	LDS  R30,_noteindex
	SUBI R30,-LOW(18)
	CALL SUBOPT_0x38
; 0007 0097         _buzzer_out_count_();
; 0007 0098 
; 0007 0099     }
; 0007 009A     else if(buzzer_up_flag)
	RJMP _0xE000C
_0xE000B:
	LDS  R30,_buzzer_up_flag
	CPI  R30,0
	BREQ _0xE000D
; 0007 009B     {
; 0007 009C         buzzer_count = noteindex+20;
	LDS  R30,_noteindex
	SUBI R30,-LOW(20)
	CALL SUBOPT_0x38
; 0007 009D         _buzzer_out_count_();
; 0007 009E 
; 0007 009F     }
; 0007 00A0     else if(buzzer_down_flag)
	RJMP _0xE000E
_0xE000D:
	LDS  R30,_buzzer_down_flag
	CPI  R30,0
	BREQ _0xE000F
; 0007 00A1     {
; 0007 00A2         buzzer_count = noteindex+22;
	LDS  R30,_noteindex
	SUBI R30,-LOW(22)
	CALL SUBOPT_0x38
; 0007 00A3         _buzzer_out_count_();
; 0007 00A4 
; 0007 00A5     }
; 0007 00A6      else if(buzzer_start_flag)
	RJMP _0xE0010
_0xE000F:
	LDS  R30,_buzzer_start_flag
	CPI  R30,0
	BREQ _0xE0011
; 0007 00A7     {
; 0007 00A8         buzzer_count = noteindex+24;
	LDS  R30,_noteindex
	SUBI R30,-LOW(24)
	CALL SUBOPT_0x38
; 0007 00A9         _buzzer_out_count_();
; 0007 00AA     }
; 0007 00AB 
; 0007 00AC     else buzzer_count=1;
	RJMP _0xE0012
_0xE0011:
	LDI  R30,LOW(1)
	STS  _buzzer_count,R30
; 0007 00AD 
; 0007 00AE 
; 0007 00AF 
; 0007 00B0     return BUZZER_ERR_NONE;
_0xE0012:
_0xE0010:
_0xE000E:
_0xE000C:
_0xE000A:
_0xE0008:
_0xE0006:
_0xE0004:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RET
; 0007 00B1 }
; .FEND
;
;//******************************************************************************
;// Local Functions
;//******************************************************************************
;void _buzzer_out_count_(void)
; 0007 00B7 {
__buzzer_out_count_:
; .FSTART __buzzer_out_count_
; 0007 00B8    if(buzzer_count >= 39) buzzer_count=39;
	LDS  R26,_buzzer_count
	CPI  R26,LOW(0x27)
	BRLO _0xE0013
	LDI  R30,LOW(39)
	STS  _buzzer_count,R30
; 0007 00B9 
; 0007 00BA     currentperiod=BUZNOTES[buzzer_count];
_0xE0013:
	LDS  R30,_buzzer_count
	LDI  R26,LOW(_BUZNOTES*2)
	LDI  R27,HIGH(_BUZNOTES*2)
	CALL SUBOPT_0x39
	STS  _currentperiod,R30
	STS  _currentperiod+1,R31
; 0007 00BB     currentduration=BUZDURATIONS[buzzer_count];
	LDS  R30,_buzzer_count
	LDI  R31,0
	SUBI R30,LOW(-_BUZDURATIONS*2)
	SBCI R31,HIGH(-_BUZDURATIONS*2)
	LPM  R0,Z
	STS  _currentduration,R0
; 0007 00BC     buzznoteecho = ECHOS[buzzer_count];
	LDS  R30,_buzzer_count
	LDI  R26,LOW(_ECHOS*2)
	LDI  R27,HIGH(_ECHOS*2)
	CALL SUBOPT_0x39
	STS  _buzznoteecho,R30
	STS  _buzznoteecho+1,R31
; 0007 00BD 
; 0007 00BE     if(!currentduration)
	LDS  R30,_currentduration
	CPI  R30,0
	BRNE _0xE0014
; 0007 00BF     {
; 0007 00C0         noteindex=0;
	LDI  R30,LOW(0)
	STS  _noteindex,R30
; 0007 00C1        // buzzer_cut_flag=0;
; 0007 00C2        // buzzer_coa_flag=0;
; 0007 00C3        // buzzer_bip_flag=0;
; 0007 00C4 
; 0007 00C5         /*
; 0007 00C6         else if((UD.cut_hand_start==RUN)||( UD.cut_foot_start))
; 0007 00C7         {
; 0007 00C8         }
; 0007 00C9         else if((UD.coa_hand_start==RUN)||( UD.coa_foot_start))
; 0007 00CA         {
; 0007 00CB         }
; 0007 00CC         else if(UD.bipol_foot_start)
; 0007 00CD         {
; 0007 00CE         }
; 0007 00CF 
; 0007 00D0         switch(stim_freq)
; 0007 00D1         {
; 0007 00D2             case FREQ_2Hz :
; 0007 00D3                             buzzer_2hz_flag=0;
; 0007 00D4                             break;
; 0007 00D5             case FREQ_5Hz :
; 0007 00D6                             buzzer_5hz_flag=0;
; 0007 00D7                             break;
; 0007 00D8             case FREQ_10Hz :
; 0007 00D9                             buzzer_10hz_flag=0;
; 0007 00DA                             break;
; 0007 00DB             case FREQ_20Hz :
; 0007 00DC                             buzzer_20hz_flag=0;
; 0007 00DD                             break;
; 0007 00DE             case FREQ_50Hz :
; 0007 00DF                             buzzer_50hz_flag=0;
; 0007 00E0                             break;
; 0007 00E1             case FREQ_75Hz :
; 0007 00E2                             buzzer_75hz_flag=0;
; 0007 00E3                             break;
; 0007 00E4             case FREQ_100Hz :
; 0007 00E5                             buzzer_100hz_flag=0;
; 0007 00E6                             break;
; 0007 00E7             case FREQ_150Hz :
; 0007 00E8                             buzzer_150hz_flag=0;
; 0007 00E9                             break;
; 0007 00EA             case FREQ_180Hz :
; 0007 00EB                             buzzer_180hz_flag=0;
; 0007 00EC                             break;
; 0007 00ED             case FREQ_200Hz :
; 0007 00EE                             buzzer_200hz_flag=0;
; 0007 00EF                             break;
; 0007 00F0             default :
; 0007 00F1                             break;
; 0007 00F2         }
; 0007 00F3         */
; 0007 00F4         buzzer_over_watt_flag=0;
	STS  _buzzer_over_watt_flag,R30
; 0007 00F5         buzzer_plate_alram_flag=0;
	STS  _buzzer_plate_alram_flag,R30
; 0007 00F6         buzzer_fan_error_flag=0;
	STS  _buzzer_fan_error_flag,R30
; 0007 00F7 
; 0007 00F8         buzzer_up_flag=0;
	STS  _buzzer_up_flag,R30
; 0007 00F9         buzzer_down_flag=0;
	STS  _buzzer_down_flag,R30
; 0007 00FA         buzzer_start_flag=0;
	STS  _buzzer_start_flag,R30
; 0007 00FB 
; 0007 00FC         Clrbit(SPEAKER_PORT, SPEAKER);
	CBI  0x18,4
; 0007 00FD         buzzeractionflag=0;
	RJMP _0xE0016
; 0007 00FE     }
; 0007 00FF     else
_0xE0014:
; 0007 0100     {
; 0007 0101         noteindex++;
	LDS  R30,_noteindex
	SUBI R30,-LOW(1)
	STS  _noteindex,R30
; 0007 0102         Setbit(SPEAKER_PORT, SPEAKER);
	SBI  0x18,4
; 0007 0103         buzzeractionflag=1;
	LDI  R30,LOW(1)
_0xE0016:
	STS  _buzzeractionflag,R30
; 0007 0104     }
; 0007 0105 
; 0007 0106 }
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __ACTION_H__
;#include "action.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#ifndef __IO_H__
;#include "io.h"
;#endif
;
;#ifndef __ADC_H__
;#include "adc.h"
;#endif
;
;#ifndef __TIME_H__
;#include "time.h"
;#endif
;
;
;#include "../TCN75/TCN75.h"
;#include "../ADS1248/ADS1248.h"
;#include "../DAC7611/DAC7611.h"
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;
;int gCurTemp=0;
;volatile Uchar impedance_check_flag;
;BYTE gReadIntTempFlag = 0;
;BYTE gAD_Channel = 0;
;Uchar bipol_relay_time = 0;
;float gI_err = 0.0f;
;float prev_err = 0.0f;
;const float gLimite_err = 80.0f;
;extern int gExtTemp;
;
;extern UART_DATA UD;
;extern TIMEFLAG TF;
;extern volatile Uint imp_value,imp_vol,imp_cur;
;extern volatile Uchar buzzer_cut_hand_flag,buzzer_coa_hand_flag,buzzer_cut_foot_flag,buzzer_coa_foot_flag,buzzer_bip_fla ...
;extern volatile Uchar buzzer_up_flag,buzzer_down_flag,buzzer_start_flag,buzzer_plate_alram_flag,buzzer_fan_error_flag,bu ...
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;void _total_start_stop_(void); //star & stop
;void _blend_off_hand_start_(void);//start
;void _blend_1_hand_start_(void);//start
;void _blend_2_hand_start_(void);//start
;void _blend_off_foot_start_(void);//start
;void _blend_1_foot_start_(void);//start
;void _blend_2_foot_start_(void);//start
;
;void _contact_hand_start_(void);//start
;void _spray_hand_start_(void);//start
;void _contact_foot_start_(void);//start
;void _spray_foot_start_(void);//start
;
;void _imp_sense_off_start(void);
;void _imp_sense_on_start(void);
;void _total_stop_(void); //stop
;
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;void ACTION_Schedule(void)
; 0008 004D {

	.CSEG
_ACTION_Schedule:
; .FSTART _ACTION_Schedule
; 0008 004E 
; 0008 004F   _total_start_stop_(); //star & stop
	RCALL __total_start_stop_
; 0008 0050 
; 0008 0051     if( UD.startflag==RUN )  //start
	__GETB2MN _UD,12
	CPI  R26,LOW(0x1)
	BRNE _0x100003
; 0008 0052     {
; 0008 0053         switch( UD.action_mode )
	__GETB1MN _UD,15
; 0008 0054         {
; 0008 0055             case BLEND_OFF_HAND://cut
	CPI  R30,LOW(0x1)
	BRNE _0x100007
; 0008 0056                                 _blend_off_hand_start_();
	RCALL __blend_off_hand_start_
; 0008 0057                                 break;
	RJMP _0x100006
; 0008 0058 
; 0008 0059             case BLEND_1_HAND: //cut
_0x100007:
	CPI  R30,LOW(0x2)
	BRNE _0x100008
; 0008 005A                                 _blend_1_hand_start_();
	RCALL __blend_1_hand_start_
; 0008 005B                                 break;
	RJMP _0x100006
; 0008 005C 
; 0008 005D             case BLEND_2_HAND: //cut
_0x100008:
	CPI  R30,LOW(0x3)
	BRNE _0x100009
; 0008 005E                                 _blend_2_hand_start_();
	RCALL __blend_2_hand_start_
; 0008 005F                                 break;
	RJMP _0x100006
; 0008 0060 
; 0008 0061             case BLEND_OFF_FOOT://cut
_0x100009:
	CPI  R30,LOW(0x4)
	BRNE _0x10000A
; 0008 0062                                 _blend_off_foot_start_();
	RCALL __blend_off_foot_start_
; 0008 0063                                 break;
	RJMP _0x100006
; 0008 0064 
; 0008 0065             case BLEND_1_FOOT: //cut
_0x10000A:
	CPI  R30,LOW(0x5)
	BRNE _0x10000B
; 0008 0066                                 _blend_1_foot_start_();
	RCALL __blend_1_foot_start_
; 0008 0067                                 break;
	RJMP _0x100006
; 0008 0068 
; 0008 0069             case BLEND_2_FOOT: //cut
_0x10000B:
	CPI  R30,LOW(0x6)
	BRNE _0x10000C
; 0008 006A                                 _blend_2_foot_start_();
	RCALL __blend_2_foot_start_
; 0008 006B                                 break;
	RJMP _0x100006
; 0008 006C 
; 0008 006D             case CONTACT_HAND: //coa
_0x10000C:
	CPI  R30,LOW(0x7)
	BRNE _0x10000D
; 0008 006E                                  _contact_hand_start_();
	RCALL __contact_hand_start_
; 0008 006F                                 break;
	RJMP _0x100006
; 0008 0070 
; 0008 0071             case SPRAY_HAND:   //coa
_0x10000D:
	CPI  R30,LOW(0x8)
	BRNE _0x10000E
; 0008 0072                                 _spray_hand_start_();
	RCALL __spray_hand_start_
; 0008 0073                                 break;
	RJMP _0x100006
; 0008 0074 
; 0008 0075             case CONTACT_FOOT: //coa
_0x10000E:
	CPI  R30,LOW(0x9)
	BRNE _0x10000F
; 0008 0076                                  _contact_foot_start_();
	RCALL __contact_foot_start_
; 0008 0077                                 break;
	RJMP _0x100006
; 0008 0078 
; 0008 0079             case SPRAY_FOOT:   //coa
_0x10000F:
	CPI  R30,LOW(0xA)
	BRNE _0x100010
; 0008 007A                                 _spray_foot_start_();
	RCALL __spray_foot_start_
; 0008 007B                                 break;
	RJMP _0x100006
; 0008 007C 
; 0008 007D             case IMP_SENSE_OFF:  // bipol
_0x100010:
	CPI  R30,LOW(0xB)
	BRNE _0x100011
; 0008 007E                                 _imp_sense_off_start();
	RCALL __imp_sense_off_start
; 0008 007F                                 break;
	RJMP _0x100006
; 0008 0080 
; 0008 0081             case IMP_SENSE_ON: //bipol
_0x100011:
	CPI  R30,LOW(0xC)
	BRNE _0x100013
; 0008 0082                                 _imp_sense_on_start();
	RCALL __imp_sense_on_start
; 0008 0083                                 break;
; 0008 0084 
; 0008 0085             default :
_0x100013:
; 0008 0086                                 break;
; 0008 0087       }
_0x100006:
; 0008 0088     }
; 0008 0089     else if(UD.startflag==STOP)
	RJMP _0x100014
_0x100003:
	__GETB1MN _UD,12
	CPI  R30,0
	BRNE _0x100015
; 0008 008A     {
; 0008 008B         _total_stop_();
	RCALL __total_stop_
; 0008 008C     } //stop
; 0008 008D }
_0x100015:
_0x100014:
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
	LDS  R30,_gAD_Channel
	CPI  R30,0
	BRNE _0x100016
	CALL _AD_ReadExTTemp
; 0008 0094      else if( gAD_Channel == 1 ) AD_ReadVoltage();
	RJMP _0x100017
_0x100016:
	LDS  R26,_gAD_Channel
	CPI  R26,LOW(0x1)
	BRNE _0x100018
	CALL _AD_ReadVoltage
; 0008 0095      else if( gAD_Channel == 2 ) AD_ReadCurrent();
	RJMP _0x100019
_0x100018:
	LDS  R26,_gAD_Channel
	CPI  R26,LOW(0x2)
	BRNE _0x10001A
	CALL _AD_ReadCurrent
; 0008 0096 
; 0008 0097      gAD_Channel++;
_0x10001A:
_0x100019:
_0x100017:
	LDS  R30,_gAD_Channel
	SUBI R30,-LOW(1)
	STS  _gAD_Channel,R30
; 0008 0098      if( gAD_Channel >=  3 )
	LDS  R26,_gAD_Channel
	CPI  R26,LOW(0x3)
	BRLO _0x10001B
; 0008 0099         gAD_Channel = 0;
	LDI  R30,LOW(0)
	STS  _gAD_Channel,R30
; 0008 009A 
; 0008 009B      if( gAD_Channel == 0 ) mRealCh = 0;
_0x10001B:
	LDS  R30,_gAD_Channel
	CPI  R30,0
	BRNE _0x10001C
	LDI  R17,LOW(0)
; 0008 009C      else if( gAD_Channel == 1 ) mRealCh = 6;
	RJMP _0x10001D
_0x10001C:
	LDS  R26,_gAD_Channel
	CPI  R26,LOW(0x1)
	BRNE _0x10001E
	LDI  R17,LOW(6)
; 0008 009D      else if( gAD_Channel == 2 ) mRealCh = 7;
	RJMP _0x10001F
_0x10001E:
	LDS  R26,_gAD_Channel
	CPI  R26,LOW(0x2)
	BRNE _0x100020
	LDI  R17,LOW(7)
; 0008 009E      else  mRealCh = 8;
	RJMP _0x100021
_0x100020:
	LDI  R17,LOW(8)
; 0008 009F 
; 0008 00A0      ADS1248_ChangeChannel( mRealCh );
_0x100021:
_0x10001F:
_0x10001D:
	MOV  R26,R17
	CALL _ADS1248_ChangeChannel
; 0008 00A1 }
	LD   R17,Y+
	RET
; .FEND
;
;//******************************************************************************
;// Local Functions
;//******************************************************************************
;void _total_start_stop_(void) //star & stop
; 0008 00A7 {
__total_start_stop_:
; .FSTART __total_start_stop_
; 0008 00A8     IO_over_watt_detect_function_();
	CALL _IO_over_watt_detect_function_
; 0008 00A9    // IO_fan_error_function_();
; 0008 00AA     IO_plate_error_function_();
	CALL _IO_plate_error_function_
; 0008 00AB     Temp_over_detect_function_();
	CALL _Temp_over_detect_function_
; 0008 00AC 
; 0008 00AD  //   AD_Convert_Calculator_Proc(IMP_VOLTAGE_ADC);
; 0008 00AE   //  AD_Convert_Calculator_Proc(IMP_CURRENT_ADC);
; 0008 00AF 
; 0008 00B0     if( gReadIntTempFlag == ON )
	LDS  R26,_gReadIntTempFlag
	CPI  R26,LOW(0x1)
	BRNE _0x100022
; 0008 00B1     {
; 0008 00B2        gReadIntTempFlag = OFF;
	LDI  R30,LOW(0)
	STS  _gReadIntTempFlag,R30
; 0008 00B3        gCurTemp = TCN75_Read();
	CALL _TCN75_Read
	STS  _gCurTemp,R30
	STS  _gCurTemp+1,R31
; 0008 00B4 
; 0008 00B5        ADCProcessor();
	RCALL _ADCProcessor
; 0008 00B6     }
; 0008 00B7 
; 0008 00B8 }
_0x100022:
	RET
; .FEND
;//******************************************************************************
;void _blend_off_hand_start_(void)//start
; 0008 00BB {
__blend_off_hand_start_:
; .FSTART __blend_off_hand_start_
; 0008 00BC     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3A
; 0008 00BD     IO_CLR_monopol_watt_sel();
; 0008 00BE 
; 0008 00BF     //2016-04-15
; 0008 00C0     //if(UD.mono_relay_flag==1)
; 0008 00C1     {
; 0008 00C2         IO_CLR_monopol_hand_sig_out();
; 0008 00C3         IO_SET_monopol_foot_sig_out();
; 0008 00C4     }
; 0008 00C5 
; 0008 00C6     buzzer_cut_hand_flag=1;
; 0008 00C7 
; 0008 00C8     TIME_pwm_33Khz_setting(F_BLEND_OFF);
	LDI  R26,LOW(1)
	RJMP _0x20A000F
; 0008 00C9 
; 0008 00CA }
; .FEND
;//******************************************************************************
;void _blend_1_hand_start_(void)//start
; 0008 00CD {
__blend_1_hand_start_:
; .FSTART __blend_1_hand_start_
; 0008 00CE     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3A
; 0008 00CF     IO_CLR_monopol_watt_sel();
; 0008 00D0 
; 0008 00D1     //2016-04-15
; 0008 00D2     //if(UD.mono_relay_flag==1)
; 0008 00D3     {
; 0008 00D4         IO_CLR_monopol_hand_sig_out();
; 0008 00D5         IO_SET_monopol_foot_sig_out();
; 0008 00D6     }
; 0008 00D7 
; 0008 00D8     buzzer_cut_hand_flag=1;
; 0008 00D9 
; 0008 00DA     TIME_pwm_33Khz_setting(F_BLEND_1);
	LDI  R26,LOW(2)
	RJMP _0x20A000F
; 0008 00DB }
; .FEND
;//******************************************************************************
;void _blend_2_hand_start_(void)//start
; 0008 00DE {
__blend_2_hand_start_:
; .FSTART __blend_2_hand_start_
; 0008 00DF     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3A
; 0008 00E0     IO_CLR_monopol_watt_sel();
; 0008 00E1 
; 0008 00E2     //2016-04-15
; 0008 00E3     //if(UD.mono_relay_flag==1)
; 0008 00E4     {
; 0008 00E5         IO_CLR_monopol_hand_sig_out();
; 0008 00E6         IO_SET_monopol_foot_sig_out();
; 0008 00E7     }
; 0008 00E8 
; 0008 00E9     buzzer_cut_hand_flag=1;
; 0008 00EA 
; 0008 00EB     TIME_pwm_33Khz_setting(F_BLEND_2);
	LDI  R26,LOW(3)
	RJMP _0x20A000F
; 0008 00EC }
; .FEND
;
;//******************************************************************************
;void _blend_off_foot_start_(void)//start
; 0008 00F0 {
__blend_off_foot_start_:
; .FSTART __blend_off_foot_start_
; 0008 00F1     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3B
; 0008 00F2     IO_CLR_monopol_watt_sel();
; 0008 00F3 
; 0008 00F4     //2016-04-15
; 0008 00F5     //if(UD.mono_relay_flag==1)
; 0008 00F6     {
; 0008 00F7         IO_CLR_monopol_foot_sig_out();
; 0008 00F8         IO_SET_monopol_hand_sig_out();
; 0008 00F9     }
; 0008 00FA 
; 0008 00FB     buzzer_cut_foot_flag=1;
; 0008 00FC 
; 0008 00FD     TIME_pwm_33Khz_setting(F_BLEND_OFF);
	LDI  R26,LOW(1)
	RJMP _0x20A000F
; 0008 00FE }
; .FEND
;//******************************************************************************
;void _blend_1_foot_start_(void)//start
; 0008 0101 {
__blend_1_foot_start_:
; .FSTART __blend_1_foot_start_
; 0008 0102     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3B
; 0008 0103     IO_CLR_monopol_watt_sel();
; 0008 0104 
; 0008 0105     //2016-04-15
; 0008 0106     //if(UD.mono_relay_flag==1)
; 0008 0107     {
; 0008 0108         IO_CLR_monopol_foot_sig_out();
; 0008 0109         IO_SET_monopol_hand_sig_out();
; 0008 010A     }
; 0008 010B 
; 0008 010C     buzzer_cut_foot_flag=1;
; 0008 010D 
; 0008 010E     TIME_pwm_33Khz_setting(F_BLEND_1);
	LDI  R26,LOW(2)
	RJMP _0x20A000F
; 0008 010F }
; .FEND
;//******************************************************************************
;void _blend_2_foot_start_(void)//start
; 0008 0112 {
__blend_2_foot_start_:
; .FSTART __blend_2_foot_start_
; 0008 0113     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3B
; 0008 0114     IO_CLR_monopol_watt_sel();
; 0008 0115 
; 0008 0116     //2016-04-15
; 0008 0117     //if(UD.mono_relay_flag==1)
; 0008 0118     {
; 0008 0119         IO_CLR_monopol_foot_sig_out();
; 0008 011A         IO_SET_monopol_hand_sig_out();
; 0008 011B     }
; 0008 011C 
; 0008 011D     buzzer_cut_foot_flag=1;
; 0008 011E 
; 0008 011F     TIME_pwm_33Khz_setting(F_BLEND_2);
	LDI  R26,LOW(3)
	RJMP _0x20A000F
; 0008 0120 }
; .FEND
;//******************************************************************************
;void _contact_hand_start_(void)//start
; 0008 0123 {
__contact_hand_start_:
; .FSTART __contact_hand_start_
; 0008 0124     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3C
; 0008 0125     IO_CLR_monopol_watt_sel();
; 0008 0126 
; 0008 0127     //2016-04-15
; 0008 0128     // if(UD.mono_relay_flag==1)
; 0008 0129     {
; 0008 012A         IO_CLR_monopol_hand_sig_out();
; 0008 012B         IO_SET_monopol_foot_sig_out();
; 0008 012C     }
; 0008 012D 
; 0008 012E     buzzer_coa_hand_flag=1;
; 0008 012F 
; 0008 0130     TIME_pwm_33Khz_setting(F_CONTACT);
	RJMP _0x20A000E
; 0008 0131 }
; .FEND
;//******************************************************************************
;void _spray_hand_start_(void)//start
; 0008 0134 {
__spray_hand_start_:
; .FSTART __spray_hand_start_
; 0008 0135     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3C
; 0008 0136     IO_CLR_monopol_watt_sel();
; 0008 0137 
; 0008 0138     //2016-04-15
; 0008 0139     //if(UD.mono_relay_flag==1)
; 0008 013A     {
; 0008 013B         IO_CLR_monopol_hand_sig_out();
; 0008 013C         IO_SET_monopol_foot_sig_out();
; 0008 013D      }
; 0008 013E 
; 0008 013F      buzzer_coa_hand_flag=1;
; 0008 0140 
; 0008 0141     TIME_pwm_33Khz_setting(F_SPRAY);
	RJMP _0x20A000D
; 0008 0142     IO_CLR_monopol_spray_cont_relay();
; 0008 0143 }
; .FEND
;//******************************************************************************
;void _contact_foot_start_(void)//start
; 0008 0146 {
__contact_foot_start_:
; .FSTART __contact_foot_start_
; 0008 0147     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3D
; 0008 0148     IO_CLR_monopol_watt_sel();
; 0008 0149 
; 0008 014A     //2016-04-15
; 0008 014B     //if(UD.mono_relay_flag==1)
; 0008 014C     {
; 0008 014D         IO_CLR_monopol_foot_sig_out();
; 0008 014E         IO_SET_monopol_hand_sig_out();
; 0008 014F     }
; 0008 0150 
; 0008 0151      buzzer_coa_foot_flag=1;
; 0008 0152 
; 0008 0153     TIME_pwm_33Khz_setting(F_CONTACT);
_0x20A000E:
	LDI  R26,LOW(4)
_0x20A000F:
	CALL _TIME_pwm_33Khz_setting
; 0008 0154 }
	RET
; .FEND
;//******************************************************************************
;void _spray_foot_start_(void)//start
; 0008 0157 {
__spray_foot_start_:
; .FSTART __spray_foot_start_
; 0008 0158     IO_CLR_bipol_monopol_power_sel();
	CALL SUBOPT_0x3D
; 0008 0159     IO_CLR_monopol_watt_sel();
; 0008 015A 
; 0008 015B     //2016-04-15
; 0008 015C     // if(UD.mono_relay_flag==1)
; 0008 015D     {
; 0008 015E         IO_CLR_monopol_foot_sig_out();
; 0008 015F         IO_SET_monopol_hand_sig_out();
; 0008 0160     }
; 0008 0161 
; 0008 0162     buzzer_coa_foot_flag=1;
; 0008 0163 
; 0008 0164     TIME_pwm_33Khz_setting(F_SPRAY);
_0x20A000D:
	LDI  R26,LOW(5)
	CALL _TIME_pwm_33Khz_setting
; 0008 0165     IO_CLR_monopol_spray_cont_relay();
	CALL _IO_CLR_monopol_spray_cont_relay
; 0008 0166   //  IO_spray_relay(LOW);
; 0008 0167 
; 0008 0168 }
	RET
; .FEND
;
;//******************************************************************************
;void _imp_sense_off_start(void)
; 0008 016C {
__imp_sense_off_start:
; .FSTART __imp_sense_off_start
; 0008 016D     IO_SET_bipol_monopol_power_sel();
	CALL SUBOPT_0x3E
; 0008 016E     IO_SET_monopol_watt_sel();
; 0008 016F 
; 0008 0170     IO_SET_monopol_foot_sig_out();
; 0008 0171     IO_SET_monopol_hand_sig_out();
; 0008 0172 
; 0008 0173     TIME_pwm_33Khz_setting(F_IMP_SENSE_OFF);
	LDI  R26,LOW(6)
	CALL _TIME_pwm_33Khz_setting
; 0008 0174 
; 0008 0175     //2016-04-15
; 0008 0176     // if( UD.bipol_relay_flag==1 )
; 0008 0177     {
; 0008 0178         IO_spray_relay(LOW);
	CALL SUBOPT_0x3F
; 0008 0179     }
; 0008 017A 
; 0008 017B     buzzer_bip_flag=1;
; 0008 017C }
	RET
; .FEND
;
;void PidControl( void )
; 0008 017F {
_PidControl:
; .FSTART _PidControl
; 0008 0180    #define SA_Kp  0.02f
; 0008 0181    #define SA_Ki  0.03f
; 0008 0182    #define SA_Kd  0.001f
; 0008 0183 
; 0008 0184    float err   = 0.0f;                // 오차. 이전 오차
; 0008 0185    float D_err = 0.0f;                // 오차적분. 오차미분
; 0008 0186    float Kp_term, Ki_term, Kd_term;   // p항, i항, d항
; 0008 0187    float control;
; 0008 0188    int mVoltage;
; 0008 0189    float windupguard;
; 0008 018A 
; 0008 018B   // int mImp = UD.voltage/UD.current;
; 0008 018C    err = (float)UD.coa_contact_power+42.0f - (float)gExtTemp/10.0f;
	SBIW R28,28
	LDI  R30,LOW(0)
	STD  Y+20,R30
	STD  Y+21,R30
	STD  Y+22,R30
	STD  Y+23,R30
	STD  Y+24,R30
	STD  Y+25,R30
	STD  Y+26,R30
	STD  Y+27,R30
	ST   -Y,R17
	ST   -Y,R16
;	err -> Y+26
;	D_err -> Y+22
;	Kp_term -> Y+18
;	Ki_term -> Y+14
;	Kd_term -> Y+10
;	control -> Y+6
;	mVoltage -> R16,R17
;	windupguard -> Y+2
	CALL SUBOPT_0x40
	CALL SUBOPT_0x41
	__GETD2N 0x42280000
	CALL __ADDF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R4
	CALL SUBOPT_0x41
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x42
	CALL __DIVF21
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL SUBOPT_0x43
	__PUTD1S 26
; 0008 018D 
; 0008 018E    Kp_term = SA_Kp * err;   // p항 = Kp*오차
	CALL SUBOPT_0x44
	__GETD2N 0x3CA3D70A
	CALL __MULF12
	CALL SUBOPT_0x45
; 0008 018F    gI_err += err ;
	CALL SUBOPT_0x44
	CALL SUBOPT_0x46
	CALL __ADDF12
	CALL SUBOPT_0x47
; 0008 0190 
; 0008 0191  //  if( mImp > 900  )
; 0008 0192  //  {
; 0008 0193  //         Kp_term = 1.0f;
; 0008 0194  //         gI_err = 0.0f;
; 0008 0195  //  }
; 0008 0196    if(err <= 0.0f )
	__GETD2S 26
	CALL __CPD02
	BRLT _0x100023
; 0008 0197    {
; 0008 0198       // Kp_term = 1.0f;
; 0008 0199        gI_err = gI_err * 2.0f/3.0f;
	CALL SUBOPT_0x46
	__GETD1N 0x40000000
	CALL SUBOPT_0x48
	__GETD1N 0x40400000
	CALL __DIVF21
	CALL SUBOPT_0x47
; 0008 019A     }
; 0008 019B    windupguard = gLimite_err/SA_Ki;
_0x100023:
	__GETD1N 0x4526AAAB
	CALL SUBOPT_0x49
; 0008 019C 
; 0008 019D    if( gI_err > windupguard )      gI_err = windupguard;
	CALL SUBOPT_0x46
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x100024
	CALL SUBOPT_0x4A
	RJMP _0x10002E
; 0008 019E    else if( gI_err <-windupguard ) gI_err = -windupguard;
_0x100024:
	CALL SUBOPT_0x4A
	CALL __ANEGF1
	CALL SUBOPT_0x46
	CALL __CMPF12
	BRSH _0x100026
	CALL SUBOPT_0x4A
	CALL __ANEGF1
_0x10002E:
	STS  _gI_err,R30
	STS  _gI_err+1,R31
	STS  _gI_err+2,R22
	STS  _gI_err+3,R23
; 0008 019F 
; 0008 01A0    Ki_term = SA_Ki * gI_err;           // i항 = Ki*오차적분
_0x100026:
	LDS  R30,_gI_err
	LDS  R31,_gI_err+1
	LDS  R22,_gI_err+2
	LDS  R23,_gI_err+3
	__GETD2N 0x3CF5C28F
	CALL __MULF12
	CALL SUBOPT_0x4B
; 0008 01A1 
; 0008 01A2    D_err = (err - prev_err) ;          // 오차미분 = (현재오차-이전오차)/dt
	LDS  R26,_prev_err
	LDS  R27,_prev_err+1
	LDS  R24,_prev_err+2
	LDS  R25,_prev_err+3
	CALL SUBOPT_0x44
	CALL __SUBF12
	__PUTD1S 22
; 0008 01A3    Kd_term = SA_Kd * D_err;            // d항 = Kd*오차미분
	__GETD2N 0x3A83126F
	CALL SUBOPT_0x4C
; 0008 01A4    prev_err  = err;                    // 현재오차를 이전오차로
	CALL SUBOPT_0x44
	STS  _prev_err,R30
	STS  _prev_err+1,R31
	STS  _prev_err+2,R22
	STS  _prev_err+3,R23
; 0008 01A5 
; 0008 01A6    control = Kp_term + Ki_term + Kd_term;   // 제어량 = p항+i항+d항
	__GETD1S 14
	CALL SUBOPT_0x4D
	CALL __ADDF12
	CALL SUBOPT_0x4E
	CALL SUBOPT_0x4F
; 0008 01A7    mVoltage = (int)control;//*1.17f;
	CALL SUBOPT_0x50
	CALL __CFD1
	MOVW R16,R30
; 0008 01A8 
; 0008 01A9    if( mVoltage < 0 )   mVoltage = 0;
	TST  R17
	BRPL _0x100027
	__GETWRN 16,17,0
; 0008 01AA    if ( mVoltage > UD.imp_sense_power*5.0f ) mVoltage  = UD.imp_sense_power*5.0f;
_0x100027:
	CALL SUBOPT_0x51
	MOVW R26,R16
	CALL __CWD2
	CALL __CDF2
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x100028
	CALL SUBOPT_0x51
	CALL __CFD1
	MOVW R16,R30
; 0008 01AB 
; 0008 01AC    DAC7611_WriteVoltage( mVoltage );
_0x100028:
	MOVW R26,R16
	CALL _DAC7611_WriteVoltage
; 0008 01AD }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,30
	RET
; .FEND
;
;//******************************************************************************
;void _imp_sense_on_start(void)
; 0008 01B1 {
__imp_sense_on_start:
; .FSTART __imp_sense_on_start
; 0008 01B2     IO_SET_bipol_monopol_power_sel();
	CALL SUBOPT_0x3E
; 0008 01B3     IO_SET_monopol_watt_sel();
; 0008 01B4 
; 0008 01B5     IO_SET_monopol_foot_sig_out();
; 0008 01B6     IO_SET_monopol_hand_sig_out();
; 0008 01B7 
; 0008 01B8     TIME_pwm_33Khz_setting(F_IMP_SENSE_ON);
	LDI  R26,LOW(7)
	CALL _TIME_pwm_33Khz_setting
; 0008 01B9 
; 0008 01BA  //   DAC7611_WriteVoltage( UD.imp_sense_power );
; 0008 01BB 
; 0008 01BC     HIGH_PWM;
	SBI  0x1B,4
; 0008 01BD     //2016-04-15
; 0008 01BE     // if( UD.bipol_relay_flag == 1 )
; 0008 01BF     {
; 0008 01C0         IO_spray_relay(LOW);
	CALL SUBOPT_0x3F
; 0008 01C1     }
; 0008 01C2     buzzer_bip_flag=1;
; 0008 01C3 
; 0008 01C4     if( impedance_check_flag == ON )
	LDS  R26,_impedance_check_flag
	CPI  R26,LOW(0x1)
	BRNE _0x10002B
; 0008 01C5     {
; 0008 01C6        // impedance_value(UD.imp_sense_power);
; 0008 01C7        PidControl();
	RCALL _PidControl
; 0008 01C8     }
; 0008 01C9 }
_0x10002B:
	RET
; .FEND
;
;
;//******************************************************************************
;void _total_stop_(void) //stop
; 0008 01CE {
__total_stop_:
; .FSTART __total_stop_
; 0008 01CF     TIME_pwm_33Khz_setting(F_TOTAL_STOP);
	LDI  R26,LOW(8)
	CALL _TIME_pwm_33Khz_setting
; 0008 01D0 
; 0008 01D1     IO_SET_monopol_foot_sig_out();
	CALL SUBOPT_0x2
; 0008 01D2     IO_SET_monopol_hand_sig_out();
; 0008 01D3     IO_SET_monopol_spray_cont_relay();
	CALL _IO_SET_monopol_spray_cont_relay
; 0008 01D4     IO_spray_relay(HIGH);
	LDI  R26,LOW(1)
	CALL _IO_spray_relay
; 0008 01D5 
; 0008 01D6     LOW_PWM;
	CBI  0x1B,4
; 0008 01D7     DAC7611_WriteVoltage( 0 );
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL _DAC7611_WriteVoltage
; 0008 01D8 
; 0008 01D9     buzzer_cut_hand_flag=0;
	LDI  R30,LOW(0)
	STS  _buzzer_cut_hand_flag,R30
; 0008 01DA     buzzer_coa_hand_flag=0;
	STS  _buzzer_coa_hand_flag,R30
; 0008 01DB     buzzer_cut_foot_flag=0;
	STS  _buzzer_cut_foot_flag,R30
; 0008 01DC     buzzer_coa_foot_flag=0;
	STS  _buzzer_coa_foot_flag,R30
; 0008 01DD 
; 0008 01DE     gI_err = 0.0f;
	STS  _gI_err,R30
	STS  _gI_err+1,R30
	STS  _gI_err+2,R30
	STS  _gI_err+3,R30
; 0008 01DF 
; 0008 01E0 }
	RET
; .FEND
;
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __ADC_H__
;#include "adc.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;volatile Sint imp_value=0,imp_vol=0,imp_cur=0;
;
;extern UART_DATA UD;
;extern volatile int fan_data,plate_data;
;
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;void AD_Convert_Calculator_Proc(unsigned char ch)
; 0009 001C {

	.CSEG
_AD_Convert_Calculator_Proc:
; .FSTART _AD_Convert_Calculator_Proc
; 0009 001D     ADMUX=ch;
	ST   -Y,R26
;	ch -> Y+0
	LD   R30,Y
	OUT  0x7,R30
; 0009 001E     ADCSRA=0x85;
	LDI  R30,LOW(133)
	OUT  0x6,R30
; 0009 001F     ADC_START;
	SBI  0x6,6
; 0009 0020     while(!ADC_EOC);
_0x120005:
	SBIS 0x6,4
	RJMP _0x120005
; 0009 0021     if(ch==IMP_VOLTAGE_ADC){imp_vol=(ADCW>>1);}
	LD   R30,Y
	CPI  R30,0
	BRNE _0x120008
	IN   R30,0x4
	IN   R31,0x4+1
	LSR  R31
	ROR  R30
	STS  _imp_vol,R30
	STS  _imp_vol+1,R31
; 0009 0022     if(ch==IMP_CURRENT_ADC){imp_cur=(ADCW>>1);}
_0x120008:
	LD   R26,Y
	CPI  R26,LOW(0x1)
	BRNE _0x120009
	IN   R30,0x4
	IN   R31,0x4+1
	LSR  R31
	ROR  R30
	STS  _imp_cur,R30
	STS  _imp_cur+1,R31
; 0009 0023     if(ch==PLATE_DETECT_ADC){plate_data=ADCW;plate_data=(plate_data/2)+1;}
_0x120009:
	LD   R26,Y
	CPI  R26,LOW(0x4)
	BRNE _0x12000A
	IN   R30,0x4
	IN   R31,0x4+1
	STS  _plate_data,R30
	STS  _plate_data+1,R31
	LDS  R26,_plate_data
	LDS  R27,_plate_data+1
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	ADIW R30,1
	STS  _plate_data,R30
	STS  _plate_data+1,R31
; 0009 0024     if(ch==FAN_ERROR_TEMP_ADC){fan_data=ADCW; fan_data=(fan_data/2)+1; }
_0x12000A:
	LD   R26,Y
	CPI  R26,LOW(0x2)
	BRNE _0x12000B
	IN   R30,0x4
	IN   R31,0x4+1
	STS  _fan_data,R30
	STS  _fan_data+1,R31
	LDS  R26,_fan_data
	LDS  R27,_fan_data+1
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	CALL __DIVW21
	ADIW R30,1
	STS  _fan_data,R30
	STS  _fan_data+1,R31
; 0009 0025     ADC_STOP;
_0x12000B:
	CBI  0x6,6
; 0009 0026 }
	JMP  _0x20A0005
; .FEND
;//******************************************************************************
;void impedance_value(Uint power_data)
; 0009 0029 {
; 0009 002A     if(power_data==0)
;	power_data -> Y+0
; 0009 002B     {
; 0009 002C       UD.alram_mode = IMPEDANCE_OVER;
; 0009 002D     }
; 0009 002E     else
; 0009 002F     {
; 0009 0030         if(imp_vol!=0 && imp_cur!=0)
; 0009 0031         {
; 0009 0032             imp_value=((imp_vol*10)/imp_cur);
; 0009 0033 
; 0009 0034             /*
; 0009 0035             if(power_data<=5){if(imp_value>30){UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.a ...
; 0009 0036             else if(power_data>5&&power_data<=10){if(imp_value>22){UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode== ...
; 0009 0037             else if(power_data>10&&power_data<=15){if(imp_value>21){UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode= ...
; 0009 0038             else if(power_data>15&&power_data<=20){if(imp_value>19){UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode= ...
; 0009 0039             */
; 0009 003A             if( power_data<=5 )
; 0009 003B             {
; 0009 003C                if( imp_value>27 || imp_cur > 135 )
; 0009 003D                {UD.alram_mode = IMPEDANCE_OVER;}else{if( UD.alram_mode == IMPEDANCE_OVER ){UD.alram_mode = ALRAM_OFF;}}
; 0009 003E             }
; 0009 003F             else if(power_data>5&&power_data<=10)
; 0009 0040             {
; 0009 0041                if(imp_value>17|| imp_cur > 170)
; 0009 0042                {UD.alram_mode = IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0043             }
; 0009 0044             else if(power_data>10&&power_data<=15)
; 0009 0045             {
; 0009 0046                if(imp_value>16|| imp_cur > 240)
; 0009 0047                {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0048             }
; 0009 0049             else if(power_data>15&&power_data<=20)
; 0009 004A             {
; 0009 004B                if(imp_value>14|| imp_cur > 245)
; 0009 004C                {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 004D             }
; 0009 004E             else if(power_data>20&&power_data<=25)
; 0009 004F             {
; 0009 0050                if(imp_value>17|| imp_cur > 270)
; 0009 0051                {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0052             }
; 0009 0053             else if(power_data>25&&power_data<=30)
; 0009 0054             {
; 0009 0055                if(imp_value>17|| imp_cur > 285)
; 0009 0056                {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0057             }
; 0009 0058             else if(power_data>30&&power_data<=35)
; 0009 0059             {
; 0009 005A               if(imp_value>16|| imp_cur > 310)
; 0009 005B               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 005C             }
; 0009 005D             else if(power_data>35&&power_data<=40)
; 0009 005E             {
; 0009 005F               if(imp_value>16|| imp_cur > 350 )
; 0009 0060               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0061             }
; 0009 0062             else if(power_data>40&&power_data<=45)
; 0009 0063             {
; 0009 0064               if(imp_value>15|| imp_cur > 345)
; 0009 0065               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0066             }
; 0009 0067             else if(power_data>45&&power_data<=50)
; 0009 0068             {
; 0009 0069               if(imp_value>15|| imp_cur > 355 )
; 0009 006A               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 006B             }
; 0009 006C             else if(power_data>50&&power_data<=55)
; 0009 006D             {
; 0009 006E               if(imp_value>15 || imp_cur >380 )
; 0009 006F               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0070             }
; 0009 0071             else if(power_data>55&&power_data<=60)
; 0009 0072             {
; 0009 0073               if(imp_value>15 || imp_cur > 400 )
; 0009 0074               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0075             }
; 0009 0076             else if(power_data>60&&power_data<=65)
; 0009 0077             {
; 0009 0078               if(imp_value>15 || imp_cur > 410 )
; 0009 0079               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 007A             }
; 0009 007B             else if(power_data>65&&power_data<=70)
; 0009 007C             {
; 0009 007D               if(imp_value>15 || imp_cur > 420 )
; 0009 007E               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 007F             }
; 0009 0080             else if(power_data>70&&power_data<=75)
; 0009 0081             {
; 0009 0082               if(imp_value>14 || imp_cur > 435 )
; 0009 0083               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0084             }
; 0009 0085             else if(power_data>75&&power_data<=80)
; 0009 0086             {
; 0009 0087               if(imp_value>14|| imp_cur > 485 )
; 0009 0088               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0089             }
; 0009 008A             else if(power_data>80&&power_data<=85)
; 0009 008B             {
; 0009 008C               if(imp_value>13|| imp_cur > 485 )   //
; 0009 008D               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 008E             }
; 0009 008F             else if(power_data>85&&power_data<=90)
; 0009 0090             {
; 0009 0091               if(imp_value>13|| imp_cur > 495 )   //
; 0009 0092               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0093             }
; 0009 0094             else if(power_data>90&&power_data<=95)
; 0009 0095             {
; 0009 0096               if(imp_value>13|| imp_cur > 495 )   //
; 0009 0097               {UD.alram_mode=IMPEDANCE_OVER;}else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 0098             }
; 0009 0099             else if(power_data>95)
; 0009 009A             {
; 0009 009B               if(imp_value>13 || imp_cur > 495 )   //
; 0009 009C               {UD.alram_mode=IMPEDANCE_OVER;} else{if(UD.alram_mode==IMPEDANCE_OVER){UD.alram_mode=ALRAM_OFF;}}
; 0009 009D             }
; 0009 009E         }
; 0009 009F         else
; 0009 00A0         {
; 0009 00A1             UD.alram_mode=IMPEDANCE_OVER;
; 0009 00A2         }
; 0009 00A3     }
; 0009 00A4 }
;
;//******************************************************************************
;// Local Functions
;//******************************************************************************
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
;
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
;
;#ifndef __DEFINE_H__
;#include "define.h"
;#endif
;
;#ifndef __EEPROM_H__
;#include "eeprom.h"
;#endif
;
;#ifndef __UART_H__
;#include "uart.h"
;#endif
;
;#ifndef __TIME_H__
;#include "time.h"
;#endif
;
;
;//******************************************************************************
;// Variables
;//******************************************************************************
;Uchar save_data_reed[23];
;Uchar save_data_write[23];
;
;
; extern UART_DATA UD;
;
;//******************************************************************************
;// Local Function Declarations
;//******************************************************************************
;Uchar _Eeprom_Read_(Uint addr);
;void _Eeprom_Write_(Uint addr, Uchar wdat);
;void _Eeprom_init_data_(void);
;void _Eeprom_data_write_(void);
;void Delay(Uchar delay);
;//******************************************************************************
;// Global Functions
;//******************************************************************************
;void Eeprom_Write_Control_Proc(void)
; 000A 002A {

	.CSEG
_Eeprom_Write_Control_Proc:
; .FSTART _Eeprom_Write_Control_Proc
; 000A 002B     Uchar count;
; 000A 002C 
; 000A 002D     Uint cut_blend_off_power_data, cut_blend_1_power_data,cut_blend_2_power_data,coa_contact_power_data,coa_spray_power_ ...
; 000A 002E 
; 000A 002F     for(count=1;count<23;count++)
	SBIW R28,10
	CALL __SAVELOCR6
;	count -> R17
;	cut_blend_off_power_data -> R18,R19
;	cut_blend_1_power_data -> R20,R21
;	cut_blend_2_power_data -> Y+14
;	coa_contact_power_data -> Y+12
;	coa_spray_power_data -> Y+10
;	imp_sense_off_power_data -> Y+8
;	imp_sense_on_power_data -> Y+6
	LDI  R17,LOW(1)
_0x140004:
	CPI  R17,23
	BRSH _0x140005
; 000A 0030     {
; 000A 0031 
; 000A 0032         save_data_reed[count] =_Eeprom_Read_(count);
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_save_data_reed)
	SBCI R31,HIGH(-_save_data_reed)
	PUSH R31
	PUSH R30
	MOV  R26,R17
	CLR  R27
	RCALL __Eeprom_Read_
	POP  R26
	POP  R27
	ST   X,R30
; 000A 0033        // Delay(0xFF);
; 000A 0034     }
	SUBI R17,-1
	RJMP _0x140004
_0x140005:
; 000A 0035 
; 000A 0036     if(UD.cut_mode!= save_data_reed[1]){_Eeprom_Write_(1,UD.cut_mode); Delay(0xFF);}
	__GETB2MN _UD,8
	__GETB1MN _save_data_reed,1
	CP   R30,R26
	BREQ _0x140006
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,8
	CALL SUBOPT_0x52
; 000A 0037     if(UD.coa_mode!=save_data_reed[2]){_Eeprom_Write_(2,UD.coa_mode); Delay(0xFF);}
_0x140006:
	__GETB2MN _UD,9
	__GETB1MN _save_data_reed,2
	CP   R30,R26
	BREQ _0x140007
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,9
	CALL SUBOPT_0x52
; 000A 0038     if(UD.bipol_mode!= save_data_reed[3]){_Eeprom_Write_(3,UD.bipol_mode); Delay(0xFF);}
_0x140007:
	__GETB2MN _UD,10
	__GETB1MN _save_data_reed,3
	CP   R30,R26
	BREQ _0x140008
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,10
	CALL SUBOPT_0x52
; 000A 0039 
; 000A 003A     cut_blend_off_power_data= save_data_reed[4];
_0x140008:
	__GETBRMN 18,_save_data_reed,4
	CLR  R19
; 000A 003B     if(UD.cut_blend_off_power!= ((cut_blend_off_power_data<<8)+save_data_reed[5])){_Eeprom_Write_(4,UD.cut_blend_off_pow ...
	MOV  R27,R18
	LDI  R26,LOW(0)
	__GETB1MN _save_data_reed,5
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	__GETW2MN _UD,18
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x140009
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x1A
	CALL SUBOPT_0x53
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,18
	CALL SUBOPT_0x52
; 000A 003C 
; 000A 003D     cut_blend_1_power_data= save_data_reed[6];
_0x140009:
	__GETBRMN 20,_save_data_reed,6
	CLR  R21
; 000A 003E     if(UD.cut_blend_1_power!= ((cut_blend_1_power_data<<8)+save_data_reed[7])){_Eeprom_Write_(6,UD.cut_blend_1_power>>8) ...
	MOV  R27,R20
	LDI  R26,LOW(0)
	__GETB1MN _save_data_reed,7
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	__GETW2MN _UD,20
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000A
	LDI  R30,LOW(6)
	LDI  R31,HIGH(6)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x1F
	CALL SUBOPT_0x53
	LDI  R30,LOW(7)
	LDI  R31,HIGH(7)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,20
	CALL SUBOPT_0x52
; 000A 003F 
; 000A 0040     cut_blend_2_power_data= save_data_reed[8];
_0x14000A:
	__GETB1MN _save_data_reed,8
	LDI  R31,0
	STD  Y+14,R30
	STD  Y+14+1,R31
; 000A 0041     if(UD.cut_blend_2_power!= ((cut_blend_2_power_data<<8)+save_data_reed[9])){_Eeprom_Write_(8,UD.cut_blend_2_power>>8) ...
	LDD  R31,Y+14
	CALL SUBOPT_0x54
	__GETW2MN _UD,22
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000B
	LDI  R30,LOW(8)
	LDI  R31,HIGH(8)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x23
	CALL SUBOPT_0x53
	LDI  R30,LOW(9)
	LDI  R31,HIGH(9)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,22
	CALL SUBOPT_0x52
; 000A 0042 
; 000A 0043     coa_contact_power_data= save_data_reed[10];
_0x14000B:
	__GETB1MN _save_data_reed,10
	LDI  R31,0
	STD  Y+12,R30
	STD  Y+12+1,R31
; 000A 0044     if(UD.coa_contact_power!= ((coa_contact_power_data<<8)+save_data_reed[11])){_Eeprom_Write_(10,UD.coa_contact_power>> ...
	LDD  R31,Y+12
	CALL SUBOPT_0x55
	__GETW2MN _UD,24
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000C
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x40
	CALL SUBOPT_0x53
	LDI  R30,LOW(11)
	LDI  R31,HIGH(11)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,24
	CALL SUBOPT_0x52
; 000A 0045 
; 000A 0046     coa_spray_power_data= save_data_reed[12];
_0x14000C:
	__GETB1MN _save_data_reed,12
	LDI  R31,0
	STD  Y+10,R30
	STD  Y+10+1,R31
; 000A 0047     if(UD.coa_spray_power!= ((coa_spray_power_data<<8)+save_data_reed[13])){_Eeprom_Write_(12,UD.coa_spray_power>>8); De ...
	LDD  R31,Y+10
	CALL SUBOPT_0x56
	__GETW2MN _UD,26
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000D
	LDI  R30,LOW(12)
	LDI  R31,HIGH(12)
	ST   -Y,R31
	ST   -Y,R30
	__GETW1MN _UD,26
	CALL SUBOPT_0x53
	LDI  R30,LOW(13)
	LDI  R31,HIGH(13)
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,26
	CALL SUBOPT_0x52
; 000A 0048 
; 000A 0049     imp_sense_off_power_data= save_data_reed[14];
_0x14000D:
	__GETB1MN _save_data_reed,14
	LDI  R31,0
	STD  Y+8,R30
	STD  Y+8+1,R31
; 000A 004A     if(UD.imp_sense_power!= ((imp_sense_off_power_data<<8)+save_data_reed[15])){_Eeprom_Write_(14,UD.imp_sense_power>>8) ...
	LDD  R31,Y+8
	CALL SUBOPT_0x57
	CALL SUBOPT_0x35
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000E
	LDI  R30,LOW(14)
	LDI  R31,HIGH(14)
	CALL SUBOPT_0x58
	LDI  R30,LOW(15)
	LDI  R31,HIGH(15)
	CALL SUBOPT_0x59
; 000A 004B 
; 000A 004C     imp_sense_on_power_data= save_data_reed[16];
_0x14000E:
	__GETB1MN _save_data_reed,16
	LDI  R31,0
	STD  Y+6,R30
	STD  Y+6+1,R31
; 000A 004D     if(UD.imp_sense_power!= ((imp_sense_on_power_data<<8)+save_data_reed[17])){_Eeprom_Write_(16,UD.imp_sense_power>>8); ...
	LDD  R31,Y+6
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,17
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x35
	CP   R30,R26
	CPC  R31,R27
	BREQ _0x14000F
	LDI  R30,LOW(16)
	LDI  R31,HIGH(16)
	CALL SUBOPT_0x58
	LDI  R30,LOW(17)
	LDI  R31,HIGH(17)
	CALL SUBOPT_0x59
; 000A 004E }
_0x14000F:
	CALL __LOADLOCR6
	ADIW R28,16
	RET
; .FEND
;//******************************************************************************
;void Eeprom_Read_Control_Proc(void)
; 000A 0051 {
_Eeprom_Read_Control_Proc:
; .FSTART _Eeprom_Read_Control_Proc
; 000A 0052 
; 000A 0053     Uint count;
; 000A 0054 
; 000A 0055     for(count=1;count<23;count++)
	ST   -Y,R17
	ST   -Y,R16
;	count -> R16,R17
	__GETWRN 16,17,1
_0x140011:
	__CPWRN 16,17,23
	BRSH _0x140012
; 000A 0056     {
; 000A 0057         save_data_reed[count] = _Eeprom_Read_(count);
	MOVW R30,R16
	SUBI R30,LOW(-_save_data_reed)
	SBCI R31,HIGH(-_save_data_reed)
	PUSH R31
	PUSH R30
	MOVW R26,R16
	RCALL __Eeprom_Read_
	POP  R26
	POP  R27
	ST   X,R30
; 000A 0058         //Delay(0xFF);
; 000A 0059     }
	__ADDWRN 16,17,1
	RJMP _0x140011
_0x140012:
; 000A 005A 
; 000A 005B 
; 000A 005C     if(save_data_reed[21] != 'A' || save_data_reed[22] != 'K')
	__GETB2MN _save_data_reed,21
	CPI  R26,LOW(0x41)
	BRNE _0x140014
	__GETB2MN _save_data_reed,22
	CPI  R26,LOW(0x4B)
	BREQ _0x140013
_0x140014:
; 000A 005D     {
; 000A 005E         for(count=1;count<23;count++)
	__GETWRN 16,17,1
_0x140017:
	__CPWRN 16,17,23
	BRSH _0x140018
; 000A 005F         {
; 000A 0060             save_data_reed[count] = _Eeprom_Read_(count);
	MOVW R30,R16
	SUBI R30,LOW(-_save_data_reed)
	SBCI R31,HIGH(-_save_data_reed)
	PUSH R31
	PUSH R30
	MOVW R26,R16
	RCALL __Eeprom_Read_
	POP  R26
	POP  R27
	ST   X,R30
; 000A 0061             //Delay(0xFF);
; 000A 0062         }
	__ADDWRN 16,17,1
	RJMP _0x140017
_0x140018:
; 000A 0063 
; 000A 0064         if(save_data_reed[21] != 'A' || save_data_reed[22] != 'K')
	__GETB2MN _save_data_reed,21
	CPI  R26,LOW(0x41)
	BRNE _0x14001A
	__GETB2MN _save_data_reed,22
	CPI  R26,LOW(0x4B)
	BREQ _0x140019
_0x14001A:
; 000A 0065         {
; 000A 0066             _Eeprom_init_data_();
	RCALL __Eeprom_init_data_
; 000A 0067             _Eeprom_data_write_();
	RCALL __Eeprom_data_write_
; 000A 0068            for(count=1;count<23;count++)
	__GETWRN 16,17,1
_0x14001D:
	__CPWRN 16,17,23
	BRSH _0x14001E
; 000A 0069             {
; 000A 006A                 save_data_reed[count] = _Eeprom_Read_(count);
	MOVW R30,R16
	SUBI R30,LOW(-_save_data_reed)
	SBCI R31,HIGH(-_save_data_reed)
	PUSH R31
	PUSH R30
	MOVW R26,R16
	RCALL __Eeprom_Read_
	POP  R26
	POP  R27
	ST   X,R30
; 000A 006B                // Delay(0xFF);
; 000A 006C             }
	__ADDWRN 16,17,1
	RJMP _0x14001D
_0x14001E:
; 000A 006D         }
; 000A 006E     }
_0x140019:
; 000A 006F 
; 000A 0070     UD.cut_mode= save_data_reed[1];
_0x140013:
	__GETB1MN _save_data_reed,1
	__PUTB1MN _UD,8
; 000A 0071     UD.coa_mode=save_data_reed[2];
	__GETB1MN _save_data_reed,2
	__PUTB1MN _UD,9
; 000A 0072     UD.bipol_mode= save_data_reed[3];
	__GETB1MN _save_data_reed,3
	__PUTB1MN _UD,10
; 000A 0073     UD.cut_blend_off_power= save_data_reed[4];
	__POINTW2MN _UD,18
	__GETB1MN _save_data_reed,4
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 0074     UD.cut_blend_off_power= (UD.cut_blend_off_power<<8)+save_data_reed[5];
	__GETB1HMN _UD,18
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,5
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x1B
; 000A 0075     UD.cut_blend_1_power=save_data_reed[6];
	__POINTW2MN _UD,20
	__GETB1MN _save_data_reed,6
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 0076     UD.cut_blend_1_power=(UD.cut_blend_1_power<<8)+save_data_reed[7];
	__GETB1HMN _UD,20
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,7
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	CALL SUBOPT_0x20
; 000A 0077     UD.cut_blend_2_power=save_data_reed[8];
	__POINTW2MN _UD,22
	__GETB1MN _save_data_reed,8
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 0078     UD.cut_blend_2_power=(UD.cut_blend_2_power<<8)+save_data_reed[9];
	__GETB1HMN _UD,22
	CALL SUBOPT_0x54
	CALL SUBOPT_0x24
; 000A 0079     UD.coa_contact_power=save_data_reed[10];
	__POINTW2MN _UD,24
	__GETB1MN _save_data_reed,10
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 007A     UD.coa_contact_power=(UD.coa_contact_power<<8)+save_data_reed[11];
	__GETB1HMN _UD,24
	CALL SUBOPT_0x55
	__PUTW1MN _UD,24
; 000A 007B     UD.coa_spray_power=save_data_reed[12];
	__POINTW2MN _UD,26
	__GETB1MN _save_data_reed,12
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 007C     UD.coa_spray_power=(UD.coa_spray_power<<8)+save_data_reed[13];
	__GETB1HMN _UD,26
	CALL SUBOPT_0x56
	__PUTW1MN _UD,26
; 000A 007D     UD.imp_sense_power=save_data_reed[14];
	__POINTW2MN _UD,28
	__GETB1MN _save_data_reed,14
	LDI  R31,0
	ST   X+,R30
	ST   X,R31
; 000A 007E     UD.imp_sense_power=(UD.imp_sense_power<<8)+save_data_reed[15];
	__GETB1HMN _UD,28
	CALL SUBOPT_0x57
	__PUTW1MN _UD,28
; 000A 007F 
; 000A 0080 }
	RJMP _0x20A000C
; .FEND
;//******************************************************************************
;// Local Functions
;//******************************************************************************
;void Delay(Uchar delay) { while(delay--);}
; 000A 0084 void Delay(Uchar delay) { while(delay--);}
_Delay:
; .FSTART _Delay
	ST   -Y,R26
;	delay -> Y+0
_0x14001F:
	LD   R30,Y
	SUBI R30,LOW(1)
	ST   Y,R30
	SUBI R30,-LOW(1)
	BRNE _0x14001F
	JMP  _0x20A0005
; .FEND
;//******************************************************************************
;
;Uchar _Eeprom_Read_(Uint addr)
; 000A 0088 {
__Eeprom_Read_:
; .FSTART __Eeprom_Read_
; 000A 0089     while(EECR &(1<<1));// _WDR( );  //EEWE
	ST   -Y,R27
	ST   -Y,R26
;	addr -> Y+0
_0x140022:
	SBIC 0x1C,1
	RJMP _0x140022
; 000A 008A     EEAR = addr;         //address set
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 000A 008B     EECR |= (1<<0);        //EERE
	SBI  0x1C,0
; 000A 008C     return EEDR;
	IN   R30,0x1D
	JMP  _0x20A0008
; 000A 008D }
; .FEND
;//******************************************************************************
;void _Eeprom_Write_(Uint addr, Uchar wdat)
; 000A 0090 {
__Eeprom_Write_:
; .FSTART __Eeprom_Write_
; 000A 0091         while(EECR &(1<<1));// _WDR( );
	ST   -Y,R26
;	addr -> Y+1
;	wdat -> Y+0
_0x140025:
	SBIC 0x1C,1
	RJMP _0x140025
; 000A 0092         EEAR = addr;         //address set
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 000A 0093         EEDR = wdat;        //write dat set
	LD   R30,Y
	OUT  0x1D,R30
; 000A 0094         EECR |= (1<<2);        //EEMWE
	SBI  0x1C,2
; 000A 0095         EECR |= (1<<1);        //EEWE
	SBI  0x1C,1
; 000A 0096 }
	RJMP _0x20A000B
; .FEND
;//******************************************************************************
;void _Eeprom_init_data_(void)
; 000A 0099 {
__Eeprom_init_data_:
; .FSTART __Eeprom_init_data_
; 000A 009A     UD.cut_mode = F_BLEND_OFF;  //cut_mode
	LDI  R30,LOW(1)
	__PUTB1MN _UD,8
; 000A 009B     UD.coa_mode = F_CONTACT; //coa_mode
	LDI  R30,LOW(4)
	__PUTB1MN _UD,9
; 000A 009C     UD.bipol_mode = F_IMP_SENSE_ON; //bipol_mod
	LDI  R30,LOW(7)
	__PUTB1MN _UD,10
; 000A 009D     UD.cut_blend_off_power =0;
	CALL SUBOPT_0x1D
; 000A 009E     UD.cut_blend_1_power=0;
	CALL SUBOPT_0x22
; 000A 009F     UD.cut_blend_2_power=0;
	CALL SUBOPT_0x26
; 000A 00A0     UD.coa_contact_power=0;
	CALL SUBOPT_0x2D
; 000A 00A1     UD.coa_spray_power=0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _UD,26
; 000A 00A2     UD.imp_sense_power=0;
	CALL SUBOPT_0x31
; 000A 00A3 
; 000A 00A4 }
	RET
; .FEND
;//******************************************************************************
;void _Eeprom_data_write_(void)
; 000A 00A7 {
__Eeprom_data_write_:
; .FSTART __Eeprom_data_write_
; 000A 00A8     Uint count;
; 000A 00A9 
; 000A 00AA     save_data_write[1] =UD.cut_mode;
	ST   -Y,R17
	ST   -Y,R16
;	count -> R16,R17
	__GETB1MN _UD,8
	__PUTB1MN _save_data_write,1
; 000A 00AB     save_data_write[2] = UD.coa_mode;
	__GETB1MN _UD,9
	__PUTB1MN _save_data_write,2
; 000A 00AC     save_data_write[3] =UD.bipol_mode;
	__GETB1MN _UD,10
	__PUTB1MN _save_data_write,3
; 000A 00AD     save_data_write[4] =(UD.cut_blend_off_power>>8);
	CALL SUBOPT_0x1A
	CALL __ASRW8
	__PUTB1MN _save_data_write,4
; 000A 00AE     save_data_write[5] = UD.cut_blend_off_power;
	__GETB1MN _UD,18
	__PUTB1MN _save_data_write,5
; 000A 00AF     save_data_write[6] =(UD.cut_blend_1_power>>8);
	CALL SUBOPT_0x1F
	CALL __ASRW8
	__PUTB1MN _save_data_write,6
; 000A 00B0     save_data_write[7] =UD.cut_blend_1_power;
	__GETB1MN _UD,20
	__PUTB1MN _save_data_write,7
; 000A 00B1     save_data_write[8] =(UD.cut_blend_2_power>>8);
	CALL SUBOPT_0x23
	CALL __ASRW8
	__PUTB1MN _save_data_write,8
; 000A 00B2     save_data_write[9] =UD.cut_blend_2_power;
	__GETB1MN _UD,22
	__PUTB1MN _save_data_write,9
; 000A 00B3     save_data_write[10] =(UD.coa_contact_power>>8);
	CALL SUBOPT_0x40
	CALL __ASRW8
	__PUTB1MN _save_data_write,10
; 000A 00B4     save_data_write[11] =UD.coa_contact_power;
	__GETB1MN _UD,24
	__PUTB1MN _save_data_write,11
; 000A 00B5     save_data_write[12] =(UD.coa_spray_power>>8);
	__GETW1MN _UD,26
	CALL __ASRW8
	__PUTB1MN _save_data_write,12
; 000A 00B6     save_data_write[13] =UD.coa_spray_power;
	__GETB1MN _UD,26
	__PUTB1MN _save_data_write,13
; 000A 00B7     save_data_write[14] =(UD.imp_sense_power>>8);
	__GETW1MN _UD,28
	CALL __ASRW8
	__PUTB1MN _save_data_write,14
; 000A 00B8     save_data_write[15] = UD.imp_sense_power;
	__GETB1MN _UD,28
	__PUTB1MN _save_data_write,15
; 000A 00B9     save_data_write[16] =0xff;//dumy
	LDI  R30,LOW(255)
	__PUTB1MN _save_data_write,16
; 000A 00BA     save_data_write[17] =0xff;//dumy
	__PUTB1MN _save_data_write,17
; 000A 00BB     save_data_write[18] = 0xff;     //dumy
	__PUTB1MN _save_data_write,18
; 000A 00BC     save_data_write[19] = 0xff;     //dumy
	__PUTB1MN _save_data_write,19
; 000A 00BD     save_data_write[20] = 0xff;     //dumy
	__PUTB1MN _save_data_write,20
; 000A 00BE     save_data_write[21] = 'A';     //dumy
	LDI  R30,LOW(65)
	__PUTB1MN _save_data_write,21
; 000A 00BF     save_data_write[22] = 'K';     //dumy
	LDI  R30,LOW(75)
	__PUTB1MN _save_data_write,22
; 000A 00C0 
; 000A 00C1     for(count=1;count<23;count++)
	__GETWRN 16,17,1
_0x140029:
	__CPWRN 16,17,23
	BRSH _0x14002A
; 000A 00C2     {
; 000A 00C3      _Eeprom_Write_(count, save_data_write[count]);
	ST   -Y,R17
	ST   -Y,R16
	LDI  R26,LOW(_save_data_write)
	LDI  R27,HIGH(_save_data_write)
	ADD  R26,R16
	ADC  R27,R17
	LD   R26,X
	CALL SUBOPT_0x52
; 000A 00C4      Delay(0xFF);
; 000A 00C5     }
	__ADDWRN 16,17,1
	RJMP _0x140029
_0x14002A:
; 000A 00C6 
; 000A 00C7 
; 000A 00C8 }
_0x20A000C:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;//******************************************************************************
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
; 000B 0006 {

	.CSEG
; 000B 0007      WORD i;
; 000B 0008 
; 000B 0009 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 000A    if( address > 0x1fff)
; 000B 000B        return ERROR;
; 000B 000C #else
; 000B 000D    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 000B 000E        return ERROR;
; 000B 000F #endif
; 000B 0010      /* Start */
; 000B 0011      I2C_Start();
; 000B 0012      /*Device Address & Write mode */
; 000B 0013      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 000B 0014      I2C_Ack();
; 000B 0015 
; 000B 0016 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 0017      I2C_ShiftOut( (address>>8)&0xff ); /* High Address */
; 000B 0018      I2C_Ack();
; 000B 0019 #endif
; 000B 001A 
; 000B 001B      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );   /* Low Address */
; 000B 001C      I2C_Ack();
; 000B 001D 
; 000B 001E      for( i=0; i< Count; i++ )
; 000B 001F      {
; 000B 0020     /* Data Read  */
; 000B 0021     I2C_ShiftOut( Data[i] );
; 000B 0022            I2C_Ack();
; 000B 0023      }
; 000B 0024     // I2C_Ack();
; 000B 0025 
; 000B 0026      /** bring SDA high while clock is high */
; 000B 0027      I2C_Stop();
; 000B 0028 
; 000B 0029      //for( i=0; i<500; i++ )
; 000B 002A            i2c_delay();        /* 10mSec delay(no test) */
; 000B 002B 
; 000B 002C      return OK;
; 000B 002D }
;
;
;BYTE I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
; 000B 0031 {
_I2C_Write:
; .FSTART _I2C_Write
; 000B 0032    //WORD i;
; 000B 0033 
; 000B 0034 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 0035    if( address > 0x1fff)
; 000B 0036        return ERROR;
; 000B 0037 #else
; 000B 0038    if( address > 0xff)
	ST   -Y,R26
;	ChipAddr -> Y+3
;	address -> Y+1
;	dat -> Y+0
	LDD  R26,Y+1
	LDD  R27,Y+1+1
	CPI  R26,LOW(0x100)
	LDI  R30,HIGH(0x100)
	CPC  R27,R30
	BRLO _0x160007
; 000B 0039        return ERROR;
	LDI  R30,LOW(255)
	JMP  _0x20A0004
; 000B 003A #endif
; 000B 003B 
; 000B 003C    I2C_Start();  // Start
_0x160007:
	RCALL _I2C_Start
; 000B 003D 
; 000B 003E    // Device Address & Write mode
; 000B 003F    I2C_ShiftOut( ChipAddr&0xfe );
	LDD  R30,Y+3
	ANDI R30,0xFE
	MOV  R26,R30
	CALL SUBOPT_0x5A
; 000B 0040    I2C_Ack();
; 000B 0041 
; 000B 0042 #ifdef   CFG_I2C_HIGH_ADDRESS
; 000B 0043    // High Address
; 000B 0044    I2C_ShiftOut( (address>>8)&0xff );
; 000B 0045    I2C_Ack();
; 000B 0046 #endif
; 000B 0047 
; 000B 0048    // Low Address
; 000B 0049    I2C_ShiftOut( address&0xff );
	LDD  R30,Y+1
	MOV  R26,R30
	CALL SUBOPT_0x5A
; 000B 004A    I2C_Ack();
; 000B 004B 
; 000B 004C    I2C_ShiftOut( dat );     // write data
	LD   R26,Y
	CALL SUBOPT_0x5A
; 000B 004D    I2C_Ack();
; 000B 004E 
; 000B 004F    // bring SDA high while clock is high
; 000B 0050    I2C_Stop();
	RCALL _I2C_Stop
; 000B 0051 
; 000B 0052    //for( i=0; i<400; i++ )
; 000B 0053         i2c_delay();        //10mSec delay(no test)
	RCALL _i2c_delay
; 000B 0054 
; 000B 0055    return OK;
	LDI  R30,LOW(0)
	JMP  _0x20A0004
; 000B 0056 }
; .FEND
;
;void i2c_delay(void)
; 000B 0059 {
_i2c_delay:
; .FSTART _i2c_delay
; 000B 005A   // int i;
; 000B 005B 
; 000B 005C //   for( i=0; i<10;i++ )    //
; 000B 005D  //    for( i=0; i<2;i++ )    //
; 000B 005E 
; 000B 005F        #asm( "nop" );
	nop
; 000B 0060 }
	RET
; .FEND
;
;BYTE I2C_Ack(void )
; 000B 0063 {
_I2C_Ack:
; .FSTART _I2C_Ack
; 000B 0064      BYTE Ack;
; 000B 0065 
; 000B 0066      HIGH_SDA;
	ST   -Y,R17
;	Ack -> R17
	SBI  0x1B,0
; 000B 0067 
; 000B 0068      I2C_R_MODE; //DDRC.2 = 0;
	CBI  0x1A,0
; 000B 0069      HIGH_SCLK;
	CALL SUBOPT_0x5B
; 000B 006A      i2c_delay();
; 000B 006B      Ack = IN_SDA;
	MOV  R17,R30
; 000B 006C      i2c_delay();
	RCALL _i2c_delay
; 000B 006D      LOW_SCLK;
	CBI  0x1B,1
; 000B 006E 
; 000B 006F      I2C_W_MODE; //DDRC.2 = 1;
	SBI  0x1A,0
; 000B 0070      i2c_delay();
	RCALL _i2c_delay
; 000B 0071 
; 000B 0072      if( Ack )
	CPI  R17,0
	BREQ _0x160012
; 000B 0073         return ERROR;
	LDI  R30,LOW(255)
	JMP  _0x20A0006
; 000B 0074 
; 000B 0075      return OK;
_0x160012:
	LDI  R30,LOW(0)
	JMP  _0x20A0006
; 000B 0076 }
; .FEND
;
;BYTE I2C_OutAck( BYTE Flag  )
; 000B 0079 {
; 000B 007A        //BYTE Ack;
; 000B 007B 
; 000B 007C        if( Flag )    HIGH_SDA;
;	Flag -> Y+0
; 000B 007D         else        LOW_SDA;
; 000B 007E        /*LOW_SCLK; */
; 000B 007F 
; 000B 0080        /*i2c_delay(); */
; 000B 0081        HIGH_SCLK;
; 000B 0082       // Ack = IN_SDA;//ioport1&0x80;
; 000B 0083        i2c_delay();
; 000B 0084        LOW_SCLK;
; 000B 0085 
; 000B 0086        i2c_delay();
; 000B 0087 
; 000B 0088        //if( Ack )
; 000B 0089 //    return ERROR;
; 000B 008A 
; 000B 008B        return OK;
; 000B 008C }
;
;
;BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
; 000B 0090 {
; 000B 0091      WORD i;
; 000B 0092 
; 000B 0093 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 0094    if( address > 0x1fff)
; 000B 0095        return ERROR;
; 000B 0096 #else
; 000B 0097    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 000B 0098        return ERROR;
; 000B 0099 #endif
; 000B 009A      /* Start */
; 000B 009B      I2C_Start();
; 000B 009C      // Device Address & Write mod
; 000B 009D      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 000B 009E      I2C_Ack();
; 000B 009F 
; 000B 00A0 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 00A1      // High Address
; 000B 00A2      I2C_ShiftOut( (address>>8)&0xff );
; 000B 00A3      I2C_Ack();
; 000B 00A4 #endif
; 000B 00A5      // Low Address
; 000B 00A6      I2C_ShiftOut( address&0xff );
; 000B 00A7      I2C_Ack();
; 000B 00A8 
; 000B 00A9      /* Start */
; 000B 00AA      I2C_Start();
; 000B 00AB      /*Device Address & Read mode */
; 000B 00AC      I2C_ShiftOut( 0x01|(BYTE)(ChipAddr&0xff) );
; 000B 00AD      I2C_Ack();
; 000B 00AE 
; 000B 00AF      for( i=0; i< Count-1; i++ )
; 000B 00B0      {
; 000B 00B1      /* Data Read  */
; 000B 00B2      Data[i] = I2C_ShiftIn();
; 000B 00B3            // I2C_Ack();
; 000B 00B4            I2C_OutAck( FALSE );
; 000B 00B5      }
; 000B 00B6       Data[i] =    I2C_ShiftIn();
; 000B 00B7       I2C_OutAck( TRUE );
; 000B 00B8      //I2C_Ack();
; 000B 00B9      /** bring SDA high while clock is high */
; 000B 00BA      I2C_Stop();
; 000B 00BB 
; 000B 00BC      return OK;
; 000B 00BD }
;
;BYTE I2C_Read( BYTE ChipAddr, WORD address )
; 000B 00C0 {
; 000B 00C1      BYTE Dat;
; 000B 00C2 
; 000B 00C3 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 00C4    if( address > 0x1fff)
; 000B 00C5        return ERROR;
; 000B 00C6 #else
; 000B 00C7    if( address > 0xff)
;	ChipAddr -> Y+3
;	address -> Y+1
;	Dat -> R17
; 000B 00C8        return ERROR;
; 000B 00C9 #endif
; 000B 00CA 
; 000B 00CB      I2C_Start();   // Start
; 000B 00CC 
; 000B 00CD      /*Device Address & Write mode */
; 000B 00CE      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 000B 00CF      I2C_Ack();
; 000B 00D0 
; 000B 00D1 #ifdef CFG_I2C_HIGH_ADDRESS
; 000B 00D2      // High Address
; 000B 00D3      I2C_ShiftOut( (address>>8)&0xff );
; 000B 00D4      I2C_Ack();
; 000B 00D5 #endif
; 000B 00D6 
; 000B 00D7      // Low Address
; 000B 00D8      I2C_ShiftOut( address&0xff );
; 000B 00D9      I2C_Ack();
; 000B 00DA 
; 000B 00DB      // Start
; 000B 00DC      I2C_Start();
; 000B 00DD      // Device Address & Read mode
; 000B 00DE      I2C_ShiftOut( 0x01| (BYTE)(ChipAddr&0xff) );
; 000B 00DF 
; 000B 00E0      I2C_Ack();
; 000B 00E1 
; 000B 00E2       // Data Read
; 000B 00E3       Dat = I2C_ShiftIn();
; 000B 00E4       I2C_Ack();
; 000B 00E5 
; 000B 00E6       /** bring SDA high while clock is high */
; 000B 00E7       I2C_Stop();
; 000B 00E8 
; 000B 00E9      return Dat;
; 000B 00EA }
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
; 000B 011D {
_I2C_Start:
; .FSTART _I2C_Start
; 000B 011E       HIGH_SDA;    /* high serial data  */
	SBI  0x1B,0
; 000B 011F       HIGH_SCLK;   /* high serial clock */
	SBI  0x1B,1
; 000B 0120       i2c_delay();
	RCALL _i2c_delay
; 000B 0121       LOW_SDA;     /* low  serial data */
	CBI  0x1B,0
; 000B 0122       i2c_delay();
	CALL SUBOPT_0x5C
; 000B 0123       LOW_SCLK;    /* low  serial clock */
; 000B 0124       i2c_delay();
; 000B 0125 }
	RET
; .FEND
;
;void I2C_Stop( void )
; 000B 0128 {
_I2C_Stop:
; .FSTART _I2C_Stop
; 000B 0129      LOW_SCLK;
	CBI  0x1B,1
; 000B 012A      LOW_SDA;      /* low serial data */
	CBI  0x1B,0
; 000B 012B      i2c_delay();
	RCALL _i2c_delay
; 000B 012C      HIGH_SCLK;    /* high serial clock */
	SBI  0x1B,1
; 000B 012D      i2c_delay();
	RCALL _i2c_delay
; 000B 012E      HIGH_SDA;     /* high serial data      */
	SBI  0x1B,0
; 000B 012F }
	RET
; .FEND
;
;void I2C_ShiftOut( BYTE dat )
; 000B 0132 {
_I2C_ShiftOut:
; .FSTART _I2C_ShiftOut
; 000B 0133      BYTE i,temp;
; 000B 0134 
; 000B 0135      for( i=0; i<8; i++ )
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
;	dat -> Y+2
;	i -> R17
;	temp -> R16
	LDI  R17,LOW(0)
_0x160033:
	CPI  R17,8
	BRSH _0x160034
; 000B 0136      {
; 000B 0137         /* right shift */
; 000B 0138         temp = dat & ( 0x80>>i );
	CALL SUBOPT_0xF
; 000B 0139 
; 000B 013A        if( temp )   HIGH_SDA;    /* high data   */
	BREQ _0x160035
	SBI  0x1B,0
; 000B 013B        else         LOW_SDA;
	RJMP _0x160038
_0x160035:
	CBI  0x1B,0
; 000B 013C        i2c_delay();
_0x160038:
	RCALL _i2c_delay
; 000B 013D        HIGH_SCLK;              /* high clock   */
	SBI  0x1B,1
; 000B 013E        i2c_delay();
	CALL SUBOPT_0x5C
; 000B 013F        LOW_SCLK;               /* low clock    */
; 000B 0140        i2c_delay();
; 000B 0141      }
	SUBI R17,-1
	RJMP _0x160033
_0x160034:
; 000B 0142 }
	LDD  R17,Y+1
	LDD  R16,Y+0
_0x20A000B:
	ADIW R28,3
	RET
; .FEND
;
;BYTE I2C_ShiftIn( void )
; 000B 0145 {
_I2C_ShiftIn:
; .FSTART _I2C_ShiftIn
; 000B 0146      BYTE i=0,temp;
; 000B 0147      BYTE Dat=0;
; 000B 0148 
; 000B 0149      HIGH_SDA;
	CALL __SAVELOCR4
;	i -> R17
;	temp -> R16
;	Dat -> R19
	LDI  R17,0
	LDI  R19,0
	SBI  0x1B,0
; 000B 014A      I2C_R_MODE;      // input mode
	CBI  0x1A,0
; 000B 014B      for( i=0; i<8; i++ )
	LDI  R17,LOW(0)
_0x160044:
	CPI  R17,8
	BRSH _0x160045
; 000B 014C      {
; 000B 014D           //  HIGH_SDA;
; 000B 014E           HIGH_SCLK;         /* high serial clock    */
	CALL SUBOPT_0x5B
; 000B 014F           i2c_delay();
; 000B 0150 
; 000B 0151           temp = IN_SDA;     // &0x80;
	MOV  R16,R30
; 000B 0152           Dat |= ( temp<<(7-i) );
	LDI  R30,LOW(7)
	SUB  R30,R17
	MOV  R26,R16
	CALL __LSLB12
	OR   R19,R30
; 000B 0153 
; 000B 0154           i2c_delay();
	CALL SUBOPT_0x5C
; 000B 0155           LOW_SCLK;          /* low serial clock; */
; 000B 0156           i2c_delay();
; 000B 0157      }
	SUBI R17,-1
	RJMP _0x160044
_0x160045:
; 000B 0158 
; 000B 0159       I2C_W_MODE;   // output mode
	SBI  0x1A,0
; 000B 015A 
; 000B 015B      return Dat;
	MOV  R30,R19
	CALL __LOADLOCR4
	JMP  _0x20A0004
; 000B 015C }
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
; 000C 000C {

	.CSEG
_TCN75_init:
; .FSTART _TCN75_init
; 000C 000D     I2C_Write( TCN75_CHIP_ADDR, ACCESS_CONFIG , 0x00 );
	LDI  R30,LOW(144)
	ST   -Y,R30
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(0)
	RCALL _I2C_Write
; 000C 000E }
	RET
; .FEND
;
;int TCN75_Read( void )
; 000C 0011 {
_TCN75_Read:
; .FSTART _TCN75_Read
; 000C 0012      WORD temp;
; 000C 0013      BYTE temperaturMSB, temperaturLSB;
; 000C 0014      int Rval;
; 000C 0015 
; 000C 0016      I2C_Start();   // Start
	CALL __SAVELOCR6
;	temp -> R16,R17
;	temperaturMSB -> R19
;	temperaturLSB -> R18
;	Rval -> R20,R21
	RCALL _I2C_Start
; 000C 0017 
; 000C 0018      /*Device Address & Write mode */
; 000C 0019      I2C_ShiftOut( TCN75_CHIP_ADDR );
	LDI  R26,LOW(144)
	CALL SUBOPT_0x5A
; 000C 001A      I2C_Ack();
; 000C 001B 
; 000C 001C      // Low Address
; 000C 001D      I2C_ShiftOut( 0 ); // Pointer Byte TEMP Register selection
	LDI  R26,LOW(0)
	CALL SUBOPT_0x5A
; 000C 001E      I2C_Ack();
; 000C 001F 
; 000C 0020      // Start
; 000C 0021      I2C_Start();
	RCALL _I2C_Start
; 000C 0022      // Device Address & Read mode
; 000C 0023      I2C_ShiftOut( 0x01| TCN75_CHIP_ADDR );
	LDI  R26,LOW(145)
	CALL SUBOPT_0x5A
; 000C 0024 
; 000C 0025      I2C_Ack();
; 000C 0026 
; 000C 0027       // Data Read
; 000C 0028       temperaturMSB = I2C_ShiftIn();
	RCALL _I2C_ShiftIn
	MOV  R19,R30
; 000C 0029       I2C_Ack();
	RCALL _I2C_Ack
; 000C 002A       temperaturLSB = I2C_ShiftIn();
	RCALL _I2C_ShiftIn
	MOV  R18,R30
; 000C 002B       I2C_Ack();
	RCALL _I2C_Ack
; 000C 002C 
; 000C 002D       /** bring SDA high while clock is high */
; 000C 002E       I2C_Stop();
	RCALL _I2C_Stop
; 000C 002F 
; 000C 0030       temp = ((WORD)temperaturMSB<<1)&0x1fe|(temperaturLSB>>7&0x01);
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
; 000C 0031 
; 000C 0032       // MyPrint( "MSB =%x, MLSB= %X\r\n", temperaturMSB, temperaturLSB );
; 000C 0033 
; 000C 0034       if( temp > 0x0fa ) Rval = 0;
	__CPWRN 16,17,251
	BRLO _0x180003
	__GETWRN 20,21,0
; 000C 0035       else               Rval = (int)((float)temp*0.5f);
	RJMP _0x180004
_0x180003:
	MOVW R30,R16
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x3F000000
	CALL SUBOPT_0x5D
	MOVW R20,R30
; 000C 0036 
; 000C 0037       if( Rval > 150 ) Rval = 150;
_0x180004:
	__CPWRN 20,21,151
	BRLT _0x180005
	__GETWRN 20,21,150
; 000C 0038 
; 000C 0039       return Rval;
_0x180005:
	MOVW R30,R20
	CALL __LOADLOCR6
	RJMP _0x20A000A
; 000C 003A  }
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
; 000D 000B {

	.CSEG
_DAC7611_init:
; .FSTART _DAC7611_init
; 000D 000C    DAC7611_Write( 0 );
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _DAC7611_Write
; 000D 000D }
	RET
; .FEND
;
;void DAC7611_WriteVoltage( int data )
; 000D 0010 {
_DAC7611_WriteVoltage:
; .FSTART _DAC7611_WriteVoltage
; 000D 0011    WORD temp;
; 000D 0012    float cal;
; 000D 0013 
; 000D 0014   // cal = 4.095f /5.0f * (float)data / 10.0f;
; 000D 0015    temp = (WORD)(4095.0f* (float)data /100.0f);
	ST   -Y,R27
	ST   -Y,R26
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
;	data -> Y+6
;	temp -> R16,R17
;	cal -> Y+2
	LDD  R30,Y+6
	LDD  R31,Y+6+1
	CALL SUBOPT_0x41
	__GETD2N 0x457FF000
	CALL SUBOPT_0x48
	__GETD1N 0x42C80000
	CALL __DIVF21
	CALL __CFD1U
	MOVW R16,R30
; 000D 0016 
; 000D 0017    DAC7611_Write( temp );
	MOVW R26,R16
	RCALL _DAC7611_Write
; 000D 0018 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	RJMP _0x20A0007
; .FEND
;
;void DAC7611_Write( WORD data )
; 000D 001B {
_DAC7611_Write:
; .FSTART _DAC7611_Write
; 000D 001C      int i;
; 000D 001D      WORD temp;
; 000D 001E 
; 000D 001F      HIGH_LD;
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
;	data -> Y+4
;	i -> R16,R17
;	temp -> R18,R19
	SBI  0x1B,3
; 000D 0020      HIGH_SCLK;
	SBI  0x1B,1
; 000D 0021      LOW_CS;
	CBI  0x1B,2
; 000D 0022 
; 000D 0023      for( i=0; i<12; i++ )
	__GETWRN 16,17,0
_0x1A000A:
	__CPWRN 16,17,12
	BRGE _0x1A000B
; 000D 0024      {
; 000D 0025         /* right shift */
; 000D 0026        temp = data & ( 0x800>>i );
	MOV  R30,R16
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	CALL __LSRW12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	AND  R30,R26
	AND  R31,R27
	MOVW R18,R30
; 000D 0027 
; 000D 0028        if( temp ) HIGH_SDA;    /* high data  */
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x1A000C
	SBI  0x1B,0
; 000D 0029        else       LOW_SDA;
	RJMP _0x1A000F
_0x1A000C:
	CBI  0x1B,0
; 000D 002A 
; 000D 002B        i2c_delay();
_0x1A000F:
	CALL SUBOPT_0x5C
; 000D 002C        LOW_SCLK;          /* high clock */
; 000D 002D        i2c_delay();
; 000D 002E        HIGH_SCLK;         /* low clock    */
	SBI  0x1B,1
; 000D 002F        i2c_delay();
	CALL _i2c_delay
; 000D 0030      }
	__ADDWRN 16,17,1
	RJMP _0x1A000A
_0x1A000B:
; 000D 0031 
; 000D 0032      HIGH_CS;
	SBI  0x1B,2
; 000D 0033 
; 000D 0034      LOW_LD;
	CBI  0x1B,3
; 000D 0035      i2c_delay();
	CALL _i2c_delay
; 000D 0036      HIGH_LD;
	SBI  0x1B,3
; 000D 0037 }
	CALL __LOADLOCR4
_0x20A000A:
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
; 000E 0019 {

	.CSEG
_ADS1248_init:
; .FSTART _ADS1248_init
; 000E 001A    // SPI initialization
; 000E 001B    // SPI Type: Master
; 000E 001C    // SPI Clock Rate: 1000.000 kHz
; 000E 001D    // SPI Clock Phase: Cycle Half
; 000E 001E    // SPI Clock Polarity: Low
; 000E 001F    // SPI Data Order: MSB First
; 000E 0020    SPCR=0x55;
	LDI  R30,LOW(85)
	OUT  0xD,R30
; 000E 0021    SPSR=0x00;
	LDI  R30,LOW(0)
	OUT  0xE,R30
; 000E 0022 
; 000E 0023    ADS1248_StopReadCommand(  );
	RCALL _ADS1248_StopReadCommand
; 000E 0024    ADS1248ResetCommand(  );
	RCALL _ADS1248ResetCommand
; 000E 0025    ADS1248_WriteRegByte( 0, 0x05 );
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(5)
	RCALL _ADS1248_WriteRegByte
; 000E 0026    ADS1248_WriteRegByte( 2, 0x28 ); // 20140318 0x20 -> 0x08로
	LDI  R30,LOW(2)
	ST   -Y,R30
	LDI  R26,LOW(40)
	RCALL _ADS1248_WriteRegByte
; 000E 0027    // System Control Register 0
; 000E 0028    //PGA : 1
; 000E 0029    //DOR :  0101 = 160SPS , 1000 = 1000SPS , 0011 = 40SP
; 000E 002A    ADS1248_WriteRegByte(  3, 0x03 );
	LDI  R30,LOW(3)
	ST   -Y,R30
	LDI  R26,LOW(3)
	RCALL _ADS1248_WriteRegByte
; 000E 002B }
	RET
; .FEND
;
;void AD_ReadExTTemp( void )
; 000E 002E {
_AD_ReadExTTemp:
; .FSTART _AD_ReadExTTemp
; 000E 002F    float fTemp;
; 000E 0030    DWORD rTemp;
; 000E 0031    int   cTemp;
; 000E 0032 
; 000E 0033    rTemp = ADS1248_ADConvertData(  );
	SBIW R28,8
	CALL SUBOPT_0x5E
;	fTemp -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 000E 0034    fTemp =  5.0f*(float)rTemp/8388608.0f;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x60
	CALL SUBOPT_0x61
; 000E 0035 
; 000E 0036    if( fTemp >= 1.0f ) fTemp -= 1.0f;
	CALL SUBOPT_0x62
	CALL SUBOPT_0x63
	CALL __CMPF12
	BRLO _0x1C0003
	CALL SUBOPT_0x64
	CALL SUBOPT_0x61
; 000E 0037    fTemp = fTemp - (100.0f-(float)gCurTemp)*0.015f;
_0x1C0003:
	LDS  R30,_gCurTemp
	LDS  R31,_gCurTemp+1
	CALL SUBOPT_0x41
	__GETD2N 0x42C80000
	CALL SUBOPT_0x43
	__GETD2N 0x3C75C28F
	CALL __MULF12
	CALL SUBOPT_0x62
	CALL SUBOPT_0x43
	CALL SUBOPT_0x65
; 000E 0038    cTemp = (int)(fTemp/0.019f*10.0f);
	__GETD1N 0x3C9BA5E3
	CALL __DIVF21
	__GETD2N 0x41200000
	CALL SUBOPT_0x5D
	MOVW R16,R30
; 000E 0039 
; 000E 003A    if( cTemp > 1500 ) cTemp =  1500;
	__CPWRN 16,17,1501
	BRLT _0x1C0004
	__GETWRN 16,17,1500
; 000E 003B    if( cTemp < 0 )    cTemp = 0;
_0x1C0004:
	TST  R17
	BRPL _0x1C0005
	__GETWRN 16,17,0
; 000E 003C 
; 000E 003D    gExtTemp = cTemp;
_0x1C0005:
	MOVW R4,R16
; 000E 003E }
	JMP  _0x20A0003
; .FEND
;
;void AD_ReadVoltage( void )
; 000E 0041 {
_AD_ReadVoltage:
; .FSTART _AD_ReadVoltage
; 000E 0042     float fTemp, fPin, fWatt;
; 000E 0043     float fV2;
; 000E 0044     DWORD rTemp;
; 000E 0045     int   cTemp;
; 000E 0046 
; 000E 0047     rTemp = ADS1248_ADConvertData(  );
	SBIW R28,20
	CALL SUBOPT_0x5E
;	fTemp -> Y+18
;	fPin -> Y+14
;	fWatt -> Y+10
;	fV2 -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 000E 0048     fTemp = 5.0f*(float)rTemp/8388608.0f ;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x60
	CALL SUBOPT_0x66
; 000E 0049 
; 000E 004A     // MyPrint( "ch%d=%f,%d\r\n", bCh, fTemp, cTemp);
; 000E 004B 
; 000E 004C     fPin = fTemp/0.025f-90.0f;
	CALL SUBOPT_0x67
; 000E 004D     fWatt = pow( 10.0f, fPin/10.0f );
; 000E 004E 
; 000E 004F     fV2 = sqrt( fWatt*189689.79f);
	__GETD1N 0x48393E73
	CALL SUBOPT_0x48
	CALL _sqrt
	CALL SUBOPT_0x65
; 000E 0050    // fV2 = sqrt( fWatt*79689.79f);
; 000E 0051 
; 000E 0052     cTemp = (int)(fV2*12.5f);
	__GETD1N 0x41480000
	CALL SUBOPT_0x5D
	MOVW R16,R30
; 000E 0053     //cTemp = (int)(fV2*0.125f);
; 000E 0054     gVoltage = cTemp;
	MOVW R6,R16
; 000E 0055 }
	RJMP _0x20A0009
; .FEND
;
;void AD_ReadCurrent( void )
; 000E 0058 {
_AD_ReadCurrent:
; .FSTART _AD_ReadCurrent
; 000E 0059   float fTemp, fPin, fWatt;
; 000E 005A   float  fI2;
; 000E 005B   DWORD rTemp;
; 000E 005C   int   cTemp;
; 000E 005D 
; 000E 005E   rTemp = ADS1248_ADConvertData(  );
	SBIW R28,20
	CALL SUBOPT_0x5E
;	fTemp -> Y+18
;	fPin -> Y+14
;	fWatt -> Y+10
;	fI2 -> Y+6
;	rTemp -> Y+2
;	cTemp -> R16,R17
; 000E 005F   fTemp = 5.0f*(float)rTemp/8388608.0f ;
	CALL SUBOPT_0x5F
	CALL SUBOPT_0x60
	CALL SUBOPT_0x66
; 000E 0060 
; 000E 0061   fPin = fTemp/0.025f-90.0f;
	CALL SUBOPT_0x67
; 000E 0062   fWatt = pow( 10.0f, fPin/10.0f );
; 000E 0063 
; 000E 0064   fI2 = sqrt(fWatt*0.001f/9091.1752f)*1000.0f;
	__GETD1N 0x3A83126F
	CALL SUBOPT_0x48
	__GETD1N 0x460E0CB3
	CALL __DIVF21
	MOVW R26,R30
	MOVW R24,R22
	CALL _sqrt
	__GETD2N 0x447A0000
	CALL __MULF12
	CALL SUBOPT_0x65
; 000E 0065   cTemp = (int)(fI2*1000.0f);
	__GETD1N 0x447A0000
	CALL SUBOPT_0x5D
	MOVW R16,R30
; 000E 0066   gCurrent = cTemp;
	MOVW R8,R16
; 000E 0067 }
_0x20A0009:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,22
	RET
; .FEND
;
;void ADS1248_ChangeChannel(  BYTE Ch )
; 000E 006A {
_ADS1248_ChangeChannel:
; .FSTART _ADS1248_ChangeChannel
; 000E 006B    LOW_ADS1248_CS1;
	ST   -Y,R26
;	Ch -> Y+0
	CBI  0x15,1
; 000E 006C    ADS1248_WriteRegByte( 0, 0x05|((Ch&0x07)<<3 ));
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
; 000E 006D 
; 000E 006E    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 000E 006F }
	RJMP _0x20A0005
; .FEND
;
;void ADS1248_ReadContinueCommand( void )
; 000E 0072 {
; 000E 0073    LOW_ADS1248_CS1;
; 000E 0074    ADS1248_WriteByte( CMD_ADS1248_RDATC )  ; // command
; 000E 0075 
; 000E 0076    HIGH_ADS1248_CS1;
; 000E 0077    delay_ms( 10 );
; 000E 0078 }
;
;void ADS1248_StopReadCommand( void )
; 000E 007B {
_ADS1248_StopReadCommand:
; .FSTART _ADS1248_StopReadCommand
; 000E 007C    LOW_ADS1248_CS1;
	CBI  0x15,1
; 000E 007D 
; 000E 007E    ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command
	LDI  R26,LOW(22)
	RCALL _ADS1248_WriteByte
; 000E 007F 
; 000E 0080    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 000E 0081    delay_ms( 10 );
	CALL SUBOPT_0x0
; 000E 0082 }
	RET
; .FEND
;
;BYTE  ADS1248_ReadRegByte( BYTE addr )
; 000E 0085 {
; 000E 0086    BYTE temp;
; 000E 0087 
; 000E 0088    LOW_ADS1248_CS1;
;	addr -> Y+1
;	temp -> R17
; 000E 0089 
; 000E 008A    ADS1248_WriteByte( CMD_ADS1248_RREG|(addr&0x0f) );
; 000E 008B    ADS1248_WriteByte( 0x00 );
; 000E 008C    temp = ADS1248_ReadByte();
; 000E 008D 
; 000E 008E    HIGH_ADS1248_CS1;
; 000E 008F 
; 000E 0090    delay_ms( 1 );
; 000E 0091 
; 000E 0092    return temp;
; 000E 0093 }
;
;void  ADS1248_WriteRegByte( BYTE addr, BYTE Data )
; 000E 0096 {
_ADS1248_WriteRegByte:
; .FSTART _ADS1248_WriteRegByte
; 000E 0097    LOW_ADS1248_CS1;
	ST   -Y,R26
;	addr -> Y+1
;	Data -> Y+0
	CBI  0x15,1
; 000E 0098 
; 000E 0099    //delay_us( 5 );
; 000E 009A    ADS1248_WriteByte( CMD_ADS1248_WREG|(addr&0x0f) );
	LDD  R30,Y+1
	ANDI R30,LOW(0xF)
	ORI  R30,0x40
	MOV  R26,R30
	RCALL _ADS1248_WriteByte
; 000E 009B    ADS1248_WriteByte( 0x00 );
	LDI  R26,LOW(0)
	RCALL _ADS1248_WriteByte
; 000E 009C    ADS1248_WriteByte( Data );
	LD   R26,Y
	RCALL _ADS1248_WriteByte
; 000E 009D    delay_us( 10 );
	__DELAY_USB 53
; 000E 009E 
; 000E 009F    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 000E 00A0    //delay_us( 10 );
; 000E 00A1 }
_0x20A0008:
	ADIW R28,2
	RET
; .FEND
;
;
;DWORD ADS1248_ADConvertData( void )
; 000E 00A5 {
_ADS1248_ADConvertData:
; .FSTART _ADS1248_ADConvertData
; 000E 00A6    DWORD temp;
; 000E 00A7    BYTE AD1, AD2, AD3;
; 000E 00A8 
; 000E 00A9    LOW_ADS1248_CS1;
	SBIW R28,4
	CALL __SAVELOCR4
;	temp -> Y+4
;	AD1 -> R17
;	AD2 -> R16
;	AD3 -> R19
	CBI  0x15,1
; 000E 00AA    // delay_us( 500 );
; 000E 00AB    //ADS1248_WriteByte( CMD_ADS1248_RDATC );
; 000E 00AC    ADS1248_WriteByte( CMD_ADS1248_RDAT );
	LDI  R26,LOW(18)
	RCALL _ADS1248_WriteByte
; 000E 00AD   // SPDR;
; 000E 00AE   // delay_ms( 2 );
; 000E 00AF 
; 000E 00B0    AD1 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R17,R30
; 000E 00B1    AD2 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R16,R30
; 000E 00B2    AD3 = ADS1248_ReadByte();
	RCALL _ADS1248_ReadByte
	MOV  R19,R30
; 000E 00B3    temp = ((DWORD)AD1)<<16|((DWORD)AD2)<<8|(DWORD)AD3 ;
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
; 000E 00B4 
; 000E 00B5   // ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command
; 000E 00B6 
; 000E 00B7    HIGH_ADS1248_CS1;
	SBI  0x15,1
; 000E 00B8    return temp;
	CALL SUBOPT_0x68
	CALL __LOADLOCR4
_0x20A0007:
	ADIW R28,8
	RET
; 000E 00B9 }
; .FEND
;
;void ADS1248ResetCommand( void )
; 000E 00BC {
_ADS1248ResetCommand:
; .FSTART _ADS1248ResetCommand
; 000E 00BD 
; 000E 00BE   HIGH_ADS1248_CS1;
	SBI  0x15,1
; 000E 00BF 
; 000E 00C0 
; 000E 00C1   ADS1248_WriteByte( CMD_ADS1248_RESET );
	LDI  R26,LOW(6)
	RCALL _ADS1248_WriteByte
; 000E 00C2 
; 000E 00C3   delay_ms( 10 );
	CALL SUBOPT_0x0
; 000E 00C4 
; 000E 00C5   LOW_ADS1248_CS1;
	CBI  0x15,1
; 000E 00C6 }
	RET
; .FEND
;
;BYTE ADS1248_ReadByte( void  )
; 000E 00C9 {
_ADS1248_ReadByte:
; .FSTART _ADS1248_ReadByte
; 000E 00CA    BYTE temp;
; 000E 00CB 
; 000E 00CC    SPDR=0x00;
	ST   -Y,R17
;	temp -> R17
	LDI  R30,LOW(0)
	OUT  0xF,R30
; 000E 00CD    while(!(SPSR&0x80));
_0x1C0022:
	SBIS 0xE,7
	RJMP _0x1C0022
; 000E 00CE    temp=SPDR;
	IN   R17,15
; 000E 00CF 
; 000E 00D0    return temp;
	MOV  R30,R17
_0x20A0006:
	LD   R17,Y+
	RET
; 000E 00D1 }
; .FEND
;
;void ADS1248_WriteByte(BYTE data )
; 000E 00D4 {
_ADS1248_WriteByte:
; .FSTART _ADS1248_WriteByte
; 000E 00D5    SPDR = data;
	ST   -Y,R26
;	data -> Y+0
	LD   R30,Y
	OUT  0xF,R30
; 000E 00D6    while(!(SPSR&0x80));
_0x1C0025:
	SBIS 0xE,7
	RJMP _0x1C0025
; 000E 00D7 }
_0x20A0005:
	ADIW R28,1
	RET
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
_ftrunc:
; .FSTART _ftrunc
	CALL __PUTPARD2
   ldd  r23,y+3
   ldd  r22,y+2
   ldd  r31,y+1
   ld   r30,y
   bst  r23,7
   lsl  r23
   sbrc r22,7
   sbr  r23,1
   mov  r25,r23
   subi r25,0x7e
   breq __ftrunc0
   brcs __ftrunc0
   cpi  r25,24
   brsh __ftrunc1
   clr  r26
   clr  r27
   clr  r24
__ftrunc2:
   sec
   ror  r24
   ror  r27
   ror  r26
   dec  r25
   brne __ftrunc2
   and  r30,r26
   and  r31,r27
   and  r22,r24
   rjmp __ftrunc1
__ftrunc0:
   clt
   clr  r23
   clr  r30
   clr  r31
   clr  r22
__ftrunc1:
   cbr  r22,0x80
   lsr  r23
   brcc __ftrunc3
   sbr  r22,0x80
__ftrunc3:
   bld  r23,7
   ld   r26,y+
   ld   r27,y+
   ld   r24,y+
   ld   r25,y+
   cp   r30,r26
   cpc  r31,r27
   cpc  r22,r24
   cpc  r23,r25
   bst  r25,7
   ret
; .FEND
_floor:
; .FSTART _floor
	CALL __PUTPARD2
	CALL __GETD2S0
	CALL _ftrunc
	CALL __PUTD1S0
    brne __floor1
__floor0:
	CALL SUBOPT_0x69
	RJMP _0x20A0004
__floor1:
    brtc __floor0
	CALL SUBOPT_0x69
	__GETD2N 0x3F800000
	CALL __SUBF12
_0x20A0004:
	ADIW R28,4
	RET
; .FEND
_log:
; .FSTART _log
	CALL __PUTPARD2
	SBIW R28,4
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x62
	CALL __CPD02
	BRLT _0x204000C
	__GETD1N 0xFF7FFFFF
	RJMP _0x20A0003
_0x204000C:
	CALL SUBOPT_0x50
	CALL __PUTPARD1
	IN   R26,SPL
	IN   R27,SPH
	SBIW R26,1
	PUSH R17
	PUSH R16
	CALL _frexp
	POP  R16
	POP  R17
	CALL SUBOPT_0x65
	__GETD1N 0x3F3504F3
	CALL __CMPF12
	BRSH _0x204000D
	CALL SUBOPT_0x6A
	CALL SUBOPT_0x4F
	__SUBWRN 16,17,1
_0x204000D:
	CALL SUBOPT_0x64
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x50
	__GETD2N 0x3F800000
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL SUBOPT_0x61
	CALL SUBOPT_0x6A
	CALL __MULF12
	CALL SUBOPT_0x49
	__GETD2N 0x3F654226
	CALL SUBOPT_0x48
	__GETD1N 0x4054114E
	CALL SUBOPT_0x43
	CALL SUBOPT_0x62
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x4A
	__GETD2N 0x3FD4114D
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	MOVW R30,R16
	CALL SUBOPT_0x41
	__GETD2N 0x3F317218
	CALL __MULF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __ADDF12
_0x20A0003:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,10
	RET
; .FEND
_exp:
; .FSTART _exp
	CALL __PUTPARD2
	SBIW R28,8
	ST   -Y,R17
	ST   -Y,R16
	CALL SUBOPT_0x4E
	__GETD1N 0xC2AEAC50
	CALL __CMPF12
	BRSH _0x204000F
	CALL SUBOPT_0x6B
	RJMP _0x20A0002
_0x204000F:
	__GETD1S 10
	CALL __CPD10
	BRNE _0x2040010
	CALL SUBOPT_0x63
	RJMP _0x20A0002
_0x2040010:
	CALL SUBOPT_0x4E
	__GETD1N 0x42B17218
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0x2040011
	__GETD1N 0x7F7FFFFF
	RJMP _0x20A0002
_0x2040011:
	CALL SUBOPT_0x4E
	__GETD1N 0x3FB8AA3B
	CALL SUBOPT_0x4C
	CALL SUBOPT_0x4E
	RCALL _floor
	CALL __CFD1
	MOVW R16,R30
	CALL SUBOPT_0x4E
	CALL SUBOPT_0x41
	CALL SUBOPT_0x43
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x3F000000
	CALL SUBOPT_0x43
	CALL SUBOPT_0x61
	CALL SUBOPT_0x6A
	CALL __MULF12
	CALL SUBOPT_0x49
	__GETD2N 0x3D6C4C6D
	CALL __MULF12
	__GETD2N 0x40E6E3A6
	CALL __ADDF12
	CALL SUBOPT_0x62
	CALL __MULF12
	CALL SUBOPT_0x61
	CALL SUBOPT_0x4A
	__GETD2N 0x41A68D28
	CALL __ADDF12
	__PUTD1S 2
	CALL SUBOPT_0x50
	__GETD2S 2
	CALL __ADDF12
	__GETD2N 0x3FB504F3
	CALL __MULF12
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x62
	CALL SUBOPT_0x4A
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __DIVF21
	CALL __PUTPARD1
	MOVW R26,R16
	CALL _ldexp
_0x20A0002:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,14
	RET
; .FEND
_pow:
; .FSTART _pow
	CALL __PUTPARD2
	SBIW R28,4
	CALL SUBOPT_0x6C
	CALL __CPD10
	BRNE _0x2040012
	CALL SUBOPT_0x6B
	RJMP _0x20A0001
_0x2040012:
	__GETD2S 8
	CALL __CPD02
	BRGE _0x2040013
	CALL SUBOPT_0x68
	CALL __CPD10
	BRNE _0x2040014
	CALL SUBOPT_0x63
	RJMP _0x20A0001
_0x2040014:
	__GETD2S 8
	CALL SUBOPT_0x6D
	RCALL _exp
	RJMP _0x20A0001
_0x2040013:
	CALL SUBOPT_0x68
	MOVW R26,R28
	CALL __CFD1
	CALL __PUTDP1
	CALL SUBOPT_0x69
	CALL __CDF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x68
	CALL __CPD12
	BREQ _0x2040015
	CALL SUBOPT_0x6B
	RJMP _0x20A0001
_0x2040015:
	CALL SUBOPT_0x6C
	CALL __ANEGF1
	MOVW R26,R30
	MOVW R24,R22
	CALL SUBOPT_0x6D
	RCALL _exp
	__PUTD1S 8
	LD   R30,Y
	ANDI R30,LOW(0x1)
	BRNE _0x2040016
	CALL SUBOPT_0x6C
	RJMP _0x20A0001
_0x2040016:
	CALL SUBOPT_0x6C
	CALL __ANEGF1
_0x20A0001:
	ADIW R28,12
	RET
; .FEND

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.DSEG
_gFlag_maintime:
	.BYTE 0x1
_key_time:
	.BYTE 0xA
_key_repeat:
	.BYTE 0xA
_cut_in_de_flag:
	.BYTE 0x1
_coa_in_de_flag:
	.BYTE 0x1
_bip_in_de_flag:
	.BYTE 0x1
_fan_data:
	.BYTE 0x2
_plate_data:
	.BYTE 0x2
_UD:
	.BYTE 0x2F
_buzzer_cut_hand_flag:
	.BYTE 0x1
_buzzer_coa_hand_flag:
	.BYTE 0x1
_buzzer_cut_foot_flag:
	.BYTE 0x1
_buzzer_coa_foot_flag:
	.BYTE 0x1
_buzzer_bip_flag:
	.BYTE 0x1
_buzzer_up_flag:
	.BYTE 0x1
_buzzer_down_flag:
	.BYTE 0x1
_buzzer_start_flag:
	.BYTE 0x1
_buzzer_plate_alram_flag:
	.BYTE 0x1
_buzzer_fan_error_flag:
	.BYTE 0x1
_buzzer_over_watt_flag:
	.BYTE 0x1
_blink_flag:
	.BYTE 0x1
_bipol_relay_time:
	.BYTE 0x1
_Time:
	.BYTE 0x7
_TF:
	.BYTE 0x1
_timer0_count:
	.BYTE 0x1
_blink_warring_flag:
	.BYTE 0x1
_impedance_check_time:
	.BYTE 0x1
_currentperiod:
	.BYTE 0x2
_buzzeractionflag:
	.BYTE 0x1
_impedance_check_flag:
	.BYTE 0x1
_gReadIntTempFlag:
	.BYTE 0x1
_count:
	.BYTE 0x1
_DspMem:
	.BYTE 0xA
_gCurTemp:
	.BYTE 0x2
_s1:
	.BYTE 0x2
_s0:
	.BYTE 0x2
_s2:
	.BYTE 0x2
_s3:
	.BYTE 0x2
_s4:
	.BYTE 0x2
_s5:
	.BYTE 0x2
_TXdata:
	.BYTE 0x30
_txquefront:
	.BYTE 0x1
_txquetail:
	.BYTE 0x1
_txreadytime:
	.BYTE 0x1
_datasendflag:
	.BYTE 0x1
_RXdata:
	.BYTE 0x30
_rxquefront:
	.BYTE 0x1
_rxquetail:
	.BYTE 0x1
_receivedelay:
	.BYTE 0x1
_txtemp:
	.BYTE 0x1
_receiveflag:
	.BYTE 0x1
_noteindex:
	.BYTE 0x1
_currentduration:
	.BYTE 0x1
_buzznoteecho:
	.BYTE 0x2
_buzzer_count:
	.BYTE 0x1
_gAD_Channel:
	.BYTE 0x1
_gI_err:
	.BYTE 0x4
_prev_err:
	.BYTE 0x4
_imp_value:
	.BYTE 0x2
_imp_vol:
	.BYTE 0x2
_imp_cur:
	.BYTE 0x2
_save_data_reed:
	.BYTE 0x17
_save_data_write:
	.BYTE 0x17
__seed_G104:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	LDI  R26,LOW(10)
	LDI  R27,0
	JMP  _delay_ms

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x1:
	__GETB1MN _UD,1
	ANDI R30,0x7F
	__PUTB1MN _UD,1
	__GETB1MN _UD,1
	ANDI R30,0xBF
	__PUTB1MN _UD,1
	__GETB1MN _UD,1
	ANDI R30,0xDF
	__PUTB1MN _UD,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	CALL _IO_SET_monopol_foot_sig_out
	JMP  _IO_SET_monopol_hand_sig_out

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x3:
	__PUTB1MN _UD,14
	LDI  R30,LOW(0)
	__PUTB1MN _UD,12
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	__PUTW1MN _UD,16
	LDI  R30,LOW(1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4:
	LDI  R30,LOW(0)
	__PUTB1MN _UD,14
	__GETW2MN _UD,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	__PUTW1MN _UD,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x6:
	LDS  R26,_plate_data
	LDS  R27,_plate_data+1
	CPI  R26,LOW(0xC8)
	LDI  R30,HIGH(0xC8)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	__PUTB1MN _UD,5
	STS  _buzzer_bip_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x8:
	__GETB1MN _UD,1
	ANDI R30,0xEF
	__PUTB1MN _UD,1
	__GETB1MN _UD,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	__PUTB1MN _UD,1
	__GETB1MN _UD,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xA:
	STS  _blink_flag,R30
	LDS  R30,98
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	__GETW2MN _UD,16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:49 WORDS
SUBOPT_0xC:
	LDI  R30,LOW(50)
	STS  139,R30
	LDI  R30,LOW(26)
	STS  138,R30
	LDI  R30,LOW(0)
	STS  129,R30
	LDI  R30,LOW(60)
	STS  128,R30
	LDI  R30,LOW(0)
	STS  133,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(2)
	STS  139,R30
	SBI  0x3,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0xE:
	ST   -Y,R0
	ST   -Y,R1
	ST   -Y,R15
	ST   -Y,R22
	ST   -Y,R23
	ST   -Y,R24
	ST   -Y,R25
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	MOV  R30,R17
	LDI  R26,LOW(128)
	CALL __LSRB12
	LDD  R26,Y+2
	AND  R30,R26
	MOV  R16,R30
	CPI  R16,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	__GETW2MN _UD,28
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	CALL __DIVW21
	MOV  R17,R30
	CPI  R17,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x12:
	MOV  R30,R17
	LDI  R31,0
	SUBI R30,LOW(-_FndNum*2)
	SBCI R31,HIGH(-_FndNum*2)
	LPM  R16,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x13:
	CALL __MODW21
	MOV  R17,R30
	MOV  R26,R17
	LDI  R30,LOW(10)
	CALL __DIVB21U
	CPI  R30,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x14:
	MOV  R26,R17
	LDI  R30,LOW(10)
	CALL __DIVB21U
	LDI  R31,0
	SUBI R30,LOW(-_FndNum*2)
	SBCI R31,HIGH(-_FndNum*2)
	LPM  R16,Z
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x15:
	MOV  R26,R17
	LDI  R30,LOW(10)
	CALL __MODB21U
	LDI  R31,0
	SUBI R30,LOW(-_FndNum*2)
	SBCI R31,HIGH(-_FndNum*2)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x16:
	__GETW2MN _UD,24
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x17:
	LDI  R30,LOW(1)
	ST   -Y,R30
	LDI  R26,LOW(0)
	JMP  _Sel_ShiftOut

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x18:
	LDS  R30,_s1
	LDS  R31,_s1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x19:
	LDS  R26,_s0
	LDS  R27,_s0+1
	RCALL SUBOPT_0x18
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1A:
	__GETW1MN _UD,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1B:
	__PUTW1MN _UD,18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1C:
	__GETW2MN _UD,18
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1D:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP SUBOPT_0x1B

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x1E:
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1F:
	__GETW1MN _UD,20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x20:
	__PUTW1MN _UD,20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x21:
	__GETW2MN _UD,20
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x22:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP SUBOPT_0x20

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x23:
	__GETW1MN _UD,22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x24:
	__PUTW1MN _UD,22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x25:
	__GETW2MN _UD,22
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x26:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x27:
	__GETW2MN _UD,18
	CPI  R26,LOW(0x190)
	LDI  R30,HIGH(0x190)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x28:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x29:
	__GETW2MN _UD,20
	CPI  R26,LOW(0xE6)
	LDI  R30,HIGH(0xE6)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x2A:
	__GETW2MN _UD,22
	CPI  R26,LOW(0xB4)
	LDI  R30,HIGH(0xB4)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDS  R30,_s3
	LDS  R31,_s3+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2C:
	LDS  R26,_s2
	LDS  R27,_s2+1
	RCALL SUBOPT_0x2B
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2D:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _UD,24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2E:
	LDS  R30,_s5
	LDS  R31,_s5+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2F:
	LDS  R26,_s4
	LDS  R27,_s4+1
	RCALL SUBOPT_0x2E
	SUB  R30,R26
	SBC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x30:
	__GETW1MN _UD,28
	SBIW R30,5
	__PUTW1MN _UD,28
	__GETW2MN _UD,28
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x31:
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	__PUTW1MN _UD,28
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x32:
	__GETW2MN _UD,28
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x33:
	__GETW1MN _UD,28
	ADIW R30,5
	__PUTW1MN _UD,28
	__GETW2MN _UD,28
	SBIW R26,20
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x34:
	LDI  R30,LOW(20)
	LDI  R31,HIGH(20)
	__PUTW1MN _UD,28
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x35:
	__GETW2MN _UD,28
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x36:
	STS  _txquefront,R30
	LDI  R30,LOW(0)
	STS  _txquetail,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x37:
	LDS  R30,_txquetail
	SUBI R30,-LOW(1)
	STS  _txquetail,R30
	SUBI R30,LOW(1)
	LDI  R31,0
	SUBI R30,LOW(-_TXdata)
	SBCI R31,HIGH(-_TXdata)
	LD   R30,Z
	OUT  0xC,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x38:
	STS  _buzzer_count,R30
	JMP  __buzzer_out_count_

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x39:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETW1PF
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3A:
	CALL _IO_CLR_bipol_monopol_power_sel
	CALL _IO_CLR_monopol_watt_sel
	CALL _IO_CLR_monopol_hand_sig_out
	CALL _IO_SET_monopol_foot_sig_out
	LDI  R30,LOW(1)
	STS  _buzzer_cut_hand_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3B:
	CALL _IO_CLR_bipol_monopol_power_sel
	CALL _IO_CLR_monopol_watt_sel
	CALL _IO_CLR_monopol_foot_sig_out
	CALL _IO_SET_monopol_hand_sig_out
	LDI  R30,LOW(1)
	STS  _buzzer_cut_foot_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3C:
	CALL _IO_CLR_bipol_monopol_power_sel
	CALL _IO_CLR_monopol_watt_sel
	CALL _IO_CLR_monopol_hand_sig_out
	CALL _IO_SET_monopol_foot_sig_out
	LDI  R30,LOW(1)
	STS  _buzzer_coa_hand_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x3D:
	CALL _IO_CLR_bipol_monopol_power_sel
	CALL _IO_CLR_monopol_watt_sel
	CALL _IO_CLR_monopol_foot_sig_out
	CALL _IO_SET_monopol_hand_sig_out
	LDI  R30,LOW(1)
	STS  _buzzer_coa_foot_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3E:
	CALL _IO_SET_bipol_monopol_power_sel
	CALL _IO_SET_monopol_watt_sel
	RJMP SUBOPT_0x2

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3F:
	LDI  R26,LOW(0)
	CALL _IO_spray_relay
	LDI  R30,LOW(1)
	STS  _buzzer_bip_flag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x40:
	__GETW1MN _UD,24
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x41:
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x42:
	__GETD1N 0x41200000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x43:
	CALL __SWAPD12
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x44:
	__GETD1S 26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x45:
	__PUTD1S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x46:
	LDS  R26,_gI_err
	LDS  R27,_gI_err+1
	LDS  R24,_gI_err+2
	LDS  R25,_gI_err+3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x47:
	STS  _gI_err,R30
	STS  _gI_err+1,R31
	STS  _gI_err+2,R22
	STS  _gI_err+3,R23
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x48:
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:27 WORDS
SUBOPT_0x49:
	__PUTD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4A:
	__GETD1S 2
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4B:
	__PUTD1S 14
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	CALL __MULF12
	__PUTD1S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x4D:
	__GETD2S 18
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4E:
	__GETD2S 10
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4F:
	CALL __ADDF12
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x50:
	__GETD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x51:
	__GETW1MN _UD,28
	RCALL SUBOPT_0x41
	__GETD2N 0x40A00000
	CALL __MULF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 18 TIMES, CODE SIZE REDUCTION:48 WORDS
SUBOPT_0x52:
	CALL __Eeprom_Write_
	LDI  R26,LOW(255)
	JMP  _Delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x53:
	CALL __ASRW8
	MOV  R26,R30
	RJMP SUBOPT_0x52

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x54:
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,9
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x55:
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,11
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x56:
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,13
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x57:
	LDI  R30,LOW(0)
	MOVW R26,R30
	__GETB1MN _save_data_reed,15
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x58:
	ST   -Y,R31
	ST   -Y,R30
	__GETW1MN _UD,28
	RJMP SUBOPT_0x53

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x59:
	ST   -Y,R31
	ST   -Y,R30
	__GETB2MN _UD,28
	RJMP SUBOPT_0x52

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x5A:
	CALL _I2C_ShiftOut
	JMP  _I2C_Ack

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x5B:
	SBI  0x1B,1
	CALL _i2c_delay
	LDI  R30,0
	SBIC 0x19,0
	LDI  R30,1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x5C:
	CALL _i2c_delay
	CBI  0x1B,1
	JMP  _i2c_delay

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x5D:
	CALL __MULF12
	CALL __CFD1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x5E:
	ST   -Y,R17
	ST   -Y,R16
	CALL _ADS1248_ADConvertData
	RJMP SUBOPT_0x49

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x5F:
	CALL __CDF1U
	__GETD2N 0x40A00000
	RJMP SUBOPT_0x48

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x60:
	__GETD1N 0x4B000000
	CALL __DIVF21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x61:
	__PUTD1S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:21 WORDS
SUBOPT_0x62:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x63:
	__GETD1N 0x3F800000
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x64:
	RCALL SUBOPT_0x50
	__GETD2N 0x3F800000
	CALL __SUBF12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x65:
	RCALL SUBOPT_0x61
	RJMP SUBOPT_0x62

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:13 WORDS
SUBOPT_0x66:
	RCALL SUBOPT_0x45
	RCALL SUBOPT_0x4D
	__GETD1N 0x3CCCCCCD
	CALL __DIVF21
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x42B40000
	RJMP SUBOPT_0x43

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0x67:
	RCALL SUBOPT_0x4B
	RCALL SUBOPT_0x42
	CALL __PUTPARD1
	RCALL SUBOPT_0x4D
	RCALL SUBOPT_0x42
	CALL __DIVF21
	MOVW R26,R30
	MOVW R24,R22
	CALL _pow
	__PUTD1S 10
	RJMP SUBOPT_0x4E

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x68:
	__GETD1S 4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x69:
	CALL __GETD1S0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6A:
	RCALL SUBOPT_0x50
	RJMP SUBOPT_0x62

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x6B:
	__GETD1N 0x0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6C:
	__GETD1S 8
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6D:
	CALL _log
	__GETD2S 4
	RJMP SUBOPT_0x48


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

_frexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	CLR  R24
	SUBI R23,0x7E
	SBC  R24,R24
	ST   X+,R23
	ST   X,R24
	LDI  R23,0x7E
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

_ldexp:
	LD   R30,Y+
	LD   R31,Y+
	LD   R22,Y+
	LD   R23,Y+
	BST  R23,7
	LSL  R22
	ROL  R23
	ADD  R23,R26
	LSR  R23
	ROR  R22
	BRTS __ANEGF1
	RET

__ANEGF1:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	BREQ __ANEGF10
	SUBI R23,0x80
__ANEGF10:
	RET

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

	RJMP __ADDF120

__ADDF12:
	PUSH R21
	RCALL __UNPACK
	CPI  R25,0x80
	BREQ __ADDF129

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

_sqrt:
	rcall __PUTPARD2
	sbiw r28,4
	push r21
	ldd  r25,y+7
	tst  r25
	brne __sqrt0
	adiw r28,8
	rjmp __zerores
__sqrt0:
	brpl __sqrt1
	adiw r28,8
	rjmp __maxres
__sqrt1:
	push r20
	ldi  r20,66
	ldd  r24,y+6
	ldd  r27,y+5
	ldd  r26,y+4
__sqrt2:
	st   y,r24
	std  y+1,r25
	std  y+2,r26
	std  y+3,r27
	movw r30,r26
	movw r22,r24
	ldd  r26,y+4
	ldd  r27,y+5
	ldd  r24,y+6
	ldd  r25,y+7
	rcall __divf21
	ld   r24,y
	ldd  r25,y+1
	ldd  r26,y+2
	ldd  r27,y+3
	rcall __addf12
	rcall __unpack1
	dec  r23
	rcall __repack
	ld   r24,y
	ldd  r25,y+1
	ldd  r26,y+2
	ldd  r27,y+3
	eor  r26,r30
	andi r26,0xf8
	brne __sqrt4
	cp   r27,r31
	cpc  r24,r22
	cpc  r25,r23
	breq __sqrt3
__sqrt4:
	dec  r20
	breq __sqrt3
	movw r26,r30
	movw r24,r22
	rjmp __sqrt2
__sqrt3:
	pop  r20
	pop  r21
	adiw r28,8
	ret

__ORD12:
	OR   R30,R26
	OR   R31,R27
	OR   R22,R24
	OR   R23,R25
	RET

__ANEGW1:
	NEG  R31
	NEG  R30
	SBCI R31,0
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

__CWD2:
	MOV  R24,R27
	ADD  R24,R24
	SBC  R24,R24
	MOV  R25,R24
	RET

__DIVB21U:
	CLR  R0
	LDI  R25,8
__DIVB21U1:
	LSL  R26
	ROL  R0
	SUB  R0,R30
	BRCC __DIVB21U2
	ADD  R0,R30
	RJMP __DIVB21U3
__DIVB21U2:
	SBR  R26,1
__DIVB21U3:
	DEC  R25
	BRNE __DIVB21U1
	MOV  R30,R26
	MOV  R26,R0
	RET

__DIVW21U:
	CLR  R0
	CLR  R1
	LDI  R25,16
__DIVW21U1:
	LSL  R26
	ROL  R27
	ROL  R0
	ROL  R1
	SUB  R0,R30
	SBC  R1,R31
	BRCC __DIVW21U2
	ADD  R0,R30
	ADC  R1,R31
	RJMP __DIVW21U3
__DIVW21U2:
	SBR  R26,1
__DIVW21U3:
	DEC  R25
	BRNE __DIVW21U1
	MOVW R30,R26
	MOVW R26,R0
	RET

__DIVW21:
	RCALL __CHKSIGNW
	RCALL __DIVW21U
	BRTC __DIVW211
	RCALL __ANEGW1
__DIVW211:
	RET

__MODB21U:
	RCALL __DIVB21U
	MOV  R30,R26
	RET

__MODW21:
	CLT
	SBRS R27,7
	RJMP __MODW211
	COM  R26
	COM  R27
	ADIW R26,1
	SET
__MODW211:
	SBRC R31,7
	RCALL __ANEGW1
	RCALL __DIVW21U
	MOVW R30,R26
	BRTC __MODW212
	RCALL __ANEGW1
__MODW212:
	RET

__CHKSIGNW:
	CLT
	SBRS R31,7
	RJMP __CHKSW1
	RCALL __ANEGW1
	SET
__CHKSW1:
	SBRS R27,7
	RJMP __CHKSW2
	COM  R26
	COM  R27
	ADIW R26,1
	BLD  R0,0
	INC  R0
	BST  R0,0
__CHKSW2:
	RET

__PUTDP1:
	ST   X+,R30
	ST   X+,R31
	ST   X+,R22
	ST   X,R23
	RET

__GETW1PF:
	LPM  R0,Z+
	LPM  R31,Z
	MOV  R30,R0
	RET

__GETD1S0:
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R22,Y+2
	LDD  R23,Y+3
	RET

__GETD2S0:
	LD   R26,Y
	LDD  R27,Y+1
	LDD  R24,Y+2
	LDD  R25,Y+3
	RET

__PUTD1S0:
	ST   Y,R30
	STD  Y+1,R31
	STD  Y+2,R22
	STD  Y+3,R23
	RET

__PUTPARD1:
	ST   -Y,R23
	ST   -Y,R22
	ST   -Y,R31
	ST   -Y,R30
	RET

__PUTPARD2:
	ST   -Y,R25
	ST   -Y,R24
	ST   -Y,R27
	ST   -Y,R26
	RET

__CDF2U:
	SET
	RJMP __CDF2U0
__CDF2:
	CLT
__CDF2U0:
	RCALL __SWAPD12
	RCALL __CDF1U0

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

__CPD10:
	SBIW R30,0
	SBCI R22,0
	SBCI R23,0
	RET

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	RET

__CPD02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
	CPC  R0,R24
	CPC  R0,R25
	RET

__CPD12:
	CP   R30,R26
	CPC  R31,R27
	CPC  R22,R24
	CPC  R23,R25
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

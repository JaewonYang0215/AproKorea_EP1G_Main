
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
	.DEF _rx_wr_index0=R5
	.DEF _rx_rd_index0=R4
	.DEF _rx_counter0=R7
	.DEF _rx_buffer_overflow0=R6
	.DEF _mRcvErrFlag0=R9
	.DEF _rx_wr_index1=R8
	.DEF _rx_rd_index1=R11
	.DEF _rx_counter1=R10
	.DEF _rx_buffer_overflow1=R13
	.DEF _mRcvErrFlag1=R12

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
	JMP  _timer1_ovf_isr
	JMP  0x00
	JMP  _timer0_ovf_isr
	JMP  0x00
	JMP  _usart0_rx_isr
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

_VolArray:
	.DB  0x5,0xB,0x12,0x1A,0x28,0x33,0x3F,0x4A
	.DB  0x55,0x5D,0x6D,0x7C,0x8A,0x96,0xA0
_DacArray:
	.DB  0x0,0x0,0x20,0x41,0x0,0x0,0xA0,0x41
	.DB  0x0,0x0,0xF0,0x41,0xCD,0xCC,0x20,0x42
	.DB  0x33,0x33,0x53,0x41,0x1F,0x85,0x87,0x41
	.DB  0x71,0x3D,0xAA,0x41,0x5C,0x8F,0xCE,0x41
	.DB  0x5C,0x8F,0xF4,0x41,0x9A,0x99,0xD,0x42
	.DB  0x0,0x0,0x20,0x42,0x9A,0x99,0x5F,0x42
_tbl10_G100:
	.DB  0x10,0x27,0xE8,0x3,0x64,0x0,0xA,0x0
	.DB  0x1,0x0
_tbl16_G100:
	.DB  0x0,0x10,0x0,0x1,0x10,0x0,0x1,0x0

;GLOBAL REGISTER VARIABLES INITIALIZATION
__REG_VARS:
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0,0x0,0x0
	.DB  0x0,0x0

_0x60003:
	.DB  LOW(_IPC1_RCV_MODE),HIGH(_IPC1_RCV_MODE),LOW(_IPC1_RCV_RUN),HIGH(_IPC1_RCV_RUN),LOW(_IPC1_RCV_DOSE),HIGH(_IPC1_RCV_DOSE),LOW(_IPC1_RCV_VOLTAGE),HIGH(_IPC1_RCV_VOLTAGE)
	.DB  LOW(_IPC1_RCV_DEPTH),HIGH(_IPC1_RCV_DEPTH),LOW(_IPC1_RCV_SPEED),HIGH(_IPC1_RCV_SPEED),LOW(_IPC1_RCV_ELCOUNT),HIGH(_IPC1_RCV_ELCOUNT),LOW(_IPC1_RCV_FLAG),HIGH(_IPC1_RCV_FLAG)
	.DB  LOW(_IPC1_RCV_EL_MAP),HIGH(_IPC1_RCV_EL_MAP),LOW(_IPC1_RCV_MOTOR_POS1),HIGH(_IPC1_RCV_MOTOR_POS1),LOW(_IPC1_RCV_MOTOR_POS2),HIGH(_IPC1_RCV_MOTOR_POS2),LOW(_IPC1_RCV_ERROR),HIGH(_IPC1_RCV_ERROR)
_0x6001E:
	.DB  LOW(_IPC1_SND_MODE),HIGH(_IPC1_SND_MODE),LOW(_IPC1_SND_RUN),HIGH(_IPC1_SND_RUN),LOW(_IPC1_SND_DOSE),HIGH(_IPC1_SND_DOSE),LOW(_IPC1_SND_VOLTAGE),HIGH(_IPC1_SND_VOLTAGE)
	.DB  LOW(_IPC1_SND_DEPTH),HIGH(_IPC1_SND_DEPTH),LOW(_IPC1_SND_SPEED),HIGH(_IPC1_SND_SPEED),LOW(_IPC1_SND_ELCOUNT),HIGH(_IPC1_SND_ELCOUNT),LOW(_IPC1_SND_FLAG),HIGH(_IPC1_SND_FLAG)
	.DB  LOW(_IPC1_SND_EL_MAP),HIGH(_IPC1_SND_EL_MAP),LOW(_IPC1_SND_MOTOR_POS1),HIGH(_IPC1_SND_MOTOR_POS1),LOW(_IPC1_SND_MOTOR_POS2),HIGH(_IPC1_SND_MOTOR_POS2),LOW(_IPC1_SND_ERROR),HIGH(_IPC1_SND_ERROR)
_0x6002F:
	.DB  LOW(_IPC0_RCV_MODE),HIGH(_IPC0_RCV_MODE),LOW(_IPC0_RCV_RUN),HIGH(_IPC0_RCV_RUN),LOW(_IPC0_RCV_DOSE),HIGH(_IPC0_RCV_DOSE),LOW(_IPC0_RCV_VOLTAGE),HIGH(_IPC0_RCV_VOLTAGE)
	.DB  LOW(_IPC0_RCV_DEPTH),HIGH(_IPC0_RCV_DEPTH),LOW(_IPC0_RCV_SPEED),HIGH(_IPC0_RCV_SPEED),LOW(_IPC0_RCV_ELCOUNT),HIGH(_IPC0_RCV_ELCOUNT),LOW(_IPC0_RCV_FLAG),HIGH(_IPC0_RCV_FLAG)
	.DB  LOW(_IPC0_RCV_EL_MAP),HIGH(_IPC0_RCV_EL_MAP),LOW(_IPC0_RCV_MOTOR_POS1),HIGH(_IPC0_RCV_MOTOR_POS1),LOW(_IPC0_RCV_MOTOR_POS2),HIGH(_IPC0_RCV_MOTOR_POS2),LOW(_IPC0_RCV_ERROR),HIGH(_IPC0_RCV_ERROR)
_0x6003D:
	.DB  LOW(_IPC0_SND_MODE),HIGH(_IPC0_SND_MODE),LOW(_IPC0_SND_RUN),HIGH(_IPC0_SND_RUN),LOW(_IPC0_SND_DOSE),HIGH(_IPC0_SND_DOSE),LOW(_IPC0_SND_VOLTAGE),HIGH(_IPC0_SND_VOLTAGE)
	.DB  LOW(_IPC0_SND_DEPTH),HIGH(_IPC0_SND_DEPTH),LOW(_IPC0_SND_SPEED),HIGH(_IPC0_SND_SPEED),LOW(_IPC0_SND_ELCOUNT),HIGH(_IPC0_SND_ELCOUNT),LOW(_IPC0_SND_FLAG),HIGH(_IPC0_SND_FLAG)
	.DB  LOW(_IPC0_SND_EL_MAP),HIGH(_IPC0_SND_EL_MAP),LOW(_IPC0_SND_MOTOR_POS1),HIGH(_IPC0_SND_MOTOR_POS1),LOW(_IPC0_SND_MOTOR_POS2),HIGH(_IPC0_SND_MOTOR_POS2),LOW(_IPC0_SND_ERROR),HIGH(_IPC0_SND_ERROR)
_0xE0003:
	.DB  0x88,0x13
_0x2080060:
	.DB  0x1
_0x2080000:
	.DB  0x2D,0x4E,0x41,0x4E,0x0,0x49,0x4E,0x46
	.DB  0x0

__GLOBAL_INI_TBL:
	.DW  0x0A
	.DW  0x04
	.DW  __REG_VARS*2

	.DW  0x18
	.DW  _IPC1Rcvfun
	.DW  _0x60003*2

	.DW  0x18
	.DW  _IPC1Sndfun
	.DW  _0x6001E*2

	.DW  0x18
	.DW  _IPC0Rcvfun
	.DW  _0x6002F*2

	.DW  0x18
	.DW  _IPC0Sndfun
	.DW  _0x6003D*2

	.DW  0x02
	.DW  _gSetVolagteInitTime
	.DW  _0xE0003*2

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
;#include "InEepromLib.h"
;
;#define  EEWE    1
;#define  EEMWE   2
;#define  EERE    0
;
;void _EEPROMWrite( WORD addr, BYTE data )
; 0000 0009 {

	.CSEG
__EEPROMWrite:
; .FSTART __EEPROMWrite
; 0000 000A      while( EECR & (1 << EEWE) );
	ST   -Y,R26
;	addr -> Y+1
;	data -> Y+0
_0x3:
	SBIC 0x1C,1
	RJMP _0x3
; 0000 000B      EEAR = addr;
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 0000 000C      EEDR = data;
	LD   R30,Y
	OUT  0x1D,R30
; 0000 000D      EECR |= ( 1 << EEMWE);
	SBI  0x1C,2
; 0000 000E      EECR |= ( 1 << EEWE);
	SBI  0x1C,1
; 0000 000F }
	JMP  _0x20A000E
; .FEND
;
;BYTE _EEPROMRead( WORD addr)
; 0000 0012 {
__EEPROMRead:
; .FSTART __EEPROMRead
; 0000 0013      while( EECR & (1 << EEWE) );
	ST   -Y,R27
	ST   -Y,R26
;	addr -> Y+0
_0x6:
	SBIC 0x1C,1
	RJMP _0x6
; 0000 0014      EEAR = addr;
	LD   R30,Y
	LDD  R31,Y+1
	OUT  0x1E+1,R31
	OUT  0x1E,R30
; 0000 0015      EECR |= ( 1 << EERE);
	SBI  0x1C,0
; 0000 0016      return EEDR;
	IN   R30,0x1D
	JMP  _0x20A000C
; 0000 0017 }
; .FEND
;BYTE E2pRead( WORD Addr )
; 0000 0019 {
; 0000 001A     return _EEPROMRead( Addr );
;	Addr -> Y+0
; 0000 001B }
;void E2pReadLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
; 0000 001D {
_E2pReadLen:
; .FSTART _E2pReadLen
; 0000 001E     int i;
; 0000 001F 
; 0000 0020     for( i=0; i< nLen; i++ )
	ST   -Y,R26
	CALL SUBOPT_0x0
;	*bDat -> Y+4
;	bAddr -> Y+3
;	nLen -> Y+2
;	i -> R16,R17
_0xA:
	LDD  R30,Y+2
	MOVW R26,R16
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRGE _0xB
; 0000 0021     {
; 0000 0022         bDat[i] = _EEPROMRead( bAddr+i );
	MOVW R30,R16
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	ADD  R30,R26
	ADC  R31,R27
	PUSH R31
	PUSH R30
	MOVW R30,R16
	LDD  R26,Y+3
	LDI  R27,0
	ADD  R26,R30
	ADC  R27,R31
	RCALL __EEPROMRead
	POP  R26
	POP  R27
	ST   X,R30
; 0000 0023     }
	__ADDWRN 16,17,1
	RJMP _0xA
_0xB:
; 0000 0024 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0010
; .FEND
;void E2pWriteLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
; 0000 0026 {
_E2pWriteLen:
; .FSTART _E2pWriteLen
; 0000 0027     int i;
; 0000 0028     for( i=0; i< nLen; i++)
	ST   -Y,R26
	CALL SUBOPT_0x0
;	*bDat -> Y+4
;	bAddr -> Y+3
;	nLen -> Y+2
;	i -> R16,R17
_0xD:
	LDD  R30,Y+2
	MOVW R26,R16
	LDI  R31,0
	CP   R26,R30
	CPC  R27,R31
	BRGE _0xE
; 0000 0029     {
; 0000 002A        _EEPROMWrite( bAddr+i, bDat[i] );
	MOVW R30,R16
	LDD  R26,Y+3
	LDI  R27,0
	ADD  R30,R26
	ADC  R31,R27
	ST   -Y,R31
	ST   -Y,R30
	MOVW R30,R16
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RCALL __EEPROMWrite
; 0000 002B     }
	__ADDWRN 16,17,1
	RJMP _0xD
_0xE:
; 0000 002C }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0010
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
;#include  "I2CLib.h"
;
;BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
; 0001 0006 {

	.CSEG
; 0001 0007      WORD i;
; 0001 0008 
; 0001 0009 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 000A    if( address > 0x1fff)
; 0001 000B        return ERROR;
; 0001 000C #else
; 0001 000D    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 0001 000E        return ERROR;
; 0001 000F #endif
; 0001 0010      /* Start */
; 0001 0011      I2C_Start();
; 0001 0012      /*Device Address & Write mode */
; 0001 0013      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0001 0014      I2C_Ack();
; 0001 0015 
; 0001 0016 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 0017      I2C_ShiftOut( (address>>8)&0xff ); /* High Address */
; 0001 0018      I2C_Ack();
; 0001 0019 #endif
; 0001 001A 
; 0001 001B      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );   /* Low Address */
; 0001 001C      I2C_Ack();
; 0001 001D 
; 0001 001E      for( i=0; i< Count; i++ )
; 0001 001F      {
; 0001 0020     /* Data Read  */
; 0001 0021     I2C_ShiftOut( Data[i] );
; 0001 0022            I2C_Ack();
; 0001 0023      }
; 0001 0024     // I2C_Ack();
; 0001 0025 
; 0001 0026      /** bring SDA high while clock is high */
; 0001 0027      I2C_Stop();
; 0001 0028 
; 0001 0029      //for( i=0; i<500; i++ )
; 0001 002A            i2c_delay();        /* 10mSec delay(no test) */
; 0001 002B 
; 0001 002C      return OK;
; 0001 002D }
;
;
;BYTE I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
; 0001 0031 {
; 0001 0032    //WORD i;
; 0001 0033 
; 0001 0034 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 0035    if( address > 0x1fff)
; 0001 0036        return ERROR;
; 0001 0037 #else
; 0001 0038    if( address > 0xff)
;	ChipAddr -> Y+3
;	address -> Y+1
;	dat -> Y+0
; 0001 0039        return ERROR;
; 0001 003A #endif
; 0001 003B 
; 0001 003C    I2C_Start();  // Start
; 0001 003D 
; 0001 003E    // Device Address & Write mode
; 0001 003F    I2C_ShiftOut( ChipAddr&0xfe );
; 0001 0040    I2C_Ack();
; 0001 0041 
; 0001 0042 #ifdef   CFG_I2C_HIGH_ADDRESS
; 0001 0043    // High Address
; 0001 0044    I2C_ShiftOut( (address>>8)&0xff );
; 0001 0045    I2C_Ack();
; 0001 0046 #endif
; 0001 0047 
; 0001 0048    // Low Address
; 0001 0049    I2C_ShiftOut( address&0xff );
; 0001 004A    I2C_Ack();
; 0001 004B 
; 0001 004C    I2C_ShiftOut( dat );     // write data
; 0001 004D    I2C_Ack();
; 0001 004E 
; 0001 004F    // bring SDA high while clock is high
; 0001 0050    I2C_Stop();
; 0001 0051 
; 0001 0052    //for( i=0; i<400; i++ )
; 0001 0053         i2c_delay();        //10mSec delay(no test)
; 0001 0054 
; 0001 0055    return OK;
; 0001 0056 }
;
;void i2c_delay(void)
; 0001 0059 {
_i2c_delay:
; .FSTART _i2c_delay
; 0001 005A   // int i;
; 0001 005B 
; 0001 005C //   for( i=0; i<10;i++ )    //
; 0001 005D  //    for( i=0; i<2;i++ )    //
; 0001 005E 
; 0001 005F        #asm( "nop" );
	nop
; 0001 0060 }
	RET
; .FEND
;
;BYTE I2C_Ack(void )
; 0001 0063 {
; 0001 0064      BYTE Ack;
; 0001 0065 
; 0001 0066      HIGH_SDA;
;	Ack -> R17
; 0001 0067 
; 0001 0068      I2C_R_MODE; //DDRC.2 = 0;
; 0001 0069      HIGH_SCLK;
; 0001 006A      i2c_delay();
; 0001 006B      Ack = IN_SDA;
; 0001 006C      i2c_delay();
; 0001 006D      LOW_SCLK;
; 0001 006E 
; 0001 006F      I2C_W_MODE; //DDRC.2 = 1;
; 0001 0070      i2c_delay();
; 0001 0071 
; 0001 0072      if( Ack )
; 0001 0073         return ERROR;
; 0001 0074 
; 0001 0075      return OK;
; 0001 0076 }
;
;BYTE I2C_OutAck( BYTE Flag  )
; 0001 0079 {
; 0001 007A        //BYTE Ack;
; 0001 007B 
; 0001 007C        if( Flag )    HIGH_SDA;
;	Flag -> Y+0
; 0001 007D         else        LOW_SDA;
; 0001 007E        /*LOW_SCLK; */
; 0001 007F 
; 0001 0080        /*i2c_delay(); */
; 0001 0081        HIGH_SCLK;
; 0001 0082       // Ack = IN_SDA;//ioport1&0x80;
; 0001 0083        i2c_delay();
; 0001 0084        LOW_SCLK;
; 0001 0085 
; 0001 0086        i2c_delay();
; 0001 0087 
; 0001 0088        //if( Ack )
; 0001 0089 //    return ERROR;
; 0001 008A 
; 0001 008B        return OK;
; 0001 008C }
;
;
;BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
; 0001 0090 {
; 0001 0091      WORD i;
; 0001 0092 
; 0001 0093 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 0094    if( address > 0x1fff)
; 0001 0095        return ERROR;
; 0001 0096 #else
; 0001 0097    if( address > 0xff)
;	ChipAddr -> Y+8
;	address -> Y+6
;	*Data -> Y+4
;	Count -> Y+2
;	i -> R16,R17
; 0001 0098        return ERROR;
; 0001 0099 #endif
; 0001 009A      /* Start */
; 0001 009B      I2C_Start();
; 0001 009C      // Device Address & Write mod
; 0001 009D      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0001 009E      I2C_Ack();
; 0001 009F 
; 0001 00A0 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 00A1      // High Address
; 0001 00A2      I2C_ShiftOut( (address>>8)&0xff );
; 0001 00A3      I2C_Ack();
; 0001 00A4 #endif
; 0001 00A5      // Low Address
; 0001 00A6      I2C_ShiftOut( address&0xff );
; 0001 00A7      I2C_Ack();
; 0001 00A8 
; 0001 00A9      /* Start */
; 0001 00AA      I2C_Start();
; 0001 00AB      /*Device Address & Read mode */
; 0001 00AC      I2C_ShiftOut( 0x01|(BYTE)(ChipAddr&0xff) );
; 0001 00AD      I2C_Ack();
; 0001 00AE 
; 0001 00AF      for( i=0; i< Count-1; i++ )
; 0001 00B0      {
; 0001 00B1      /* Data Read  */
; 0001 00B2      Data[i] = I2C_ShiftIn();
; 0001 00B3            // I2C_Ack();
; 0001 00B4            I2C_OutAck( FALSE );
; 0001 00B5      }
; 0001 00B6       Data[i] =    I2C_ShiftIn();
; 0001 00B7       I2C_OutAck( TRUE );
; 0001 00B8      //I2C_Ack();
; 0001 00B9      /** bring SDA high while clock is high */
; 0001 00BA      I2C_Stop();
; 0001 00BB 
; 0001 00BC      return OK;
; 0001 00BD }
;
;BYTE I2C_Read( BYTE ChipAddr, WORD address )
; 0001 00C0 {
; 0001 00C1      BYTE Dat;
; 0001 00C2 
; 0001 00C3 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 00C4    if( address > 0x1fff)
; 0001 00C5        return ERROR;
; 0001 00C6 #else
; 0001 00C7    if( address > 0xff)
;	ChipAddr -> Y+3
;	address -> Y+1
;	Dat -> R17
; 0001 00C8        return ERROR;
; 0001 00C9 #endif
; 0001 00CA 
; 0001 00CB      I2C_Start();   // Start
; 0001 00CC 
; 0001 00CD      /*Device Address & Write mode */
; 0001 00CE      I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
; 0001 00CF      I2C_Ack();
; 0001 00D0 
; 0001 00D1 #ifdef CFG_I2C_HIGH_ADDRESS
; 0001 00D2      // High Address
; 0001 00D3      I2C_ShiftOut( (address>>8)&0xff );
; 0001 00D4      I2C_Ack();
; 0001 00D5 #endif
; 0001 00D6 
; 0001 00D7      // Low Address
; 0001 00D8      I2C_ShiftOut( address&0xff );
; 0001 00D9      I2C_Ack();
; 0001 00DA 
; 0001 00DB      // Start
; 0001 00DC      I2C_Start();
; 0001 00DD      // Device Address & Read mode
; 0001 00DE      I2C_ShiftOut( 0x01| (BYTE)(ChipAddr&0xff) );
; 0001 00DF 
; 0001 00E0      I2C_Ack();
; 0001 00E1 
; 0001 00E2       // Data Read
; 0001 00E3       Dat = I2C_ShiftIn();
; 0001 00E4       I2C_Ack();
; 0001 00E5 
; 0001 00E6       /** bring SDA high while clock is high */
; 0001 00E7       I2C_Stop();
; 0001 00E8 
; 0001 00E9      return Dat;
; 0001 00EA }
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
; 0001 011D {
; 0001 011E       HIGH_SDA;    /* high serial data  */
; 0001 011F       HIGH_SCLK;   /* high serial clock */
; 0001 0120       i2c_delay();
; 0001 0121       LOW_SDA;     /* low  serial data */
; 0001 0122       i2c_delay();
; 0001 0123       LOW_SCLK;    /* low  serial clock */
; 0001 0124       i2c_delay();
; 0001 0125 }
;
;void I2C_Stop( void )
; 0001 0128 {
; 0001 0129      LOW_SCLK;
; 0001 012A      LOW_SDA;      /* low serial data */
; 0001 012B      i2c_delay();
; 0001 012C      HIGH_SCLK;    /* high serial clock */
; 0001 012D      i2c_delay();
; 0001 012E      HIGH_SDA;     /* high serial data      */
; 0001 012F }
;
;void I2C_ShiftOut( BYTE dat )
; 0001 0132 {
; 0001 0133      BYTE i,temp;
; 0001 0134 
; 0001 0135      for( i=0; i<8; i++ )
;	dat -> Y+2
;	i -> R17
;	temp -> R16
; 0001 0136      {
; 0001 0137         /* right shift */
; 0001 0138         temp = dat & ( 0x80>>i );
; 0001 0139 
; 0001 013A        if( temp )   HIGH_SDA;    /* high data   */
; 0001 013B        else         LOW_SDA;
; 0001 013C        i2c_delay();
; 0001 013D        HIGH_SCLK;              /* high clock   */
; 0001 013E        i2c_delay();
; 0001 013F        LOW_SCLK;               /* low clock    */
; 0001 0140        i2c_delay();
; 0001 0141      }
; 0001 0142 }
;
;BYTE I2C_ShiftIn( void )
; 0001 0145 {
; 0001 0146      BYTE i=0,temp;
; 0001 0147      BYTE Dat=0;
; 0001 0148 
; 0001 0149      HIGH_SDA;
;	i -> R17
;	temp -> R16
;	Dat -> R19
; 0001 014A      I2C_R_MODE;      // input mode
; 0001 014B      for( i=0; i<8; i++ )
; 0001 014C      {
; 0001 014D           //  HIGH_SDA;
; 0001 014E           HIGH_SCLK;         /* high serial clock    */
; 0001 014F           i2c_delay();
; 0001 0150 
; 0001 0151           temp = IN_SDA;     // &0x80;
; 0001 0152           Dat |= ( temp<<(7-i) );
; 0001 0153 
; 0001 0154           i2c_delay();
; 0001 0155           LOW_SCLK;          /* low serial clock; */
; 0001 0156           i2c_delay();
; 0001 0157      }
; 0001 0158 
; 0001 0159       I2C_W_MODE;   // output mode
; 0001 015A 
; 0001 015B      return Dat;
; 0001 015C }
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
;//const BYTE VolArray[15] = {4, 8, 14, 21, 30, 40, 50, 65, 82, 93, 110, 124, 138, 150, 160};
;//const BYTE VolArray[15] = {5, 8, 14, 20, 30, 40, 53, 65, 82, 93, 110, 124, 138, 150, 160};
;
;                           //20 30 40  50  60  70  80  90  100 110 120  130  140  150  160   2020-10-21
;const BYTE VolArray[15] =   {5, 11, 18, 26, 40, 51, 63, 74, 85, 93, 109, 124, 138, 150, 160};
;
;void DAC7611_init( void )
; 0002 0011 {

	.CSEG
_DAC7611_init:
; .FSTART _DAC7611_init
; 0002 0012    DAC7611_Write( 0 );
	LDI  R26,LOW(0)
	LDI  R27,0
	RCALL _DAC7611_Write
; 0002 0013 }
	RET
; .FEND
;
;void DAC7611_WriteVoltage( int data )
; 0002 0016 {
_DAC7611_WriteVoltage:
; .FSTART _DAC7611_WriteVoltage
; 0002 0017    WORD temp;
; 0002 0018    int mRefVol;
; 0002 0019 
; 0002 001A    if(data < 20 )
	CALL SUBOPT_0x1
;	data -> Y+4
;	temp -> R16,R17
;	mRefVol -> R18,R19
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	SBIW R26,20
	BRGE _0x40003
; 0002 001B    {
; 0002 001C       mRefVol = 0;
	__GETWRN 18,19,0
; 0002 001D    }
; 0002 001E    else
	RJMP _0x40004
_0x40003:
; 0002 001F    {
; 0002 0020       mRefVol =  (data-20)/10;
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	CALL SUBOPT_0x2
	MOVW R18,R30
; 0002 0021       mRefVol = VolArray[mRefVol];
	SUBI R30,LOW(-_VolArray*2)
	SBCI R31,HIGH(-_VolArray*2)
	LPM  R18,Z
	CLR  R19
; 0002 0022    }
_0x40004:
; 0002 0023 
; 0002 0024    temp = (WORD)(4095.0f/160.0f* (float)mRefVol);
	CALL SUBOPT_0x3
	__GETD2N 0x41CCC000
	CALL __MULF12
	CALL __CFD1U
	MOVW R16,R30
; 0002 0025 
; 0002 0026    DAC7611_Write( temp );
	MOVW R26,R16
	RCALL _DAC7611_Write
; 0002 0027 }
	RJMP _0x20A000F
; .FEND
;
;void DAC7611_Write( WORD data )
; 0002 002A {
_DAC7611_Write:
; .FSTART _DAC7611_Write
; 0002 002B      int i;
; 0002 002C      WORD temp;
; 0002 002D 
; 0002 002E      HIGH_LD;
	CALL SUBOPT_0x1
;	data -> Y+4
;	i -> R16,R17
;	temp -> R18,R19
	SBI  0x1B,3
; 0002 002F      HIGH_SCLK;
	SBI  0x1B,1
; 0002 0030      LOW_CS;
	CBI  0x1B,2
; 0002 0031 
; 0002 0032      for( i=0; i<12; i++ )
	__GETWRN 16,17,0
_0x4000C:
	__CPWRN 16,17,12
	BRGE _0x4000D
; 0002 0033      {
; 0002 0034         /* right shift */
; 0002 0035        temp = data & ( 0x800>>i );
	MOV  R30,R16
	LDI  R26,LOW(2048)
	LDI  R27,HIGH(2048)
	CALL __LSRW12
	LDD  R26,Y+4
	LDD  R27,Y+4+1
	AND  R30,R26
	AND  R31,R27
	MOVW R18,R30
; 0002 0036 
; 0002 0037        if( temp ) HIGH_SDA;    /* high data  */
	MOV  R0,R18
	OR   R0,R19
	BREQ _0x4000E
	SBI  0x1B,0
; 0002 0038        else       LOW_SDA;
	RJMP _0x40011
_0x4000E:
	CBI  0x1B,0
; 0002 0039 
; 0002 003A        i2c_delay();
_0x40011:
	RCALL _i2c_delay
; 0002 003B        LOW_SCLK;          /* high clock */
	CBI  0x1B,1
; 0002 003C        i2c_delay();
	RCALL _i2c_delay
; 0002 003D        HIGH_SCLK;         /* low clock    */
	SBI  0x1B,1
; 0002 003E        i2c_delay();
	RCALL _i2c_delay
; 0002 003F      }
	__ADDWRN 16,17,1
	RJMP _0x4000C
_0x4000D:
; 0002 0040 
; 0002 0041      HIGH_CS;
	SBI  0x1B,2
; 0002 0042 
; 0002 0043      LOW_LD;
	CBI  0x1B,3
; 0002 0044      i2c_delay();
	RCALL _i2c_delay
; 0002 0045      HIGH_LD;
	SBI  0x1B,3
; 0002 0046 }
_0x20A000F:
	CALL __LOADLOCR4
_0x20A0010:
	ADIW R28,6
	RET
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
;#include "IPCLib.h"
;#include <string.h>
;#include <math.h>
;#include "../Uart/uart.h"
;#include "../I2CLib/I2CLIb.h"
;#include "../InADC/InAdc.h"
;#include "../DAC7611/DAC7611.h"
;
;extern BYTE gElMatrix[4];
;extern WORD goldTime1ms;
;extern WORD gTime1ms;
;extern int gVoltage;
;extern BYTE gMode;
;extern BOOL gRunFlag;
;extern int gDose;
;extern int gDepth;
;extern int gSpeed;
;extern BYTE gFlag;
;extern BYTE gError;
;extern int gMotorPos1;
;extern int gMotorPos2;
;extern BOOL gElCompletFlag;
;extern int  gElCount;
;//extern int  gReadVol;
;extern BYTE gCurMode;
;extern BOOL gReadyActionFlag;
;extern int  gVolChkCount;
;
;extern void SaveInEeprom( void );
;BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
;BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead );
;typedef BYTE(*RunFun) (LPIPC_HEADER pHead );
;
;RunFun IPC1Rcvfun[]=
;{
;     IPC1_RCV_MODE,
;     IPC1_RCV_RUN,
;     IPC1_RCV_DOSE,
;     IPC1_RCV_VOLTAGE,
;     IPC1_RCV_DEPTH,
;     IPC1_RCV_SPEED,
;     IPC1_RCV_ELCOUNT,
;     IPC1_RCV_FLAG,
;     IPC1_RCV_EL_MAP,
;     IPC1_RCV_MOTOR_POS1,
;     IPC1_RCV_MOTOR_POS2,
;     IPC1_RCV_ERROR
;};

	.DSEG
;
;BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead )
; 0003 003E {

	.CSEG
_IPC1_RCV_MODE:
; .FSTART _IPC1_RCV_MODE
; 0003 003F     return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0040 }
; .FEND
;
;BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead )
; 0003 0043 {
_IPC1_RCV_RUN:
; .FSTART _IPC1_RCV_RUN
; 0003 0044    //gRunFlag =  pHead->data1;
; 0003 0045    //gRunFlag = gRunFlag?TRUE:FALSE;
; 0003 0046    BOOL mFlag =  pHead->data1? TRUE:FALSE;
; 0003 0047    if( mFlag )
	CALL SUBOPT_0x4
;	*pHead -> Y+1
;	mFlag -> R17
	LDD  R30,Z+3
	CPI  R30,0
	BREQ _0x60004
	LDI  R30,LOW(1)
	RJMP _0x60005
_0x60004:
	LDI  R30,LOW(0)
_0x60005:
	MOV  R17,R30
	CPI  R17,0
	BREQ _0x60007
; 0003 0048        SaveInEeprom();
	CALL _SaveInEeprom
; 0003 0049 
; 0003 004A    return TRUE;
_0x60007:
	RJMP _0x20A000D
; 0003 004B }
; .FEND
;
;BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead )
; 0003 004E {
_IPC1_RCV_DOSE:
; .FSTART _IPC1_RCV_DOSE
; 0003 004F    gDose = pHead->data2 | ((int)pHead->data1<<8);
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R26,Z+4
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R30,Z+3
	MOV  R31,R30
	LDI  R30,0
	OR   R30,R26
	CALL SUBOPT_0x6
; 0003 0050    if( gDose < 0 ) gDose = 0;
	LDS  R26,_gDose+1
	TST  R26
	BRPL _0x60008
	CALL SUBOPT_0x7
; 0003 0051    if( gDose > 3 ) gDose = 3;
_0x60008:
	LDS  R26,_gDose
	LDS  R27,_gDose+1
	SBIW R26,4
	BRLT _0x60009
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL SUBOPT_0x6
; 0003 0052 
; 0003 0053    return TRUE;
_0x60009:
	RJMP _0x20A000B
; 0003 0054 }
; .FEND
;
;BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead )
; 0003 0057 {
_IPC1_RCV_VOLTAGE:
; .FSTART _IPC1_RCV_VOLTAGE
; 0003 0058    gVoltage = pHead->data1;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+3
	CALL SUBOPT_0x8
; 0003 0059    if( gVoltage < 60 ) gVoltage = 60;
	BRGE _0x6000A
	CALL SUBOPT_0x9
; 0003 005A    if( gVoltage > 120 ) gVoltage = 120;
_0x6000A:
	CALL SUBOPT_0xA
	CPI  R26,LOW(0x79)
	LDI  R30,HIGH(0x79)
	CPC  R27,R30
	BRLT _0x6000B
	CALL SUBOPT_0xB
; 0003 005B 
; 0003 005C    if( gVoltage > 50 ) LOW_VOLRY;
_0x6000B:
	CALL SUBOPT_0xA
	SBIW R26,51
	BRLT _0x6000C
	CBI  0x12,7
; 0003 005D    else  HIGH_VOLRY;
	RJMP _0x6000F
_0x6000C:
	SBI  0x12,7
; 0003 005E 
; 0003 005F   // DAC7611_WriteVoltage(gVoltage);
; 0003 0060 
; 0003 0061    return TRUE;
_0x6000F:
	RJMP _0x20A000B
; 0003 0062 }
; .FEND
;
;BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead )
; 0003 0065 {
_IPC1_RCV_DEPTH:
; .FSTART _IPC1_RCV_DEPTH
; 0003 0066    gDepth = pHead->data1;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+3
	CALL SUBOPT_0xC
; 0003 0067    if( gDepth < 0 ) gDepth = 0;
	BRPL _0x60012
	CALL SUBOPT_0xD
; 0003 0068    if( gDepth > 3 ) gDepth = 3;
_0x60012:
	LDS  R26,_gDepth
	LDS  R27,_gDepth+1
	SBIW R26,4
	BRLT _0x60013
	CALL SUBOPT_0xE
; 0003 0069 
; 0003 006A    return TRUE;
_0x60013:
	RJMP _0x20A000B
; 0003 006B }
; .FEND
;
;BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead )
; 0003 006E {
_IPC1_RCV_SPEED:
; .FSTART _IPC1_RCV_SPEED
; 0003 006F    gSpeed = pHead->data1;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+3
	CALL SUBOPT_0xF
; 0003 0070    if( gSpeed < 0 ) gSpeed = 0;
	BRPL _0x60014
	LDI  R30,LOW(0)
	STS  _gSpeed,R30
	STS  _gSpeed+1,R30
; 0003 0071    if( gSpeed > 2 ) gSpeed = 2;
_0x60014:
	LDS  R26,_gSpeed
	LDS  R27,_gSpeed+1
	SBIW R26,3
	BRLT _0x60015
	CALL SUBOPT_0x10
; 0003 0072 
; 0003 0073    return TRUE;
_0x60015:
	RJMP _0x20A000B
; 0003 0074 }
; .FEND
;
;BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead )
; 0003 0077 {
_IPC1_RCV_ELCOUNT:
; .FSTART _IPC1_RCV_ELCOUNT
; 0003 0078    gElCount = pHead->data1;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+3
	LDI  R31,0
	CALL SUBOPT_0x11
; 0003 0079    if( gElCount < 0 ) gElCount = 0;
	LDS  R26,_gElCount+1
	TST  R26
	BRPL _0x60016
	LDI  R30,LOW(0)
	STS  _gElCount,R30
	STS  _gElCount+1,R30
; 0003 007A    if( gElCount > 100 ) gElCount = 100;
_0x60016:
	LDS  R26,_gElCount
	LDS  R27,_gElCount+1
	CPI  R26,LOW(0x65)
	LDI  R30,HIGH(0x65)
	CPC  R27,R30
	BRLT _0x60017
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	CALL SUBOPT_0x11
; 0003 007B 
; 0003 007C    return TRUE;
_0x60017:
	RJMP _0x20A000B
; 0003 007D }
; .FEND
;
;BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead )
; 0003 0080 {
_IPC1_RCV_FLAG:
; .FSTART _IPC1_RCV_FLAG
; 0003 0081    gFlag = pHead->data2;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+4
	STS  _gFlag,R30
; 0003 0082 
; 0003 0083    return TRUE;
	RJMP _0x20A000B
; 0003 0084 }
; .FEND
;
;BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead )
; 0003 0087 {
_IPC1_RCV_EL_MAP:
; .FSTART _IPC1_RCV_EL_MAP
; 0003 0088    gElMatrix[0] = (BYTE)((pHead->data1>>4)&0xf);
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+3
	SWAP R30
	ANDI R30,LOW(0xF)
	STS  _gElMatrix,R30
; 0003 0089    gElMatrix[1] = (BYTE)(pHead->data1&0xf);
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Z+3
	LDI  R30,LOW(15)
	AND  R30,R26
	__PUTB1MN _gElMatrix,1
; 0003 008A    gElMatrix[2] = (BYTE)((pHead->data2>>4)&0xf);
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R30,Z+4
	SWAP R30
	ANDI R30,LOW(0xF)
	__PUTB1MN _gElMatrix,2
; 0003 008B    gElMatrix[3] = (BYTE)(pHead->data2&0xf);
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R26,Z+4
	LDI  R30,LOW(15)
	AND  R30,R26
	__PUTB1MN _gElMatrix,3
; 0003 008C 
; 0003 008D    return TRUE;
	RJMP _0x20A000B
; 0003 008E }
; .FEND
;
;BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
; 0003 0091 {
_IPC1_RCV_MOTOR_POS1:
; .FSTART _IPC1_RCV_MOTOR_POS1
; 0003 0092    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0093 }
; .FEND
;
;BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
; 0003 0096 {
_IPC1_RCV_MOTOR_POS2:
; .FSTART _IPC1_RCV_MOTOR_POS2
; 0003 0097    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0098 }
; .FEND
;
;BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead )
; 0003 009B {
_IPC1_RCV_ERROR:
; .FSTART _IPC1_RCV_ERROR
; 0003 009C    BYTE mErrPos = pHead->data1;
; 0003 009D    BOOL mSetClearFlag = pHead->data2?TRUE:FALSE;
; 0003 009E 
; 0003 009F    if( mErrPos> ERROR_EM_STOP )
	CALL SUBOPT_0x12
;	*pHead -> Y+2
;	mErrPos -> R17
;	mSetClearFlag -> R16
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R30,Z+3
	MOV  R17,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x60018
	LDI  R30,LOW(1)
	RJMP _0x60019
_0x60018:
	LDI  R30,LOW(0)
_0x60019:
	MOV  R16,R30
	CPI  R17,8
	BRLO _0x6001B
; 0003 00A0        mErrPos = ERROR_EM_STOP;
	LDI  R17,LOW(7)
; 0003 00A1 
; 0003 00A2    if( mSetClearFlag )
_0x6001B:
	CPI  R16,0
	BREQ _0x6001C
; 0003 00A3         gError &= ~(1<<mErrPos);
	CALL SUBOPT_0x13
	COM  R30
	LDS  R26,_gError
	AND  R30,R26
	RJMP _0x6004D
; 0003 00A4    else gError |= (1<<mErrPos);
_0x6001C:
	CALL SUBOPT_0x13
	LDS  R26,_gError
	OR   R30,R26
_0x6004D:
	STS  _gError,R30
; 0003 00A5 
; 0003 00A6    return TRUE;
	LDI  R30,LOW(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,4
	RET
; 0003 00A7 }
; .FEND
;
;BYTE IPC1_SND_MODE( LPIPC_HEADER pHead );
;BYTE IPC1_SND_RUN( LPIPC_HEADER pHead );
;BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead );
;BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead );
;BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead );
;BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead );
;BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead );
;BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead );
;BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead );
;BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead );
;BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead );
;typedef BYTE(*SenFun) (LPIPC_HEADER pHead);
;
;SenFun IPC1Sndfun[]=
;{
;     IPC1_SND_MODE,
;     IPC1_SND_RUN,
;     IPC1_SND_DOSE,
;     IPC1_SND_VOLTAGE,
;     IPC1_SND_DEPTH,
;     IPC1_SND_SPEED,
;     IPC1_SND_ELCOUNT,
;     IPC1_SND_FLAG,
;     IPC1_SND_EL_MAP,
;     IPC1_SND_MOTOR_POS1,
;     IPC1_SND_MOTOR_POS2,
;     IPC1_SND_ERROR
;};

	.DSEG
;
;BYTE IPC1_SND_MODE( LPIPC_HEADER pHead )
; 0003 00C8 {

	.CSEG
_IPC1_SND_MODE:
; .FSTART _IPC1_SND_MODE
; 0003 00C9    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 00CA    pHead->data1 = 0;//(BYTE)((gMode>>8)&0xff);  //
	LDI  R30,LOW(0)
	CALL SUBOPT_0x15
; 0003 00CB    pHead->data2 = (BYTE)(gMode&0xff);
; 0003 00CC 
; 0003 00CD    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 00CE 
; 0003 00CF    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 00D0    return TRUE;
	RJMP _0x20A000B
; 0003 00D1 }
; .FEND
;BYTE IPC1_SND_RUN( LPIPC_HEADER pHead )
; 0003 00D3 {
_IPC1_SND_RUN:
; .FSTART _IPC1_SND_RUN
; 0003 00D4    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 00D5    pHead->data1 = 1;  //
	CALL SUBOPT_0x18
; 0003 00D6    pHead->data2 = (BYTE)(gRunFlag&0xff);
; 0003 00D7 
; 0003 00D8    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 00D9 
; 0003 00DA    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 00DB    return TRUE;
	RJMP _0x20A000B
; 0003 00DC }
; .FEND
;
;BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead )
; 0003 00DF {
_IPC1_SND_DOSE:
; .FSTART _IPC1_SND_DOSE
; 0003 00E0    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 00E1    pHead->data1 = (BYTE)((gDose>>8)&0xff);
	CALL SUBOPT_0x1A
; 0003 00E2    pHead->data2 = (BYTE)(gDose&0xff);
; 0003 00E3 
; 0003 00E4    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 00E5 
; 0003 00E6    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 00E7    return TRUE;
	RJMP _0x20A000B
; 0003 00E8 }
; .FEND
;
;BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead )
; 0003 00EB {
_IPC1_SND_VOLTAGE:
; .FSTART _IPC1_SND_VOLTAGE
; 0003 00EC    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 00ED    pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  //
	CALL SUBOPT_0x1B
; 0003 00EE    pHead->data2 = (BYTE)(gVoltage&0xff);
; 0003 00EF 
; 0003 00F0    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 00F1 
; 0003 00F2    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 00F3 
; 0003 00F4    return TRUE;
	RJMP _0x20A000B
; 0003 00F5 }
; .FEND
;
;BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead )
; 0003 00F8 {
_IPC1_SND_DEPTH:
; .FSTART _IPC1_SND_DEPTH
; 0003 00F9    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 00FA    pHead->data1 = (BYTE)((gDepth>>8)&0xff);  //
	CALL SUBOPT_0x1C
; 0003 00FB    pHead->data2 = (BYTE)(gDepth&0xff);
; 0003 00FC 
; 0003 00FD    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 00FE 
; 0003 00FF    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 0100 
; 0003 0101    return TRUE;
	RJMP _0x20A000B
; 0003 0102 
; 0003 0103 }
; .FEND
;
;BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead )
; 0003 0106 {
_IPC1_SND_SPEED:
; .FSTART _IPC1_SND_SPEED
; 0003 0107    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 0108    pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  //
	CALL SUBOPT_0x1D
; 0003 0109    pHead->data2 = (BYTE)(gSpeed&0xff);
; 0003 010A 
; 0003 010B    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 010C 
; 0003 010D    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 010E    return TRUE;
	RJMP _0x20A000B
; 0003 010F 
; 0003 0110 }
; .FEND
;
;BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead )
; 0003 0113 {
_IPC1_SND_ELCOUNT:
; .FSTART _IPC1_SND_ELCOUNT
; 0003 0114    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 0115    pHead->data1 = (BYTE)((gElCount>>8)&0xff);  //
	CALL SUBOPT_0x1E
; 0003 0116    pHead->data2 = (BYTE)(gElCount&0xff);
; 0003 0117 
; 0003 0118    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 0119 
; 0003 011A    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 011B    return TRUE;
	RJMP _0x20A000B
; 0003 011C }
; .FEND
;
;BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead )
; 0003 011F {
_IPC1_SND_FLAG:
; .FSTART _IPC1_SND_FLAG
; 0003 0120    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 0121    pHead->data1 = (BYTE)(gRunFlag&0xff);
	LDS  R30,_gRunFlag
	CALL SUBOPT_0x1F
; 0003 0122    pHead->data2 = (BYTE)(gFlag&0xff);
	CALL SUBOPT_0x20
; 0003 0123 
; 0003 0124    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x16
	CALL SUBOPT_0x17
; 0003 0125 
; 0003 0126    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 0127 
; 0003 0128    return TRUE;
	RJMP _0x20A000B
; 0003 0129 
; 0003 012A }
; .FEND
;
;BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead )
; 0003 012D {
_IPC1_SND_EL_MAP:
; .FSTART _IPC1_SND_EL_MAP
; 0003 012E    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 012F    pHead->data1  = (gElMatrix[0]&0x0f)<<4 | (gElMatrix[1]&0x0f);
	LDS  R30,_gElMatrix
	ANDI R30,LOW(0xF)
	SWAP R30
	ANDI R30,0xF0
	MOV  R26,R30
	__GETB1MN _gElMatrix,1
	ANDI R30,LOW(0xF)
	OR   R30,R26
	__PUTB1SNS 0,3
; 0003 0130    pHead->data2  = (gElMatrix[2]&0x0f)<<4 | (gElMatrix[3]&0x0f);
	__GETB1MN _gElMatrix,2
	ANDI R30,LOW(0xF)
	SWAP R30
	ANDI R30,0xF0
	MOV  R26,R30
	__GETB1MN _gElMatrix,3
	ANDI R30,LOW(0xF)
	OR   R30,R26
	CALL SUBOPT_0x21
; 0003 0131 
; 0003 0132    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x17
; 0003 0133 
; 0003 0134    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 0135 
; 0003 0136    return TRUE;
	RJMP _0x20A000B
; 0003 0137 }
; .FEND
;
;BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead )
; 0003 013A {
_IPC1_SND_MOTOR_POS1:
; .FSTART _IPC1_SND_MOTOR_POS1
; 0003 013B    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 013C    pHead->data1  = (BYTE)((gMotorPos1>>8)&0xff);
	LDS  R30,_gMotorPos1
	LDS  R31,_gMotorPos1+1
	CALL __ASRW8
	CALL SUBOPT_0x1F
; 0003 013D    pHead->data2  = (BYTE)(gMotorPos1&0xff);
	LDS  R30,_gMotorPos1
	CALL SUBOPT_0x21
; 0003 013E 
; 0003 013F    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x17
; 0003 0140 
; 0003 0141    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 0142 
; 0003 0143    return TRUE;
	RJMP _0x20A000B
; 0003 0144 
; 0003 0145 }
; .FEND
;
;BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead )
; 0003 0148 {
_IPC1_SND_MOTOR_POS2:
; .FSTART _IPC1_SND_MOTOR_POS2
; 0003 0149    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 014A    pHead->data1  = (BYTE)((gMotorPos2>>8)&0xff);
	LDS  R30,_gMotorPos2
	LDS  R31,_gMotorPos2+1
	CALL __ASRW8
	CALL SUBOPT_0x1F
; 0003 014B    pHead->data2  = (BYTE)(gMotorPos2&0xff);
	LDS  R30,_gMotorPos2
	CALL SUBOPT_0x21
; 0003 014C 
; 0003 014D    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x17
; 0003 014E 
; 0003 014F    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 0150 
; 0003 0151    return TRUE;
	RJMP _0x20A000B
; 0003 0152 
; 0003 0153 }
; .FEND
;
;BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead )
; 0003 0156 {
_IPC1_SND_ERROR:
; .FSTART _IPC1_SND_ERROR
; 0003 0157 
; 0003 0158    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 0159    pHead->data1 = 0;
	LDI  R30,LOW(0)
	ST   X,R30
; 0003 015A    pHead->data2 = gError;;
	LDS  R30,_gError
	CALL SUBOPT_0x21
; 0003 015B 
; 0003 015C    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	CALL SUBOPT_0x17
; 0003 015D 
; 0003 015E    IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData1
; 0003 015F 
; 0003 0160    gReadyActionFlag=TRUE;
	LDI  R30,LOW(1)
	STS  _gReadyActionFlag,R30
; 0003 0161    return TRUE;
	RJMP _0x20A000B
; 0003 0162 
; 0003 0163 }
; .FEND
;
;BYTE MakeCrc( BYTE *Data, int Len )
; 0003 0166 {
_MakeCrc:
; .FSTART _MakeCrc
; 0003 0167      int i;
; 0003 0168      BYTE CRC;
; 0003 0169 
; 0003 016A      CRC = 0;
	CALL SUBOPT_0x1
;	*Data -> Y+6
;	Len -> Y+4
;	i -> R16,R17
;	CRC -> R19
	LDI  R19,LOW(0)
; 0003 016B 
; 0003 016C      for( i=0; i<Len ; i++ )
	__GETWRN 16,17,0
_0x60020:
	LDD  R30,Y+4
	LDD  R31,Y+4+1
	CP   R16,R30
	CPC  R17,R31
	BRGE _0x60021
; 0003 016D           CRC += Data[i];
	MOVW R30,R16
	LDD  R26,Y+6
	LDD  R27,Y+6+1
	ADD  R26,R30
	ADC  R27,R31
	LD   R30,X
	ADD  R19,R30
	__ADDWRN 16,17,1
	RJMP _0x60020
_0x60021:
; 0003 016F return CRC;
	MOV  R30,R19
	CALL __LOADLOCR4
	ADIW R28,8
	RET
; 0003 0170 }
; .FEND
;
;void IPC_RunProcess1( void )
; 0003 0173 {
_IPC_RunProcess1:
; .FSTART _IPC_RunProcess1
; 0003 0174      BYTE RcvHead[30];
; 0003 0175      BYTE RcvByte;
; 0003 0176      BYTE  Crc,RcvCrc;
; 0003 0177      LPIPC_HEADER pHead;
; 0003 0178 
; 0003 0179   //   while( TRUE )
; 0003 017A      {
	CALL SUBOPT_0x22
;	RcvHead -> Y+6
;	RcvByte -> R17
;	Crc -> R16
;	RcvCrc -> R19
;	*pHead -> R20,R21
; 0003 017B         RcvByte = IPC_RcvData_Interrupt1( RcvHead, sizeof( IPC_HEADER ) );
	CALL _IPC_RcvData_Interrupt1
	CALL SUBOPT_0x23
; 0003 017C         pHead = ( LPIPC_HEADER )RcvHead;
; 0003 017D 
; 0003 017E          Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
; 0003 017F          RcvCrc = pHead->checksum;
; 0003 0180 
; 0003 0181          if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
; 0003 0182               pHead->stx == 0x02 && pHead->etx == 0x03 )
	BRNE _0x60023
	CP   R16,R19
	BRNE _0x60023
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0x2)
	BRNE _0x60023
	MOVW R30,R20
	LDD  R26,Z+6
	CPI  R26,LOW(0x3)
	BREQ _0x60024
_0x60023:
	RJMP _0x60022
_0x60024:
; 0003 0183          {
; 0003 0184               if( pHead->RWflag ==  IPC_MODE_READ )
	MOVW R30,R20
	LDD  R26,Z+1
	CPI  R26,LOW(0x52)
	BRNE _0x60025
; 0003 0185                    IPC_SndProcess1( RcvHead );
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_SndProcess1
; 0003 0186               else IPC_RcvProcess1( RcvHead );
	RJMP _0x60026
_0x60025:
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_RcvProcess1
; 0003 0187 
; 0003 0188           }
_0x60026:
; 0003 0189           else
	RJMP _0x60027
_0x60022:
; 0003 018A           {
; 0003 018B              IPC_Send_Response1( RcvHead, SYS_ERROR);
	MOVW R30,R28
	ADIW R30,6
	CALL SUBOPT_0x24
; 0003 018C              IPC_ResetCount1();
	RCALL _IPC_ResetCount1
; 0003 018D           }
_0x60027:
; 0003 018E 
; 0003 018F      }
; 0003 0190 
; 0003 0191 }
	RJMP _0x20A0009
; .FEND
; void IPC_Send_Response1( BYTE *Data, BYTE Res )
; 0003 0193 {
_IPC_Send_Response1:
; .FSTART _IPC_Send_Response1
; 0003 0194      LPIPC_HEADER mLpHead;
; 0003 0195 
; 0003 0196      mLpHead = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x25
;	*Data -> Y+3
;	Res -> Y+2
;	*mLpHead -> R16,R17
; 0003 0197 
; 0003 0198      mLpHead->Command = Res;
; 0003 0199      mLpHead->data1 = 0;
; 0003 019A      mLpHead->data2 = 0;
; 0003 019B      mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );
; 0003 019C 
; 0003 019D      IPC_SendData1( Data, sizeof( IPC_HEADER ) );
	CALL _IPC_SendData1
; 0003 019E }
	RJMP _0x20A0008
; .FEND
;
;void IPC_RcvProcess1( BYTE *Data )
; 0003 01A1 {
_IPC_RcvProcess1:
; .FSTART _IPC_RcvProcess1
; 0003 01A2       LPIPC_HEADER pHead;
; 0003 01A3 
; 0003 01A4       pHead   = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x12
;	*Data -> Y+2
;	*pHead -> R16,R17
	CALL SUBOPT_0x26
; 0003 01A5       if(  pHead->Command < sizeof(IPC1Rcvfun)/2 )
	BRSH _0x60028
; 0003 01A6       {
; 0003 01A7              if( IPC1Rcvfun[pHead->Command]( pHead ) == TRUE )        //  Run Command
	MOVW R30,R16
	LDD  R30,Z+2
	LDI  R26,LOW(_IPC1Rcvfun)
	LDI  R27,HIGH(_IPC1Rcvfun)
	CALL SUBOPT_0x27
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,LOW(0x1)
	BRNE _0x60029
; 0003 01A8              {
; 0003 01A9                  IPC_Send_Response1( Data, SYS_OK );
	CALL SUBOPT_0x28
	LDI  R26,LOW(128)
	RJMP _0x6004E
; 0003 01AA              }
; 0003 01AB              else
_0x60029:
; 0003 01AC              {
; 0003 01AD                  IPC_Send_Response1( Data, SYS_ERROR);
	CALL SUBOPT_0x28
	LDI  R26,LOW(129)
_0x6004E:
	RCALL _IPC_Send_Response1
; 0003 01AE               }
; 0003 01AF        }
; 0003 01B0        else
	RJMP _0x6002B
_0x60028:
; 0003 01B1        {
; 0003 01B2            IPC_Send_Response1( Data, SYS_ERROR );
	CALL SUBOPT_0x29
; 0003 01B3         }
_0x6002B:
; 0003 01B4 
; 0003 01B5 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
; .FEND
;
;
;void IPC_SndProcess1( BYTE *Data )
; 0003 01B9 {
_IPC_SndProcess1:
; .FSTART _IPC_SndProcess1
; 0003 01BA       LPIPC_HEADER pHead;
; 0003 01BB 
; 0003 01BC       pHead = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x12
;	*Data -> Y+2
;	*pHead -> R16,R17
	CALL SUBOPT_0x26
; 0003 01BD       if(   pHead->Command < sizeof(IPC1Sndfun)/2  )
	BRSH _0x6002C
; 0003 01BE       {
; 0003 01BF           if( IPC1Sndfun[pHead->Command]( pHead ) == FALSE )        //  Run Command
	MOVW R30,R16
	LDD  R30,Z+2
	LDI  R26,LOW(_IPC1Sndfun)
	LDI  R27,HIGH(_IPC1Sndfun)
	CALL SUBOPT_0x27
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,0
	BRNE _0x6002D
; 0003 01C0               IPC_Send_Response1( Data, SYS_ERROR );
	CALL SUBOPT_0x29
; 0003 01C1       }
_0x6002D:
; 0003 01C2       else
	RJMP _0x6002E
_0x6002C:
; 0003 01C3       {
; 0003 01C4            IPC_Send_Response1( Data, SYS_ERROR );
	CALL SUBOPT_0x29
; 0003 01C5       }
_0x6002E:
; 0003 01C6 }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
; .FEND
;
;
;BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
;BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead );
;//typedef BYTE(*RunFun) (LPIPC_HEADER pHead );
;
;RunFun IPC0Rcvfun[]=
;{
;     IPC0_RCV_MODE,
;     IPC0_RCV_RUN,
;     IPC0_RCV_DOSE,
;     IPC0_RCV_VOLTAGE,
;     IPC0_RCV_DEPTH,
;     IPC0_RCV_SPEED,
;     IPC0_RCV_ELCOUNT,
;     IPC0_RCV_FLAG,
;     IPC0_RCV_EL_MAP,
;     IPC0_RCV_MOTOR_POS1,
;     IPC0_RCV_MOTOR_POS2,
;     IPC0_RCV_ERROR
;};

	.DSEG
;
;BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead )
; 0003 01E8 {

	.CSEG
_IPC0_RCV_MODE:
; .FSTART _IPC0_RCV_MODE
; 0003 01E9    gMode = pHead->data2;
	CALL SUBOPT_0x5
;	*pHead -> Y+0
	LDD  R30,Z+4
	STS  _gMode,R30
; 0003 01EA 
; 0003 01EB    if( gMode == MODE_READY ) //ready
	LDS  R26,_gMode
	CPI  R26,LOW(0x1)
	BRNE _0x60030
; 0003 01EC    {
; 0003 01ED       //gElCount = 0;
; 0003 01EE       PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0003 01EF       HIGH_PWM;
	LDS  R30,101
	ORI  R30,8
	STS  101,R30
; 0003 01F0       DAC7611_WriteVoltage(gVoltage);
	CALL SUBOPT_0xA
	CALL SUBOPT_0x2A
; 0003 01F1       HIGH_OUTRY;
	ORI  R30,0x10
	STS  101,R30
; 0003 01F2 
; 0003 01F3       gError = ERROR_NO;
	LDI  R30,LOW(0)
	STS  _gError,R30
; 0003 01F4       gFlag = FLAG_VOLADJ;
	LDI  R30,LOW(1)
	STS  _gFlag,R30
; 0003 01F5 
; 0003 01F6       gVolChkCount = 2;
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	STS  _gVolChkCount,R30
	STS  _gVolChkCount+1,R31
; 0003 01F7 
; 0003 01F8       //LOW_COMPLETE_LED;
; 0003 01F9       //LOW_WARRING_LED;
; 0003 01FA    }
; 0003 01FB    else //if( gMode == MODE_STOP )
	RJMP _0x60031
_0x60030:
; 0003 01FC    {
; 0003 01FD        PORTC = 0x00;
	CALL SUBOPT_0x2B
; 0003 01FE        DAC7611_WriteVoltage(0);
; 0003 01FF        LOW_PWM;
	CALL SUBOPT_0x2C
; 0003 0200        LOW_OUTRY;
; 0003 0201       // gError = ERROR_NO;
; 0003 0202        gFlag = FLAG_STADNBY;
; 0003 0203 
; 0003 0204       // LOW_COMPLETE_LED;
; 0003 0205       //LOW_WARRING_LED;
; 0003 0206    }
_0x60031:
; 0003 0207 
; 0003 0208    gRunFlag = FALSE;
	LDI  R30,LOW(0)
	STS  _gRunFlag,R30
; 0003 0209    gElCompletFlag = FALSE;
	STS  _gElCompletFlag,R30
; 0003 020A    return TRUE;
	RJMP _0x20A000B
; 0003 020B }
; .FEND
;
;BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead )
; 0003 020E {
_IPC0_RCV_RUN:
; .FSTART _IPC0_RCV_RUN
; 0003 020F    if( gFlag == FLAG_SHOOTING ) //ready
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	LDS  R26,_gFlag
	CPI  R26,LOW(0x3)
	BRNE _0x60032
; 0003 0210    {
; 0003 0211       // HIGH_SH;
; 0003 0212        gRunFlag = pHead->data2?TRUE:FALSE;
	LD   R30,Y
	LDD  R31,Y+1
	LDD  R30,Z+4
	CPI  R30,0
	BREQ _0x60033
	LDI  R30,LOW(1)
	RJMP _0x60034
_0x60033:
	LDI  R30,LOW(0)
_0x60034:
	STS  _gRunFlag,R30
; 0003 0213 
; 0003 0214        gElCompletFlag = FALSE;
	LDI  R30,LOW(0)
	STS  _gElCompletFlag,R30
; 0003 0215        LOW_SH;
	CBI  0x18,6
; 0003 0216    }
; 0003 0217    else
	RJMP _0x60038
_0x60032:
; 0003 0218    {
; 0003 0219        PORTC = 0x00;
	CALL SUBOPT_0x2B
; 0003 021A        DAC7611_WriteVoltage(0);
; 0003 021B        LOW_PWM;
	CALL SUBOPT_0x2C
; 0003 021C        LOW_OUTRY;
; 0003 021D       // gError = ERROR_NO;
; 0003 021E        gFlag = FLAG_STADNBY;
; 0003 021F    }
_0x60038:
; 0003 0220    return TRUE;
	RJMP _0x20A000B
; 0003 0221 }
; .FEND
;
;BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead )
; 0003 0224 {
_IPC0_RCV_DOSE:
; .FSTART _IPC0_RCV_DOSE
; 0003 0225 
; 0003 0226    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0227 }
; .FEND
;
;BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead )
; 0003 022A {
_IPC0_RCV_VOLTAGE:
; .FSTART _IPC0_RCV_VOLTAGE
; 0003 022B    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 022C }
; .FEND
;
;BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead )
; 0003 022F {
_IPC0_RCV_DEPTH:
; .FSTART _IPC0_RCV_DEPTH
; 0003 0230    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0231 }
; .FEND
;BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead )
; 0003 0233 {
_IPC0_RCV_SPEED:
; .FSTART _IPC0_RCV_SPEED
; 0003 0234    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0235 }
; .FEND
;BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead )
; 0003 0237 {
_IPC0_RCV_ELCOUNT:
; .FSTART _IPC0_RCV_ELCOUNT
; 0003 0238    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0239 }
; .FEND
;
; BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead )
; 0003 023C {
_IPC0_RCV_FLAG:
; .FSTART _IPC0_RCV_FLAG
; 0003 023D    BYTE mFlag;
; 0003 023E    mFlag = pHead->data2;
	CALL SUBOPT_0x4
;	*pHead -> Y+1
;	mFlag -> R17
	LDD  R17,Z+4
; 0003 023F 
; 0003 0240    if( mFlag > FLAG_EM_STOP)
	CPI  R17,6
	BRLO _0x60039
; 0003 0241        gFlag = FLAG_EM_STOP;
	LDI  R30,LOW(5)
	STS  _gFlag,R30
; 0003 0242    else gFlag = mFlag;
	RJMP _0x6003A
_0x60039:
	STS  _gFlag,R17
; 0003 0243 
; 0003 0244    return TRUE;
_0x6003A:
	RJMP _0x20A000D
; 0003 0245 }
; .FEND
;BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead )
; 0003 0247 {
_IPC0_RCV_EL_MAP:
; .FSTART _IPC0_RCV_EL_MAP
; 0003 0248    return TRUE;
	ST   -Y,R27
	ST   -Y,R26
;	*pHead -> Y+0
	RJMP _0x20A000B
; 0003 0249 }
; .FEND
;
;BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
; 0003 024C {
_IPC0_RCV_MOTOR_POS1:
; .FSTART _IPC0_RCV_MOTOR_POS1
; 0003 024D    WORD temp;
; 0003 024E    temp = ((WORD)pHead->data1)<<8|pHead->data2;
	CALL SUBOPT_0x12
;	*pHead -> Y+2
;	temp -> R16,R17
	CALL SUBOPT_0x2D
; 0003 024F    gMotorPos1 = temp;
	__PUTWMRN _gMotorPos1,0,16,17
; 0003 0250 
; 0003 0251    return TRUE;
	LDI  R30,LOW(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
; 0003 0252 }
; .FEND
;
;BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
; 0003 0255 {
_IPC0_RCV_MOTOR_POS2:
; .FSTART _IPC0_RCV_MOTOR_POS2
; 0003 0256    WORD temp;
; 0003 0257    temp = ((WORD)pHead->data1)<<8|pHead->data2;
	CALL SUBOPT_0x12
;	*pHead -> Y+2
;	temp -> R16,R17
	CALL SUBOPT_0x2D
; 0003 0258    gMotorPos2 = temp;
	__PUTWMRN _gMotorPos2,0,16,17
; 0003 0259 
; 0003 025A    return TRUE;
	LDI  R30,LOW(1)
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
; 0003 025B }
; .FEND
;
;BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead )
; 0003 025E {
_IPC0_RCV_ERROR:
; .FSTART _IPC0_RCV_ERROR
; 0003 025F    BYTE mErrPos = pHead->data1;
; 0003 0260 
; 0003 0261    if( mErrPos> ERROR_EM_STOP )
	CALL SUBOPT_0x4
;	*pHead -> Y+1
;	mErrPos -> R17
	LDD  R30,Z+3
	MOV  R17,R30
	CPI  R17,8
	BRLO _0x6003B
; 0003 0262        mErrPos = ERROR_EM_STOP;
	LDI  R17,LOW(7)
; 0003 0263 
; 0003 0264    if( mErrPos == ERROR_EM_STOP )  //2021-01-12
_0x6003B:
	CPI  R17,7
	BRNE _0x6003C
; 0003 0265       gFlag = FLAG_EM_STOP;
	LDI  R30,LOW(5)
	STS  _gFlag,R30
; 0003 0266 
; 0003 0267    gError |= (1<<mErrPos);
_0x6003C:
	CALL SUBOPT_0x13
	LDS  R26,_gError
	OR   R30,R26
	CALL SUBOPT_0x2E
; 0003 0268 
; 0003 0269    gCurMode = CUR_ERROR;
; 0003 026A 
; 0003 026B    return TRUE;
_0x20A000D:
	LDI  R30,LOW(1)
	LDD  R17,Y+0
_0x20A000E:
	ADIW R28,3
	RET
; 0003 026C }
; .FEND
;BYTE IPC0_SND_MODE( LPIPC_HEADER pHead );
;BYTE IPC0_SND_RUN( LPIPC_HEADER pHead );
;BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead );
;BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead );
;BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead );
;BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead );
;BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead );
;BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead );
;BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead );
;BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead );
;BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead );
;BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead );
;//typedef BYTE(*SenFun) (LPIPC_HEADER pHead);
;
;SenFun IPC0Sndfun[]=
;{
;     IPC0_SND_MODE,
;     IPC0_SND_RUN,
;     IPC0_SND_DOSE,
;     IPC0_SND_VOLTAGE,
;     IPC0_SND_DEPTH,
;     IPC0_SND_SPEED,
;     IPC0_SND_ELCOUNT,
;     IPC0_SND_FLAG,
;     IPC0_SND_EL_MAP,
;     IPC0_SND_MOTOR_POS1,
;     IPC0_SND_MOTOR_POS2,
;     IPC0_SND_ERROR
;};

	.DSEG
;
;BYTE IPC0_SND_MODE( LPIPC_HEADER pHead )
; 0003 028C {

	.CSEG
_IPC0_SND_MODE:
; .FSTART _IPC0_SND_MODE
; 0003 028D    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 028E    pHead->data1 = 1;//(BYTE)((gMode>>8)&0xff);  //
	LDI  R30,LOW(1)
	CALL SUBOPT_0x15
; 0003 028F    pHead->data2 =  (BYTE)(gMode&0xff);
; 0003 0290 
; 0003 0291    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 0292 
; 0003 0293    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 0294    return TRUE;
; 0003 0295 }
; .FEND
;
;BYTE IPC0_SND_RUN( LPIPC_HEADER pHead )
; 0003 0298 {
_IPC0_SND_RUN:
; .FSTART _IPC0_SND_RUN
; 0003 0299    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 029A    pHead->data1 = 1;//(BYTE)((gRunFlag>>8)&0xff);  //
	CALL SUBOPT_0x18
; 0003 029B    pHead->data2 = (BYTE)(gRunFlag&0xff);
; 0003 029C 
; 0003 029D    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 029E 
; 0003 029F    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02A0    return TRUE;
; 0003 02A1 }
; .FEND
;
;BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead )
; 0003 02A4 {
_IPC0_SND_DOSE:
; .FSTART _IPC0_SND_DOSE
; 0003 02A5    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02A6    pHead->data1 = (BYTE)((gDose>>8)&0xff);
	CALL SUBOPT_0x1A
; 0003 02A7    pHead->data2 = (BYTE)(gDose&0xff);
; 0003 02A8 
; 0003 02A9    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02AA 
; 0003 02AB    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02AC    return TRUE;
; 0003 02AD }
; .FEND
;BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead )
; 0003 02AF {
_IPC0_SND_VOLTAGE:
; .FSTART _IPC0_SND_VOLTAGE
; 0003 02B0    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02B1    pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  //
	CALL SUBOPT_0x1B
; 0003 02B2    pHead->data2 = (BYTE)(gVoltage&0xff);
; 0003 02B3 
; 0003 02B4    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02B5 
; 0003 02B6    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02B7 
; 0003 02B8    return TRUE;
; 0003 02B9 }
; .FEND
;
;BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead )
; 0003 02BC {
_IPC0_SND_DEPTH:
; .FSTART _IPC0_SND_DEPTH
; 0003 02BD    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02BE    pHead->data1 = (BYTE)((gDepth>>8)&0xff);  //
	CALL SUBOPT_0x1C
; 0003 02BF    pHead->data2 = (BYTE)(gDepth&0xff);
; 0003 02C0 
; 0003 02C1    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02C2 
; 0003 02C3    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02C4 
; 0003 02C5    return TRUE;
; 0003 02C6 
; 0003 02C7 }
; .FEND
;
;BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead )
; 0003 02CA {
_IPC0_SND_ELCOUNT:
; .FSTART _IPC0_SND_ELCOUNT
; 0003 02CB    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02CC    pHead->data1 = (BYTE)((gElCount>>8)&0xff);  //
	CALL SUBOPT_0x1E
; 0003 02CD    pHead->data2 = (BYTE)(gElCount&0xff);
; 0003 02CE 
; 0003 02CF    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02D0 
; 0003 02D1    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02D2    return TRUE;
; 0003 02D3 
; 0003 02D4 }
; .FEND
;BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead )
; 0003 02D6 {
_IPC0_SND_SPEED:
; .FSTART _IPC0_SND_SPEED
; 0003 02D7    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02D8    pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  //
	CALL SUBOPT_0x1D
; 0003 02D9    pHead->data2 = (BYTE)(gSpeed&0xff);
; 0003 02DA 
; 0003 02DB    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02DC 
; 0003 02DD    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02DE    return TRUE;
; 0003 02DF 
; 0003 02E0 }
; .FEND
;
;BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead )
; 0003 02E3 {
_IPC0_SND_FLAG:
; .FSTART _IPC0_SND_FLAG
; 0003 02E4 
; 0003 02E5    pHead->Command = SYS_OK;
	CALL SUBOPT_0x19
;	*pHead -> Y+0
; 0003 02E6    pHead->data1 = (BYTE)((gFlag>>8)&0xff);  //
	LDS  R26,_gFlag
	LDI  R30,LOW(8)
	CALL __LSRB12
	CALL SUBOPT_0x1F
; 0003 02E7    pHead->data2 = (BYTE)(gFlag&0xff);
	CALL SUBOPT_0x20
; 0003 02E8 
; 0003 02E9    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02EA 
; 0003 02EB    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02EC 
; 0003 02ED    return TRUE;
; 0003 02EE 
; 0003 02EF }
; .FEND
;BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead )
; 0003 02F1 {
_IPC0_SND_EL_MAP:
; .FSTART _IPC0_SND_EL_MAP
; 0003 02F2 
; 0003 02F3    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 02F4    pHead->data1 = 0;  //
	CALL SUBOPT_0x2F
; 0003 02F5    pHead->data2 = 0;
; 0003 02F6 
; 0003 02F7    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 02F8 
; 0003 02F9    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 02FA 
; 0003 02FB    return TRUE;
; 0003 02FC 
; 0003 02FD }
; .FEND
;BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead )
; 0003 02FF {
_IPC0_SND_MOTOR_POS1:
; .FSTART _IPC0_SND_MOTOR_POS1
; 0003 0300 
; 0003 0301    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 0302    pHead->data1 = 0;  //
	CALL SUBOPT_0x2F
; 0003 0303    pHead->data2 = 0;
; 0003 0304 
; 0003 0305    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 0306 
; 0003 0307    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 0308 
; 0003 0309    return TRUE;
; 0003 030A }
; .FEND
;
;BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead )
; 0003 030D {
_IPC0_SND_MOTOR_POS2:
; .FSTART _IPC0_SND_MOTOR_POS2
; 0003 030E    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 030F    pHead->data1 = 0;  //
	CALL SUBOPT_0x2F
; 0003 0310    pHead->data2 = 0;
; 0003 0311 
; 0003 0312    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
	RJMP _0x20A000A
; 0003 0313 
; 0003 0314    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
; 0003 0315 
; 0003 0316    return TRUE;
; 0003 0317 }
; .FEND
;
;BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead )
; 0003 031A {
_IPC0_SND_ERROR:
; .FSTART _IPC0_SND_ERROR
; 0003 031B    pHead->Command = SYS_OK;
	CALL SUBOPT_0x14
;	*pHead -> Y+0
; 0003 031C    pHead->data1 = 0;  //
	LDI  R30,LOW(0)
	ST   X,R30
; 0003 031D    if( gReadyActionFlag ==FALSE )
	LDS  R30,_gReadyActionFlag
	CPI  R30,0
	BRNE _0x6003E
; 0003 031E         pHead->data2 = ERROR_NOTLCD;
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,4
	LDI  R30,LOW(6)
	ST   X,R30
; 0003 031F    else
	RJMP _0x6003F
_0x6003E:
; 0003 0320        pHead->data2 = gError;
	LDS  R30,_gError
	__PUTB1SNS 0,4
; 0003 0321 
; 0003 0322    pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );
_0x6003F:
_0x20A000A:
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	CALL SUBOPT_0x17
; 0003 0323 
; 0003 0324    IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
	LDI  R26,LOW(7)
	CALL _IPC_SendData0
; 0003 0325 
; 0003 0326    return TRUE;
_0x20A000B:
	LDI  R30,LOW(1)
_0x20A000C:
	ADIW R28,2
	RET
; 0003 0327 
; 0003 0328 }
; .FEND
;void IPC_RunProcess0( void )
; 0003 032A {
_IPC_RunProcess0:
; .FSTART _IPC_RunProcess0
; 0003 032B      BYTE RcvHead[30];
; 0003 032C      BYTE RcvByte;
; 0003 032D      BYTE  Crc,RcvCrc;
; 0003 032E      LPIPC_HEADER pHead;
; 0003 032F 
; 0003 0330   //   while( TRUE )
; 0003 0331      {
	CALL SUBOPT_0x22
;	RcvHead -> Y+6
;	RcvByte -> R17
;	Crc -> R16
;	RcvCrc -> R19
;	*pHead -> R20,R21
; 0003 0332         RcvByte = IPC_RcvData_Interrupt0( RcvHead, sizeof( IPC_HEADER ) );
	CALL _IPC_RcvData_Interrupt0
	CALL SUBOPT_0x23
; 0003 0333         pHead = ( LPIPC_HEADER )RcvHead;
; 0003 0334 
; 0003 0335          Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
; 0003 0336          RcvCrc = pHead->checksum;
; 0003 0337 
; 0003 0338          if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
; 0003 0339               pHead->stx == 0x02 && pHead->etx == 0x03 )
	BRNE _0x60041
	CP   R16,R19
	BRNE _0x60041
	MOVW R26,R20
	LD   R26,X
	CPI  R26,LOW(0x2)
	BRNE _0x60041
	MOVW R30,R20
	LDD  R26,Z+6
	CPI  R26,LOW(0x3)
	BREQ _0x60042
_0x60041:
	RJMP _0x60040
_0x60042:
; 0003 033A          {
; 0003 033B               if( pHead->RWflag ==  IPC_MODE_READ )
	MOVW R30,R20
	LDD  R26,Z+1
	CPI  R26,LOW(0x52)
	BRNE _0x60043
; 0003 033C                    IPC_SndProcess0( RcvHead );
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_SndProcess0
; 0003 033D               else IPC_RcvProcess0( RcvHead );
	RJMP _0x60044
_0x60043:
	MOVW R26,R28
	ADIW R26,6
	RCALL _IPC_RcvProcess0
; 0003 033E 
; 0003 033F           }
_0x60044:
; 0003 0340           else
	RJMP _0x60045
_0x60040:
; 0003 0341           {
; 0003 0342              IPC_Send_Response0( RcvHead, SYS_ERROR);
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(129)
	RCALL _IPC_Send_Response0
; 0003 0343              IPC_ResetCount0();
	RCALL _IPC_ResetCount0
; 0003 0344           }
_0x60045:
; 0003 0345 
; 0003 0346      }
; 0003 0347 
; 0003 0348 }
_0x20A0009:
	CALL __LOADLOCR6
	ADIW R28,36
	RET
; .FEND
; void IPC_Send_Response0( BYTE *Data, BYTE Res )
; 0003 034A {
_IPC_Send_Response0:
; .FSTART _IPC_Send_Response0
; 0003 034B      LPIPC_HEADER mLpHead;
; 0003 034C 
; 0003 034D      mLpHead = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x25
;	*Data -> Y+3
;	Res -> Y+2
;	*mLpHead -> R16,R17
; 0003 034E 
; 0003 034F      mLpHead->Command = Res;
; 0003 0350      mLpHead->data1 = 0;
; 0003 0351      mLpHead->data2 = 0;
; 0003 0352      mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );
; 0003 0353 
; 0003 0354      IPC_SendData0( Data, sizeof( IPC_HEADER ) );
	CALL _IPC_SendData0
; 0003 0355 }
_0x20A0008:
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,5
	RET
; .FEND
;
;void IPC_RcvProcess0( BYTE *Data )
; 0003 0358 {
_IPC_RcvProcess0:
; .FSTART _IPC_RcvProcess0
; 0003 0359       LPIPC_HEADER pHead;
; 0003 035A 
; 0003 035B       pHead   = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x12
;	*Data -> Y+2
;	*pHead -> R16,R17
	CALL SUBOPT_0x26
; 0003 035C       if(  pHead->Command < sizeof(IPC0Rcvfun)/2 )
	BRSH _0x60046
; 0003 035D       {
; 0003 035E              if( IPC0Rcvfun[pHead->Command]( pHead ) == TRUE )        //  Run Command
	MOVW R30,R16
	LDD  R30,Z+2
	LDI  R26,LOW(_IPC0Rcvfun)
	LDI  R27,HIGH(_IPC0Rcvfun)
	CALL SUBOPT_0x27
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,LOW(0x1)
	BRNE _0x60047
; 0003 035F              {
; 0003 0360                  IPC_Send_Response0( Data, SYS_OK );
	CALL SUBOPT_0x28
	LDI  R26,LOW(128)
	RJMP _0x6004F
; 0003 0361              }
; 0003 0362              else
_0x60047:
; 0003 0363              {
; 0003 0364                  IPC_Send_Response0( Data, SYS_ERROR);
	CALL SUBOPT_0x28
	LDI  R26,LOW(129)
_0x6004F:
	RCALL _IPC_Send_Response0
; 0003 0365               }
; 0003 0366        }
; 0003 0367        else
	RJMP _0x60049
_0x60046:
; 0003 0368        {
; 0003 0369            IPC_Send_Response0( Data, SYS_ERROR );
	CALL SUBOPT_0x28
	LDI  R26,LOW(129)
	RCALL _IPC_Send_Response0
; 0003 036A         }
_0x60049:
; 0003 036B 
; 0003 036C }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
; .FEND
;
;
;void IPC_SndProcess0( BYTE *Data )
; 0003 0370 {
_IPC_SndProcess0:
; .FSTART _IPC_SndProcess0
; 0003 0371       LPIPC_HEADER pHead;
; 0003 0372 
; 0003 0373       pHead = (LPIPC_HEADER)Data;
	CALL SUBOPT_0x12
;	*Data -> Y+2
;	*pHead -> R16,R17
	CALL SUBOPT_0x26
; 0003 0374       if( pHead->Command < sizeof(IPC0Sndfun)/2  )
	BRSH _0x6004A
; 0003 0375       {
; 0003 0376           if( IPC0Sndfun[pHead->Command]( pHead ) == FALSE )        //  Run Command
	MOVW R30,R16
	LDD  R30,Z+2
	LDI  R26,LOW(_IPC0Sndfun)
	LDI  R27,HIGH(_IPC0Sndfun)
	CALL SUBOPT_0x27
	PUSH R31
	PUSH R30
	MOVW R26,R16
	POP  R30
	POP  R31
	ICALL
	CPI  R30,0
	BRNE _0x6004B
; 0003 0377               IPC_Send_Response0( Data, SYS_ERROR );
	CALL SUBOPT_0x28
	LDI  R26,LOW(129)
	RCALL _IPC_Send_Response0
; 0003 0378       }
_0x6004B:
; 0003 0379       else
	RJMP _0x6004C
_0x6004A:
; 0003 037A       {
; 0003 037B            IPC_Send_Response0( Data, SYS_ERROR );
	CALL SUBOPT_0x28
	LDI  R26,LOW(129)
	RCALL _IPC_Send_Response0
; 0003 037C       }
_0x6004C:
; 0003 037D }
	LDD  R17,Y+1
	LDD  R16,Y+0
	JMP  _0x20A0003
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
;#define RX_BUFFER_SIZE0 250
;char rx_buffer0[RX_BUFFER_SIZE0];
;unsigned char rx_wr_index0=0,rx_rd_index0=0,rx_counter0=0;
;BOOL rx_buffer_overflow0=FALSE;
;char mRcvErrFlag0 = 0;
;
;#define RX_BUFFER_SIZE1 250
;char rx_buffer1[RX_BUFFER_SIZE1];
;unsigned char rx_wr_index1=0,rx_rd_index1=0,rx_counter1=0;
;BOOL rx_buffer_overflow1=FALSE;
;char mRcvErrFlag1 = 0;
;
;// USART1 Receiver interrupt service routine
;interrupt [USART1_RXC] void usart1_rx_isr(void)
; 0004 0023 {

	.CSEG
_usart1_rx_isr:
; .FSTART _usart1_rx_isr
	CALL SUBOPT_0x30
; 0004 0024    char status,data;
; 0004 0025    status = UCSR1A;
;	status -> R17
;	data -> R16
	LDS  R17,155
; 0004 0026    data   = UDR1;
	LDS  R16,156
; 0004 0027 
; 0004 0028    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0 )
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x80003
; 0004 0029    {
; 0004 002A       rx_buffer1[rx_wr_index1++]=data;
	MOV  R30,R8
	INC  R8
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer1)
	SBCI R31,HIGH(-_rx_buffer1)
	ST   Z,R16
; 0004 002B       if (rx_wr_index1 == RX_BUFFER_SIZE1) rx_wr_index1=0;
	LDI  R30,LOW(250)
	CP   R30,R8
	BRNE _0x80004
	CLR  R8
; 0004 002C       if (++rx_counter1 == RX_BUFFER_SIZE1)
_0x80004:
	INC  R10
	LDI  R30,LOW(250)
	CP   R30,R10
	BRNE _0x80005
; 0004 002D       {
; 0004 002E          rx_counter1 = 0;
	CLR  R10
; 0004 002F          rx_buffer_overflow1 = TRUE;
	LDI  R30,LOW(1)
	MOV  R13,R30
; 0004 0030       }
; 0004 0031       //gOldUartTime1ms = gTime1ms;
; 0004 0032    }
_0x80005:
; 0004 0033 }
_0x80003:
	RJMP _0x80059
; .FEND
;
;// Get a character from the USART1 Receiver buffer
;//#pragma used+
;char getchar1( void )
; 0004 0038 {
_getchar1:
; .FSTART _getchar1
; 0004 0039    char data;
; 0004 003A    //while (rx_counter1==0);
; 0004 003B     if( rx_counter1 >0 )
	ST   -Y,R17
;	data -> R17
	LDI  R30,LOW(0)
	CP   R30,R10
	BRSH _0x80006
; 0004 003C     {
; 0004 003D       data = rx_buffer1[rx_rd_index1++];
	MOV  R30,R11
	INC  R11
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer1)
	SBCI R31,HIGH(-_rx_buffer1)
	LD   R17,Z
; 0004 003E       if (rx_rd_index1 == RX_BUFFER_SIZE1) rx_rd_index1=0;
	LDI  R30,LOW(250)
	CP   R30,R11
	BRNE _0x80007
	CLR  R11
; 0004 003F 
; 0004 0040        #asm("cli")
_0x80007:
	cli
; 0004 0041        --rx_counter1;
	DEC  R10
; 0004 0042        #asm("sei")
	sei
; 0004 0043        mRcvErrFlag1 = 0;
	CLR  R12
; 0004 0044        return data;
	MOV  R30,R17
	RJMP _0x20A0007
; 0004 0045     }
; 0004 0046     else
_0x80006:
; 0004 0047     {
; 0004 0048        mRcvErrFlag1 = 1;
	LDI  R30,LOW(1)
	MOV  R12,R30
; 0004 0049        return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0007
; 0004 004A     }
; 0004 004B }
; .FEND
;
;//#pragma used-
;BYTE  IPC_Get_RxCount1( void )
; 0004 004F {
_IPC_Get_RxCount1:
; .FSTART _IPC_Get_RxCount1
; 0004 0050    return rx_counter1;
	MOV  R30,R10
	RET
; 0004 0051 }
; .FEND
;
;void IPC_ResetCount1( void )
; 0004 0054 {
_IPC_ResetCount1:
; .FSTART _IPC_ResetCount1
; 0004 0055    #asm("cli")
	cli
; 0004 0056    rx_counter1 = 0;
	CLR  R10
; 0004 0057    rx_rd_index1 = 0;
	CLR  R11
; 0004 0058    rx_wr_index1 = 0;
	CLR  R8
; 0004 0059    #asm("sei")
	sei
; 0004 005A }
	RET
; .FEND
;
;char Mygetchar1( BYTE flag )
; 0004 005D {
; 0004 005E       WORD oldTime1ms;
; 0004 005F       char status,data;
; 0004 0060 
; 0004 0061       while ( 1 )
;	flag -> Y+4
;	oldTime1ms -> R16,R17
;	status -> R19
;	data -> R18
; 0004 0062       {
; 0004 0063           if( flag )
; 0004 0064                oldTime1ms = gTime1ms;
; 0004 0065 
; 0004 0066           while ( ((status=UCSR1A) & RX_COMPLETE) == 0 )
; 0004 0067           {
; 0004 0068               if( flag )
; 0004 0069               {
; 0004 006A                  if( (gTime1ms - oldTime1ms) > 300 ) //old 300
; 0004 006B                  {
; 0004 006C                       return 0;
; 0004 006D                  }
; 0004 006E               }
; 0004 006F           };
; 0004 0070 
; 0004 0071           data = UDR1;
; 0004 0072           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0004 0073           return data;
; 0004 0074       };
; 0004 0075 }
;
;char Tgetchar1( void )
; 0004 0078 {
; 0004 0079       char status,data;
; 0004 007A       while ( 1 )
;	status -> R17
;	data -> R16
; 0004 007B       {
; 0004 007C           while ( ((status=UCSR1A) & RX_COMPLETE)==0 );
; 0004 007D               data = UDR1;
; 0004 007E           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0004 007F          return data;
; 0004 0080       };
; 0004 0081 }
;
;void Tputchar1( char c )
; 0004 0084 {
_Tputchar1:
; .FSTART _Tputchar1
; 0004 0085      while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R26
;	c -> Y+0
_0x8001A:
	LDS  R30,155
	ANDI R30,LOW(0x20)
	BREQ _0x8001A
; 0004 0086      UDR1 = c;
	LD   R30,Y
	STS  156,R30
; 0004 0087 }
	RJMP _0x20A0006
; .FEND
;
;void Usrprintf1( char  *string )
; 0004 008A {
; 0004 008B     while( *string != '\0' )
;	*string -> Y+0
; 0004 008C     {
; 0004 008D         Tputchar1(*string++);
; 0004 008E     }
; 0004 008F }
;
;void FlashUsrprintf1( const char *string )
; 0004 0092 {
; 0004 0093     while( *string != '\0' )
;	*string -> Y+0
; 0004 0094     {
; 0004 0095         Tputchar1(*string++);
; 0004 0096     }
; 0004 0097 }
;
;void MyPrint1( char flash* format, ...)
; 0004 009A {
; 0004 009B       char str[100];
; 0004 009C 
; 0004 009D       va_list arg;
; 0004 009E       va_start(arg, format);
;	*format -> Y+102
;	str -> Y+2
;	*arg -> R16,R17
; 0004 009F 
; 0004 00A0       vsprintf( str, format, arg);
; 0004 00A1       va_end(arg);
; 0004 00A2 
; 0004 00A3       Usrprintf1( str ); // putchar1()를 스트링으로 전송하는 함수입니다.-아래 기술할께요~
; 0004 00A4 }
;
;BYTE  IPC_RcvData1( BYTE *Buffer, BYTE len )
; 0004 00A7 {
; 0004 00A8    BYTE i=0;
; 0004 00A9 
; 0004 00AA    while( i < len )
;	*Buffer -> Y+2
;	len -> Y+1
;	i -> R17
; 0004 00AB    {
; 0004 00AC         Buffer[i] = Mygetchar1(i);
; 0004 00AD         i++;
; 0004 00AE    }
; 0004 00AF    return  i;
; 0004 00B0 }
;
;
;BYTE  IPC_RcvData_Interrupt1( BYTE *Buffer, BYTE len )
; 0004 00B4 {
_IPC_RcvData_Interrupt1:
; .FSTART _IPC_RcvData_Interrupt1
; 0004 00B5    BYTE i=0;
; 0004 00B6    char dat = 0;
; 0004 00B7    WORD oldTime1ms;
; 0004 00B8    oldTime1ms = gTime1ms;
	CALL SUBOPT_0x31
;	*Buffer -> Y+5
;	len -> Y+4
;	i -> R17
;	dat -> R16
;	oldTime1ms -> R18,R19
; 0004 00B9 
; 0004 00BA    while( i < len )
_0x80026:
	LDD  R30,Y+4
	CP   R17,R30
	BRSH _0x80028
; 0004 00BB    {
; 0004 00BC        dat = getchar1();
	RCALL _getchar1
	MOV  R16,R30
; 0004 00BD        if( mRcvErrFlag1 == 0  )
	TST  R12
	BRNE _0x80029
; 0004 00BE        {
; 0004 00BF           Buffer[i] = dat;
	CALL SUBOPT_0x32
; 0004 00C0           i++;
; 0004 00C1        }
; 0004 00C2        if( (gTime1ms - oldTime1ms) > 3000 ) //old 300
_0x80029:
	CALL SUBOPT_0x33
	BRLO _0x8002A
; 0004 00C3        {
; 0004 00C4           IPC_ResetCount1();
	RCALL _IPC_ResetCount1
; 0004 00C5           return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0004 00C6        }
; 0004 00C7    }
_0x8002A:
	RJMP _0x80026
_0x80028:
; 0004 00C8    return  i;
	RJMP _0x20A0005
; 0004 00C9 }
; .FEND
;
;BYTE IPC_SendData1( BYTE *Buffer, BYTE len )
; 0004 00CC {
_IPC_SendData1:
; .FSTART _IPC_SendData1
; 0004 00CD    BYTE i;
; 0004 00CE    i= 0;
	ST   -Y,R26
	ST   -Y,R17
;	*Buffer -> Y+2
;	len -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
; 0004 00CF    while( i < len )
_0x8002B:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x8002D
; 0004 00D0    {
; 0004 00D1      Tputchar1(Buffer[i++]);
	CALL SUBOPT_0x34
	RCALL _Tputchar1
; 0004 00D2    }
	RJMP _0x8002B
_0x8002D:
; 0004 00D3 
; 0004 00D4    return  i;
	RJMP _0x20A0002
; 0004 00D5 }
; .FEND
;
;
;// USART0 Receiver interrupt service routine
;interrupt [USART0_RXC] void usart0_rx_isr(void)
; 0004 00DA {
_usart0_rx_isr:
; .FSTART _usart0_rx_isr
	CALL SUBOPT_0x30
; 0004 00DB    char status,data;
; 0004 00DC    status=UCSR0A;
;	status -> R17
;	data -> R16
	IN   R17,11
; 0004 00DD    data=UDR0;
	IN   R16,12
; 0004 00DE 
; 0004 00DF    if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
	MOV  R30,R17
	ANDI R30,LOW(0x1C)
	BRNE _0x8002E
; 0004 00E0    {
; 0004 00E1       rx_buffer0[rx_wr_index0++]=data;
	MOV  R30,R5
	INC  R5
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	ST   Z,R16
; 0004 00E2       if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
	LDI  R30,LOW(250)
	CP   R30,R5
	BRNE _0x8002F
	CLR  R5
; 0004 00E3       if (++rx_counter0 == RX_BUFFER_SIZE0)
_0x8002F:
	INC  R7
	LDI  R30,LOW(250)
	CP   R30,R7
	BRNE _0x80030
; 0004 00E4       {
; 0004 00E5         rx_counter0=0;
	CLR  R7
; 0004 00E6         rx_buffer_overflow0=TRUE;
	LDI  R30,LOW(1)
	MOV  R6,R30
; 0004 00E7       }
; 0004 00E8    }
_0x80030:
; 0004 00E9 }
_0x8002E:
_0x80059:
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
;char getchar0( void )
; 0004 00ED {
_getchar0:
; .FSTART _getchar0
; 0004 00EE     char data;
; 0004 00EF     if( rx_counter0 >0 )
	ST   -Y,R17
;	data -> R17
	LDI  R30,LOW(0)
	CP   R30,R7
	BRSH _0x80031
; 0004 00F0     {
; 0004 00F1       data = rx_buffer0[rx_rd_index0++];
	MOV  R30,R4
	INC  R4
	LDI  R31,0
	SUBI R30,LOW(-_rx_buffer0)
	SBCI R31,HIGH(-_rx_buffer0)
	LD   R17,Z
; 0004 00F2       if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;
	LDI  R30,LOW(250)
	CP   R30,R4
	BRNE _0x80032
	CLR  R4
; 0004 00F3 
; 0004 00F4        #asm("cli")
_0x80032:
	cli
; 0004 00F5        --rx_counter0;
	DEC  R7
; 0004 00F6        #asm("sei")
	sei
; 0004 00F7        mRcvErrFlag0 = 0;
	CLR  R9
; 0004 00F8        return data;
	MOV  R30,R17
	RJMP _0x20A0007
; 0004 00F9     }
; 0004 00FA     else
_0x80031:
; 0004 00FB     {
; 0004 00FC        mRcvErrFlag0 = 1;
	LDI  R30,LOW(1)
	MOV  R9,R30
; 0004 00FD        return 0;
	LDI  R30,LOW(0)
; 0004 00FE     }
; 0004 00FF }
_0x20A0007:
	LD   R17,Y+
	RET
; .FEND
;
;//#pragma used-
;BYTE  IPC_Get_RxCount0( void )
; 0004 0103 {
_IPC_Get_RxCount0:
; .FSTART _IPC_Get_RxCount0
; 0004 0104    return rx_counter0;
	MOV  R30,R7
	RET
; 0004 0105 }
; .FEND
;
;void IPC_ResetCount0( void )
; 0004 0108 {
_IPC_ResetCount0:
; .FSTART _IPC_ResetCount0
; 0004 0109    #asm("cli")
	cli
; 0004 010A    rx_counter0 = 0;
	CLR  R7
; 0004 010B    rx_rd_index0 = 0;
	CLR  R4
; 0004 010C    rx_wr_index0 = 0;
	CLR  R5
; 0004 010D    #asm("sei")
	sei
; 0004 010E }
	RET
; .FEND
;
;char Mygetchar0( BYTE flag )
; 0004 0111 {
; 0004 0112       WORD oldTime1ms;
; 0004 0113       char status,data;
; 0004 0114 
; 0004 0115       while ( 1 )
;	flag -> Y+4
;	oldTime1ms -> R16,R17
;	status -> R19
;	data -> R18
; 0004 0116       {
; 0004 0117           if( flag )
; 0004 0118                oldTime1ms = gTime1ms;
; 0004 0119 
; 0004 011A           while ( ((status=UCSR0A) & RX_COMPLETE) == 0 )
; 0004 011B           {
; 0004 011C               if( flag )
; 0004 011D               {
; 0004 011E                  if( (gTime1ms - oldTime1ms) > 300 ) //old 300
; 0004 011F                  {
; 0004 0120                       return 0;
; 0004 0121                  }
; 0004 0122               }
; 0004 0123           };
; 0004 0124 
; 0004 0125           data = UDR0;
; 0004 0126           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0004 0127           return data;
; 0004 0128       };
; 0004 0129 }
;
;char Tgetchar0( void )
; 0004 012C {
; 0004 012D       char status,data;
; 0004 012E       while ( 1 )
;	status -> R17
;	data -> R16
; 0004 012F       {
; 0004 0130           while ( ((status=UCSR0A) & RX_COMPLETE)==0 );
; 0004 0131               data = UDR0;
; 0004 0132           if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
; 0004 0133          return data;
; 0004 0134       };
; 0004 0135 }
;
;void Tputchar0( char c )
; 0004 0138 {
_Tputchar0:
; .FSTART _Tputchar0
; 0004 0139      while ((UCSR0A & DATA_REGISTER_EMPTY)==0);
	ST   -Y,R26
;	c -> Y+0
_0x80045:
	SBIS 0xB,5
	RJMP _0x80045
; 0004 013A      UDR0 = c;
	LD   R30,Y
	OUT  0xC,R30
; 0004 013B }
_0x20A0006:
	ADIW R28,1
	RET
; .FEND
;
;void Usrprintf0( char  *string )
; 0004 013E {
; 0004 013F     while( *string != '\0' )
;	*string -> Y+0
; 0004 0140     {
; 0004 0141         Tputchar0(*string++);
; 0004 0142     }
; 0004 0143 }
;
;void FlashUsrprintf0( const char *string )
; 0004 0146 {
; 0004 0147     while( *string != '\0' )
;	*string -> Y+0
; 0004 0148     {
; 0004 0149         Tputchar0(*string++);
; 0004 014A     }
; 0004 014B }
;
;void MyPrint0( char flash* format, ...)
; 0004 014E {
; 0004 014F       char str[100];
; 0004 0150 
; 0004 0151       va_list arg;
; 0004 0152       va_start(arg, format);
;	*format -> Y+102
;	str -> Y+2
;	*arg -> R16,R17
; 0004 0153 
; 0004 0154       vsprintf( str, format, arg);
; 0004 0155       va_end(arg);
; 0004 0156 
; 0004 0157       Usrprintf0( str ); // putchar1()를 스트링으로 전송하는 함수입니다.-아래 기술할께요~
; 0004 0158 }
;
;BYTE  IPC_RcvData0( BYTE *Buffer, BYTE len )
; 0004 015B {
; 0004 015C    BYTE i=0;
; 0004 015D 
; 0004 015E    while( i < len )
;	*Buffer -> Y+2
;	len -> Y+1
;	i -> R17
; 0004 015F    {
; 0004 0160         Buffer[i] = Mygetchar0(i);
; 0004 0161         i++;
; 0004 0162    }
; 0004 0163    return  i;
; 0004 0164 }
;
;BYTE IPC_RcvData_Interrupt0( BYTE *Buffer, BYTE len )
; 0004 0167 {
_IPC_RcvData_Interrupt0:
; .FSTART _IPC_RcvData_Interrupt0
; 0004 0168    BYTE i=0;
; 0004 0169    char dat = 0;
; 0004 016A    WORD oldTime1ms;
; 0004 016B    oldTime1ms = gTime1ms;
	CALL SUBOPT_0x31
;	*Buffer -> Y+5
;	len -> Y+4
;	i -> R17
;	dat -> R16
;	oldTime1ms -> R18,R19
; 0004 016C 
; 0004 016D    while( i < len )
_0x80051:
	LDD  R30,Y+4
	CP   R17,R30
	BRSH _0x80053
; 0004 016E    {
; 0004 016F        dat = getchar0();
	RCALL _getchar0
	MOV  R16,R30
; 0004 0170        if( mRcvErrFlag0 == 0  )
	TST  R9
	BRNE _0x80054
; 0004 0171        {
; 0004 0172           Buffer[i] = dat;
	CALL SUBOPT_0x32
; 0004 0173           i++;
; 0004 0174        }
; 0004 0175        if( (gTime1ms - oldTime1ms) > 3000 ) //old 300
_0x80054:
	CALL SUBOPT_0x33
	BRLO _0x80055
; 0004 0176        {
; 0004 0177           IPC_ResetCount0();
	RCALL _IPC_ResetCount0
; 0004 0178           return 0;
	LDI  R30,LOW(0)
	RJMP _0x20A0004
; 0004 0179        }
; 0004 017A    }
_0x80055:
	RJMP _0x80051
_0x80053:
; 0004 017B    return  i;
_0x20A0005:
	MOV  R30,R17
_0x20A0004:
	CALL __LOADLOCR4
	ADIW R28,7
	RET
; 0004 017C }
; .FEND
;
;BYTE IPC_SendData0( BYTE *Buffer, BYTE len )
; 0004 017F {
_IPC_SendData0:
; .FSTART _IPC_SendData0
; 0004 0180    BYTE i;
; 0004 0181    i= 0;
	ST   -Y,R26
	ST   -Y,R17
;	*Buffer -> Y+2
;	len -> Y+1
;	i -> R17
	LDI  R17,LOW(0)
; 0004 0182    while( i < len )
_0x80056:
	LDD  R30,Y+1
	CP   R17,R30
	BRSH _0x80058
; 0004 0183    {
; 0004 0184      Tputchar0(Buffer[i++]);
	CALL SUBOPT_0x34
	RCALL _Tputchar0
; 0004 0185    }
	RJMP _0x80056
_0x80058:
; 0004 0186 
; 0004 0187    return  i;
_0x20A0002:
	MOV  R30,R17
	LDD  R17,Y+0
_0x20A0003:
	ADIW R28,4
	RET
; 0004 0188 }
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
; 0005 0005 {

	.CSEG
; 0005 0006    BYTE temp;
; 0005 0007 
; 0005 0008    SPDR = 0xff;
;	temp -> R17
; 0005 0009    while(!(SPSR&0x80));
; 0005 000A    temp=SPDR;
; 0005 000B 
; 0005 000C    return temp;
; 0005 000D }
;
;void Spi_WriteByte(BYTE data )
; 0005 0010 {
; 0005 0011    SPDR = data;
;	data -> Y+0
; 0005 0012    while(!(SPSR&0x80));
; 0005 0013    data = SPDR;
; 0005 0014 }
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
; 0006 0009 {

	.CSEG
_read_adc:
; .FSTART _read_adc
; 0006 000A   WORD temp;
; 0006 000B   int  RetVal;
; 0006 000C 
; 0006 000D   ADMUX = adc_input | (ADC_VREF_TYPE & 0xff);
	ST   -Y,R26
	CALL __SAVELOCR4
;	adc_input -> Y+4
;	temp -> R16,R17
;	RetVal -> R18,R19
	LDD  R30,Y+4
	OUT  0x7,R30
; 0006 000E   // Delay needed for the stabilization of the ADC input voltage
; 0006 000F   delay_us(10);
	__DELAY_USB 53
; 0006 0010   // Start the AD conversion
; 0006 0011   ADCSRA|=0x40;
	SBI  0x6,6
; 0006 0012   // Wait for the AD conversion to complete
; 0006 0013   while ((ADCSRA & 0x10)==0);
_0xC0003:
	SBIS 0x6,4
	RJMP _0xC0003
; 0006 0014   ADCSRA |=0x10;
	SBI  0x6,4
; 0006 0015 
; 0006 0016  // return ADCW;
; 0006 0017   temp  = ADCW;
	__INWR 16,17,4
; 0006 0018 
; 0006 0019   RetVal =  (int)(5.0f*10.0f*(float)temp/1024.0f);
	MOVW R30,R16
	CLR  R22
	CLR  R23
	CALL __CDF1
	__GETD2N 0x42480000
	CALL __MULF12
	MOVW R26,R30
	MOVW R24,R22
	__GETD1N 0x44800000
	CALL __DIVF21
	CALL __CFD1
	MOVW R18,R30
; 0006 001A 
; 0006 001B   return RetVal;
	CALL __LOADLOCR4
	JMP  _0x20A0001
; 0006 001C }
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
;#include <string.h>
;
;#include "DAC7611/DAC7611.h"
;#include "Uart/uart.h"
;#include "IPC/IPClib.h"
;#include "InAdc/InAdc.h"
;#include "InEEprom/InEepromLib.h"
;
;const float DacArray[12] = {10.0f, 20.0f, 30.0f, 40.20f, 13.20f, 16.94f, 21.28f, 25.82f, 30.57f, 35.4f, 40.0f, 55.9f};
;
;// Variables
;int  gVoltage;
;BYTE gMode;
;BOOL gRunFlag;
;int  gDepth;
;int  gSpeed;
;int  gElCount=0;
;BYTE gFlag;
;int  gDose;
;BYTE gError;
;int  gAdcLoc=0;
;int  gElLoc=0;
;int  gMotorPos1=0;
;int  gMotorPos2=0;
;
;
;WORD gTime1ms;
;WORD goldTime1ms;
;BYTE WaitEvent( void );
;BYTE gElMatrix[4];
;int  gCurState=0;
;int  gCalValue0,gCalValue1;
;int  gDutyOff=0;
;BOOL gElCompletFlag = FALSE;
;
;//add yjw 2021.04.03
;BYTE gShotCnt =0;
;int gShotWaitTime =0;
;int gShotGapWaitTime =0;
;
;int gSetVolagteInitTime = 5000;

	.DSEG
;
;
;int  gShift=0;
;//int  gReadVol;
;int  gVolAdjCount=0;
;int  gVolChkCount = 0;
;//int  gInitCount=0;
;BYTE gCurMode;
;BOOL gGenMode=FALSE;
;BOOL gReadyActionFlag=FALSE;
;
;void InitSettingData(void);
;void LoadInEeprom( void);
;void InitData(void);
;
;//const int LowVolAdj[4] = {0, 8, 7, 0};
;
;// Timer 0 overflow interrupt service routine
;interrupt [TIM0_OVF] void timer0_ovf_isr(void)
; 0007 0041 {

	.CSEG
_timer0_ovf_isr:
; .FSTART _timer0_ovf_isr
	ST   -Y,R26
	ST   -Y,R27
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
; 0007 0042     // Reinitialize Timer 0 value
; 0007 0043     TCNT0 = 0x06;   //1ms
	LDI  R30,LOW(6)
	OUT  0x32,R30
; 0007 0044     // Place your code here
; 0007 0045     gTime1ms++;
	LDI  R26,LOW(_gTime1ms)
	LDI  R27,HIGH(_gTime1ms)
	CALL SUBOPT_0x35
; 0007 0046 }
	LD   R30,Y+
	OUT  SREG,R30
	LD   R31,Y+
	LD   R30,Y+
	LD   R27,Y+
	LD   R26,Y+
	RETI
; .FEND
;
;void PulseGenerator( void )
; 0007 0049 {
_PulseGenerator:
; .FSTART _PulseGenerator
; 0007 004A     int i=0;
; 0007 004B     // Reinitialize Timer1 value
; 0007 004C 
; 0007 004D     #if 0
; 0007 004E     TCNT1H=0xB1E0 >> 8;           //10ms
; 0007 004F     TCNT1L=0xB1E0 & 0xff;
; 0007 0050     #else
; 0007 0051     TCNT1H=0xE0;    //0.5ms
	CALL SUBOPT_0x0
;	i -> R16,R17
	CALL SUBOPT_0x36
; 0007 0052     TCNT1L=0xC0;
; 0007 0053     #endif
; 0007 0054 
; 0007 0055     // Place your code here
; 0007 0056     if( gRunFlag==TRUE && gElCompletFlag == FALSE )
	LDS  R26,_gRunFlag
	CPI  R26,LOW(0x1)
	BRNE _0xE0005
	LDS  R26,_gElCompletFlag
	CPI  R26,LOW(0x0)
	BREQ _0xE0006
_0xE0005:
	RJMP _0xE0004
_0xE0006:
; 0007 0057     {
; 0007 0058 
; 0007 0059         if( gGenMode==FALSE )
	LDS  R30,_gGenMode
	CPI  R30,0
	BREQ PC+2
	RJMP _0xE0007
; 0007 005A         {
; 0007 005B             if(gShotWaitTime<=800)  //0.5ms * 800 = 400ms
	LDS  R26,_gShotWaitTime
	LDS  R27,_gShotWaitTime+1
	CPI  R26,LOW(0x321)
	LDI  R30,HIGH(0x321)
	CPC  R27,R30
	BRGE _0xE0008
; 0007 005C             {
; 0007 005D                  gShotWaitTime++;
	LDI  R26,LOW(_gShotWaitTime)
	LDI  R27,HIGH(_gShotWaitTime)
	CALL SUBOPT_0x35
; 0007 005E             }
; 0007 005F             else
	RJMP _0xE0009
_0xE0008:
; 0007 0060             {
; 0007 0061                 if( gCurState == 0 )
	LDS  R30,_gCurState
	LDS  R31,_gCurState+1
	SBIW R30,0
	BRNE _0xE000A
; 0007 0062                 {
; 0007 0063                     gCalValue0 = gElMatrix[gElLoc]<<4;
	CALL SUBOPT_0x37
	CALL SUBOPT_0x38
; 0007 0064                     gCalValue1 = 0;
; 0007 0065 
; 0007 0066                     for( i=0; i< 4; i++)
_0xE000C:
	__CPWRN 16,17,4
	BRGE _0xE000D
; 0007 0067                     {
; 0007 0068                         if( gElMatrix[gElLoc]&(0x08>>i))
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
	BRNE _0xE000D
; 0007 0069                         break;
; 0007 006A                     }
	__ADDWRN 16,17,1
	RJMP _0xE000C
_0xE000D:
; 0007 006B                     gShift = i;
	CALL SUBOPT_0x3A
; 0007 006C 
; 0007 006D                     gShift++;
; 0007 006E                     if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE000F
	CALL SUBOPT_0x3C
; 0007 006F 
; 0007 0070                     PORTC = gCalValue0|(0x08>>gShift);
_0xE000F:
	CALL SUBOPT_0x3D
; 0007 0071                     gCurState = 1;
	CALL SUBOPT_0x3E
; 0007 0072                 }
; 0007 0073                 else if( gCurState == 1 )
	RJMP _0xE0010
_0xE000A:
	CALL SUBOPT_0x3F
	SBIW R26,1
	BRNE _0xE0011
; 0007 0074                 {
; 0007 0075                     PORTC = gCalValue1;
	CALL SUBOPT_0x40
; 0007 0076                     gCurState = 2;
; 0007 0077                 }
; 0007 0078                 else if( gCurState == 2 )
	RJMP _0xE0012
_0xE0011:
	CALL SUBOPT_0x3F
	SBIW R26,2
	BRNE _0xE0013
; 0007 0079                 {
; 0007 007A                     gShift++;
	CALL SUBOPT_0x41
; 0007 007B                     if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE0014
	CALL SUBOPT_0x3C
; 0007 007C                     PORTC = gCalValue0|(0x08>>gShift);
_0xE0014:
	CALL SUBOPT_0x3D
; 0007 007D                     gCurState = 3;
	CALL SUBOPT_0x42
; 0007 007E                 }
; 0007 007F                 else if( gCurState == 3 )
	RJMP _0xE0015
_0xE0013:
	CALL SUBOPT_0x3F
	SBIW R26,3
	BRNE _0xE0016
; 0007 0080                 {
; 0007 0081                     PORTC = gCalValue1;
	CALL SUBOPT_0x43
; 0007 0082                     gCurState = 4;
; 0007 0083                 }
; 0007 0084                 else if( gCurState == 4 )
	RJMP _0xE0017
_0xE0016:
	CALL SUBOPT_0x3F
	SBIW R26,4
	BRNE _0xE0018
; 0007 0085                 {
; 0007 0086                     gShift++;
	CALL SUBOPT_0x41
; 0007 0087                     if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE0019
	CALL SUBOPT_0x3C
; 0007 0088                     PORTC = gCalValue0|(0x08>>gShift);
_0xE0019:
	CALL SUBOPT_0x3D
; 0007 0089                     gCurState = 5;
	CALL SUBOPT_0x44
; 0007 008A                 }
; 0007 008B                 else if( gCurState == 5 )
	RJMP _0xE001A
_0xE0018:
	CALL SUBOPT_0x3F
	SBIW R26,5
	BRNE _0xE001B
; 0007 008C                 {
; 0007 008D                     PORTC = gCalValue1;
	CALL SUBOPT_0x45
; 0007 008E                     gElLoc++;
; 0007 008F                     if( gElLoc > 3 )
	LDS  R26,_gElLoc
	LDS  R27,_gElLoc+1
	SBIW R26,4
	BRLT _0xE001C
; 0007 0090                     {
; 0007 0091                         gShotCnt++;
	CALL SUBOPT_0x46
; 0007 0092                         gElLoc = 0;
; 0007 0093                     }
; 0007 0094                     gCurState = 0;
_0xE001C:
	LDI  R30,LOW(0)
	STS  _gCurState,R30
	STS  _gCurState+1,R30
; 0007 0095 
; 0007 0096                     if(gShotCnt >=1)      //1CYCLE
	LDS  R26,_gShotCnt
	CPI  R26,LOW(0x1)
	BRLO _0xE001D
; 0007 0097                     {
; 0007 0098                         gShotCnt = 0;
	CALL SUBOPT_0x47
; 0007 0099                         gShotWaitTime = 0;
; 0007 009A                         gElCompletFlag = TRUE;
; 0007 009B                     }
; 0007 009C                 }
_0xE001D:
; 0007 009D             }
_0xE001B:
_0xE001A:
_0xE0017:
_0xE0015:
_0xE0012:
_0xE0010:
_0xE0009:
; 0007 009E         }
; 0007 009F         else
	RJMP _0xE001E
_0xE0007:
; 0007 00A0         {
; 0007 00A1 
; 0007 00A2           if(gShotWaitTime<=400)  //0.5ms * 400 = 200ms
	LDS  R26,_gShotWaitTime
	LDS  R27,_gShotWaitTime+1
	CPI  R26,LOW(0x191)
	LDI  R30,HIGH(0x191)
	CPC  R27,R30
	BRGE _0xE001F
; 0007 00A3             {
; 0007 00A4                  gShotWaitTime++;
	LDI  R26,LOW(_gShotWaitTime)
	LDI  R27,HIGH(_gShotWaitTime)
	CALL SUBOPT_0x35
; 0007 00A5                  gShotGapWaitTime = 0;
	LDI  R30,LOW(0)
	STS  _gShotGapWaitTime,R30
	STS  _gShotGapWaitTime+1,R30
; 0007 00A6             }
; 0007 00A7             else
	RJMP _0xE0020
_0xE001F:
; 0007 00A8             {
; 0007 00A9                 if(gShotGapWaitTime)
	LDS  R30,_gShotGapWaitTime
	LDS  R31,_gShotGapWaitTime+1
	SBIW R30,0
	BREQ _0xE0021
; 0007 00AA                 {
; 0007 00AB                     gShotGapWaitTime --;
	LDI  R26,LOW(_gShotGapWaitTime)
	LDI  R27,HIGH(_gShotGapWaitTime)
	CALL SUBOPT_0x48
; 0007 00AC                 }
; 0007 00AD                 else
	RJMP _0xE0022
_0xE0021:
; 0007 00AE                 {
; 0007 00AF                    if( gCurState == 0 )
	LDS  R30,_gCurState
	LDS  R31,_gCurState+1
	SBIW R30,0
	BRNE _0xE0023
; 0007 00B0                     {
; 0007 00B1                         gCalValue0 = gElMatrix[gElLoc]<<4;
	CALL SUBOPT_0x37
	CALL SUBOPT_0x38
; 0007 00B2                         gCalValue1 = 0;
; 0007 00B3 
; 0007 00B4                         for( i=0; i< 4; i++)
_0xE0025:
	__CPWRN 16,17,4
	BRGE _0xE0026
; 0007 00B5                         {
; 0007 00B6                             if( gElMatrix[gElLoc]&(0x08>>i))
	CALL SUBOPT_0x37
	CALL SUBOPT_0x39
	BRNE _0xE0026
; 0007 00B7                             break;
; 0007 00B8                         }
	__ADDWRN 16,17,1
	RJMP _0xE0025
_0xE0026:
; 0007 00B9                         gShift = i;
	CALL SUBOPT_0x3A
; 0007 00BA 
; 0007 00BB                         gShift++;
; 0007 00BC                         if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE0028
	CALL SUBOPT_0x3C
; 0007 00BD 
; 0007 00BE                         PORTC = gCalValue0|(0x08>>gShift);
_0xE0028:
	CALL SUBOPT_0x3D
; 0007 00BF                         gCurState = 1;
	CALL SUBOPT_0x3E
; 0007 00C0                     }
; 0007 00C1                     else if( gCurState == 1 )
	RJMP _0xE0029
_0xE0023:
	CALL SUBOPT_0x3F
	SBIW R26,1
	BRNE _0xE002A
; 0007 00C2                     {
; 0007 00C3                         PORTC = gCalValue1;
	CALL SUBOPT_0x40
; 0007 00C4                         gCurState = 2;
; 0007 00C5                     }
; 0007 00C6                     else if( gCurState == 2 )
	RJMP _0xE002B
_0xE002A:
	CALL SUBOPT_0x3F
	SBIW R26,2
	BRNE _0xE002C
; 0007 00C7                     {
; 0007 00C8                         gShift++;
	CALL SUBOPT_0x41
; 0007 00C9                         if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE002D
	CALL SUBOPT_0x3C
; 0007 00CA                         PORTC = gCalValue0|(0x08>>gShift);
_0xE002D:
	CALL SUBOPT_0x3D
; 0007 00CB                         gCurState = 3;
	CALL SUBOPT_0x42
; 0007 00CC                     }
; 0007 00CD                     else if( gCurState == 3 )
	RJMP _0xE002E
_0xE002C:
	CALL SUBOPT_0x3F
	SBIW R26,3
	BRNE _0xE002F
; 0007 00CE                     {
; 0007 00CF                         PORTC = gCalValue1;
	CALL SUBOPT_0x43
; 0007 00D0                         gCurState = 4;
; 0007 00D1                     }
; 0007 00D2                     else if( gCurState == 4 )
	RJMP _0xE0030
_0xE002F:
	CALL SUBOPT_0x3F
	SBIW R26,4
	BRNE _0xE0031
; 0007 00D3                     {
; 0007 00D4                         gShift++;
	CALL SUBOPT_0x41
; 0007 00D5                         if( gShift > 3 ) gShift = 0;
	CALL SUBOPT_0x3B
	BRLT _0xE0032
	CALL SUBOPT_0x3C
; 0007 00D6                         PORTC = gCalValue0|(0x08>>gShift);
_0xE0032:
	CALL SUBOPT_0x3D
; 0007 00D7                         gCurState = 5;
	CALL SUBOPT_0x44
; 0007 00D8                     }
; 0007 00D9                     else if( gCurState == 5 )
	RJMP _0xE0033
_0xE0031:
	CALL SUBOPT_0x3F
	SBIW R26,5
	BRNE _0xE0034
; 0007 00DA                     {
; 0007 00DB                         PORTC = gCalValue1;
	CALL SUBOPT_0x45
; 0007 00DC                         gElLoc++;
; 0007 00DD                         gCurState = 0;
	LDI  R30,LOW(0)
	STS  _gCurState,R30
	STS  _gCurState+1,R30
; 0007 00DE                         gShotGapWaitTime = 200;  //0.5ms * 200 = 100ms
	LDI  R30,LOW(200)
	LDI  R31,HIGH(200)
	STS  _gShotGapWaitTime,R30
	STS  _gShotGapWaitTime+1,R31
; 0007 00DF                         if( gElLoc > 3 )
	LDS  R26,_gElLoc
	LDS  R27,_gElLoc+1
	SBIW R26,4
	BRLT _0xE0035
; 0007 00E0                         {
; 0007 00E1                             gShotCnt++;
	CALL SUBOPT_0x46
; 0007 00E2                             gElLoc = 0;
; 0007 00E3                         }
; 0007 00E4 
; 0007 00E5                         if(gShotCnt >=1)      //1CYCLE
_0xE0035:
	LDS  R26,_gShotCnt
	CPI  R26,LOW(0x1)
	BRLO _0xE0036
; 0007 00E6                         {
; 0007 00E7                             gShotCnt = 0;
	CALL SUBOPT_0x47
; 0007 00E8                             gShotWaitTime = 0;
; 0007 00E9                             gElCompletFlag = TRUE;
; 0007 00EA                         }
; 0007 00EB                     }
_0xE0036:
; 0007 00EC                 }
_0xE0034:
_0xE0033:
_0xE0030:
_0xE002E:
_0xE002B:
_0xE0029:
_0xE0022:
; 0007 00ED             }
_0xE0020:
; 0007 00EE         }
_0xE001E:
; 0007 00EF      }
; 0007 00F0 }
_0xE0004:
	LD   R16,Y+
	LD   R17,Y+
	RET
; .FEND
;
;void PulseGenerator6( void )
; 0007 00F3 {
; 0007 00F4      // Reinitialize Timer1 value
; 0007 00F5     TCNT1H=0xE600 >> 8;          //     0.4ms
; 0007 00F6     TCNT1L=0xE600 & 0xff;
; 0007 00F7 
; 0007 00F8     // Place your code here
; 0007 00F9     if( gRunFlag==TRUE && gElCompletFlag == FALSE )
; 0007 00FA     {
; 0007 00FB        if( gCurState == 0 )
; 0007 00FC        {
; 0007 00FD           gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElL ...
; 0007 00FE           gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;
; 0007 00FF 
; 0007 0100           PORTC = gCalValue0;
; 0007 0101           gDutyOff = 0;
; 0007 0102           gCurState = 1;
; 0007 0103        }
; 0007 0104        else if( gCurState == 1 )
; 0007 0105        {
; 0007 0106           gDutyOff++;
; 0007 0107           if( gDutyOff >14 )gCurState = 2;
; 0007 0108        }
; 0007 0109        else if( gCurState == 2 )
; 0007 010A        {
; 0007 010B           gDutyOff = 0;
; 0007 010C           PORTC = gCalValue1;
; 0007 010D           gCurState = 3;
; 0007 010E        }
; 0007 010F        else if( gCurState == 3 )
; 0007 0110        {
; 0007 0111           PORTC = gCalValue0;
; 0007 0112           gDutyOff++;
; 0007 0113           if( gDutyOff >15) gCurState = 4;
; 0007 0114        }
; 0007 0115        else if( gCurState == 4 )
; 0007 0116        {
; 0007 0117           gDutyOff = 0;
; 0007 0118           PORTC = gCalValue1;
; 0007 0119           gCurState = 5;
; 0007 011A        }
; 0007 011B        else if( gCurState == 5 )
; 0007 011C        {
; 0007 011D           PORTC = gCalValue0;
; 0007 011E           gDutyOff++;
; 0007 011F           if( gDutyOff >15) gCurState = 6;
; 0007 0120        }
; 0007 0121        else if( gCurState == 6 )
; 0007 0122        {
; 0007 0123           gDutyOff = 0;
; 0007 0124           PORTC = gCalValue1;
; 0007 0125           gCurState = 7;
; 0007 0126        }
; 0007 0127        else if( gCurState == 7 )
; 0007 0128        {
; 0007 0129           PORTC = gCalValue0;
; 0007 012A           gDutyOff++;
; 0007 012B           if( gDutyOff >15) gCurState = 8;
; 0007 012C        }
; 0007 012D        else if( gCurState == 8 )
; 0007 012E        {
; 0007 012F           gDutyOff = 0;
; 0007 0130           PORTC = gCalValue1;
; 0007 0131           gCurState = 9;
; 0007 0132        }
; 0007 0133        else if( gCurState == 9 )
; 0007 0134        {
; 0007 0135           PORTC = gCalValue0;
; 0007 0136           gDutyOff++;
; 0007 0137           if( gDutyOff >15) gCurState = 10;
; 0007 0138        }
; 0007 0139        else if( gCurState == 10 )
; 0007 013A        {
; 0007 013B           gDutyOff = 0;
; 0007 013C           PORTC = gCalValue1;
; 0007 013D           gCurState = 11;
; 0007 013E        }
; 0007 013F        else if( gCurState == 11 )
; 0007 0140        {
; 0007 0141           gDutyOff++;
; 0007 0142           if( gDutyOff > 363)     //150ms
; 0007 0143           {
; 0007 0144              gCurState = 0;
; 0007 0145              gElLoc++;
; 0007 0146              if( gElLoc > 3 )
; 0007 0147              {
; 0007 0148                 PORTC = 0x00;
; 0007 0149                 gElLoc = 0;
; 0007 014A                 gElCompletFlag = TRUE;
; 0007 014B              }
; 0007 014C           }
; 0007 014D        }
; 0007 014E    }
; 0007 014F }
;
;interrupt [TIM1_OVF] void timer1_ovf_isr(void)
; 0007 0152 {
_timer1_ovf_isr:
; .FSTART _timer1_ovf_isr
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
; 0007 0153     PulseGenerator();
	RCALL _PulseGenerator
; 0007 0154 
; 0007 0155     if(gSetVolagteInitTime>0)
	LDS  R26,_gSetVolagteInitTime
	LDS  R27,_gSetVolagteInitTime+1
	CALL __CPW02
	BRGE _0xE0058
; 0007 0156     {
; 0007 0157          gSetVolagteInitTime--;
	LDI  R26,LOW(_gSetVolagteInitTime)
	LDI  R27,HIGH(_gSetVolagteInitTime)
	CALL SUBOPT_0x48
; 0007 0158     }
; 0007 0159     else
	RJMP _0xE0059
_0xE0058:
; 0007 015A     {
; 0007 015B         gSetVolagteInitTime =0;
	LDI  R30,LOW(0)
	STS  _gSetVolagteInitTime,R30
	STS  _gSetVolagteInitTime+1,R30
; 0007 015C     }
_0xE0059:
; 0007 015D }
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
;void PortInit( void )
; 0007 0160 {
_PortInit:
; .FSTART _PortInit
; 0007 0161     // PORTA
; 0007 0162     // bit 7 : N.C
; 0007 0163     // bit 6 : N.C
; 0007 0164     // bit 5 : EPG 2 out(LED)
; 0007 0165     // bit 4 : EPG 1 out(LED)
; 0007 0166     // bit 3 : DAC7611 LD  out
; 0007 0167     // bit 2 : DAC7611 CS  out
; 0007 0168     // bit 1 : DAC7611 CLK out
; 0007 0169     // bit 0 : DAC7611 SDI out
; 0007 016A     DDRA    = 0x3f;
	LDI  R30,LOW(63)
	OUT  0x1A,R30
; 0007 016B     PORTA   = 0x04;
	LDI  R30,LOW(4)
	OUT  0x1B,R30
; 0007 016C 
; 0007 016D     //PORTB
; 0007 016E     // bit 7 : N.C
; 0007 016F     // bit 6 : LF398 Sample Hold out
; 0007 0170     // bit 5 : N.C
; 0007 0171     // bit 4 : N.C
; 0007 0172     // bit 3 : N.C
; 0007 0173     // bit 2 : N.C
; 0007 0174     // bit 1 : N.C
; 0007 0175     // bit 0 : N.C
; 0007 0176     DDRB    = 0x40;
	LDI  R30,LOW(64)
	OUT  0x17,R30
; 0007 0177     PORTB   = 0x01;
	LDI  R30,LOW(1)
	OUT  0x18,R30
; 0007 0178 
; 0007 0179     //PORTC
; 0007 017A     //bit 7: ELECT7
; 0007 017B     //bit 6: ELECT6
; 0007 017C     //bit 5: ELECT5
; 0007 017D     //bit 4: ELECT4
; 0007 017E     //bit 3: ELECT3
; 0007 017F     //bit 2: ELECT2
; 0007 0180     //bit 1: ELECT1
; 0007 0181     //bit 0: ELECT0
; 0007 0182     DDRC    = 0xff;
	LDI  R30,LOW(255)
	OUT  0x14,R30
; 0007 0183     PORTC   = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0007 0184 
; 0007 0185     //PORTD
; 0007 0186     //bit 7: (OUT) Voltage Read Select
; 0007 0187     //bit 6: NC
; 0007 0188     //bit 5: NC
; 0007 0189     //bit 4: (IN)FET destruction sen
; 0007 018A     //bit 3: TXD1
; 0007 018B     //bit 2: RXD1
; 0007 018C     //bit 1: NC
; 0007 018D     //bit 0: NC
; 0007 018E     DDRD    = 0x80;
	LDI  R30,LOW(128)
	OUT  0x11,R30
; 0007 018F     PORTD   = 0x00;
	LDI  R30,LOW(0)
	OUT  0x12,R30
; 0007 0190 
; 0007 0191     DDRE    = 0x12;
	LDI  R30,LOW(18)
	OUT  0x2,R30
; 0007 0192     //PORTE   = 0x54;
; 0007 0193 
; 0007 0194     DDRF    = 0xC0;
	LDI  R30,LOW(192)
	STS  97,R30
; 0007 0195     PORTF   = 0x00;
	LDI  R30,LOW(0)
	STS  98,R30
; 0007 0196 
; 0007 0197     DDRG    = 0xff;
	LDI  R30,LOW(255)
	STS  100,R30
; 0007 0198     PORTG   = 0x00;
	LDI  R30,LOW(0)
	STS  101,R30
; 0007 0199 
; 0007 019A     // Timer/Counter 0 initialization
; 0007 019B     // Clock source: System Clock
; 0007 019C     // Clock value: 250.000 kHz
; 0007 019D     // Mode: Normal top=0xFF
; 0007 019E     // OC0 output: Disconnected
; 0007 019F     // Timer Period: 1 ms
; 0007 01A0     ASSR=0;
	OUT  0x30,R30
; 0007 01A1     TCCR0=0x04;
	LDI  R30,LOW(4)
	OUT  0x33,R30
; 0007 01A2     TCNT0=0x06;
	LDI  R30,LOW(6)
	OUT  0x32,R30
; 0007 01A3     OCR0=0x00;
	LDI  R30,LOW(0)
	OUT  0x31,R30
; 0007 01A4 
; 0007 01A5    // Timer/Counter 1 initialization
; 0007 01A6    // Clock source: System Clock
; 0007 01A7    // Clock value: 2000.000 kHz
; 0007 01A8    // Mode: Normal top=0xFFFF
; 0007 01A9    // OC1A output: Disconnected
; 0007 01AA    // OC1B output: Disconnected
; 0007 01AB    // OC1C output: Disconnected
; 0007 01AC    // Noise Canceler: Off
; 0007 01AD    // Input Capture on Falling Edge
; 0007 01AE    // Timer Period: 10 ms
; 0007 01AF    // Timer1 Overflow Interrupt: On
; 0007 01B0    // Input Capture Interrupt: Off
; 0007 01B1    // Compare A Match Interrupt: Off
; 0007 01B2    // Compare B Match Interrupt: Off
; 0007 01B3    // Compare C Match Interrupt: Off
; 0007 01B4    /*
; 0007 01B5    TCCR1A=0x00;
; 0007 01B6    TCCR1B=0x02;
; 0007 01B7    TCNT1H=0xB1;
; 0007 01B8    TCNT1L=0xE0;
; 0007 01B9    ICR1H=0x00;
; 0007 01BA    ICR1L=0x00;
; 0007 01BB    OCR1AH=0x00;
; 0007 01BC    OCR1AL=0x00;
; 0007 01BD    OCR1BH=0x00;
; 0007 01BE    OCR1BL=0x00;
; 0007 01BF    OCR1CH=0x00;
; 0007 01C0    */
; 0007 01C1 
; 0007 01C2 // Timer/Counter 1 initialization
; 0007 01C3 // Clock source: System Clock
; 0007 01C4 // Clock value: 16000.000 kHz
; 0007 01C5 // Mode: Normal top=0xFFFF
; 0007 01C6 // OC1A output: Disconnected
; 0007 01C7 // OC1B output: Disconnected
; 0007 01C8 // OC1C output: Disconnected
; 0007 01C9 // Noise Canceler: Off
; 0007 01CA // Input Capture on Falling Edge
; 0007 01CB // Timer Period: 0.4 ms
; 0007 01CC // Timer1 Overflow Interrupt: On
; 0007 01CD // Input Capture Interrupt: Off
; 0007 01CE // Compare A Match Interrupt: Off
; 0007 01CF // Compare B Match Interrupt: Off
; 0007 01D0 // Compare C Match Interrupt: Off
; 0007 01D1 
; 0007 01D2 //yjw add 2021.04.03
; 0007 01D3 #if 0
; 0007 01D4 TCCR1A=0x00;
; 0007 01D5 TCCR1B= 0x01;
; 0007 01D6 TCNT1H=0xE7;
; 0007 01D7 TCNT1L=0x00;
; 0007 01D8 #else
; 0007 01D9 TCCR1A=0x00;
	CALL SUBOPT_0x49
; 0007 01DA TCCR1B=0x01;
; 0007 01DB TCNT1H=0xE0;
; 0007 01DC TCNT1L=0xC0;
; 0007 01DD #endif
; 0007 01DE ICR1H=0x00;
	LDI  R30,LOW(0)
	OUT  0x27,R30
; 0007 01DF ICR1L=0x00;
	OUT  0x26,R30
; 0007 01E0 OCR1AH=0x00;
	OUT  0x2B,R30
; 0007 01E1 OCR1AL=0x00;
	OUT  0x2A,R30
; 0007 01E2 OCR1BH=0x00;
	OUT  0x29,R30
; 0007 01E3 OCR1BL=0x00;
	OUT  0x28,R30
; 0007 01E4 OCR1CH=0x00;
	STS  121,R30
; 0007 01E5 OCR1CL=0x00;
	STS  120,R30
; 0007 01E6 
; 0007 01E7    // Timer(s)/Counter(s) Interrupt(s) initialization
; 0007 01E8    TIMSK=0x05;
	LDI  R30,LOW(5)
	OUT  0x37,R30
; 0007 01E9    ETIMSK=0x00;
	LDI  R30,LOW(0)
	STS  125,R30
; 0007 01EA 
; 0007 01EB 
; 0007 01EC // USART0 initialization
; 0007 01ED // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0007 01EE // USART0 Receiver: On
; 0007 01EF // USART0 Transmitter: On
; 0007 01F0 // USART0 Mode: Asynchronous
; 0007 01F1 // USART0 Baud Rate: 38400 (Double Speed Mode)
; 0007 01F2    UCSR0A=0x02;
	LDI  R30,LOW(2)
	OUT  0xB,R30
; 0007 01F3    UCSR0B=0x98;
	LDI  R30,LOW(152)
	OUT  0xA,R30
; 0007 01F4    UCSR0C=0x06;
	LDI  R30,LOW(6)
	STS  149,R30
; 0007 01F5    UBRR0H=0x00;
	LDI  R30,LOW(0)
	STS  144,R30
; 0007 01F6    UBRR0L=0x33;
	LDI  R30,LOW(51)
	OUT  0x9,R30
; 0007 01F7 
; 0007 01F8    // USART1 initialization
; 0007 01F9    // Communication Parameters: 8 Data, 1 Stop, No Parity
; 0007 01FA    // USART1 Receiver: On
; 0007 01FB    // USART1 Transmitter: On
; 0007 01FC    // USART1 Mode: Asynchronous
; 0007 01FD    // USART1 Baud Rate: 57600 (Double Speed Mode)
; 0007 01FE    UCSR1A=0x02;
	LDI  R30,LOW(2)
	STS  155,R30
; 0007 01FF    UCSR1B=0x98;
	LDI  R30,LOW(152)
	STS  154,R30
; 0007 0200    UCSR1C=0x06;
	LDI  R30,LOW(6)
	STS  157,R30
; 0007 0201    UBRR1H=0x00;
	LDI  R30,LOW(0)
	STS  152,R30
; 0007 0202    UBRR1L=0x22;
	LDI  R30,LOW(34)
	STS  153,R30
; 0007 0203 
; 0007 0204    // ADC initialization
; 0007 0205    // ADC Clock frequency: 1000.000 kHz
; 0007 0206    // ADC Voltage Reference: AREF pin
; 0007 0207    ADMUX  = 0x00 & 0xff;
	LDI  R30,LOW(0)
	OUT  0x7,R30
; 0007 0208    ADCSRA = 0x84;
	LDI  R30,LOW(132)
	OUT  0x6,R30
; 0007 0209 }
	RET
; .FEND
;
;void InitData(void)
; 0007 020C {
_InitData:
; .FSTART _InitData
; 0007 020D    gCurMode = CUR_INIT;
	LDI  R30,LOW(0)
	STS  _gCurMode,R30
; 0007 020E    gVoltage=100;
	LDI  R30,LOW(100)
	LDI  R31,HIGH(100)
	STS  _gVoltage,R30
	STS  _gVoltage+1,R31
; 0007 020F    gMode=0;
	LDI  R30,LOW(0)
	STS  _gMode,R30
; 0007 0210    gRunFlag = FALSE;
	STS  _gRunFlag,R30
; 0007 0211    gDepth=0;
	CALL SUBOPT_0xD
; 0007 0212    gSpeed=1;
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _gSpeed,R30
	STS  _gSpeed+1,R31
; 0007 0213    gFlag=0;
	LDI  R30,LOW(0)
	STS  _gFlag,R30
; 0007 0214    gError = (1<<ERROR_NOTLCD);
	LDI  R30,LOW(64)
	STS  _gError,R30
; 0007 0215    gDose = 0;
	CALL SUBOPT_0x7
; 0007 0216 
; 0007 0217    // A B C D
; 0007 0218    // - - + -
; 0007 0219    // - - - +
; 0007 021A    // + - - -
; 0007 021B    // - + - -
; 0007 021C    gElMatrix[0] = 0x02;
	CALL SUBOPT_0x4A
; 0007 021D    gElMatrix[1] = 0x01;
; 0007 021E    gElMatrix[2] = 0x08;
; 0007 021F    gElMatrix[3] = 0x04;
; 0007 0220 }
	RET
; .FEND
;void InitSettingData(void)
; 0007 0222 {
_InitSettingData:
; .FSTART _InitSettingData
; 0007 0223    DAC7611_WriteVoltage(gVoltage);
	CALL SUBOPT_0xA
	CALL _DAC7611_WriteVoltage
; 0007 0224 }
	RET
; .FEND
;
;void SystemInit( void )
; 0007 0227 {
_SystemInit:
; .FSTART _SystemInit
; 0007 0228    PortInit();
	RCALL _PortInit
; 0007 0229    InitData();
	RCALL _InitData
; 0007 022A 
; 0007 022B    LoadInEeprom();
	RCALL _LoadInEeprom
; 0007 022C 
; 0007 022D    DAC7611_init(  );
	CALL _DAC7611_init
; 0007 022E 
; 0007 022F    InitSettingData();
	RCALL _InitSettingData
; 0007 0230 
; 0007 0231    gGenMode = PINB.0?TRUE:FALSE;
	SBIS 0x16,0
	RJMP _0xE005A
	LDI  R30,LOW(1)
	RJMP _0xE005B
_0xE005A:
	LDI  R30,LOW(0)
_0xE005B:
	STS  _gGenMode,R30
; 0007 0232 
; 0007 0233    HIGH_PGM1_LED;
	SBI  0x1B,4
; 0007 0234 
; 0007 0235      // A B C D
; 0007 0236      // - - + -
; 0007 0237      // - - - +
; 0007 0238      // + - - -
; 0007 0239      // - + - -
; 0007 023A      gElMatrix[0] = 0x02;
	CALL SUBOPT_0x4A
; 0007 023B      gElMatrix[1] = 0x01;
; 0007 023C      gElMatrix[2] = 0x08;
; 0007 023D      gElMatrix[3] = 0x04;
; 0007 023E 
; 0007 023F     //0.5ms
; 0007 0240     TCCR1A=0x00;
	CALL SUBOPT_0x49
; 0007 0241     TCCR1B=0x01;
; 0007 0242 
; 0007 0243     TCNT1H=0xE0;
; 0007 0244     TCNT1L=0xC0;
; 0007 0245 }
	RET
; .FEND
;
;
;BYTE WaitEvent( void )
; 0007 0249 {
_WaitEvent:
; .FSTART _WaitEvent
; 0007 024A 
; 0007 024B     while ( 1 )
_0xE005F:
; 0007 024C     {
; 0007 024D        if( IPC_Get_RxCount0() >=  sizeof( IPC_HEADER ) )
	CALL _IPC_Get_RxCount0
	CPI  R30,LOW(0x7)
	BRLO _0xE0062
; 0007 024E        {
; 0007 024F            goldTime1ms = gTime1ms;
	CALL SUBOPT_0x4B
; 0007 0250            return EVN_RCVUART0;
	LDI  R30,LOW(1)
	RET
; 0007 0251        }
; 0007 0252        else if( IPC_Get_RxCount1() >=  sizeof( IPC_HEADER ) )
_0xE0062:
	CALL _IPC_Get_RxCount1
	CPI  R30,LOW(0x7)
	BRLO _0xE0064
; 0007 0253        {
; 0007 0254            goldTime1ms = gTime1ms;
	CALL SUBOPT_0x4B
; 0007 0255            return EVN_RCVUART1;
	LDI  R30,LOW(2)
	RET
; 0007 0256        }
; 0007 0257        //else if( (gTime1ms-goldTime1ms) > 300 ) // 50=200ms
; 0007 0258        else if( (gTime1ms-goldTime1ms) > 300 ) // 50=200ms
_0xE0064:
	LDS  R26,_goldTime1ms
	LDS  R27,_goldTime1ms+1
	LDS  R30,_gTime1ms
	LDS  R31,_gTime1ms+1
	SUB  R30,R26
	SBC  R31,R27
	CPI  R30,LOW(0x12D)
	LDI  R26,HIGH(0x12D)
	CPC  R31,R26
	BRLO _0xE0066
; 0007 0259        {
; 0007 025A            goldTime1ms = gTime1ms;
	CALL SUBOPT_0x4B
; 0007 025B 
; 0007 025C           return EVN_TIMEOVER;
	LDI  R30,LOW(3)
	RET
; 0007 025D        }
; 0007 025E     }
_0xE0066:
	RJMP _0xE005F
; 0007 025F }
; .FEND
;
;void SaveInEeprom( void )
; 0007 0262 {
_SaveInEeprom:
; .FSTART _SaveInEeprom
; 0007 0263    EEPROM_BODY mEDat;
; 0007 0264 
; 0007 0265    memset((void *)&mEDat,0 ,sizeof( EEPROM_BODY));
	SBIW R28,11
;	mEDat -> Y+0
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(11)
	LDI  R27,0
	CALL _memset
; 0007 0266 
; 0007 0267    mEDat.AkFlag = 'A';
	LDI  R30,LOW(65)
	ST   Y,R30
; 0007 0268    mEDat.Run  = gRunFlag?1:0;
	LDS  R30,_gRunFlag
	CPI  R30,0
	BREQ _0xE0067
	LDI  R30,LOW(1)
	RJMP _0xE0068
_0xE0067:
	LDI  R30,LOW(0)
_0xE0068:
	STD  Y+2,R30
; 0007 0269    mEDat.Dose1 = (BYTE)((gDose>>8)&0xff);
	LDS  R30,_gDose
	LDS  R31,_gDose+1
	CALL __ASRW8
	STD  Y+3,R30
; 0007 026A    mEDat.Dose2 = (BYTE)(gDose&0xff);
	LDS  R30,_gDose
	STD  Y+4,R30
; 0007 026B    mEDat.Voltage = gVoltage ;
	LDS  R30,_gVoltage
	STD  Y+5,R30
; 0007 026C    mEDat.Depth = gDepth;
	LDS  R30,_gDepth
	STD  Y+6,R30
; 0007 026D    mEDat.Speed = gSpeed;
	LDS  R30,_gSpeed
	STD  Y+7,R30
; 0007 026E    mEDat.Flag  = gFlag;
	LDS  R30,_gFlag
	STD  Y+8,R30
; 0007 026F    mEDat.Map1  = (gElMatrix[0]<<4)&0xf0 | gElMatrix[1]&0x0f;
	LDS  R30,_gElMatrix
	SWAP R30
	ANDI R30,LOW(0xF0)
	MOV  R26,R30
	__GETB1MN _gElMatrix,1
	ANDI R30,LOW(0xF)
	OR   R30,R26
	STD  Y+9,R30
; 0007 0270    mEDat.Map2  = (gElMatrix[2]<<4)&0xf0 | gElMatrix[3]&0x0f;
	__GETB1MN _gElMatrix,2
	SWAP R30
	ANDI R30,LOW(0xF0)
	MOV  R26,R30
	__GETB1MN _gElMatrix,3
	ANDI R30,LOW(0xF)
	OR   R30,R26
	STD  Y+10,R30
; 0007 0271    E2pWriteLen((BYTE*)&mEDat, E_EP_MODE, sizeof( EEPROM_BODY));
	MOVW R30,R28
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R26,LOW(11)
	CALL _E2pWriteLen
; 0007 0272 }
	ADIW R28,11
	RET
; .FEND
;
;void LoadInEeprom( void )
; 0007 0275 {
_LoadInEeprom:
; .FSTART _LoadInEeprom
; 0007 0276    BYTE mData[20];
; 0007 0277    LPEEPROM_BODY mEDat;
; 0007 0278 
; 0007 0279    memset((void *)&mData,0 ,20 );
	SBIW R28,20
	ST   -Y,R17
	ST   -Y,R16
;	mData -> Y+2
;	*mEDat -> R16,R17
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(0)
	ST   -Y,R30
	LDI  R26,LOW(20)
	LDI  R27,0
	CALL _memset
; 0007 027A    E2pReadLen( mData, E_EP_MODE, sizeof( EEPROM_BODY));
	MOVW R30,R28
	ADIW R30,2
	ST   -Y,R31
	ST   -Y,R30
	LDI  R30,LOW(10)
	ST   -Y,R30
	LDI  R26,LOW(11)
	CALL _E2pReadLen
; 0007 027B    mEDat =(LPEEPROM_BODY)mData ;
	MOVW R30,R28
	ADIW R30,2
	MOVW R16,R30
; 0007 027C 
; 0007 027D    if( mEDat->AkFlag == 'A' )
	MOVW R26,R16
	LD   R26,X
	CPI  R26,LOW(0x41)
	BREQ PC+2
	RJMP _0xE006A
; 0007 027E    {
; 0007 027F       gMode = 0; //= mEDat->Mode;
	LDI  R30,LOW(0)
	STS  _gMode,R30
; 0007 0280       //gRunFlag = mEDat->Run?TRUE:FALSE;
; 0007 0281       gDose = (int)mEDat->Dose1<<8|mEDat->Dose2;
	MOVW R30,R16
	LDD  R30,Z+3
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	MOVW R30,R16
	LDD  R30,Z+4
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	CALL SUBOPT_0x6
; 0007 0282       if( gDose < 0 ) gDose = 0;
	LDS  R26,_gDose+1
	TST  R26
	BRPL _0xE006B
	CALL SUBOPT_0x7
; 0007 0283       if( gDose > 3 ) gDose = 3;
_0xE006B:
	LDS  R26,_gDose
	LDS  R27,_gDose+1
	SBIW R26,4
	BRLT _0xE006C
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	CALL SUBOPT_0x6
; 0007 0284 
; 0007 0285       gVoltage = mEDat->Voltage;
_0xE006C:
	MOVW R30,R16
	LDD  R30,Z+5
	CALL SUBOPT_0x8
; 0007 0286       if( gVoltage < 60 ) gVoltage = 60;
	BRGE _0xE006D
	CALL SUBOPT_0x9
; 0007 0287       if( gVoltage > 120 ) gVoltage = 120;
_0xE006D:
	CALL SUBOPT_0xA
	CPI  R26,LOW(0x79)
	LDI  R30,HIGH(0x79)
	CPC  R27,R30
	BRLT _0xE006E
	CALL SUBOPT_0xB
; 0007 0288 
; 0007 0289       gDepth = mEDat->Depth;
_0xE006E:
	MOVW R30,R16
	LDD  R30,Z+6
	CALL SUBOPT_0xC
; 0007 028A       if( gDepth < 0 ) gDepth = 0;
	BRPL _0xE006F
	CALL SUBOPT_0xD
; 0007 028B       if( gDepth > 3 ) gDepth = 3;
_0xE006F:
	LDS  R26,_gDepth
	LDS  R27,_gDepth+1
	SBIW R26,4
	BRLT _0xE0070
	CALL SUBOPT_0xE
; 0007 028C 
; 0007 028D       gSpeed = mEDat->Speed;
_0xE0070:
	MOVW R30,R16
	LDD  R30,Z+7
	CALL SUBOPT_0xF
; 0007 028E       if( gSpeed < 0 ) gSpeed = 0;
	BRPL _0xE0071
	LDI  R30,LOW(0)
	STS  _gSpeed,R30
	STS  _gSpeed+1,R30
; 0007 028F       if( gSpeed > 2 ) gSpeed = 2;
_0xE0071:
	LDS  R26,_gSpeed
	LDS  R27,_gSpeed+1
	SBIW R26,3
	BRLT _0xE0072
	CALL SUBOPT_0x10
; 0007 0290 
; 0007 0291       gFlag = mEDat->Flag;
_0xE0072:
	MOVW R30,R16
	LDD  R30,Z+8
	STS  _gFlag,R30
; 0007 0292       gElMatrix[0] = (mEDat->Map1>>4)&0x0f;
	MOVW R30,R16
	LDD  R30,Z+9
	SWAP R30
	ANDI R30,LOW(0xF)
	STS  _gElMatrix,R30
; 0007 0293       gElMatrix[1] = mEDat->Map1&0x0f;
	MOVW R30,R16
	LDD  R26,Z+9
	LDI  R30,LOW(15)
	AND  R30,R26
	__PUTB1MN _gElMatrix,1
; 0007 0294       gElMatrix[2] = (mEDat->Map2>>4)&0x0f;
	MOVW R30,R16
	LDD  R30,Z+10
	SWAP R30
	ANDI R30,LOW(0xF)
	__PUTB1MN _gElMatrix,2
; 0007 0295       gElMatrix[3] = mEDat->Map2&0x0f;
	MOVW R30,R16
	LDD  R26,Z+10
	LDI  R30,LOW(15)
	AND  R30,R26
	__PUTB1MN _gElMatrix,3
; 0007 0296 
; 0007 0297       if( gVoltage > 50 ) LOW_VOLRY;
	CALL SUBOPT_0xA
	SBIW R26,51
	BRLT _0xE0073
	CBI  0x12,7
; 0007 0298       else  HIGH_VOLRY;
	RJMP _0xE0076
_0xE0073:
	SBI  0x12,7
; 0007 0299    }
_0xE0076:
; 0007 029A    else
	RJMP _0xE0079
_0xE006A:
; 0007 029B    {
; 0007 029C       InitData();
	RCALL _InitData
; 0007 029D       SaveInEeprom();
	RCALL _SaveInEeprom
; 0007 029E    }
_0xE0079:
; 0007 029F }
	LDD  R17,Y+1
	LDD  R16,Y+0
	ADIW R28,22
	RET
; .FEND
;
;void ADCProcessor( void )
; 0007 02A2 {
_ADCProcessor:
; .FSTART _ADCProcessor
; 0007 02A3    // 0: Heat Protect
; 0007 02A4    // 1: output voltage
; 0007 02A5    // 2: elect current
; 0007 02A6    int mIndexVol=0;
; 0007 02A7    int mVol;
; 0007 02A8    int mTemp;
; 0007 02A9    float mCalvol;
; 0007 02AA    mVol= read_adc( gAdcLoc );
	SBIW R28,4
	CALL __SAVELOCR6
;	mIndexVol -> R16,R17
;	mVol -> R18,R19
;	mTemp -> R20,R21
;	mCalvol -> Y+6
	__GETWRN 16,17,0
	LDS  R26,_gAdcLoc
	RCALL _read_adc
	MOVW R18,R30
; 0007 02AB 
; 0007 02AC    if( gAdcLoc == 0 )
	LDS  R30,_gAdcLoc
	LDS  R31,_gAdcLoc+1
	SBIW R30,0
	BRNE _0xE007A
; 0007 02AD    {
; 0007 02AE       if( mVol > 25)
	__CPWRN 18,19,26
	BRLT _0xE007B
; 0007 02AF       {
; 0007 02B0          gError |= (1<<ERROR_HEATSINK);  //2.5V
	LDS  R30,_gError
	ORI  R30,0x10
	CALL SUBOPT_0x2E
; 0007 02B1          gCurMode =  CUR_ERROR;
; 0007 02B2       }
; 0007 02B3       else
	RJMP _0xE007C
_0xE007B:
; 0007 02B4       {
; 0007 02B5          gError &= ~(1<<ERROR_HEATSINK);  //2.5V
	LDS  R30,_gError
	ANDI R30,0xEF
	STS  _gError,R30
; 0007 02B6       }
_0xE007C:
; 0007 02B7    }
; 0007 02B8    else if( gAdcLoc == 1 )
	RJMP _0xE007D
_0xE007A:
	CALL SUBOPT_0x4C
	SBIW R26,1
	BREQ PC+2
	RJMP _0xE007E
; 0007 02B9    {
; 0007 02BA       if( gMode == MODE_READY && gFlag == FLAG_VOLADJ )
	LDS  R26,_gMode
	CPI  R26,LOW(0x1)
	BRNE _0xE0080
	LDS  R26,_gFlag
	CPI  R26,LOW(0x1)
	BREQ _0xE0081
_0xE0080:
	RJMP _0xE007F
_0xE0081:
; 0007 02BB       {
; 0007 02BC 
; 0007 02BD         if( gVoltage> 50 )
	CALL SUBOPT_0xA
	SBIW R26,51
	BRGE PC+2
	RJMP _0xE0082
; 0007 02BE         {
; 0007 02BF            if( gVolChkCount > 0 )
	CALL SUBOPT_0x4D
	BRGE _0xE0083
; 0007 02C0            {
; 0007 02C1               gVolChkCount--;
	LDI  R26,LOW(_gVolChkCount)
	LDI  R27,HIGH(_gVolChkCount)
	CALL SUBOPT_0x48
; 0007 02C2            }
; 0007 02C3            else   //2*600ms = 1.2sec
	RJMP _0xE0084
_0xE0083:
; 0007 02C4            {
; 0007 02C5               if(gVoltage < 20 ) mIndexVol = 0;
	CALL SUBOPT_0xA
	SBIW R26,20
	BRGE _0xE0085
	__GETWRN 16,17,0
; 0007 02C6               else  mIndexVol = (gVoltage-20)/10;
	RJMP _0xE0086
_0xE0085:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x2
	MOVW R16,R30
; 0007 02C7 
; 0007 02C8               mCalvol = DacArray[mIndexVol];
_0xE0086:
	CALL SUBOPT_0x4E
; 0007 02C9 
; 0007 02CA               //gReadVol =(int)(60.0f+(float)mVol*2.2f);
; 0007 02CB 
; 0007 02CC               if( (float)mVol > (mCalvol-mCalvol*0.2f) &&
; 0007 02CD                   (float)mVol < (mCalvol+mCalvol*0.2f) )
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x4F
	CALL SUBOPT_0x50
	CALL __SWAPD12
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0xE0088
	CALL SUBOPT_0x3
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x51
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CMPF12
	BRLO _0xE0089
_0xE0088:
	RJMP _0xE0087
_0xE0089:
; 0007 02CE               {
; 0007 02CF 
; 0007 02D0                  gFlag = FLAG_READY;
	CALL SUBOPT_0x52
; 0007 02D1                  if( gError & (1<<ERROR_VOL) )
	BREQ _0xE008A
; 0007 02D2                  {
; 0007 02D3                      gVolAdjCount++; //300ms
	CALL SUBOPT_0x53
; 0007 02D4                      if( gVolAdjCount > 3 )  //300ms*3
	CALL SUBOPT_0x54
	BRLT _0xE008B
; 0007 02D5                      {
; 0007 02D6                         gVolAdjCount = 0;
	CALL SUBOPT_0x55
; 0007 02D7                         gError &= ~(1<<ERROR_VOL);  //2.5V
	ANDI R30,0xFE
	STS  _gError,R30
; 0007 02D8                      }
; 0007 02D9                  }
_0xE008B:
; 0007 02DA                  else
	RJMP _0xE008C
_0xE008A:
; 0007 02DB                  {
; 0007 02DC                     gError &= ~(1<<ERROR_VOL);  //2.5V
	LDS  R30,_gError
	ANDI R30,0xFE
	STS  _gError,R30
; 0007 02DD                  }
_0xE008C:
; 0007 02DE               }
; 0007 02DF               else
	RJMP _0xE008D
_0xE0087:
; 0007 02E0               {
; 0007 02E1                  gFlag = FLAG_VOLADJ;
	LDI  R30,LOW(1)
	STS  _gFlag,R30
; 0007 02E2                  gVolAdjCount++; //300ms
	CALL SUBOPT_0x53
; 0007 02E3                  if( gVolAdjCount > 3 )  //300ms*3
	CALL SUBOPT_0x54
	BRLT _0xE008E
; 0007 02E4                 {
; 0007 02E5                     gVolAdjCount = 0;
	CALL SUBOPT_0x55
; 0007 02E6                     gError |= (1<<ERROR_VOL);
	ORI  R30,1
	CALL SUBOPT_0x2E
; 0007 02E7                     gCurMode =  CUR_ERROR;
; 0007 02E8                 }
; 0007 02E9               }
_0xE008E:
_0xE008D:
; 0007 02EA            }
_0xE0084:
; 0007 02EB          }
; 0007 02EC          else
	RJMP _0xE008F
_0xE0082:
; 0007 02ED          {
; 0007 02EE            if( gVolChkCount > 0 )
	CALL SUBOPT_0x4D
	BRGE _0xE0090
; 0007 02EF            {
; 0007 02F0               gVolChkCount--;
	LDI  R26,LOW(_gVolChkCount)
	LDI  R27,HIGH(_gVolChkCount)
	CALL SUBOPT_0x48
; 0007 02F1            }
; 0007 02F2            else
	RJMP _0xE0091
_0xE0090:
; 0007 02F3            {
; 0007 02F4               if(gVoltage < 20 ) mIndexVol = 0;
	CALL SUBOPT_0xA
	SBIW R26,20
	BRGE _0xE0092
	__GETWRN 16,17,0
; 0007 02F5               else  mIndexVol = (gVoltage-20)/10;
	RJMP _0xE0093
_0xE0092:
	CALL SUBOPT_0xA
	CALL SUBOPT_0x2
	MOVW R16,R30
; 0007 02F6 
; 0007 02F7               mCalvol = DacArray[mIndexVol];
_0xE0093:
	CALL SUBOPT_0x4E
; 0007 02F8 
; 0007 02F9              // mTemp = LowVolAdj[gVoltage/10-2];
; 0007 02FA              // gReadVol =(int)(mTemp+20.0f+(float)mVol*0.68f);
; 0007 02FB               if( (float)mVol > (mCalvol-mCalvol*0.2f) &&
; 0007 02FC                   (float)mVol < (mCalvol+mCalvol*0.2f) )
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x51
	CALL __SWAPD12
	CALL __SUBF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CMPF12
	BREQ PC+2
	BRCC PC+2
	RJMP _0xE0095
	CALL SUBOPT_0x3
	PUSH R23
	PUSH R22
	PUSH R31
	PUSH R30
	CALL SUBOPT_0x51
	CALL __ADDF12
	POP  R26
	POP  R27
	POP  R24
	POP  R25
	CALL __CMPF12
	BRLO _0xE0096
_0xE0095:
	RJMP _0xE0094
_0xE0096:
; 0007 02FD               {
; 0007 02FE                  gFlag = FLAG_READY;
	CALL SUBOPT_0x52
; 0007 02FF                  if( gError & (1<<ERROR_VOL) )
	BREQ _0xE0097
; 0007 0300                  {
; 0007 0301                     gVolAdjCount++; //300ms
	CALL SUBOPT_0x53
; 0007 0302                     if( gVolAdjCount > 3 )  //300ms*3
	CALL SUBOPT_0x54
	BRLT _0xE0098
; 0007 0303                     {
; 0007 0304                       gVolAdjCount = 0;
	CALL SUBOPT_0x55
; 0007 0305                       gError &= ~(1<<ERROR_VOL);  //2.5V
	ANDI R30,0xFE
	STS  _gError,R30
; 0007 0306                     }
; 0007 0307                  }
_0xE0098:
; 0007 0308                  else
	RJMP _0xE0099
_0xE0097:
; 0007 0309                  {
; 0007 030A                    gError &= ~(1<<ERROR_VOL);  //2.5V
	LDS  R30,_gError
	ANDI R30,0xFE
	STS  _gError,R30
; 0007 030B                  }
_0xE0099:
; 0007 030C               }
; 0007 030D               else
	RJMP _0xE009A
_0xE0094:
; 0007 030E               {
; 0007 030F                 gFlag = FLAG_VOLADJ;
	LDI  R30,LOW(1)
	STS  _gFlag,R30
; 0007 0310                 gVolAdjCount++; //300ms
	CALL SUBOPT_0x53
; 0007 0311                 if( gVolAdjCount > 3 )  //300ms*3
	CALL SUBOPT_0x54
	BRLT _0xE009B
; 0007 0312                 {
; 0007 0313                    gVolAdjCount = 0;
	CALL SUBOPT_0x55
; 0007 0314                    gError |= (1<<ERROR_VOL);
	ORI  R30,1
	CALL SUBOPT_0x2E
; 0007 0315                    gCurMode =  CUR_ERROR;
; 0007 0316                 }
; 0007 0317               }
_0xE009B:
_0xE009A:
; 0007 0318            }
_0xE0091:
; 0007 0319          }
_0xE008F:
; 0007 031A       }
; 0007 031B       else
	RJMP _0xE009C
_0xE007F:
; 0007 031C       {
; 0007 031D           gVolAdjCount = 0; //2020-09-04
	LDI  R30,LOW(0)
	STS  _gVolAdjCount,R30
	STS  _gVolAdjCount+1,R30
; 0007 031E       }
_0xE009C:
; 0007 031F    }
; 0007 0320    else if( gAdcLoc == 2 )
	RJMP _0xE009D
_0xE007E:
	CALL SUBOPT_0x4C
	SBIW R26,2
	BRNE _0xE009E
; 0007 0321    {
; 0007 0322       if( gRunFlag==TRUE && gElCompletFlag == TRUE )
	LDS  R26,_gRunFlag
	CPI  R26,LOW(0x1)
	BRNE _0xE00A0
	LDS  R26,_gElCompletFlag
	CPI  R26,LOW(0x1)
	BREQ _0xE00A1
_0xE00A0:
	RJMP _0xE009F
_0xE00A1:
; 0007 0323       {
; 0007 0324          gRunFlag = FALSE;
	LDI  R30,LOW(0)
	STS  _gRunFlag,R30
; 0007 0325          if( mVol > 25)
	__CPWRN 18,19,26
	BRLT _0xE00A2
; 0007 0326          {
; 0007 0327             gError &= ~(1<<ERROR_ELOUT);  //2.5V
	LDS  R30,_gError
	ANDI R30,0xFD
	STS  _gError,R30
; 0007 0328 
; 0007 0329             gElCount++;
	LDI  R26,LOW(_gElCount)
	LDI  R27,HIGH(_gElCount)
	CALL SUBOPT_0x35
; 0007 032A             if( gElCount > 999 ) gElCount = 999;
	LDS  R26,_gElCount
	LDS  R27,_gElCount+1
	CPI  R26,LOW(0x3E8)
	LDI  R30,HIGH(0x3E8)
	CPC  R27,R30
	BRLT _0xE00A3
	LDI  R30,LOW(999)
	LDI  R31,HIGH(999)
	CALL SUBOPT_0x11
; 0007 032B             HIGH_COMPLETE_LED;
_0xE00A3:
	LDS  R30,98
	ORI  R30,0x80
	STS  98,R30
; 0007 032C          }
; 0007 032D          else
	RJMP _0xE00A4
_0xE00A2:
; 0007 032E          {
; 0007 032F             gError |= (1<<ERROR_ELOUT);  //2.5V
	LDS  R30,_gError
	ORI  R30,2
	CALL SUBOPT_0x2E
; 0007 0330             gCurMode =  CUR_ERROR;
; 0007 0331 
; 0007 0332            // LOW_COMPLETE_LED;
; 0007 0333          }
_0xE00A4:
; 0007 0334          HIGH_SH;
	SBI  0x18,6
; 0007 0335       }
; 0007 0336    }
_0xE009F:
; 0007 0337    gAdcLoc++;
_0xE009E:
_0xE009D:
_0xE007D:
	LDI  R26,LOW(_gAdcLoc)
	LDI  R27,HIGH(_gAdcLoc)
	CALL SUBOPT_0x35
; 0007 0338    if( gAdcLoc > 2 ) gAdcLoc = 0;
	CALL SUBOPT_0x4C
	SBIW R26,3
	BRLT _0xE00A7
	LDI  R30,LOW(0)
	STS  _gAdcLoc,R30
	STS  _gAdcLoc+1,R30
; 0007 0339 }
_0xE00A7:
	CALL __LOADLOCR6
	ADIW R28,10
	RET
; .FEND
;
;void DisplayLed( void )
; 0007 033C {
_DisplayLed:
; .FSTART _DisplayLed
; 0007 033D     if( gError > ERROR_NO )
	LDS  R26,_gError
	CPI  R26,LOW(0x1)
	BRLO _0xE00A8
; 0007 033E     {
; 0007 033F        HIGH_WARRING_LED;
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
; 0007 0340        LOW_COMPLETE_LED;
	RJMP _0xE00C0
; 0007 0341     }
; 0007 0342     else
_0xE00A8:
; 0007 0343     {
; 0007 0344        LOW_WARRING_LED;
	LDS  R30,98
	ANDI R30,0xBF
	STS  98,R30
; 0007 0345 
; 0007 0346        if( gFlag == FLAG_COMPLETE )
	LDS  R26,_gFlag
	CPI  R26,LOW(0x4)
	BRNE _0xE00AA
; 0007 0347              HIGH_COMPLETE_LED;
	LDS  R30,98
	ORI  R30,0x80
	RJMP _0xE00C1
; 0007 0348        else  LOW_COMPLETE_LED;
_0xE00AA:
_0xE00C0:
	LDS  R30,98
	ANDI R30,0x7F
_0xE00C1:
	STS  98,R30
; 0007 0349     }
; 0007 034A }
	RET
; .FEND
;void UserProcessor( void )
; 0007 034C {
_UserProcessor:
; .FSTART _UserProcessor
; 0007 034D    if( gCurMode == CUR_INIT )
	LDS  R30,_gCurMode
	CPI  R30,0
	BRNE _0xE00AC
; 0007 034E    {
; 0007 034F       DAC7611_WriteVoltage(0);
	LDI  R26,LOW(0)
	LDI  R27,0
	CALL SUBOPT_0x2A
; 0007 0350       LOW_PWM;
	ANDI R30,0XF7
	STS  101,R30
; 0007 0351       LOW_OUTRY;
	LDS  R30,101
	ANDI R30,0xEF
	STS  101,R30
; 0007 0352       gMode = MODE_STOP;
	LDI  R30,LOW(0)
	STS  _gMode,R30
; 0007 0353       gFlag = FLAG_STADNBY;
	STS  _gFlag,R30
; 0007 0354 
; 0007 0355       gCurMode = CUR_OK;
	LDI  R30,LOW(1)
	STS  _gCurMode,R30
; 0007 0356 
; 0007 0357      // LOW_COMPLETE_LED;
; 0007 0358      // LOW_WARRING_LED;
; 0007 0359    }
; 0007 035A    else if( gCurMode == CUR_OK )
	RJMP _0xE00AD
_0xE00AC:
	LDS  R26,_gCurMode
	CPI  R26,LOW(0x1)
	BRNE _0xE00AE
; 0007 035B    {
; 0007 035C        ADCProcessor();
	RCALL _ADCProcessor
; 0007 035D        DisplayLed();
	RCALL _DisplayLed
; 0007 035E    }
; 0007 035F    else if( gCurMode == CUR_ERROR )
	RJMP _0xE00AF
_0xE00AE:
	LDS  R26,_gCurMode
	CPI  R26,LOW(0x2)
	BRNE _0xE00B0
; 0007 0360    {
; 0007 0361        gCurMode = CUR_INIT;
	LDI  R30,LOW(0)
	STS  _gCurMode,R30
; 0007 0362        // gInitCount = 0;
; 0007 0363        LOW_COMPLETE_LED;
	LDS  R30,98
	ANDI R30,0x7F
	STS  98,R30
; 0007 0364        HIGH_WARRING_LED;
	LDS  R30,98
	ORI  R30,0x40
	STS  98,R30
; 0007 0365    }
; 0007 0366 }
_0xE00B0:
_0xE00AF:
_0xE00AD:
	RET
; .FEND
;
;void main()
; 0007 0369 {
_main:
; .FSTART _main
; 0007 036A    BYTE wEvent;
; 0007 036B    int mTimeUart0,mTimeUart1;
; 0007 036C 
; 0007 036D    SystemInit( );
;	wEvent -> R17
;	mTimeUart0 -> R18,R19
;	mTimeUart1 -> R20,R21
	RCALL _SystemInit
; 0007 036E 
; 0007 036F    mTimeUart0 = mTimeUart1 = 0;
	LDI  R30,LOW(0)
	LDI  R31,HIGH(0)
	MOVW R20,R30
	MOVW R18,R30
; 0007 0370    // Global enable interrupts
; 0007 0371    #asm("sei");
	sei
; 0007 0372 
; 0007 0373    while ( TRUE )
_0xE00B1:
; 0007 0374    {
; 0007 0375       wEvent = WaitEvent();
	RCALL _WaitEvent
	MOV  R17,R30
; 0007 0376       if( wEvent == EVN_RCVUART0 )
	CPI  R17,1
	BRNE _0xE00B4
; 0007 0377       {
; 0007 0378           IPC_RunProcess0( );  //handle
	CALL _IPC_RunProcess0
; 0007 0379           mTimeUart0 = 0;
	__GETWRN 18,19,0
; 0007 037A           gError &= ~(1<<ERROR_NOTHANDLE);
	LDS  R30,_gError
	ANDI R30,0xDF
	STS  _gError,R30
; 0007 037B       }
; 0007 037C       else if( wEvent == EVN_RCVUART1 )
	RJMP _0xE00B5
_0xE00B4:
	CPI  R17,2
	BRNE _0xE00B6
; 0007 037D       {
; 0007 037E           IPC_RunProcess1( );  //LCD Pannel
	CALL _IPC_RunProcess1
; 0007 037F           mTimeUart1 = 0;
	__GETWRN 20,21,0
; 0007 0380           gError &= ~(1<<ERROR_NOTLCD);
	LDS  R30,_gError
	ANDI R30,0xBF
	STS  _gError,R30
; 0007 0381       }
; 0007 0382       else if(wEvent == EVN_TIMEOVER )
	RJMP _0xE00B7
_0xE00B6:
	CPI  R17,3
	BRNE _0xE00B8
; 0007 0383       {
; 0007 0384         UserProcessor();
	RCALL _UserProcessor
; 0007 0385 
; 0007 0386         if( ++mTimeUart0 > 7 ) //2.1sec
	MOVW R30,R18
	ADIW R30,1
	MOVW R18,R30
	SBIW R30,8
	BRLT _0xE00B9
; 0007 0387         {
; 0007 0388             mTimeUart0 = 0;
	__GETWRN 18,19,0
; 0007 0389             gError |= (1<<ERROR_NOTHANDLE);
	LDS  R30,_gError
	ORI  R30,0x20
	CALL SUBOPT_0x2E
; 0007 038A             gCurMode = CUR_ERROR;
; 0007 038B         }
; 0007 038C         if( ++mTimeUart1 > 7 ) //2.1sec
_0xE00B9:
	MOVW R30,R20
	ADIW R30,1
	MOVW R20,R30
	SBIW R30,8
	BRLT _0xE00BA
; 0007 038D         {
; 0007 038E             mTimeUart1 = 0;
	__GETWRN 20,21,0
; 0007 038F             gError |= (1<<ERROR_NOTLCD);
	LDS  R30,_gError
	ORI  R30,0x40
	CALL SUBOPT_0x2E
; 0007 0390             gCurMode = CUR_ERROR;
; 0007 0391         }
; 0007 0392 
; 0007 0393         //yjw add 2021.04.03
; 0007 0394         //set volatge2
; 0007 0395         if(!gSetVolagteInitTime &&  gRunFlag==FALSE)
_0xE00BA:
	LDS  R30,_gSetVolagteInitTime
	LDS  R31,_gSetVolagteInitTime+1
	SBIW R30,0
	BRNE _0xE00BC
	LDS  R26,_gRunFlag
	CPI  R26,LOW(0x0)
	BREQ _0xE00BD
_0xE00BC:
	RJMP _0xE00BB
_0xE00BD:
; 0007 0396         {
; 0007 0397             if( IN_FET_SEN )
	SBIS 0x10,4
	RJMP _0xE00BE
; 0007 0398             {
; 0007 0399                 PORTC = 0x00;
	LDI  R30,LOW(0)
	OUT  0x15,R30
; 0007 039A                 gError |= (1<<ERROR_VOL);
	LDS  R30,_gError
	ORI  R30,1
	CALL SUBOPT_0x2E
; 0007 039B                 gCurMode =  CUR_ERROR;
; 0007 039C             }
; 0007 039D         }
_0xE00BE:
; 0007 039E 
; 0007 039F 
; 0007 03A0       }
_0xE00BB:
; 0007 03A1    }
_0xE00B8:
_0xE00B7:
_0xE00B5:
	RJMP _0xE00B1
; 0007 03A2 }
_0xE00BF:
	RJMP _0xE00BF
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
_memset:
; .FSTART _memset
	ST   -Y,R27
	ST   -Y,R26
    ldd  r27,y+1
    ld   r26,y
    adiw r26,0
    breq memset1
    ldd  r31,y+4
    ldd  r30,y+3
    ldd  r22,y+2
memset0:
    st   z+,r22
    sbiw r26,1
    brne memset0
memset1:
    ldd  r30,y+3
    ldd  r31,y+4
_0x20A0001:
	ADIW R28,5
	RET
; .FEND

	.CSEG

	.CSEG

	.CSEG

	.DSEG

	.CSEG

	.DSEG
_gElMatrix:
	.BYTE 0x4
_goldTime1ms:
	.BYTE 0x2
_gTime1ms:
	.BYTE 0x2
_gVoltage:
	.BYTE 0x2
_gMode:
	.BYTE 0x1
_gRunFlag:
	.BYTE 0x1
_gDose:
	.BYTE 0x2
_gDepth:
	.BYTE 0x2
_gSpeed:
	.BYTE 0x2
_gFlag:
	.BYTE 0x1
_gError:
	.BYTE 0x1
_gMotorPos1:
	.BYTE 0x2
_gMotorPos2:
	.BYTE 0x2
_gElCompletFlag:
	.BYTE 0x1
_gElCount:
	.BYTE 0x2
_gCurMode:
	.BYTE 0x1
_gReadyActionFlag:
	.BYTE 0x1
_gVolChkCount:
	.BYTE 0x2
_IPC1Rcvfun:
	.BYTE 0x18
_IPC1Sndfun:
	.BYTE 0x18
_IPC0Rcvfun:
	.BYTE 0x18
_IPC0Sndfun:
	.BYTE 0x18
_rx_buffer0:
	.BYTE 0xFA
_rx_buffer1:
	.BYTE 0xFA
_gAdcLoc:
	.BYTE 0x2
_gElLoc:
	.BYTE 0x2
_gCurState:
	.BYTE 0x2
_gCalValue0:
	.BYTE 0x2
_gCalValue1:
	.BYTE 0x2
_gDutyOff:
	.BYTE 0x2
_gShotCnt:
	.BYTE 0x1
_gShotWaitTime:
	.BYTE 0x2
_gShotGapWaitTime:
	.BYTE 0x2
_gSetVolagteInitTime:
	.BYTE 0x2
_gShift:
	.BYTE 0x2
_gVolAdjCount:
	.BYTE 0x2
_gGenMode:
	.BYTE 0x1
__seed_G104:
	.BYTE 0x4

	.CSEG
;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x0:
	ST   -Y,R17
	ST   -Y,R16
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x1:
	ST   -Y,R27
	ST   -Y,R26
	CALL __SAVELOCR4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2:
	SBIW R26,20
	LDI  R30,LOW(10)
	LDI  R31,HIGH(10)
	CALL __DIVW21
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 5 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x3:
	MOVW R30,R18
	CALL __CWD1
	CALL __CDF1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x4:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	LDD  R30,Y+1
	LDD  R31,Y+1+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x5:
	ST   -Y,R27
	ST   -Y,R26
	LD   R30,Y
	LDD  R31,Y+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x6:
	STS  _gDose,R30
	STS  _gDose+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x7:
	LDI  R30,LOW(0)
	STS  _gDose,R30
	STS  _gDose+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x8:
	LDI  R31,0
	STS  _gVoltage,R30
	STS  _gVoltage+1,R31
	LDS  R26,_gVoltage
	LDS  R27,_gVoltage+1
	SBIW R26,60
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x9:
	LDI  R30,LOW(60)
	LDI  R31,HIGH(60)
	STS  _gVoltage,R30
	STS  _gVoltage+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 11 TIMES, CODE SIZE REDUCTION:17 WORDS
SUBOPT_0xA:
	LDS  R26,_gVoltage
	LDS  R27,_gVoltage+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xB:
	LDI  R30,LOW(120)
	LDI  R31,HIGH(120)
	STS  _gVoltage,R30
	STS  _gVoltage+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xC:
	LDI  R31,0
	STS  _gDepth,R30
	STS  _gDepth+1,R31
	LDS  R26,_gDepth+1
	TST  R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xD:
	LDI  R30,LOW(0)
	STS  _gDepth,R30
	STS  _gDepth+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0xE:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	STS  _gDepth,R30
	STS  _gDepth+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0xF:
	LDI  R31,0
	STS  _gSpeed,R30
	STS  _gSpeed+1,R31
	LDS  R26,_gSpeed+1
	TST  R26
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x10:
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	STS  _gSpeed,R30
	STS  _gSpeed+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x11:
	STS  _gElCount,R30
	STS  _gElCount+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x12:
	ST   -Y,R27
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x13:
	MOV  R30,R17
	LDI  R26,LOW(1)
	CALL __LSLB12
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 9 TIMES, CODE SIZE REDUCTION:61 WORDS
SUBOPT_0x14:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,2
	LDI  R30,LOW(128)
	ST   X,R30
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x15:
	ST   X,R30
	LDS  R30,_gMode
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 25 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x16:
	LD   R30,Y
	LDD  R31,Y+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 13 TIMES, CODE SIZE REDUCTION:93 WORDS
SUBOPT_0x17:
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _MakeCrc
	__PUTB1SNS 0,5
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x18:
	LDI  R30,LOW(1)
	ST   X,R30
	LDS  R30,_gRunFlag
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 15 TIMES, CODE SIZE REDUCTION:67 WORDS
SUBOPT_0x19:
	ST   -Y,R27
	ST   -Y,R26
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,2
	LDI  R30,LOW(128)
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1A:
	LDS  R30,_gDose
	LDS  R31,_gDose+1
	CALL __ASRW8
	__PUTB1SNS 0,3
	LDS  R30,_gDose
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1B:
	LDS  R30,_gVoltage
	LDS  R31,_gVoltage+1
	CALL __ASRW8
	__PUTB1SNS 0,3
	LDS  R30,_gVoltage
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1C:
	LDS  R30,_gDepth
	LDS  R31,_gDepth+1
	CALL __ASRW8
	__PUTB1SNS 0,3
	LDS  R30,_gDepth
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1D:
	LDS  R30,_gSpeed
	LDS  R31,_gSpeed+1
	CALL __ASRW8
	__PUTB1SNS 0,3
	LDS  R30,_gSpeed
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x1E:
	LDS  R30,_gElCount
	LDS  R31,_gElCount+1
	CALL __ASRW8
	__PUTB1SNS 0,3
	LDS  R30,_gElCount
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x1F:
	__PUTB1SNS 0,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x20:
	LDS  R30,_gFlag
	__PUTB1SNS 0,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x21:
	__PUTB1SNS 0,4
	RJMP SUBOPT_0x16

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x22:
	SBIW R28,30
	CALL __SAVELOCR6
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x23:
	MOV  R17,R30
	MOVW R30,R28
	ADIW R30,6
	MOVW R20,R30
	MOVW R30,R28
	ADIW R30,6
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _MakeCrc
	MOV  R16,R30
	MOVW R30,R20
	LDD  R19,Z+5
	CPI  R17,7
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x24:
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(129)
	JMP  _IPC_Send_Response1

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:26 WORDS
SUBOPT_0x25:
	ST   -Y,R26
	ST   -Y,R17
	ST   -Y,R16
	__GETWRS 16,17,3
	LDD  R30,Y+2
	__PUTB1RNS 16,2
	MOVW R26,R16
	ADIW R26,3
	LDI  R30,LOW(0)
	ST   X,R30
	MOVW R26,R16
	ADIW R26,4
	ST   X,R30
	ST   -Y,R17
	ST   -Y,R16
	LDI  R26,LOW(5)
	LDI  R27,0
	CALL _MakeCrc
	__PUTB1RNS 16,5
	LDD  R30,Y+3
	LDD  R31,Y+3+1
	ST   -Y,R31
	ST   -Y,R30
	LDI  R26,LOW(7)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x26:
	__GETWRS 16,17,2
	MOVW R30,R16
	LDD  R26,Z+2
	CPI  R26,LOW(0xC)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x27:
	LDI  R31,0
	LSL  R30
	ROL  R31
	ADD  R26,R30
	ADC  R27,R31
	CALL __GETW1P
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 7 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x28:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	ST   -Y,R31
	ST   -Y,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x29:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	RJMP SUBOPT_0x24

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x2A:
	CALL _DAC7611_WriteVoltage
	LDS  R30,101
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x2B:
	LDI  R30,LOW(0)
	OUT  0x15,R30
	LDI  R26,LOW(0)
	LDI  R27,0
	RJMP SUBOPT_0x2A

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x2C:
	ANDI R30,0XF7
	STS  101,R30
	LDS  R30,101
	ANDI R30,0xEF
	STS  101,R30
	LDI  R30,LOW(0)
	STS  _gFlag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:8 WORDS
SUBOPT_0x2D:
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R30,Z+3
	MOV  R31,R30
	LDI  R30,0
	MOVW R26,R30
	LDD  R30,Y+2
	LDD  R31,Y+2+1
	LDD  R30,Z+4
	LDI  R31,0
	OR   R30,R26
	OR   R31,R27
	MOVW R16,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:18 WORDS
SUBOPT_0x2E:
	STS  _gError,R30
	LDI  R30,LOW(2)
	STS  _gCurMode,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x2F:
	LDI  R30,LOW(0)
	ST   X,R30
	LD   R26,Y
	LDD  R27,Y+1
	ADIW R26,4
	ST   X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x30:
	ST   -Y,R30
	ST   -Y,R31
	IN   R30,SREG
	ST   -Y,R30
	ST   -Y,R17
	ST   -Y,R16
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x31:
	ST   -Y,R26
	CALL __SAVELOCR4
	LDI  R17,0
	LDI  R16,0
	__GETWRMN 18,19,0,_gTime1ms
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x32:
	MOV  R30,R17
	LDD  R26,Y+5
	LDD  R27,Y+5+1
	LDI  R31,0
	ADD  R30,R26
	ADC  R31,R27
	ST   Z,R16
	SUBI R17,-1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x33:
	LDS  R26,_gTime1ms
	LDS  R27,_gTime1ms+1
	SUB  R26,R18
	SBC  R27,R19
	CPI  R26,LOW(0xBB9)
	LDI  R30,HIGH(0xBB9)
	CPC  R27,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x34:
	MOV  R30,R17
	SUBI R17,-1
	LDD  R26,Y+2
	LDD  R27,Y+2+1
	LDI  R31,0
	ADD  R26,R30
	ADC  R27,R31
	LD   R26,X
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 17 TIMES, CODE SIZE REDUCTION:45 WORDS
SUBOPT_0x35:
	LD   R30,X+
	LD   R31,X+
	ADIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x36:
	LDI  R30,LOW(224)
	OUT  0x2D,R30
	LDI  R30,LOW(192)
	OUT  0x2C,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x37:
	LDS  R30,_gElLoc
	LDS  R31,_gElLoc+1
	SUBI R30,LOW(-_gElMatrix)
	SBCI R31,HIGH(-_gElMatrix)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x38:
	LD   R30,Z
	SWAP R30
	ANDI R30,0xF0
	LDI  R31,0
	STS  _gCalValue0,R30
	STS  _gCalValue0+1,R31
	LDI  R30,LOW(0)
	STS  _gCalValue1,R30
	STS  _gCalValue1+1,R30
	__GETWRN 16,17,0
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x39:
	LD   R1,Z
	MOV  R30,R16
	LDI  R26,LOW(8)
	CALL __LSRB12
	AND  R30,R1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x3A:
	__PUTWMRN _gShift,0,16,17
	LDI  R26,LOW(_gShift)
	LDI  R27,HIGH(_gShift)
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x3B:
	LDS  R26,_gShift
	LDS  R27,_gShift+1
	SBIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x3C:
	LDI  R30,LOW(0)
	STS  _gShift,R30
	STS  _gShift+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 6 TIMES, CODE SIZE REDUCTION:32 WORDS
SUBOPT_0x3D:
	LDS  R30,_gShift
	LDI  R26,LOW(8)
	CALL __LSRB12
	LDS  R26,_gCalValue0
	OR   R30,R26
	OUT  0x15,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x3E:
	LDI  R30,LOW(1)
	LDI  R31,HIGH(1)
	STS  _gCurState,R30
	STS  _gCurState+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 10 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x3F:
	LDS  R26,_gCurState
	LDS  R27,_gCurState+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x40:
	LDS  R30,_gCalValue1
	OUT  0x15,R30
	LDI  R30,LOW(2)
	LDI  R31,HIGH(2)
	STS  _gCurState,R30
	STS  _gCurState+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x41:
	LDI  R26,LOW(_gShift)
	LDI  R27,HIGH(_gShift)
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x42:
	LDI  R30,LOW(3)
	LDI  R31,HIGH(3)
	STS  _gCurState,R30
	STS  _gCurState+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:4 WORDS
SUBOPT_0x43:
	LDS  R30,_gCalValue1
	OUT  0x15,R30
	LDI  R30,LOW(4)
	LDI  R31,HIGH(4)
	STS  _gCurState,R30
	STS  _gCurState+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x44:
	LDI  R30,LOW(5)
	LDI  R31,HIGH(5)
	STS  _gCurState,R30
	STS  _gCurState+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:2 WORDS
SUBOPT_0x45:
	LDS  R30,_gCalValue1
	OUT  0x15,R30
	LDI  R26,LOW(_gElLoc)
	LDI  R27,HIGH(_gElLoc)
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:5 WORDS
SUBOPT_0x46:
	LDS  R30,_gShotCnt
	SUBI R30,-LOW(1)
	STS  _gShotCnt,R30
	LDI  R30,LOW(0)
	STS  _gElLoc,R30
	STS  _gElLoc+1,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x47:
	LDI  R30,LOW(0)
	STS  _gShotCnt,R30
	STS  _gShotWaitTime,R30
	STS  _gShotWaitTime+1,R30
	LDI  R30,LOW(1)
	STS  _gElCompletFlag,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x48:
	LD   R30,X+
	LD   R31,X+
	SBIW R30,1
	ST   -X,R31
	ST   -X,R30
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x49:
	LDI  R30,LOW(0)
	OUT  0x2F,R30
	LDI  R30,LOW(1)
	OUT  0x2E,R30
	RJMP SUBOPT_0x36

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:7 WORDS
SUBOPT_0x4A:
	LDI  R30,LOW(2)
	STS  _gElMatrix,R30
	LDI  R30,LOW(1)
	__PUTB1MN _gElMatrix,1
	LDI  R30,LOW(8)
	__PUTB1MN _gElMatrix,2
	LDI  R30,LOW(4)
	__PUTB1MN _gElMatrix,3
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:9 WORDS
SUBOPT_0x4B:
	LDS  R30,_gTime1ms
	LDS  R31,_gTime1ms+1
	STS  _goldTime1ms,R30
	STS  _goldTime1ms+1,R31
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4C:
	LDS  R26,_gAdcLoc
	LDS  R27,_gAdcLoc+1
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x4D:
	LDS  R26,_gVolChkCount
	LDS  R27,_gVolChkCount+1
	CALL __CPW02
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:10 WORDS
SUBOPT_0x4E:
	MOVW R30,R16
	LDI  R26,LOW(_DacArray*2)
	LDI  R27,HIGH(_DacArray*2)
	CALL __LSLW2
	ADD  R30,R26
	ADC  R31,R27
	CALL __GETD1PF
	__PUTD1S 6
	RJMP SUBOPT_0x3

;OPTIMIZER ADDED SUBROUTINE, CALLED 8 TIMES, CODE SIZE REDUCTION:11 WORDS
SUBOPT_0x4F:
	__GETD2S 6
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:15 WORDS
SUBOPT_0x50:
	__GETD1N 0x3E4CCCCD
	CALL __MULF12
	RJMP SUBOPT_0x4F

;OPTIMIZER ADDED SUBROUTINE, CALLED 3 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x51:
	RCALL SUBOPT_0x4F
	RJMP SUBOPT_0x50

;OPTIMIZER ADDED SUBROUTINE, CALLED 2 TIMES, CODE SIZE REDUCTION:1 WORDS
SUBOPT_0x52:
	LDI  R30,LOW(2)
	STS  _gFlag,R30
	LDS  R30,_gError
	ANDI R30,LOW(0x1)
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:3 WORDS
SUBOPT_0x53:
	LDI  R26,LOW(_gVolAdjCount)
	LDI  R27,HIGH(_gVolAdjCount)
	RJMP SUBOPT_0x35

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:6 WORDS
SUBOPT_0x54:
	LDS  R26,_gVolAdjCount
	LDS  R27,_gVolAdjCount+1
	SBIW R26,4
	RET

;OPTIMIZER ADDED SUBROUTINE, CALLED 4 TIMES, CODE SIZE REDUCTION:12 WORDS
SUBOPT_0x55:
	LDI  R30,LOW(0)
	STS  _gVolAdjCount,R30
	STS  _gVolAdjCount+1,R30
	LDS  R30,_gError
	RET


	.CSEG
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

__LSLW2:
	LSL  R30
	ROL  R31
	LSL  R30
	ROL  R31
	RET

__ASRW8:
	MOV  R30,R31
	CLR  R31
	SBRC R30,7
	SER  R31
	RET

__CWD1:
	MOV  R22,R31
	ADD  R22,R22
	SBC  R22,R22
	MOV  R23,R22
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

__GETW1P:
	LD   R30,X+
	LD   R31,X
	SBIW R26,1
	RET

__GETD1PF:
	LPM  R0,Z+
	LPM  R1,Z+
	LPM  R22,Z+
	LPM  R23,Z
	MOVW R30,R0
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

__CPW02:
	CLR  R0
	CP   R0,R26
	CPC  R0,R27
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

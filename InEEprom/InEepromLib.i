
#pragma used+
sfrb PINF=0;
sfrb PINE=1;
sfrb DDRE=2;
sfrb PORTE=3;
sfrb ADCL=4;
sfrb ADCH=5;
sfrw ADCW=4;      
sfrb ADCSRA=6;
sfrb ADMUX=7;
sfrb ACSR=8;
sfrb UBRR0L=9;
sfrb UCSR0B=0xa;
sfrb UCSR0A=0xb;
sfrb UDR0=0xc;
sfrb SPCR=0xd;
sfrb SPSR=0xe;
sfrb SPDR=0xf;
sfrb PIND=0x10;
sfrb DDRD=0x11;
sfrb PORTD=0x12;
sfrb PINC=0x13;
sfrb DDRC=0x14;
sfrb PORTC=0x15;
sfrb PINB=0x16;
sfrb DDRB=0x17;
sfrb PORTB=0x18;
sfrb PINA=0x19;
sfrb DDRA=0x1a;
sfrb PORTA=0x1b;
sfrb EECR=0x1c;
sfrb EEDR=0x1d;
sfrb EEARL=0x1e;
sfrb EEARH=0x1f;
sfrw EEAR=0x1e;   
sfrb SFIOR=0x20;
sfrb WDTCR=0x21;
sfrb OCDR=0x22;
sfrb OCR2=0x23;
sfrb TCNT2=0x24;
sfrb TCCR2=0x25;
sfrb ICR1L=0x26;
sfrb ICR1H=0x27;
sfrw ICR1=0x26;   
sfrb OCR1BL=0x28;
sfrb OCR1BH=0x29;
sfrw OCR1B=0x28;  
sfrb OCR1AL=0x2a;
sfrb OCR1AH=0x2b;
sfrw OCR1A=0x2a;  
sfrb TCNT1L=0x2c;
sfrb TCNT1H=0x2d;
sfrw TCNT1=0x2c;  
sfrb TCCR1B=0x2e;
sfrb TCCR1A=0x2f;
sfrb ASSR=0x30;
sfrb OCR0=0x31;
sfrb TCNT0=0x32;
sfrb TCCR0=0x33;
sfrb MCUCSR=0x34;
sfrb MCUCR=0x35;
sfrb TIFR=0x36;
sfrb TIMSK=0x37;
sfrb EIFR=0x38;
sfrb EIMSK=0x39;
sfrb EICRB=0x3a;
sfrb RAMPZ=0x3b;
sfrb XDIV=0x3c;
sfrb SPL=0x3d;
sfrb SPH=0x3e;
sfrb SREG=0x3f;
#pragma used-

#asm
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
#endasm

typedef unsigned char   Uchar;      
typedef   signed char   Schar;      
typedef unsigned short  Ushort;     
typedef   signed short  Sshort;     
typedef unsigned  int   Uint;       
typedef   signed  int   Sint;       
typedef unsigned long   Ulong;      
typedef   signed long   Slong;      

typedef unsigned char   UI8;
typedef unsigned char   BYTE;
typedef signed char        SI8;
typedef unsigned int      UI16;
typedef unsigned int      WORD;
typedef signed int           SI16;
typedef unsigned long   DWORD;
typedef unsigned long   UI32;

typedef enum
{
FLAG_STADNBY = 0,
FLAG_VOLADJ,
FLAG_READY,
FLAG_SHOOTING,
FLAG_COMPLETE,
FLAG_EM_STOP
} SYSTEM_FLAG;

typedef enum
{
MODE_STOP = 0, 
MODE_READY,
MODE_START
} SYSTEM_MODE;

typedef enum
{
ERROR_VOL=0, 
ERROR_ELOUT,
ERROR_MOTOR1,
ERROR_MOTOR2,
ERROR_HEATSINK,
ERROR_NOTHANDLE,
ERROR_NOTLCD,
ERROR_EM_STOP  
} SYSTEM_ERROR;

typedef enum
{
CUR_INIT = 0,
CUR_OK, 
CUR_ERROR
} CURRENT_MODE; 

typedef enum
{
EP_MODE = 0,
EP_RUN,
EP_DOSE,
EP_VOLTAGE,
EP_DEPTH,
EP_SPEED, 
EP_EL_COUNT, 
EP_FLAG,  
EP_EL_MAP,
EP_MOTOR_POS1,
EP_MOTOR_POS2,
EP_ERROR,              

SYS_OK     =  0x80,
SYS_ERROR

} IPC_COMMAND;

typedef struct _IPC_HEADER
{
BYTE stx;
BYTE RWflag;
BYTE Command;
BYTE data1;
BYTE data2;
BYTE checksum;
BYTE etx;
} *LPIPC_HEADER, IPC_HEADER;

typedef enum
{
ERR_NO = 0,
ERR_LOW_TEMP,
ERR_HIGH_TEMP,
ERR_LOW_IMP,
ERR_HIGH_IMP,   
ERR_OVER_TEMP

} CHANNEL_ERROR;

BYTE MakeCrc( BYTE *Data, int Len );
void IPC_RunProcess1( void );
void IPC_RcvProcess1( BYTE *Data );
void IPC_SndProcess1( BYTE *Data );
void IPC_Send_Response1( BYTE *Data, BYTE Res );

void IPC_RunProcess0( void );
void IPC_RcvProcess0( BYTE *Data );
void IPC_SndProcess0( BYTE *Data );
void IPC_Send_Response0( BYTE *Data, BYTE Res );      

typedef struct _EEPROM_BODY
{
BYTE AkFlag;
BYTE Mode;
BYTE Run;
BYTE Dose1; 
BYTE Dose2;
BYTE Voltage;
BYTE Depth;
BYTE Speed;
BYTE Flag;
BYTE Map1;
BYTE Map2;   
} *LPEEPROM_BODY, EEPROM_BODY;

void _EEPROMWrite( WORD addr, BYTE data );
BYTE _EEPROMRead( WORD addr);
void E2pWriteLen( BYTE *bDat, BYTE bAddr, BYTE nLen );
void E2pReadLen( BYTE *bDat, BYTE bAddr, BYTE nLen );

void _EEPROMWrite( WORD addr, BYTE data )
{
while( EECR & (1 << 1) );
EEAR = addr;
EEDR = data;
EECR |= ( 1 << 2    );
EECR |= ( 1 << 1);
}   

BYTE _EEPROMRead( WORD addr)
{
while( EECR & (1 << 1) );
EEAR = addr;
EECR |= ( 1 << 0                            );
return EEDR;
}
BYTE E2pRead( WORD Addr )
{
return _EEPROMRead( Addr );
}
void E2pReadLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
{
int i;

for( i=0; i< nLen; i++ )
{
bDat[i] = _EEPROMRead( bAddr+i );
}    
}
void E2pWriteLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
{
int i;
for( i=0; i< nLen; i++)
{
_EEPROMWrite( bAddr+i, bDat[i] );    
}    
}

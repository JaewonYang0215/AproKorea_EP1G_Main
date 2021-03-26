
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

typedef char *va_list;

#pragma used+

char getchar(void);
void putchar(char c);
void puts(char *str);
void putsf(char flash *str);
int printf(char flash *fmtstr,...);
int sprintf(char *str, char flash *fmtstr,...);
int vprintf(char flash * fmtstr, va_list argptr);
int vsprintf(char *str, char flash * fmtstr, va_list argptr);

char *gets(char *str,unsigned int len);
int snprintf(char *str, unsigned int size, char flash *fmtstr,...);
int vsnprintf(char *str, unsigned int size, char flash * fmtstr, va_list argptr);

int scanf(char flash *fmtstr,...);
int sscanf(char *str, char flash *fmtstr,...);

#pragma used-

#pragma library stdio.lib

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

BYTE I2C_Write( BYTE ChipAddr,WORD address, BYTE dat );  
BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count );
void I2C_ShiftOut( BYTE dat );                
BYTE I2C_ShiftIn( void );                    
BYTE I2C_Read( BYTE ChipAddr,WORD address );  
BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count );
BYTE I2C_Ack( void );                        
BYTE I2C_OutAck( BYTE Flag  );
void I2C_Start( void );                      
void I2C_Stop( void );                       
void i2c_delay(void );   

BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
{
WORD i;

if( address > 0xff)
return 0xff               ;

I2C_Start();

I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
I2C_Ack();

I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );   
I2C_Ack();

for( i=0; i< Count; i++ )
{

I2C_ShiftOut( Data[i] );
I2C_Ack();
}

I2C_Stop();

i2c_delay();        

return 0x00               ;
}

BYTE I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
{

if( address > 0xff)
return 0xff               ;

I2C_Start();  

I2C_ShiftOut( ChipAddr&0xfe );
I2C_Ack();

I2C_ShiftOut( address&0xff );
I2C_Ack();

I2C_ShiftOut( dat );     
I2C_Ack();

I2C_Stop();

i2c_delay();        

return 0x00               ;
}

void i2c_delay(void)
{

#asm( "nop" );
}

BYTE I2C_Ack(void )
{
BYTE Ack;

PORTA.0 = 1;

DDRA.0 = 0; 
PORTA.1 = 1;
i2c_delay();
Ack = PINA.0;
i2c_delay();
PORTA.1 = 0;

DDRA.0 = 1; 
i2c_delay();

if( Ack )
return 0xff               ;

return 0x00               ;
}

BYTE I2C_OutAck( BYTE Flag  )
{

if( Flag )    PORTA.0 = 1;
else        PORTA.0 = 0;

PORTA.1 = 1;

i2c_delay();
PORTA.1 = 0;

i2c_delay();

return 0x00               ;
}

BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
{
WORD i;

if( address > 0xff)
return 0xff               ;

I2C_Start();

I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
I2C_Ack();

I2C_ShiftOut( address&0xff );
I2C_Ack();

I2C_Start();

I2C_ShiftOut( 0x01|(BYTE)(ChipAddr&0xff) );
I2C_Ack();

for( i=0; i< Count-1; i++ )
{

Data[i] = I2C_ShiftIn();

I2C_OutAck( 0 );
}
Data[i] =    I2C_ShiftIn();
I2C_OutAck( 1 );

I2C_Stop();

return 0x00               ;
}

BYTE I2C_Read( BYTE ChipAddr, WORD address )
{
BYTE Dat;

if( address > 0xff)
return 0xff               ;

I2C_Start();   

I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
I2C_Ack();

I2C_ShiftOut( address&0xff );
I2C_Ack();

I2C_Start();

I2C_ShiftOut( 0x01| (BYTE)(ChipAddr&0xff) );

I2C_Ack();

Dat = I2C_ShiftIn();
I2C_Ack();

I2C_Stop();

return Dat;
}

void I2C_Start(void )
{
PORTA.0 = 1;    
PORTA.1 = 1;   
i2c_delay();
PORTA.0 = 0;     
i2c_delay();
PORTA.1 = 0;    
i2c_delay();
}

void I2C_Stop( void )
{
PORTA.1 = 0;
PORTA.0 = 0;      
i2c_delay();
PORTA.1 = 1;    
i2c_delay();
PORTA.0 = 1;     
}

void I2C_ShiftOut( BYTE dat )
{
BYTE i,temp;

for( i=0; i<8; i++ )
{

temp = dat & ( 0x80>>i );

if( temp )   PORTA.0 = 1;    
else         PORTA.0 = 0;
i2c_delay();
PORTA.1 = 1;              
i2c_delay();
PORTA.1 = 0;               
i2c_delay();
}
}

BYTE I2C_ShiftIn( void )
{
BYTE i=0,temp;
BYTE Dat=0;

PORTA.0 = 1;
DDRA.0 = 0;      
for( i=0; i<8; i++ )
{

PORTA.1 = 1;         
i2c_delay();

temp = PINA.0;     
Dat |= ( temp<<(7-i) );

i2c_delay();
PORTA.1 = 0;          
i2c_delay();
}

DDRA.0 = 1;   

return Dat;
}


typedef char *va_list;

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

char  Tgetchar1( void );
void  Tputchar1( char c );
void  Usrprintf1( char *string );     
void  FlashUsrprintf1( const char  *string );  
void  MyPrint1(char flash* format, ...);

BYTE  IPC_RcvData1( BYTE *Buffer, BYTE len );
BYTE  IPC_RcvData_Interrupt1( BYTE *Buffer, BYTE len );
BYTE  IPC_SendData1( BYTE *Buffer, BYTE len ); 
BYTE  IPC_Get_RxCount1( void );
void  IPC_ResetCount1( void );

char  Tgetchar0( void );
void  Tputchar0(char c );
void  Usrprintf0( char *string );     
void  FlashUsrprintf0( const char  *string );  
void  MyPrint0(char flash* format, ...);
BYTE  IPC_RcvData0( BYTE *Buffer, BYTE len );
BYTE  IPC_RcvData_Interrupt0( BYTE *Buffer, BYTE len );
BYTE  IPC_SendData0( BYTE *Buffer, BYTE len ); 
BYTE  IPC_Get_RxCount0( void );
void  IPC_ResetCount0( void );

extern WORD  gTime1ms;

char rx_buffer0[250];
unsigned char rx_wr_index0=0,rx_rd_index0=0,rx_counter0=0;
BYTE rx_buffer_overflow0=0;
char mRcvErrFlag0 = 0;

char rx_buffer1[250];
unsigned char rx_wr_index1=0,rx_rd_index1=0,rx_counter1=0;
BYTE rx_buffer_overflow1=0;
char mRcvErrFlag1 = 0;

interrupt [31] void usart1_rx_isr(void)
{
char status,data;
status = (*(unsigned char *) 0x9b);
data   = (*(unsigned char *) 0x9c);

if ((status & ((1<<4) | (1<<2) | (1<<3)))==0 )
{
rx_buffer1[rx_wr_index1++]=data;
if (rx_wr_index1 == 250) rx_wr_index1=0;
if (++rx_counter1 == 250)
{
rx_counter1 = 0;
rx_buffer_overflow1 = 1;
}

}
}

char getchar1( void )
{
char data;

if( rx_counter1 >0 )
{
data = rx_buffer1[rx_rd_index1++];
if (rx_rd_index1 == 250) rx_rd_index1=0;

#asm("cli")
--rx_counter1;
#asm("sei")
mRcvErrFlag1 = 0;
return data;     
}
else
{                       
mRcvErrFlag1 = 1;
return 0;   
}
}

BYTE  IPC_Get_RxCount1( void )
{
return rx_counter1;
}

void IPC_ResetCount1( void )
{
#asm("cli")
rx_counter1 = 0;
rx_rd_index1 = 0;
rx_wr_index1 = 0;
#asm("sei")        
}

char Mygetchar1( BYTE flag )
{                         
WORD oldTime1ms;           
char status,data;           

while ( 1 )
{                              
if( flag )
oldTime1ms = gTime1ms;

while ( ((status=(*(unsigned char *) 0x9b)) & (1<<7)) == 0 )
{             
if( flag )
{
if( (gTime1ms - oldTime1ms) > 300 ) 
{     
return 0;
}
}                                          
};                                                  

data = (*(unsigned char *) 0x9c);
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
return data;
};
}

char Tgetchar1( void )
{
char status,data;
while ( 1 )
{
while ( ((status=(*(unsigned char *) 0x9b)) & (1<<7))==0 );
data = (*(unsigned char *) 0x9c);
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
return data;
};
}                                                                                                  

void Tputchar1( char c )
{
while (((*(unsigned char *) 0x9b) & (1<<5))==0);
(*(unsigned char *) 0x9c) = c;
}  

void Usrprintf1( char  *string )
{       
while( *string != '\0' )
{  
Tputchar1(*string++); 
}  
}                

void FlashUsrprintf1( const char *string )
{ 
while( *string != '\0' )
{  
Tputchar1(*string++); 
}
}                        

void MyPrint1( char flash* format, ...)
{
char str[100]; 

va_list arg; 
arg=(va_list) &format-sizeof(long); 

vsprintf( str, format, arg); 
; 

Usrprintf1( str ); 
}

BYTE  IPC_RcvData1( BYTE *Buffer, BYTE len )
{            
BYTE i=0;

while( i < len )
{
Buffer[i] = Mygetchar1(i);
i++;                        
}
return  i; 
}  

BYTE  IPC_RcvData_Interrupt1( BYTE *Buffer, BYTE len )
{
BYTE i=0;
char dat = 0;
WORD oldTime1ms;     
oldTime1ms = gTime1ms;   

while( i < len )
{
dat = getchar1();
if( mRcvErrFlag1 == 0  )
{      
Buffer[i] = dat;
i++;
}       
if( (gTime1ms - oldTime1ms) > 3000 ) 
{
IPC_ResetCount1();
return 0;
}
}
return  i;
}

BYTE IPC_SendData1( BYTE *Buffer, BYTE len )
{                 
BYTE i;
i= 0;
while( i < len )
{
Tputchar1(Buffer[i++]);
}

return  i;             
}                                  

interrupt [19] void usart0_rx_isr(void)
{
char status,data;
status=UCSR0A;
data=UDR0;

if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
{
rx_buffer0[rx_wr_index0++]=data;    
if (rx_wr_index0 == 250) rx_wr_index0=0;
if (++rx_counter0 == 250)
{
rx_counter0=0;
rx_buffer_overflow0=1;
}
}
}

char getchar0( void )
{
char data;
if( rx_counter0 >0 )
{
data = rx_buffer0[rx_rd_index0++];
if (rx_rd_index0 == 250) rx_rd_index0=0;

#asm("cli")
--rx_counter0;
#asm("sei")
mRcvErrFlag0 = 0;
return data;     
}
else
{                       
mRcvErrFlag0 = 1;
return 0;   
}
}

BYTE  IPC_Get_RxCount0( void )
{
return rx_counter0;
}

void IPC_ResetCount0( void )
{
#asm("cli")
rx_counter0 = 0;
rx_rd_index0 = 0;
rx_wr_index0 = 0;
#asm("sei")        
}

char Mygetchar0( BYTE flag )
{                         
WORD oldTime1ms;           
char status,data;           

while ( 1 )
{                              
if( flag )
oldTime1ms = gTime1ms;

while ( ((status=UCSR0A) & (1<<7)) == 0 )
{             
if( flag )
{
if( (gTime1ms - oldTime1ms) > 300 ) 
{     
return 0;
}
}                                          
};                                                  

data = UDR0;
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
return data;
};
}

char Tgetchar0( void )
{
char status,data;
while ( 1 )
{
while ( ((status=UCSR0A) & (1<<7))==0 );
data = UDR0;
if ((status & ((1<<4) | (1<<2) | (1<<3)))==0)
return data;
};
}                                                                                                  

void Tputchar0( char c )
{
while ((UCSR0A & (1<<5))==0);
UDR0 = c;
}  

void Usrprintf0( char  *string )
{       
while( *string != '\0' )
{  
Tputchar0(*string++); 
}  
}                

void FlashUsrprintf0( const char *string )
{ 
while( *string != '\0' )
{  
Tputchar0(*string++); 
}
}                        

void MyPrint0( char flash* format, ...)
{
char str[100]; 

va_list arg; 
arg=(va_list) &format-sizeof(long); 

vsprintf( str, format, arg); 
; 

Usrprintf0( str ); 
}

BYTE  IPC_RcvData0( BYTE *Buffer, BYTE len )
{            
BYTE i=0;

while( i < len )
{
Buffer[i] = Mygetchar0(i);
i++;                        
}
return  i; 
}            

BYTE IPC_RcvData_Interrupt0( BYTE *Buffer, BYTE len )
{
BYTE i=0;
char dat = 0;
WORD oldTime1ms;     
oldTime1ms = gTime1ms;   

while( i < len )
{
dat = getchar0();
if( mRcvErrFlag0 == 0  )
{      
Buffer[i] = dat;
i++;
}       
if( (gTime1ms - oldTime1ms) > 3000 ) 
{
IPC_ResetCount0();
return 0;
}
}
return  i;
}

BYTE IPC_SendData0( BYTE *Buffer, BYTE len )
{                 
BYTE i;
i= 0;
while( i < len )
{
Tputchar0(Buffer[i++]);
}

return  i;             
}                                  

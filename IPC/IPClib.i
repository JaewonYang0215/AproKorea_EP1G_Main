
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

#pragma used+

char *strcat(char *str1,char *str2);
char *strcatf(char *str1,char flash *str2);
char *strchr(char *str,char c);
signed char strcmp(char *str1,char *str2);
signed char strcmpf(char *str1,char flash *str2);
char *strcpy(char *dest,char *src);
char *strcpyf(char *dest,char flash *src);
unsigned char strlcpy(char *dest,char *src,unsigned char n);	
unsigned char strlcpyf(char *dest,char flash *src,unsigned char n); 
unsigned int strlenf(char flash *str);
char *strncat(char *str1,char *str2,unsigned char n);
char *strncatf(char *str1,char flash *str2,unsigned char n);
signed char strncmp(char *str1,char *str2,unsigned char n);
signed char strncmpf(char *str1,char flash *str2,unsigned char n);
char *strncpy(char *dest,char *src,unsigned char n);
char *strncpyf(char *dest,char flash *src,unsigned char n);
char *strpbrk(char *str,char *set);
char *strpbrkf(char *str,char flash *set);
char *strrchr(char *str,char c);
char *strrpbrk(char *str,char *set);
char *strrpbrkf(char *str,char flash *set);
char *strstr(char *str1,char *str2);
char *strstrf(char *str1,char flash *str2);
char *strtok(char *str1,char flash *str2);

unsigned int strlen(char *str);
void *memccpy(void *dest,void *src,char c,unsigned n);
void *memchr(void *buf,unsigned char c,unsigned n);
signed char memcmp(void *buf1,void *buf2,unsigned n);
signed char memcmpf(void *buf1,void flash *buf2,unsigned n);
void *memcpy(void *dest,void *src,unsigned n);
void *memcpyf(void *dest,void flash *src,unsigned n);
void *memmove(void *dest,void *src,unsigned n);
void *memset(void *buf,unsigned char c,unsigned n);
unsigned int strcspn(char *str,char *set);
unsigned int strcspnf(char *str,char flash *set);
int strpos(char *str,char c);
int strrpos(char *str,char c);
unsigned int strspn(char *str,char *set);
unsigned int strspnf(char *str,char flash *set);

#pragma used-
#pragma library string.lib

#pragma used+

signed char cmax(signed char a,signed char b);
int max(int a,int b);
long lmax(long a,long b);
float fmax(float a,float b);
signed char cmin(signed char a,signed char b);
int min(int a,int b);
long lmin(long a,long b);
float fmin(float a,float b);
signed char csign(signed char x);
signed char sign(int x);
signed char lsign(long x);
signed char fsign(float x);
unsigned char isqrt(unsigned int x);
unsigned int lsqrt(unsigned long x);
float sqrt(float x);
float ftrunc(float x);
float floor(float x);
float ceil(float x);
float fmod(float x,float y);
float modf(float x,float *ipart);
float ldexp(float x,int expon);
float frexp(float x,int *expon);
float exp(float x);
float log(float x);
float log10(float x);
float pow(float x,float y);
float sin(float x);
float cos(float x);
float tan(float x);
float sinh(float x);
float cosh(float x);
float tanh(float x);
float asin(float x);
float acos(float x);
float atan(float x);
float atan2(float y,float x);

#pragma used-
#pragma library math.lib

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

int read_adc( BYTE adc_input );

void DAC7611_init( void );
void DAC7611_Write( WORD data );
void DAC7611_WriteVoltage( int data );

extern BYTE gElMatrix[4];       
extern WORD goldTime1ms;
extern WORD gTime1ms; 
extern int gVoltage; 
extern BYTE gMode;
extern BYTE gRunFlag;
extern int gDose;
extern int gDepth; 
extern int gSpeed;
extern BYTE gFlag;
extern BYTE gError;
extern int gMotorPos1;
extern int gMotorPos2;
extern BYTE gElCompletFlag;
extern int  gElCount;

extern BYTE gCurMode;
extern BYTE gReadyActionFlag;
extern int  gVolChkCount;

extern void SaveInEeprom( void );
BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead );
BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead );
BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead );
BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead );
BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead );
typedef BYTE(*RunFun) (LPIPC_HEADER pHead );       

RunFun IPC1Rcvfun[]=
{
IPC1_RCV_MODE,
IPC1_RCV_RUN, 
IPC1_RCV_DOSE,
IPC1_RCV_VOLTAGE,	
IPC1_RCV_DEPTH,
IPC1_RCV_SPEED, 
IPC1_RCV_ELCOUNT,
IPC1_RCV_FLAG,
IPC1_RCV_EL_MAP,
IPC1_RCV_MOTOR_POS1,
IPC1_RCV_MOTOR_POS2,
IPC1_RCV_ERROR    
};                  

BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead )
{
return 1;
}      

BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead )
{

BYTE mFlag =  pHead->data1? 1:0;
if( mFlag )
SaveInEeprom();    

return 1;
}   

BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead )
{    
gDose = pHead->data2 | ((int)pHead->data1<<8);  
if( gDose < 0 ) gDose = 0;
if( gDose > 3 ) gDose = 3;     

return 1;
} 

BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead )
{
gVoltage = pHead->data1; 
if( gVoltage < 60 ) gVoltage = 60;
if( gVoltage > 120 ) gVoltage = 120;

if( gVoltage > 50 ) PORTD.7 = 0;
else  PORTD.7 = 1  ;

return 1;
}

BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead )
{
gDepth = pHead->data1; 
if( gDepth < 0 ) gDepth = 0;
if( gDepth > 3 ) gDepth = 3;

return 1;
}

BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead )
{
gSpeed = pHead->data1; 
if( gSpeed < 0 ) gSpeed = 0;
if( gSpeed > 2 ) gSpeed = 2;

return 1;
}

BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead )
{
gElCount = pHead->data1; 
if( gElCount < 0 ) gElCount = 0;
if( gElCount > 100 ) gElCount = 100;

return 1;
}

BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead )
{
gFlag = pHead->data2;

return 1;
} 

BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead )
{
gElMatrix[0] = (BYTE)((pHead->data1>>4)&0xf); 
gElMatrix[1] = (BYTE)(pHead->data1&0xf);
gElMatrix[2] = (BYTE)((pHead->data2>>4)&0xf); 
gElMatrix[3] = (BYTE)(pHead->data2&0xf);     

return 1;
}

BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
{ 
return 1;
}

BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
{
return 1;
}

BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead )
{
BYTE mErrPos = pHead->data1; 
BYTE mSetClearFlag = pHead->data2?1:0;

if( mErrPos> ERROR_EM_STOP )                    
mErrPos = ERROR_EM_STOP;               

if( mSetClearFlag )
gError &= ~(1<<mErrPos);  
else gError |= (1<<mErrPos); 

return 1;
}

BYTE IPC1_SND_MODE( LPIPC_HEADER pHead );
BYTE IPC1_SND_RUN( LPIPC_HEADER pHead );
BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead );
BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead );
BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead );
BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead );
BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead ); 
typedef BYTE(*SenFun) (LPIPC_HEADER pHead);    

SenFun IPC1Sndfun[]=
{                                 
IPC1_SND_MODE, 
IPC1_SND_RUN, 
IPC1_SND_DOSE,      
IPC1_SND_VOLTAGE,	
IPC1_SND_DEPTH, 
IPC1_SND_SPEED,
IPC1_SND_ELCOUNT,
IPC1_SND_FLAG,
IPC1_SND_EL_MAP,
IPC1_SND_MOTOR_POS1,
IPC1_SND_MOTOR_POS2,
IPC1_SND_ERROR
};          

BYTE IPC1_SND_MODE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = 0;
pHead->data2 = (BYTE)(gMode&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}
BYTE IPC1_SND_RUN( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = 1;  
pHead->data2 = (BYTE)(gRunFlag&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}

BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gDose>>8)&0xff); 
pHead->data2 = (BYTE)(gDose&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}

BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  
pHead->data2 = (BYTE)(gVoltage&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );

return 1;
}

BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gDepth>>8)&0xff);  
pHead->data2 = (BYTE)(gDepth&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );

return 1;

}

BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  
pHead->data2 = (BYTE)(gSpeed&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
return 1;

}

BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gElCount>>8)&0xff);  
pHead->data2 = (BYTE)(gElCount&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
return 1;        
}

BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)(gRunFlag&0xff);
pHead->data2 = (BYTE)(gFlag&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}

BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead )
{  
pHead->Command = SYS_OK;
pHead->data1  = (gElMatrix[0]&0x0f)<<4 | (gElMatrix[1]&0x0f); 
pHead->data2  = (gElMatrix[2]&0x0f)<<4 | (gElMatrix[3]&0x0f); 

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;  
}      

BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead )
{  
pHead->Command = SYS_OK;
pHead->data1  = (BYTE)((gMotorPos1>>8)&0xff);
pHead->data2  = (BYTE)(gMotorPos1&0xff); 

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}

BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead )
{  
pHead->Command = SYS_OK;
pHead->data1  = (BYTE)((gMotorPos2>>8)&0xff);
pHead->data2  = (BYTE)(gMotorPos2&0xff); 

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}

BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead )
{

pHead->Command = SYS_OK;
pHead->data1 = 0;
pHead->data2 = gError;;

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

gReadyActionFlag=1;
return 1;

}

BYTE MakeCrc( BYTE *Data, int Len )
{
int i;
BYTE CRC;

CRC = 0;

for( i=0; i<Len ; i++ )
CRC += Data[i];

return CRC;
}

void IPC_RunProcess1( void )
{
BYTE RcvHead[30];
BYTE RcvByte;
BYTE  Crc,RcvCrc;
LPIPC_HEADER pHead;

{
RcvByte = IPC_RcvData_Interrupt1( RcvHead, sizeof( IPC_HEADER ) );
pHead = ( LPIPC_HEADER )RcvHead;

Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
RcvCrc = pHead->checksum;

if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
pHead->stx == 0x02 && pHead->etx == 0x03 )
{
if( pHead->RWflag ==  'R' )
IPC_SndProcess1( RcvHead );
else IPC_RcvProcess1( RcvHead );

}
else
{
IPC_Send_Response1( RcvHead, SYS_ERROR);
IPC_ResetCount1();
}

}

}
void IPC_Send_Response1( BYTE *Data, BYTE Res )
{
LPIPC_HEADER mLpHead;

mLpHead = (LPIPC_HEADER)Data;

mLpHead->Command = Res;
mLpHead->data1 = 0;
mLpHead->data2 = 0;
mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData1( Data, sizeof( IPC_HEADER ) );
}

void IPC_RcvProcess1( BYTE *Data )
{
LPIPC_HEADER pHead;

pHead   = (LPIPC_HEADER)Data;
if(  pHead->Command < sizeof(IPC1Rcvfun)/2 )
{
if( IPC1Rcvfun[pHead->Command]( pHead ) == 1 )        
{
IPC_Send_Response1( Data, SYS_OK );
}
else
{
IPC_Send_Response1( Data, SYS_ERROR);
}
}
else
{
IPC_Send_Response1( Data, SYS_ERROR );
}

}

void IPC_SndProcess1( BYTE *Data )
{
LPIPC_HEADER pHead;

pHead = (LPIPC_HEADER)Data;
if(   pHead->Command < sizeof(IPC1Sndfun)/2  )
{
if( IPC1Sndfun[pHead->Command]( pHead ) == 0 )        
IPC_Send_Response1( Data, SYS_ERROR );
}
else
{
IPC_Send_Response1( Data, SYS_ERROR );
}
}        

BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead );
BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead );
BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead );
BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead );
BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead );

RunFun IPC0Rcvfun[]=
{
IPC0_RCV_MODE,
IPC0_RCV_RUN, 
IPC0_RCV_DOSE,
IPC0_RCV_VOLTAGE,	
IPC0_RCV_DEPTH,
IPC0_RCV_SPEED, 
IPC0_RCV_ELCOUNT,
IPC0_RCV_FLAG,
IPC0_RCV_EL_MAP,
IPC0_RCV_MOTOR_POS1,
IPC0_RCV_MOTOR_POS2,  
IPC0_RCV_ERROR
};                  

BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead )
{
gMode = pHead->data2;

if( gMode == MODE_READY ) 
{        

PORTC = 0x00;            
(*(unsigned char *) 0x65) |= 0x08 ;
DAC7611_WriteVoltage(gVoltage);   
(*(unsigned char *) 0x65) |= 0x10  ;         

gError = 0 ;  
gFlag = FLAG_VOLADJ;

gVolChkCount = 2;

}
else 
{   
PORTC = 0x00;  
DAC7611_WriteVoltage(0);             
(*(unsigned char *) 0x65) &= (~0x08);
(*(unsigned char *) 0x65) &= (~0x10);   

gFlag = FLAG_STADNBY;

}   

gRunFlag = 0;
gElCompletFlag = 0;     
return 1;
}      

BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead )
{
if( gFlag == FLAG_SHOOTING ) 
{    

gRunFlag = pHead->data2?1:0;    

gElCompletFlag = 0;      
PORTB.6 = 0;    
} 
else
{
PORTC = 0x00;  
DAC7611_WriteVoltage(0);             
(*(unsigned char *) 0x65) &= (~0x08);
(*(unsigned char *) 0x65) &= (~0x10);   

gFlag = FLAG_STADNBY;   
}
return 1;
}   

BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead )
{    

return 1;
}     

BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead )
{
return 1;
}

BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead )
{
return 1;
}
BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead )
{
return 1;
}
BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead )
{
return 1;
}

BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead )
{
BYTE mFlag;
mFlag = pHead->data2;

if( mFlag > FLAG_EM_STOP) 
gFlag = FLAG_EM_STOP;
else gFlag = mFlag;   

return 1;
}
BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead )
{
return 1;
}

BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
{
WORD temp;
temp = ((WORD)pHead->data1)<<8|pHead->data2;
gMotorPos1 = temp;

return 1;
}

BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
{
WORD temp;
temp = ((WORD)pHead->data1)<<8|pHead->data2;
gMotorPos2 = temp;

return 1;
}

BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead )
{
BYTE mErrPos = pHead->data1;    

if( mErrPos> ERROR_EM_STOP ) 
mErrPos = ERROR_EM_STOP;

if( mErrPos == ERROR_EM_STOP )  
gFlag = FLAG_EM_STOP;    

gError |= (1<<mErrPos); 

gCurMode = CUR_ERROR;

return 1;
}
BYTE IPC0_SND_MODE( LPIPC_HEADER pHead );
BYTE IPC0_SND_RUN( LPIPC_HEADER pHead );
BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead );
BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead );
BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead );
BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead );
BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead ); 

SenFun IPC0Sndfun[]=
{                                 
IPC0_SND_MODE, 
IPC0_SND_RUN, 
IPC0_SND_DOSE,      
IPC0_SND_VOLTAGE,	
IPC0_SND_DEPTH, 
IPC0_SND_SPEED,
IPC0_SND_ELCOUNT, 
IPC0_SND_FLAG,
IPC0_SND_EL_MAP,
IPC0_SND_MOTOR_POS1,
IPC0_SND_MOTOR_POS2,
IPC0_SND_ERROR
};          

BYTE IPC0_SND_MODE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = 1;
pHead->data2 =  (BYTE)(gMode&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}

BYTE IPC0_SND_RUN( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = 1;
pHead->data2 = (BYTE)(gRunFlag&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}

BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gDose>>8)&0xff); 
pHead->data2 = (BYTE)(gDose&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
return 1;
}
BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  
pHead->data2 = (BYTE)(gVoltage&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );

return 1;
}

BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gDepth>>8)&0xff);  
pHead->data2 = (BYTE)(gDepth&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );

return 1;

}

BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gElCount>>8)&0xff);  
pHead->data2 = (BYTE)(gElCount&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
return 1;

}
BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead )
{
pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  
pHead->data2 = (BYTE)(gSpeed&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
return 1;

}

BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead )
{

pHead->Command = SYS_OK;
pHead->data1 = (BYTE)((gFlag>>8)&0xff);  
pHead->data2 = (BYTE)(gFlag&0xff);

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}
BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead )
{

pHead->Command = SYS_OK;
pHead->data1 = 0;  
pHead->data2 = 0;

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}
BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead )
{

pHead->Command = SYS_OK;
pHead->data1 = 0;  
pHead->data2 = 0;

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;  
}

BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead )
{           
pHead->Command = SYS_OK;
pHead->data1 = 0;  
pHead->data2 = 0;

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;
}

BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead )
{     
pHead->Command = SYS_OK;
pHead->data1 = 0;  
if( gReadyActionFlag ==0 )
pHead->data2 = ERROR_NOTLCD;    
else
pHead->data2 = gError;

pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 

return 1;

}
void IPC_RunProcess0( void )
{
BYTE RcvHead[30];
BYTE RcvByte;
BYTE  Crc,RcvCrc;
LPIPC_HEADER pHead;

{
RcvByte = IPC_RcvData_Interrupt0( RcvHead, sizeof( IPC_HEADER ) );
pHead = ( LPIPC_HEADER )RcvHead;

Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
RcvCrc = pHead->checksum;

if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
pHead->stx == 0x02 && pHead->etx == 0x03 )
{
if( pHead->RWflag ==  'R' )
IPC_SndProcess0( RcvHead );
else IPC_RcvProcess0( RcvHead );

}
else
{
IPC_Send_Response0( RcvHead, SYS_ERROR);
IPC_ResetCount0();
}

}

}
void IPC_Send_Response0( BYTE *Data, BYTE Res )
{
LPIPC_HEADER mLpHead;

mLpHead = (LPIPC_HEADER)Data;

mLpHead->Command = Res;
mLpHead->data1 = 0;
mLpHead->data2 = 0;
mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );

IPC_SendData0( Data, sizeof( IPC_HEADER ) );
}

void IPC_RcvProcess0( BYTE *Data )
{
LPIPC_HEADER pHead;

pHead   = (LPIPC_HEADER)Data;
if(  pHead->Command < sizeof(IPC0Rcvfun)/2 )
{
if( IPC0Rcvfun[pHead->Command]( pHead ) == 1 )        
{
IPC_Send_Response0( Data, SYS_OK );
}
else
{
IPC_Send_Response0( Data, SYS_ERROR);
}
}
else
{
IPC_Send_Response0( Data, SYS_ERROR );
}

}

void IPC_SndProcess0( BYTE *Data )
{
LPIPC_HEADER pHead;

pHead = (LPIPC_HEADER)Data;
if( pHead->Command < sizeof(IPC0Sndfun)/2  )
{
if( IPC0Sndfun[pHead->Command]( pHead ) == 0 )        
IPC_Send_Response0( Data, SYS_ERROR );
}
else
{
IPC_Send_Response0( Data, SYS_ERROR );
}
}

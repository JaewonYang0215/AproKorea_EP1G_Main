
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

#pragma used+

void delay_us(unsigned int n);
void delay_ms(unsigned int n);

#pragma used-

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

void DAC7611_init( void );
void DAC7611_Write( WORD data );
void DAC7611_WriteVoltage( int data );

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

int read_adc( BYTE adc_input );

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

const float DacArray[12] = {10.0f, 20.0f, 30.0f, 40.20f, 13.20f, 16.94f, 21.28f, 25.82f, 30.57f, 35.4f, 40.0f, 55.9f}; 

int  gVoltage;
BYTE gMode;
BYTE gRunFlag;
int  gDepth; 
int  gSpeed;
int  gElCount=0;
BYTE gFlag;
int  gDose;
BYTE gError;
int  gAdcLoc=0;    
int  gElLoc=0;
int  gMotorPos1=0;
int  gMotorPos2=0;

WORD gTime1ms;
WORD goldTime1ms;
BYTE WaitEvent( void );
BYTE gElMatrix[4];
int  gCurState=0;
int  gCalValue0,gCalValue1;
int  gDutyOff=0;
BYTE gElCompletFlag = 0;

BYTE gShotCnt =0;
int gShotWaitTime =0;
int gShotGapWaitTime =0;

int gSetVolagteInitTime = 5000;

int  gShift=0;

int  gVolAdjCount=0;
int  gVolChkCount = 0;

BYTE gCurMode;
BYTE gGenMode=0;
BYTE gReadyActionFlag=0;

void InitSettingData(void);
void LoadInEeprom( void);
void InitData(void);

interrupt [17] void timer0_ovf_isr(void)
{

TCNT0 = 0x06;   

gTime1ms++;    
}

void PulseGenerator( void )
{
int i=0;

TCNT1H=0xE0;    
TCNT1L=0xC0;     

if( gRunFlag==1 && gElCompletFlag == 0 )
{     

if( gGenMode==0 )
{  
if(gShotWaitTime<=800)  
{
gShotWaitTime++;
}          
else
{
if( gCurState == 0 )
{                
gCalValue0 = gElMatrix[gElLoc]<<4;
gCalValue1 = 0; 

for( i=0; i< 4; i++)
{
if( gElMatrix[gElLoc]&(0x08>>i)) 
break;  
}                                  
gShift = i;  

gShift++; 
if( gShift > 3 ) gShift = 0;  

PORTC = gCalValue0|(0x08>>gShift);   
gCurState = 1;  
}      
else if( gCurState == 1 )
{
PORTC = gCalValue1;             
gCurState = 2;
}                        
else if( gCurState == 2 )
{  
gShift++;
if( gShift > 3 ) gShift = 0;
PORTC = gCalValue0|(0x08>>gShift);         
gCurState = 3;       
}
else if( gCurState == 3 )
{
PORTC = gCalValue1;               
gCurState = 4;      
}
else if( gCurState == 4 )
{
gShift++;
if( gShift > 3 ) gShift = 0;
PORTC = gCalValue0|(0x08>>gShift);               
gCurState = 5;         
}                    
else if( gCurState == 5 )
{              
PORTC = gCalValue1;
gElLoc++;          
if( gElLoc > 3 )
{  
gShotCnt++;                   
gElLoc = 0;          
}         
gCurState = 0;                     

if(gShotCnt >=1)      
{   
gShotCnt = 0;
gShotWaitTime = 0;
gElCompletFlag = 1;
}                                 
}   
}       
}
else
{     

if(gShotWaitTime<=400)  
{
gShotWaitTime++;   
gShotGapWaitTime = 0;
}          
else
{      
if(gShotGapWaitTime)
{   
gShotGapWaitTime --;
}
else
{   
if( gCurState == 0 )
{                
gCalValue0 = gElMatrix[gElLoc]<<4;
gCalValue1 = 0; 

for( i=0; i< 4; i++)
{
if( gElMatrix[gElLoc]&(0x08>>i)) 
break;  
}                                  
gShift = i;  

gShift++; 
if( gShift > 3 ) gShift = 0;  

PORTC = gCalValue0|(0x08>>gShift);   
gCurState = 1;  
}      
else if( gCurState == 1 )
{
PORTC = gCalValue1;             
gCurState = 2;
}                        
else if( gCurState == 2 )
{  
gShift++;
if( gShift > 3 ) gShift = 0;
PORTC = gCalValue0|(0x08>>gShift);         
gCurState = 3;       
}
else if( gCurState == 3 )
{
PORTC = gCalValue1;               
gCurState = 4;      
}
else if( gCurState == 4 )
{
gShift++;
if( gShift > 3 ) gShift = 0;
PORTC = gCalValue0|(0x08>>gShift);               
gCurState = 5;         
}                    
else if( gCurState == 5 )
{              
PORTC = gCalValue1;
gElLoc++;   
gCurState = 0;  
gShotGapWaitTime = 200;  
if( gElLoc > 3 )
{  
gShotCnt++;                   
gElLoc = 0; 
}     

if(gShotCnt >=1)      
{   
gShotCnt = 0;
gShotWaitTime = 0;
gElCompletFlag = 1;
}                                 
}
}
} 
}      
}
}

void PulseGenerator6( void )
{

TCNT1H=0xE600 >> 8;          
TCNT1L=0xE600 & 0xff;

if( gRunFlag==1 && gElCompletFlag == 0 )
{ 
if( gCurState == 0 )
{                
gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; 
gCalValue1 = gCalValue0&0x0f; 

PORTC = gCalValue0;  
gDutyOff = 0; 
gCurState = 1;  
}                        
else if( gCurState == 1 )
{
gDutyOff++;
if( gDutyOff >14 )gCurState = 2;
}      
else if( gCurState == 2 )
{                 
gDutyOff = 0; 
PORTC = gCalValue1;             
gCurState = 3;
}                        
else if( gCurState == 3 )
{         
PORTC = gCalValue0;
gDutyOff++; 
if( gDutyOff >15) gCurState = 4;       
}
else if( gCurState == 4 )
{            
gDutyOff = 0; 
PORTC = gCalValue1;               
gCurState = 5;      
}
else if( gCurState == 5 )
{         
PORTC = gCalValue0; 
gDutyOff++;
if( gDutyOff >15) gCurState = 6;       
}
else if( gCurState == 6 )
{            
gDutyOff = 0; 
PORTC = gCalValue1;               
gCurState = 7;      
} 
else if( gCurState == 7 )
{         
PORTC = gCalValue0; 
gDutyOff++;
if( gDutyOff >15) gCurState = 8;       
}
else if( gCurState == 8 )
{            
gDutyOff = 0; 
PORTC = gCalValue1;               
gCurState = 9;      
} 
else if( gCurState == 9 )
{         
PORTC = gCalValue0; 
gDutyOff++;
if( gDutyOff >15) gCurState = 10;       
}
else if( gCurState == 10 )
{            
gDutyOff = 0; 
PORTC = gCalValue1;               
gCurState = 11;      
}  
else if( gCurState == 11 )
{    
gDutyOff++;
if( gDutyOff > 363)     
{    
gCurState = 0;
gElLoc++;   
if( gElLoc > 3 )
{     
PORTC = 0x00; 
gElLoc = 0;
gElCompletFlag = 1;
}
}        
}
}    
}

interrupt [15] void timer1_ovf_isr(void)
{
PulseGenerator();   

if(gSetVolagteInitTime>0)
{     
gSetVolagteInitTime--;
} 
else
{   
gSetVolagteInitTime =0;
}
}

void PortInit( void )
{                 

DDRA    = 0x3f;     
PORTA   = 0x04; 

DDRB    = 0x40;      
PORTB   = 0x01;          

DDRC    = 0xff;   
PORTC   = 0x00;

DDRD    = 0x80;      
PORTD   = 0x00;      

DDRE    = 0x12;     

(*(unsigned char *) 0x61)    = 0xC0;      
(*(unsigned char *) 0x62)   = 0x00;    

(*(unsigned char *) 0x64)    = 0xff;     
(*(unsigned char *) 0x65)   = 0x00;         

ASSR=0;
TCCR0=0x04;
TCNT0=0x06;
OCR0=0x00;                      

TCCR1A=0x00;
TCCR1B=0x01;
TCNT1H=0xE0;
TCNT1L=0xC0;  
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
(*(unsigned char *) 0x79)=0x00;
(*(unsigned char *) 0x78)=0x00;

TIMSK=0x05;
(*(unsigned char *) 0x7d)=0x00;             

UCSR0A=0x02;
UCSR0B=0x98;
(*(unsigned char *) 0x95)=0x06;
(*(unsigned char *) 0x90)=0x00;
UBRR0L=0x33;

(*(unsigned char *) 0x9b)=0x02;
(*(unsigned char *) 0x9a)=0x98;
(*(unsigned char *) 0x9d)=0x06;
(*(unsigned char *) 0x98)=0x00;
(*(unsigned char *) 0x99)=0x22;  

ADMUX  = 0x00 & 0xff;
ADCSRA = 0x84;    
}

void InitData(void)
{
gCurMode = CUR_INIT;
gVoltage=100;
gMode=0;
gRunFlag = 0;
gDepth=0; 
gSpeed=1;
gFlag=0;
gError = (1<<ERROR_NOTLCD);
gDose = 0;

gElMatrix[0] = 0x02;
gElMatrix[1] = 0x01;
gElMatrix[2] = 0x08;
gElMatrix[3] = 0x04;     
}
void InitSettingData(void)
{
DAC7611_WriteVoltage(gVoltage);
}

void SystemInit( void )
{
PortInit();
InitData();             

LoadInEeprom();

DAC7611_init(  );  

InitSettingData();    

gGenMode = PINB.0?1:0;

PORTA.4 = 1; 

gElMatrix[0] = 0x02;
gElMatrix[1] = 0x01;
gElMatrix[2] = 0x08;
gElMatrix[3] = 0x04;  

TCCR1A=0x00;
TCCR1B=0x01;

TCNT1H=0xE0;
TCNT1L=0xC0;   
}                                                  

BYTE WaitEvent( void )
{

while ( 1 )
{       
if( IPC_Get_RxCount0() >=  sizeof( IPC_HEADER ) )
{
goldTime1ms = gTime1ms;
return 1;
}
else if( IPC_Get_RxCount1() >=  sizeof( IPC_HEADER ) )
{
goldTime1ms = gTime1ms;
return 2;
}

else if( (gTime1ms-goldTime1ms) > 300 ) 
{ 
goldTime1ms = gTime1ms;

return 3;
}
}
}

void SaveInEeprom( void )
{
EEPROM_BODY mEDat;                            

memset((void *)&mEDat,0 ,sizeof( EEPROM_BODY));    

mEDat.AkFlag = 'A';
mEDat.Run  = gRunFlag?1:0;
mEDat.Dose1 = (BYTE)((gDose>>8)&0xff);
mEDat.Dose2 = (BYTE)(gDose&0xff);   
mEDat.Voltage = gVoltage ;
mEDat.Depth = gDepth;
mEDat.Speed = gSpeed;
mEDat.Flag  = gFlag;   
mEDat.Map1  = (gElMatrix[0]<<4)&0xf0 | gElMatrix[1]&0x0f;
mEDat.Map2  = (gElMatrix[2]<<4)&0xf0 | gElMatrix[3]&0x0f;            
E2pWriteLen((BYTE*)&mEDat, 10, sizeof( EEPROM_BODY));        
}

void LoadInEeprom( void ) 
{
BYTE mData[20];
LPEEPROM_BODY mEDat;                            

memset((void *)&mData,0 ,20 );
E2pReadLen( mData, 10, sizeof( EEPROM_BODY)); 
mEDat =(LPEEPROM_BODY)mData ;

if( mEDat->AkFlag == 'A' )
{
gMode = 0; 

gDose = (int)mEDat->Dose1<<8|mEDat->Dose2;
if( gDose < 0 ) gDose = 0;
if( gDose > 3 ) gDose = 3;     

gVoltage = mEDat->Voltage;   
if( gVoltage < 60 ) gVoltage = 60;
if( gVoltage > 120 ) gVoltage = 120;

gDepth = mEDat->Depth;
if( gDepth < 0 ) gDepth = 0;
if( gDepth > 3 ) gDepth = 3;

gSpeed = mEDat->Speed;  
if( gSpeed < 0 ) gSpeed = 0;
if( gSpeed > 2 ) gSpeed = 2;

gFlag = mEDat->Flag;       
gElMatrix[0] = (mEDat->Map1>>4)&0x0f;
gElMatrix[1] = mEDat->Map1&0x0f;
gElMatrix[2] = (mEDat->Map2>>4)&0x0f;
gElMatrix[3] = mEDat->Map2&0x0f;            

if( gVoltage > 50 ) PORTD.7 = 0;
else  PORTD.7 = 1  ;
}
else
{
InitData();           
SaveInEeprom();
}  
}

void ADCProcessor( void )
{  

int mIndexVol=0;     
int mVol;
int mTemp; 
float mCalvol;
mVol= read_adc( gAdcLoc );  

if( gAdcLoc == 0 )
{
if( mVol > 25)
{
gError |= (1<<ERROR_HEATSINK);  
gCurMode =  CUR_ERROR;
} 
else
{
gError &= ~(1<<ERROR_HEATSINK);  
}
}
else if( gAdcLoc == 1 )
{
if( gMode == MODE_READY && gFlag == FLAG_VOLADJ )
{        

if( gVoltage> 50 )
{       
if( gVolChkCount > 0 )
{
gVolChkCount--;
}                 
else   
{
if(gVoltage < 20 ) mIndexVol = 0;
else  mIndexVol = (gVoltage-20)/10;

mCalvol = DacArray[mIndexVol];

if( (float)mVol > (mCalvol-mCalvol*0.2f) && 
(float)mVol < (mCalvol+mCalvol*0.2f) )
{

gFlag = FLAG_READY;  
if( gError & (1<<ERROR_VOL) )
{             
gVolAdjCount++; 
if( gVolAdjCount > 3 )  
{ 
gVolAdjCount = 0;
gError &= ~(1<<ERROR_VOL);  
}  
}
else
{
gError &= ~(1<<ERROR_VOL);  
}   
}
else
{
gFlag = FLAG_VOLADJ;  
gVolAdjCount++; 
if( gVolAdjCount > 3 )  
{
gVolAdjCount = 0;              
gError |= (1<<ERROR_VOL);                
gCurMode =  CUR_ERROR;
} 
}
}
}   
else
{           
if( gVolChkCount > 0 )
{
gVolChkCount--;
}
else
{              
if(gVoltage < 20 ) mIndexVol = 0;
else  mIndexVol = (gVoltage-20)/10;

mCalvol = DacArray[mIndexVol];

if( (float)mVol > (mCalvol-mCalvol*0.2f) && 
(float)mVol < (mCalvol+mCalvol*0.2f) )
{
gFlag = FLAG_READY;   
if( gError & (1<<ERROR_VOL) )
{             
gVolAdjCount++; 
if( gVolAdjCount > 3 )  
{ 
gVolAdjCount = 0;
gError &= ~(1<<ERROR_VOL);  
}  
}
else
{ 
gError &= ~(1<<ERROR_VOL);  
}
}  
else
{
gFlag = FLAG_VOLADJ;  
gVolAdjCount++; 
if( gVolAdjCount > 3 )  
{
gVolAdjCount = 0;              
gError |= (1<<ERROR_VOL);                
gCurMode =  CUR_ERROR;
} 
}
}
}
}
else
{
gVolAdjCount = 0; 
}
}
else if( gAdcLoc == 2 )
{   
if( gRunFlag==1 && gElCompletFlag == 1 )
{   
gRunFlag = 0;
if( mVol > 25)
{  
gError &= ~(1<<ERROR_ELOUT);  

gElCount++;
if( gElCount > 999 ) gElCount = 999;    
(*(unsigned char *) 0x62) |= 0x80 ;
} 
else
{         
gError |= (1<<ERROR_ELOUT);  
gCurMode =  CUR_ERROR;

}   
PORTB.6 = 1;  
}        
}   
gAdcLoc++;
if( gAdcLoc > 2 ) gAdcLoc = 0;        
}

void DisplayLed( void )
{       
if( gError > 0  )      
{ 
(*(unsigned char *) 0x62) |= 0x40;  
(*(unsigned char *) 0x62) &= (~0x80); 
}
else
{
(*(unsigned char *) 0x62) &= (~0x40); 

if( gFlag == FLAG_COMPLETE )
(*(unsigned char *) 0x62) |= 0x80 ;
else  (*(unsigned char *) 0x62) &= (~0x80);
}
}
void UserProcessor( void )
{
if( gCurMode == CUR_INIT )
{             
DAC7611_WriteVoltage(0);             
(*(unsigned char *) 0x65) &= (~0x08);
(*(unsigned char *) 0x65) &= (~0x10);        
gMode = MODE_STOP;
gFlag = FLAG_STADNBY;    

gCurMode = CUR_OK;    

}
else if( gCurMode == CUR_OK )
{
ADCProcessor();      
DisplayLed();
} 
else if( gCurMode == CUR_ERROR )
{ 
gCurMode = CUR_INIT; 

(*(unsigned char *) 0x62) &= (~0x80); 
(*(unsigned char *) 0x62) |= 0x40;
}
}

void main()
{
BYTE wEvent;
int mTimeUart0,mTimeUart1;     

SystemInit( );

mTimeUart0 = mTimeUart1 = 0;    

#asm("sei");

while ( 1 )
{
wEvent = WaitEvent();
if( wEvent == 1 )
{
IPC_RunProcess0( );  
mTimeUart0 = 0;     
gError &= ~(1<<ERROR_NOTHANDLE); 
}
else if( wEvent == 2 )
{
IPC_RunProcess1( );  
mTimeUart1 = 0;
gError &= ~(1<<ERROR_NOTLCD);  
}
else if(wEvent == 3 )
{           
UserProcessor();  

if( ++mTimeUart0 > 7 ) 
{
mTimeUart0 = 0;
gError |= (1<<ERROR_NOTHANDLE);  
gCurMode = CUR_ERROR;
}
if( ++mTimeUart1 > 7 ) 
{
mTimeUart1 = 0;  
gError |= (1<<ERROR_NOTLCD); 
gCurMode = CUR_ERROR;
}    

if(!gSetVolagteInitTime &&  gRunFlag==0)
{ 
if( PIND.4 )
{                   
PORTC = 0x00; 
gError |= (1<<ERROR_VOL); 
gCurMode =  CUR_ERROR;   
}  
}

}    
}      
}


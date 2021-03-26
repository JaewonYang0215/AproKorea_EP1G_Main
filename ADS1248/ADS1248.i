
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
TH_CS = 0,
VOL_CS,
CUR_CS

} ADS1248_CS;

void ADS1248_init( void );

DWORD ADS1248_ADConvertData( void );
void ADS1248_ChangeChannel( BYTE Ch );
void AD_ReadExTTemp( void );
void AD_ReadPlate( void );
void AD_ReadVoltage( void );
void AD_ReadCurrent( void );

extern int gExtTemp;
extern int gVoltage;
extern int gCurrent;
extern int gCurTemp;

void ADS1248_WriteByte( BYTE data );
BYTE ADS1248_ReadByte( void  );
void ADS1248_WriteRegByte( BYTE addr, BYTE Data );
BYTE ADS1248_ReadRegByte( BYTE addr );
void ADS1248_StopReadCommand(void );
void ADS1248_ReadContinueCommand( void );
void ADS1248ResetCommand( void );
void ADS1248_ChangeChannel(  BYTE Ch );

void ADS1248_init( void )
{

SPCR=0x55;
SPSR=0x00;

ADS1248_StopReadCommand(  );
ADS1248ResetCommand(  );
ADS1248_WriteRegByte( 0, 0x05 );
ADS1248_WriteRegByte( 2, 0x28 ); 

ADS1248_WriteRegByte(  3, 0x03 );
}

void AD_ReadExTTemp( void )
{
float fTemp;
DWORD rTemp;
int   cTemp;

rTemp = ADS1248_ADConvertData(  );
fTemp =  5.0f*(float)rTemp/8388608.0f;

if( fTemp >= 1.0f ) fTemp -= 1.0f;    
fTemp = fTemp - (100.0f-(float)gCurTemp)*0.015f;
cTemp = (int)(fTemp/0.019f*10.0f);

if( cTemp > 1500 ) cTemp =  1500;
if( cTemp < 0 )    cTemp = 0;

gExtTemp = cTemp;
}

void AD_ReadVoltage( void )
{
float fTemp, fPin, fWatt;
float fV2;
DWORD rTemp;
int   cTemp;

rTemp = ADS1248_ADConvertData(  );
fTemp = 5.0f*(float)rTemp/8388608.0f ;

gVoltage = fTemp*10; 
}

void AD_ReadCurrent( void )
{
float fTemp, fPin, fWatt;
float  fI2;
DWORD rTemp;
int   cTemp;

rTemp = ADS1248_ADConvertData(  );
fTemp = 5.0f*(float)rTemp/8388608.0f ;

gCurrent = fTemp*10; 
}

void ADS1248_ChangeChannel(  BYTE Ch )
{
PORTC.1 = 0;
ADS1248_WriteRegByte( 0, 0x05|((Ch&0x07)<<3 ));

PORTC.1 = 1;
}

void ADS1248_ReadContinueCommand( void )
{
PORTC.1 = 0;
ADS1248_WriteByte( 0x14 )  ; 

PORTC.1 = 1;
delay_ms( 10 );
}

void ADS1248_StopReadCommand( void )
{
PORTC.1 = 0;

ADS1248_WriteByte( 0x16 )  ; 

PORTC.1 = 1;
delay_ms( 10 );
}

BYTE  ADS1248_ReadRegByte( BYTE addr )
{
BYTE temp;

PORTC.1 = 0;

ADS1248_WriteByte( 0x20|(addr&0x0f) );
ADS1248_WriteByte( 0x00 );
temp = ADS1248_ReadByte();

PORTC.1 = 1;

delay_ms( 1 );

return temp;
}

void  ADS1248_WriteRegByte( BYTE addr, BYTE Data )
{
PORTC.1 = 0;

ADS1248_WriteByte( 0x40|(addr&0x0f) );
ADS1248_WriteByte( 0x00 );
ADS1248_WriteByte( Data );
delay_us( 10 );

PORTC.1 = 1;

}

DWORD ADS1248_ADConvertData( void )
{
DWORD temp;
BYTE AD1, AD2, AD3;

PORTC.1 = 0;

ADS1248_WriteByte( 0x12 );

AD1 = ADS1248_ReadByte();
AD2 = ADS1248_ReadByte();
AD3 = ADS1248_ReadByte();
temp = ((DWORD)AD1)<<16|((DWORD)AD2)<<8|(DWORD)AD3 ;

PORTC.1 = 1;
return temp;
}

void ADS1248ResetCommand( void )
{

PORTC.1 = 1;

ADS1248_WriteByte( 0x06 );

delay_ms( 10 );

PORTC.1 = 0;
}

BYTE ADS1248_ReadByte( void  )
{
BYTE temp;

SPDR=0x00;
while(!(SPSR&0x80));
temp=SPDR;

return temp;
}

void ADS1248_WriteByte(BYTE data )
{
SPDR = data;
while(!(SPSR&0x80));
}


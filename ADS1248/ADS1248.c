#include <mega128.h>
#include <stdio.h>
#include <string.h>
#include <delay.h>
#include <float.h>
#include <math.h>

#include "ADS1248.h"

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
   // SPI initialization
   // SPI Type: Master
   // SPI Clock Rate: 1000.000 kHz
   // SPI Clock Phase: Cycle Half
   // SPI Clock Polarity: Low
   // SPI Data Order: MSB First
   SPCR=0x55;
   SPSR=0x00;

   ADS1248_StopReadCommand(  );
   ADS1248ResetCommand(  );
   ADS1248_WriteRegByte( 0, 0x05 );
   ADS1248_WriteRegByte( 2, 0x28 ); // 20140318 0x20 -> 0x08·Î
   // System Control Register 0
   //PGA : 1
   //DOR :  0101 = 160SPS , 1000 = 1000SPS , 0011 = 40SP
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

   // fPin = fTemp/0.025f-90.0f;
   // fWatt = pow( 10.0f, fPin/10.0f );

   // fV2 = sqrt( fWatt*189689.79f);

   // cTemp = (int)(fV2*12.5f);
 
    gVoltage = fTemp*10; //cTemp;
}

void AD_ReadCurrent( void )
{
  float fTemp, fPin, fWatt;
  float  fI2;
  DWORD rTemp;
  int   cTemp;

  rTemp = ADS1248_ADConvertData(  );
  fTemp = 5.0f*(float)rTemp/8388608.0f ;

  //fPin = fTemp/0.025f-90.0f;
  //fWatt = pow( 10.0f, fPin/10.0f );

 // fI2 = sqrt(fWatt*0.001f/9091.1752f)*1000.0f;
 // cTemp = (int)(fI2*1000.0f);
  gCurrent = fTemp*10; //cTemp;
}

void ADS1248_ChangeChannel(  BYTE Ch )
{
   LOW_ADS1248_CS1;
   ADS1248_WriteRegByte( 0, 0x05|((Ch&0x07)<<3 ));

   HIGH_ADS1248_CS1;
}

void ADS1248_ReadContinueCommand( void )
{
   LOW_ADS1248_CS1;
   ADS1248_WriteByte( CMD_ADS1248_RDATC )  ; // command

   HIGH_ADS1248_CS1;
   delay_ms( 10 );
}

void ADS1248_StopReadCommand( void )
{
   LOW_ADS1248_CS1;

   ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command

   HIGH_ADS1248_CS1;
   delay_ms( 10 );
}

BYTE  ADS1248_ReadRegByte( BYTE addr )
{
   BYTE temp;

   LOW_ADS1248_CS1;

   ADS1248_WriteByte( CMD_ADS1248_RREG|(addr&0x0f) );
   ADS1248_WriteByte( 0x00 );
   temp = ADS1248_ReadByte();

   HIGH_ADS1248_CS1;

   delay_ms( 1 );

   return temp;
}

void  ADS1248_WriteRegByte( BYTE addr, BYTE Data )
{
   LOW_ADS1248_CS1;

   //delay_us( 5 );
   ADS1248_WriteByte( CMD_ADS1248_WREG|(addr&0x0f) );
   ADS1248_WriteByte( 0x00 );
   ADS1248_WriteByte( Data );
   delay_us( 10 );

   HIGH_ADS1248_CS1;
   //delay_us( 10 );
}


DWORD ADS1248_ADConvertData( void )
{
   DWORD temp;
   BYTE AD1, AD2, AD3;

   LOW_ADS1248_CS1;
   // delay_us( 500 );
   //ADS1248_WriteByte( CMD_ADS1248_RDATC );
   ADS1248_WriteByte( CMD_ADS1248_RDAT );
  // SPDR;
  // delay_ms( 2 );

   AD1 = ADS1248_ReadByte();
   AD2 = ADS1248_ReadByte();
   AD3 = ADS1248_ReadByte();
   temp = ((DWORD)AD1)<<16|((DWORD)AD2)<<8|(DWORD)AD3 ;

  // ADS1248_WriteByte( CMD_ADS1248_SDATAC )  ; //SDATAC command

   HIGH_ADS1248_CS1;
   return temp;
}

void ADS1248ResetCommand( void )
{

  HIGH_ADS1248_CS1;


  ADS1248_WriteByte( CMD_ADS1248_RESET );

  delay_ms( 10 );

  LOW_ADS1248_CS1;
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


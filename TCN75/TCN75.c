#include <mega128.h>
#include <stdio.h>
#include <string.h>
#include <delay.h>
#include <float.h>

#include "TCN75.h"
#include "../I2cLib/I2CLib.h"


void TCN75_init( void )
{
    I2C_Write( TCN75_CHIP_ADDR, ACCESS_CONFIG , 0x00 );
}

int TCN75_Read( void )
{
     WORD temp;
     BYTE temperaturMSB, temperaturLSB;
     int Rval;

     I2C_Start();   // Start

     /*Device Address & Write mode */
     I2C_ShiftOut( TCN75_CHIP_ADDR );
     I2C_Ack();

     // Low Address
     I2C_ShiftOut( 0 ); // Pointer Byte TEMP Register selection
     I2C_Ack();

     // Start
     I2C_Start();
     // Device Address & Read mode
     I2C_ShiftOut( 0x01| TCN75_CHIP_ADDR );

     I2C_Ack();

      // Data Read
      temperaturMSB = I2C_ShiftIn();
      I2C_Ack();
      temperaturLSB = I2C_ShiftIn();
      I2C_Ack();

      /** bring SDA high while clock is high */
      I2C_Stop();

      temp = ((WORD)temperaturMSB<<1)&0x1fe|(temperaturLSB>>7&0x01);

      // MyPrint( "MSB =%x, MLSB= %X\r\n", temperaturMSB, temperaturLSB );

      if( temp > 0x0fa ) Rval = 0;
      else               Rval = (int)((float)temp*0.5f);

      if( Rval > 150 ) Rval = 150;

      return Rval;
 }

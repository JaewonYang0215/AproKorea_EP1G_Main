#include <mega128.h>
#include <stdio.h>
#include <string.h>
#include <delay.h>
#include <float.h>

#include "DAC7611.h"
#include "../I2cLib/I2CLib.h"  

//const BYTE VolArray[15] = {4, 8, 14, 21, 30, 40, 50, 65, 82, 93, 110, 124, 138, 150, 160};
//const BYTE VolArray[15] = {5, 8, 14, 20, 30, 40, 53, 65, 82, 93, 110, 124, 138, 150, 160};
 
                           //20 30 40  50  60  70  80  90  100 110 120  130  140  150  160   2020-10-21 
const BYTE VolArray[15] =   {5, 11, 18, 26, 40, 51, 63, 74, 85, 93, 109, 124, 138, 150, 160}; 

void DAC7611_init( void )
{
   DAC7611_Write( 0 );
}

void DAC7611_WriteVoltage( int data )
{
   WORD temp;
   int mRefVol;
              
   if(data < 20 )  
   {
      mRefVol = 0;
   }
   else
   {      
      mRefVol =  (data-20)/10;
      mRefVol = VolArray[mRefVol];
   }
       
   temp = (WORD)(4095.0f/160.0f* (float)mRefVol);

   DAC7611_Write( temp );
}

void DAC7611_Write( WORD data )
{
     int i;
     WORD temp;

     HIGH_LD;
     HIGH_SCLK;
     LOW_CS;

     for( i=0; i<12; i++ )
     {
        /* right shift */
       temp = data & ( 0x800>>i );

       if( temp ) HIGH_SDA;    /* high data  */
       else       LOW_SDA;

       i2c_delay();
       LOW_SCLK;          /* high clock */
       i2c_delay();
       HIGH_SCLK;         /* low clock    */
       i2c_delay();
     }

     HIGH_CS;

     LOW_LD;
     i2c_delay();
     HIGH_LD;
}

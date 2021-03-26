#include <mega128.h>
#include <stdio.h>
#include  "I2CLib.h"

BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
{
     WORD i;

#ifdef CFG_I2C_HIGH_ADDRESS
   if( address > 0x1fff)
       return ERROR;
#else
   if( address > 0xff)
       return ERROR;
#endif
     /* Start */
     I2C_Start();
     /*Device Address & Write mode */
     I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
     I2C_Ack();

#ifdef CFG_I2C_HIGH_ADDRESS
     I2C_ShiftOut( (address>>8)&0xff ); /* High Address */
     I2C_Ack();
#endif

     I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );   /* Low Address */
     I2C_Ack();

     for( i=0; i< Count; i++ )
     {
    /* Data Read  */
    I2C_ShiftOut( Data[i] );
           I2C_Ack();
     }
    // I2C_Ack();

     /** bring SDA high while clock is high */
     I2C_Stop();

     //for( i=0; i<500; i++ )
           i2c_delay();        /* 10mSec delay(no test) */

     return OK;
}


BYTE I2C_Write( BYTE ChipAddr, WORD address, BYTE dat )
{
   //WORD i;

#ifdef CFG_I2C_HIGH_ADDRESS
   if( address > 0x1fff)
       return ERROR;
#else
   if( address > 0xff)
       return ERROR;
#endif

   I2C_Start();  // Start

   // Device Address & Write mode
   I2C_ShiftOut( ChipAddr&0xfe );
   I2C_Ack();

#ifdef   CFG_I2C_HIGH_ADDRESS
   // High Address
   I2C_ShiftOut( (address>>8)&0xff );
   I2C_Ack();
#endif

   // Low Address
   I2C_ShiftOut( address&0xff );
   I2C_Ack();

   I2C_ShiftOut( dat );     // write data
   I2C_Ack();

   // bring SDA high while clock is high
   I2C_Stop();

   //for( i=0; i<400; i++ )
        i2c_delay();        //10mSec delay(no test)

   return OK;
}

void i2c_delay(void)
{
  // int i;

//   for( i=0; i<10;i++ )    //
 //    for( i=0; i<2;i++ )    //

       #asm( "nop" );
}

BYTE I2C_Ack(void )
{
     BYTE Ack;

     HIGH_SDA;

     I2C_R_MODE; //DDRC.2 = 0;
     HIGH_SCLK;
     i2c_delay();
     Ack = IN_SDA;
     i2c_delay();
     LOW_SCLK;

     I2C_W_MODE; //DDRC.2 = 1;
     i2c_delay();

     if( Ack )
        return ERROR;

     return OK;
}

BYTE I2C_OutAck( BYTE Flag  )
{
       //BYTE Ack;

       if( Flag )    HIGH_SDA;
        else        LOW_SDA;
       /*LOW_SCLK; */

       /*i2c_delay(); */
       HIGH_SCLK;
      // Ack = IN_SDA;//ioport1&0x80;
       i2c_delay();
       LOW_SCLK;

       i2c_delay();

       //if( Ack )
//    return ERROR;

       return OK;
}


BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count )
{
     WORD i;

#ifdef CFG_I2C_HIGH_ADDRESS
   if( address > 0x1fff)
       return ERROR;
#else
   if( address > 0xff)
       return ERROR;
#endif
     /* Start */
     I2C_Start();
     // Device Address & Write mod
     I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
     I2C_Ack();

#ifdef CFG_I2C_HIGH_ADDRESS
     // High Address
     I2C_ShiftOut( (address>>8)&0xff );
     I2C_Ack();
#endif
     // Low Address
     I2C_ShiftOut( address&0xff );
     I2C_Ack();

     /* Start */
     I2C_Start();
     /*Device Address & Read mode */
     I2C_ShiftOut( 0x01|(BYTE)(ChipAddr&0xff) );
     I2C_Ack();

     for( i=0; i< Count-1; i++ )
     {
     /* Data Read  */
     Data[i] = I2C_ShiftIn();
           // I2C_Ack();
           I2C_OutAck( FALSE );
     }
      Data[i] =    I2C_ShiftIn();
      I2C_OutAck( TRUE );
     //I2C_Ack();
     /** bring SDA high while clock is high */
     I2C_Stop();

     return OK;
}

BYTE I2C_Read( BYTE ChipAddr, WORD address )
{
     BYTE Dat;

#ifdef CFG_I2C_HIGH_ADDRESS
   if( address > 0x1fff)
       return ERROR;
#else
   if( address > 0xff)
       return ERROR;
#endif

     I2C_Start();   // Start

     /*Device Address & Write mode */
     I2C_ShiftOut( (BYTE)(ChipAddr&0xff) );
     I2C_Ack();

#ifdef CFG_I2C_HIGH_ADDRESS
     // High Address
     I2C_ShiftOut( (address>>8)&0xff );
     I2C_Ack();
#endif

     // Low Address
     I2C_ShiftOut( address&0xff );
     I2C_Ack();

     // Start
     I2C_Start();
     // Device Address & Read mode
     I2C_ShiftOut( 0x01| (BYTE)(ChipAddr&0xff) );

     I2C_Ack();

      // Data Read
      Dat = I2C_ShiftIn();
      I2C_Ack();

      /** bring SDA high while clock is high */
      I2C_Stop();

     return Dat;
}
/*
BYTE I2C_Read( BYTE ChipAddr, WORD address )
{
     BYTE Dat;

#ifdef CFG_I2C_HIGH_ADDRESS
   if( address > 0x1fff)
       return ERROR;
#else
   if( address > 0xff)
       return ERROR;
#endif

     I2C_Start();   // Start

     //Device Address & Write mode
     I2C_ShiftOut(  (BYTE)((ChipAddr<<1)&0x0e) );
     I2C_Ack();

#ifdef CFG_I2C_HIGH_ADDRESS
     // High Address
     I2C_ShiftOut( (address>>8)&0xff );
     I2C_Ack();
#endif

     // Low Address
     I2C_ShiftOut( address&0xff );

     I2C_Ack();

     // Start
     I2C_Start();

     // Device Address & Read mode
     I2C_ShiftOut( 0x01| (BYTE)((ChipAddr<<1)&0x0e)  );

     I2C_Ack();

      // Data Read
      Dat = I2C_ShiftIn();

      I2C_Ack();

      // bring SDA high while clock is high
            I2C_Stop();

     return Dat;
}
*/
void I2C_Start(void )
{
      HIGH_SDA;    /* high serial data  */
      HIGH_SCLK;   /* high serial clock */
      i2c_delay();
      LOW_SDA;     /* low  serial data */
      i2c_delay();
      LOW_SCLK;    /* low  serial clock */
      i2c_delay();
}

void I2C_Stop( void )
{
     LOW_SCLK;
     LOW_SDA;      /* low serial data */
     i2c_delay();
     HIGH_SCLK;    /* high serial clock */
     i2c_delay();
     HIGH_SDA;     /* high serial data      */
}

void I2C_ShiftOut( BYTE dat )
{
     BYTE i,temp;

     for( i=0; i<8; i++ )
     {
        /* right shift */
        temp = dat & ( 0x80>>i );

       if( temp )   HIGH_SDA;    /* high data   */
       else         LOW_SDA;
       i2c_delay();
       HIGH_SCLK;              /* high clock   */
       i2c_delay();
       LOW_SCLK;               /* low clock    */
       i2c_delay();
     }
}

BYTE I2C_ShiftIn( void )
{
     BYTE i=0,temp;
     BYTE Dat=0;

     HIGH_SDA;
     I2C_R_MODE;      // input mode
     for( i=0; i<8; i++ )
     {
          //  HIGH_SDA;
          HIGH_SCLK;         /* high serial clock    */
          i2c_delay();

          temp = IN_SDA;     // &0x80;
          Dat |= ( temp<<(7-i) );

          i2c_delay();
          LOW_SCLK;          /* low serial clock; */
          i2c_delay();
     }

      I2C_W_MODE;   // output mode

     return Dat;
}

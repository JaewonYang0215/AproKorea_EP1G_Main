#include <stdio.h>
#include "SpiLib.h"

BYTE Spi_ReadByte( void  )
{
   BYTE temp;

   SPDR = 0xff;
   while(!(SPSR&0x80));
   temp=SPDR;

   return temp;
}

void Spi_WriteByte(BYTE data )
{
   SPDR = data;
   while(!(SPSR&0x80));
   data = SPDR;
}

#include <mega128.h>
#include "InEepromLib.h"

#define  EEWE    1
#define  EEMWE   2    
#define  EERE    0                            

void _EEPROMWrite( WORD addr, BYTE data )
{
     while( EECR & (1 << EEWE) );
     EEAR = addr;
     EEDR = data;
     EECR |= ( 1 << EEMWE);
     EECR |= ( 1 << EEWE);
}   

BYTE _EEPROMRead( WORD addr)
{
     while( EECR & (1 << EEWE) );
     EEAR = addr;
     EECR |= ( 1 << EERE);
     return EEDR;
}
BYTE E2pRead( WORD Addr )
{
    return _EEPROMRead( Addr );
}
void E2pReadLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
{
    int i;

    for( i=0; i< nLen; i++ )
    {
        bDat[i] = _EEPROMRead( bAddr+i );
    }    
}
void E2pWriteLen( BYTE *bDat, BYTE bAddr, BYTE nLen )
{
    int i;
    for( i=0; i< nLen; i++)
    {
       _EEPROMWrite( bAddr+i, bDat[i] );    
    }    
}

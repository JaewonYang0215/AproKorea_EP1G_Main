#ifndef   __INEEPROM_HEADER
#define   __INEEPROM_HEADER                 

#include     "../UserDefine.h"
#include "../IPC/IPClib.h"   


#define E_EP_MODE    10

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

#endif

#ifndef   __MYI2C_HEADER
#define   __MYI2C_HEADER                 

#include "../UserDefine.h"

/* eeprom function */
BYTE I2C_Write( BYTE ChipAddr,WORD address, BYTE dat );  /* unsigned char Write     */
BYTE I2C_WriteSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count );
void I2C_ShiftOut( BYTE dat );               /* Data Shift Out  */ 
BYTE I2C_ShiftIn( void );                    /* Data Shift In   */
BYTE I2C_Read( BYTE ChipAddr,WORD address ); /* 1unsigned char Read      */ 
BYTE I2C_ReadSeq( BYTE ChipAddr,WORD address, BYTE *Data, WORD Count );
BYTE I2C_Ack( void );                        /* i2c Acknowledge */
BYTE I2C_OutAck( BYTE Flag  );
void I2C_Start( void );                      /* i2c Start       */
void I2C_Stop( void );                       /* i2c Stop        */
void i2c_delay(void );   

#endif


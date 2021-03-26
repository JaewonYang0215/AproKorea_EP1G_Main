#ifndef   __ADS1248_HEADER__
#define   __ADS1248_HEADER__

#include "../UserDefine.h"

/*
typedef enum
{
     PLATE = 0,
     TH_CH1,
     TH_CH2,
     TH_CH3,
     TH_CH4,
     VOL_CH1,
     CUR_CH1,
     VOL_CH2,
     CUR_CH2,
     VOL_CH3,
     CUR_CH3,
     VOL_CH4,
     CUR_CH4

} ADS1248_CHANNEL;
*/
typedef enum
{
     TH_CS = 0,
     VOL_CS,
     CUR_CS

} ADS1248_CS;


#define CMD_ADS1248_SDATAC    0x16
#define CMD_ADS1248_RREG      0x20
#define CMD_ADS1248_WREG      0x40
#define CMD_ADS1248_RDAT      0x12
#define CMD_ADS1248_RDATC     0x14
#define CMD_ADS1248_RESET     0x06

void ADS1248_init( void );
//void ADS1248_Write( WORD data );
DWORD ADS1248_ADConvertData( void );
void ADS1248_ChangeChannel( BYTE Ch );
void AD_ReadExTTemp( void );
void AD_ReadPlate( void );
void AD_ReadVoltage( void );
void AD_ReadCurrent( void );

#endif

#ifndef   __DAC7611_HEADER__
#define   __DAC7611_HEADER__

#include "../UserDefine.h"

//#define TCN75_CHIP_ADDR      0x90
//#define ACCESS_CONFIG 0x01

void DAC7611_init( void );
void DAC7611_Write( WORD data );
void DAC7611_WriteVoltage( int data );

#endif

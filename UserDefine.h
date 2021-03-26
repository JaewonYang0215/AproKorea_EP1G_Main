#ifndef __DEFINE_H__
#define __DEFINE_H__

typedef unsigned char   Uchar;      // UINT8
typedef   signed char   Schar;      // INT8
typedef unsigned short  Ushort;     // UINT16
typedef   signed short  Sshort;     // INT16
typedef unsigned  int   Uint;       // UINT32
typedef   signed  int   Sint;       // INT32
typedef unsigned long   Ulong;      // UINT64
typedef   signed long   Slong;      // INT64

typedef unsigned char   UI8;
typedef unsigned char   BYTE;
typedef signed char        SI8;
typedef unsigned int      UI16;
typedef unsigned int      WORD;
typedef signed int           SI16;
typedef unsigned long   DWORD;
typedef unsigned long   UI32;

#define    OK                    0x00               /* Response ok    */
#define    ERROR                 0xff               /* Response Error */

#define    BOOL	                 BYTE
#define    TRUE	                 1
#define    FALSE                 0
#define    KEYSET                1
#define    KEYCLR                0

#define   EVN_NONE               0
#define   EVN_RCVUART0           1
#define   EVN_RCVUART1           2
#define   EVN_TIMEOVER           3

#define   MAX_CHANNEL             4

//adc channel
#define ADC_PLATE                4
#define  ADC_HEAT                 5

//I2C
#define HIGH_SDA               PORTA.0 = 1
#define HIGH_SCLK              PORTA.1 = 1
#define LOW_SDA                PORTA.0 = 0
#define LOW_SCLK               PORTA.1 = 0
#define I2C_R_MODE             DDRA.0 = 0
#define I2C_W_MODE             DDRA.0 = 1
#define IN_SDA                 PINA.0

//DAC7611
#define HIGH_CS                PORTA.2 = 1
#define LOW_CS                 PORTA.2 = 0
#define HIGH_LD                PORTA.3 = 1
#define LOW_LD                 PORTA.3 = 0

//LF398 Sample Hold out
#define HIGH_SH                PORTB.6 = 1
#define LOW_SH                 PORTB.6 = 0

// LED
#define HIGH_COMPLETE_LED     PORTF |= 0x80 
#define HIGH_WARRING_LED     PORTF |= 0x40

#define LOW_COMPLETE_LED     PORTF &= (~0x80)
#define LOW_WARRING_LED     PORTF &= (~0x40)

#define HIGH_PGM1_LED       PORTA.4 = 1
#define HIGH_PGM2_LED       PORTA.5 = 1
#define LED_PGM1_LED        PORTA.4 = 0
#define LED_PGM2_LED        PORTA.5 = 0


#define HIGH_OUTRY     PORTG |= 0x10  
#define LOW_OUTRY      PORTG &= (~0x10)

#define HIGH_PWM     PORTG |= 0x08 
#define LOW_PWM      PORTG &= (~0x08)

// voltage Read Relay 
#define HIGH_VOLRY     PORTD.7 = 1  
#define LOW_VOLRY      PORTD.7 = 0

#define IN_FET_SEN     PIND.4

typedef enum
{
   FLAG_STADNBY = 0,
   FLAG_VOLADJ,
   FLAG_READY,
   FLAG_SHOOTING,
   FLAG_COMPLETE,
   FLAG_EM_STOP
} SYSTEM_FLAG;

typedef enum
{
   MODE_STOP = 0, 
   MODE_READY,
   MODE_START
} SYSTEM_MODE;

#define ERROR_NO 0 
typedef enum
{
   ERROR_VOL=0, 
   ERROR_ELOUT,
   ERROR_MOTOR1,
   ERROR_MOTOR2,
   ERROR_HEATSINK,
   ERROR_NOTHANDLE,
   ERROR_NOTLCD,
   ERROR_EM_STOP  
} SYSTEM_ERROR;


typedef enum
{
    CUR_INIT = 0,
    CUR_OK, 
    CUR_ERROR
} CURRENT_MODE; 


#endif  
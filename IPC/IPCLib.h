#ifndef   __IPC_HEADER
#define   __IPC_HEADER                 

#include "../UserDefine.h"

#define IPC_MODE_READ          'R'
#define IPC_MODE_WRITE         'W'


typedef enum
{
     EP_MODE = 0,
     EP_RUN,
     EP_DOSE,
     EP_VOLTAGE,
     EP_DEPTH,
     EP_SPEED, 
     EP_EL_COUNT, 
     EP_FLAG,  
     EP_EL_MAP,
     EP_MOTOR_POS1,
     EP_MOTOR_POS2,
     EP_ERROR,              
     //
     SYS_OK     =  0x80,
     SYS_ERROR

} IPC_COMMAND;
   
typedef struct _IPC_HEADER
{
   BYTE stx;
   BYTE RWflag;
   BYTE Command;
   BYTE data1;
   BYTE data2;
   BYTE checksum;
   BYTE etx;
} *LPIPC_HEADER, IPC_HEADER;

typedef enum
{
     ERR_NO = 0,
     ERR_LOW_TEMP,
     ERR_HIGH_TEMP,
     ERR_LOW_IMP,
     ERR_HIGH_IMP,   
     ERR_OVER_TEMP

} CHANNEL_ERROR;

BYTE MakeCrc( BYTE *Data, int Len );
void IPC_RunProcess1( void );
void IPC_RcvProcess1( BYTE *Data );
void IPC_SndProcess1( BYTE *Data );
void IPC_Send_Response1( BYTE *Data, BYTE Res );

void IPC_RunProcess0( void );
void IPC_RcvProcess0( BYTE *Data );
void IPC_SndProcess0( BYTE *Data );
void IPC_Send_Response0( BYTE *Data, BYTE Res );      

#endif       

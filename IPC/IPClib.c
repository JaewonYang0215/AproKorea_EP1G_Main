#include <stdio.h>
#include "IPCLib.h"
#include <string.h>
#include <math.h>
#include "../Uart/uart.h"        
#include "../I2CLib/I2CLIb.h"
#include "../InADC/InAdc.h"
#include "../DAC7611/DAC7611.h"
       
extern BYTE gElMatrix[4];       
extern WORD goldTime1ms;
extern WORD gTime1ms; 
extern int gVoltage; 
extern BYTE gMode;
extern BOOL gRunFlag;
extern int gDose;
extern int gDepth; 
extern int gSpeed;
extern BYTE gFlag;
extern BYTE gError;
extern int gMotorPos1;
extern int gMotorPos2;
extern BOOL gElCompletFlag;
extern int  gElCount;
//extern int  gReadVol;
extern BYTE gCurMode;
extern BOOL gReadyActionFlag;
extern int  gVolChkCount;

extern void SaveInEeprom( void );
BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead );
BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead );
BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead );
BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead );
BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead );
typedef BYTE(*RunFun) (LPIPC_HEADER pHead );       
     
RunFun IPC1Rcvfun[]=
{
     IPC1_RCV_MODE,
     IPC1_RCV_RUN, 
     IPC1_RCV_DOSE,
     IPC1_RCV_VOLTAGE,	
     IPC1_RCV_DEPTH,
     IPC1_RCV_SPEED, 
     IPC1_RCV_ELCOUNT,
     IPC1_RCV_FLAG,
     IPC1_RCV_EL_MAP,
     IPC1_RCV_MOTOR_POS1,
     IPC1_RCV_MOTOR_POS2,
     IPC1_RCV_ERROR    
};                  

BYTE IPC1_RCV_MODE( LPIPC_HEADER pHead )
{
    return TRUE;
}      

BYTE IPC1_RCV_RUN( LPIPC_HEADER pHead )
{
   //gRunFlag =  pHead->data1;     
   //gRunFlag = gRunFlag?TRUE:FALSE; 
   BOOL mFlag =  pHead->data1? TRUE:FALSE;
   if( mFlag )
       SaveInEeprom();    
       
   return TRUE;
}   
   
BYTE IPC1_RCV_DOSE( LPIPC_HEADER pHead )
{    
   gDose = pHead->data2 | ((int)pHead->data1<<8);  
   if( gDose < 0 ) gDose = 0;
   if( gDose > 3 ) gDose = 3;     

   return TRUE;
} 
                                                              
BYTE IPC1_RCV_VOLTAGE( LPIPC_HEADER pHead )
{
   gVoltage = pHead->data1; 
   if( gVoltage < 60 ) gVoltage = 60;
   if( gVoltage > 120 ) gVoltage = 120;
    
   if( gVoltage > 50 ) LOW_VOLRY;
   else  HIGH_VOLRY;
       
  // DAC7611_WriteVoltage(gVoltage);  
   
   return TRUE;
}

BYTE IPC1_RCV_DEPTH( LPIPC_HEADER pHead )
{
   gDepth = pHead->data1; 
   if( gDepth < 0 ) gDepth = 0;
   if( gDepth > 3 ) gDepth = 3;
   
   return TRUE;
}

BYTE IPC1_RCV_SPEED( LPIPC_HEADER pHead )
{
   gSpeed = pHead->data1; 
   if( gSpeed < 0 ) gSpeed = 0;
   if( gSpeed > 2 ) gSpeed = 2;
   
   return TRUE;
}

BYTE IPC1_RCV_ELCOUNT( LPIPC_HEADER pHead )
{
   gElCount = pHead->data1; 
   if( gElCount < 0 ) gElCount = 0;
   if( gElCount > 100 ) gElCount = 100;
   
   return TRUE;
}

BYTE IPC1_RCV_FLAG( LPIPC_HEADER pHead )
{
   gFlag = pHead->data2;

   return TRUE;
} 
 
BYTE IPC1_RCV_EL_MAP( LPIPC_HEADER pHead )
{
   gElMatrix[0] = (BYTE)((pHead->data1>>4)&0xf); 
   gElMatrix[1] = (BYTE)(pHead->data1&0xf);
   gElMatrix[2] = (BYTE)((pHead->data2>>4)&0xf); 
   gElMatrix[3] = (BYTE)(pHead->data2&0xf);     

   return TRUE;
}

BYTE IPC1_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
{ 
   return TRUE;
}

BYTE IPC1_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
{
   return TRUE;
}

BYTE IPC1_RCV_ERROR( LPIPC_HEADER pHead )
{
   BYTE mErrPos = pHead->data1; 
   BOOL mSetClearFlag = pHead->data2?TRUE:FALSE;
      
   if( mErrPos> ERROR_EM_STOP )                    
       mErrPos = ERROR_EM_STOP;               
        
   if( mSetClearFlag )
        gError &= ~(1<<mErrPos);  
   else gError |= (1<<mErrPos); 
   
   return TRUE;
}

BYTE IPC1_SND_MODE( LPIPC_HEADER pHead );
BYTE IPC1_SND_RUN( LPIPC_HEADER pHead );
BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead );
BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead );
BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead );
BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead );
BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead ); 
typedef BYTE(*SenFun) (LPIPC_HEADER pHead);    
       
SenFun IPC1Sndfun[]=
{                                 
     IPC1_SND_MODE, 
     IPC1_SND_RUN, 
     IPC1_SND_DOSE,      
     IPC1_SND_VOLTAGE,	
     IPC1_SND_DEPTH, 
     IPC1_SND_SPEED,
     IPC1_SND_ELCOUNT,
     IPC1_SND_FLAG,
     IPC1_SND_EL_MAP,
     IPC1_SND_MOTOR_POS1,
     IPC1_SND_MOTOR_POS2,
     IPC1_SND_ERROR
};          
      
BYTE IPC1_SND_MODE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = 0;//(BYTE)((gMode>>8)&0xff);  //
   pHead->data2 = (BYTE)(gMode&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}
BYTE IPC1_SND_RUN( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = 1;  //
   pHead->data2 = (BYTE)(gRunFlag&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}

BYTE IPC1_SND_DOSE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gDose>>8)&0xff); 
   pHead->data2 = (BYTE)(gDose&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}

BYTE IPC1_SND_VOLTAGE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  //
   pHead->data2 = (BYTE)(gVoltage&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   
   return TRUE;
}

BYTE IPC1_SND_DEPTH( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gDepth>>8)&0xff);  //
   pHead->data2 = (BYTE)(gDepth&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) );

   return TRUE;

}

BYTE IPC1_SND_SPEED( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  //
   pHead->data2 = (BYTE)(gSpeed&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   return TRUE;

}

BYTE IPC1_SND_ELCOUNT( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gElCount>>8)&0xff);  //
   pHead->data2 = (BYTE)(gElCount&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   return TRUE;        
}
 
BYTE IPC1_SND_FLAG( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)(gRunFlag&0xff);
   pHead->data2 = (BYTE)(gFlag&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}
   
BYTE IPC1_SND_EL_MAP( LPIPC_HEADER pHead )
{  
   pHead->Command = SYS_OK;
   pHead->data1  = (gElMatrix[0]&0x0f)<<4 | (gElMatrix[1]&0x0f); 
   pHead->data2  = (gElMatrix[2]&0x0f)<<4 | (gElMatrix[3]&0x0f); 

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;  
}      

BYTE IPC1_SND_MOTOR_POS1( LPIPC_HEADER pHead )
{  
   pHead->Command = SYS_OK;
   pHead->data1  = (BYTE)((gMotorPos1>>8)&0xff);
   pHead->data2  = (BYTE)(gMotorPos1&0xff); 

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}

BYTE IPC1_SND_MOTOR_POS2( LPIPC_HEADER pHead )
{  
   pHead->Command = SYS_OK;
   pHead->data1  = (BYTE)((gMotorPos2>>8)&0xff);
   pHead->data2  = (BYTE)(gMotorPos2&0xff); 

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}

BYTE IPC1_SND_ERROR( LPIPC_HEADER pHead )
{
   
   pHead->Command = SYS_OK;
   pHead->data1 = 0;
   pHead->data2 = gError;;

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData1( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
     
   gReadyActionFlag=TRUE;
   return TRUE;

}

BYTE MakeCrc( BYTE *Data, int Len )
{
     int i;
     BYTE CRC;

     CRC = 0;

     for( i=0; i<Len ; i++ )
          CRC += Data[i];

     return CRC;
}

void IPC_RunProcess1( void )
{
     BYTE RcvHead[30];
     BYTE RcvByte;
     BYTE  Crc,RcvCrc;
     LPIPC_HEADER pHead;

  //   while( TRUE )
     {
        RcvByte = IPC_RcvData_Interrupt1( RcvHead, sizeof( IPC_HEADER ) );
        pHead = ( LPIPC_HEADER )RcvHead;

         Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
         RcvCrc = pHead->checksum;

         if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
              pHead->stx == 0x02 && pHead->etx == 0x03 )
         {
              if( pHead->RWflag ==  IPC_MODE_READ )
                   IPC_SndProcess1( RcvHead );
              else IPC_RcvProcess1( RcvHead );

          }
          else
          {
             IPC_Send_Response1( RcvHead, SYS_ERROR);
             IPC_ResetCount1();
          }

     }

}
 void IPC_Send_Response1( BYTE *Data, BYTE Res )
{
     LPIPC_HEADER mLpHead;

     mLpHead = (LPIPC_HEADER)Data;

     mLpHead->Command = Res;
     mLpHead->data1 = 0;
     mLpHead->data2 = 0;
     mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );

     IPC_SendData1( Data, sizeof( IPC_HEADER ) );
}

void IPC_RcvProcess1( BYTE *Data )
{
      LPIPC_HEADER pHead;

      pHead   = (LPIPC_HEADER)Data;
      if(  pHead->Command < sizeof(IPC1Rcvfun)/2 )
      {
             if( IPC1Rcvfun[pHead->Command]( pHead ) == TRUE )        //  Run Command
             {
                 IPC_Send_Response1( Data, SYS_OK );
             }
             else
             {
                 IPC_Send_Response1( Data, SYS_ERROR);
              }
       }
       else
       {
           IPC_Send_Response1( Data, SYS_ERROR );
        }

}


void IPC_SndProcess1( BYTE *Data )
{
      LPIPC_HEADER pHead;

      pHead = (LPIPC_HEADER)Data;
      if(   pHead->Command < sizeof(IPC1Sndfun)/2  )
      {
          if( IPC1Sndfun[pHead->Command]( pHead ) == FALSE )        //  Run Command
              IPC_Send_Response1( Data, SYS_ERROR );
      }
      else
      {
           IPC_Send_Response1( Data, SYS_ERROR );
      }
}        


BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead );
BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead );
BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead );
BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead );
BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead );
//typedef BYTE(*RunFun) (LPIPC_HEADER pHead );       
     
RunFun IPC0Rcvfun[]=
{
     IPC0_RCV_MODE,
     IPC0_RCV_RUN, 
     IPC0_RCV_DOSE,
     IPC0_RCV_VOLTAGE,	
     IPC0_RCV_DEPTH,
     IPC0_RCV_SPEED, 
     IPC0_RCV_ELCOUNT,
     IPC0_RCV_FLAG,
     IPC0_RCV_EL_MAP,
     IPC0_RCV_MOTOR_POS1,
     IPC0_RCV_MOTOR_POS2,  
     IPC0_RCV_ERROR
};                  

BYTE IPC0_RCV_MODE( LPIPC_HEADER pHead )
{
   gMode = pHead->data2;
        
   if( gMode == MODE_READY ) //ready 
   {        
      //gElCount = 0;
      PORTC = 0x00;            
      HIGH_PWM;
      DAC7611_WriteVoltage(gVoltage);   
      HIGH_OUTRY;         
      
      gError = ERROR_NO;  
      gFlag = FLAG_VOLADJ;
      
      gVolChkCount = 2;
      
      //LOW_COMPLETE_LED; 
      //LOW_WARRING_LED;
   }
   else //if( gMode == MODE_STOP )
   {   
       PORTC = 0x00;  
       DAC7611_WriteVoltage(0);             
       LOW_PWM;
       LOW_OUTRY;   
      // gError = ERROR_NO;  
       gFlag = FLAG_STADNBY;
       
      // LOW_COMPLETE_LED; 
      //LOW_WARRING_LED;       
   }   
            
   gRunFlag = FALSE;
   gElCompletFlag = FALSE;     
   return TRUE;
}      

BYTE IPC0_RCV_RUN( LPIPC_HEADER pHead )
{
   if( gFlag == FLAG_SHOOTING ) //ready
   {    
      // HIGH_SH;
       gRunFlag = pHead->data2?TRUE:FALSE;    
       
       gElCompletFlag = FALSE;      
       LOW_SH;    
   } 
   else
   {
       PORTC = 0x00;  
       DAC7611_WriteVoltage(0);             
       LOW_PWM;
       LOW_OUTRY;   
      // gError = ERROR_NO;  
       gFlag = FLAG_STADNBY;   
   }
   return TRUE;
}   
   
BYTE IPC0_RCV_DOSE( LPIPC_HEADER pHead )
{    
   
   return TRUE;
}     
                                                          
BYTE IPC0_RCV_VOLTAGE( LPIPC_HEADER pHead )
{
   return TRUE;
}

BYTE IPC0_RCV_DEPTH( LPIPC_HEADER pHead )
{
   return TRUE;
}
BYTE IPC0_RCV_SPEED( LPIPC_HEADER pHead )
{
   return TRUE;
}
BYTE IPC0_RCV_ELCOUNT( LPIPC_HEADER pHead )
{
   return TRUE;
}

 BYTE IPC0_RCV_FLAG( LPIPC_HEADER pHead )
{
   BYTE mFlag;
   mFlag = pHead->data2;
   
   if( mFlag > FLAG_EM_STOP) 
       gFlag = FLAG_EM_STOP;
   else gFlag = mFlag;   
   
   return TRUE;
}
BYTE IPC0_RCV_EL_MAP( LPIPC_HEADER pHead )
{
   return TRUE;
}

BYTE IPC0_RCV_MOTOR_POS1( LPIPC_HEADER pHead )
{
   WORD temp;
   temp = ((WORD)pHead->data1)<<8|pHead->data2;
   gMotorPos1 = temp;
    
   return TRUE;
}

BYTE IPC0_RCV_MOTOR_POS2( LPIPC_HEADER pHead )
{
   WORD temp;
   temp = ((WORD)pHead->data1)<<8|pHead->data2;
   gMotorPos2 = temp;
    
   return TRUE;
}

BYTE IPC0_RCV_ERROR( LPIPC_HEADER pHead )
{
   BYTE mErrPos = pHead->data1;    
   
   if( mErrPos> ERROR_EM_STOP ) 
       mErrPos = ERROR_EM_STOP;
       
   if( mErrPos == ERROR_EM_STOP )  //2021-01-12
      gFlag = FLAG_EM_STOP;    
   
   gError |= (1<<mErrPos); 
 
   gCurMode = CUR_ERROR;
   
   return TRUE;
}
BYTE IPC0_SND_MODE( LPIPC_HEADER pHead );
BYTE IPC0_SND_RUN( LPIPC_HEADER pHead );
BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead );
BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead );
BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead );
BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead );
BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead );
BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead );
BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead );
BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead );
BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead );
BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead ); 
//typedef BYTE(*SenFun) (LPIPC_HEADER pHead);    
       
SenFun IPC0Sndfun[]=
{                                 
     IPC0_SND_MODE, 
     IPC0_SND_RUN, 
     IPC0_SND_DOSE,      
     IPC0_SND_VOLTAGE,	
     IPC0_SND_DEPTH, 
     IPC0_SND_SPEED,
     IPC0_SND_ELCOUNT, 
     IPC0_SND_FLAG,
     IPC0_SND_EL_MAP,
     IPC0_SND_MOTOR_POS1,
     IPC0_SND_MOTOR_POS2,
     IPC0_SND_ERROR
};          
      
BYTE IPC0_SND_MODE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = 1;//(BYTE)((gMode>>8)&0xff);  //
   pHead->data2 =  (BYTE)(gMode&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}

BYTE IPC0_SND_RUN( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = 1;//(BYTE)((gRunFlag>>8)&0xff);  //
   pHead->data2 = (BYTE)(gRunFlag&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}

BYTE IPC0_SND_DOSE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gDose>>8)&0xff); 
   pHead->data2 = (BYTE)(gDose&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   return TRUE;
}
BYTE IPC0_SND_VOLTAGE( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gVoltage>>8)&0xff);  //
   pHead->data2 = (BYTE)(gVoltage&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );
   
   return TRUE;
}

BYTE IPC0_SND_DEPTH( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gDepth>>8)&0xff);  //
   pHead->data2 = (BYTE)(gDepth&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) );

   return TRUE;

}

BYTE IPC0_SND_ELCOUNT( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gElCount>>8)&0xff);  //
   pHead->data2 = (BYTE)(gElCount&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   return TRUE;

}
BYTE IPC0_SND_SPEED( LPIPC_HEADER pHead )
{
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gSpeed>>8)&0xff);  //
   pHead->data2 = (BYTE)(gSpeed&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   return TRUE;

}

BYTE IPC0_SND_FLAG( LPIPC_HEADER pHead )
{
   
   pHead->Command = SYS_OK;
   pHead->data1 = (BYTE)((gFlag>>8)&0xff);  //
   pHead->data2 = (BYTE)(gFlag&0xff);

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}
BYTE IPC0_SND_EL_MAP( LPIPC_HEADER pHead )
{
   
   pHead->Command = SYS_OK;
   pHead->data1 = 0;  //
   pHead->data2 = 0;

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}
BYTE IPC0_SND_MOTOR_POS1( LPIPC_HEADER pHead )
{
   
   pHead->Command = SYS_OK;
   pHead->data1 = 0;  //
   pHead->data2 = 0;

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;  
}

BYTE IPC0_SND_MOTOR_POS2( LPIPC_HEADER pHead )
{           
   pHead->Command = SYS_OK;
   pHead->data1 = 0;  //
   pHead->data2 = 0;

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;
}

BYTE IPC0_SND_ERROR( LPIPC_HEADER pHead )
{     
   pHead->Command = SYS_OK;
   pHead->data1 = 0;  //       
   if( gReadyActionFlag ==FALSE )
        pHead->data2 = ERROR_NOTLCD;    
   else
       pHead->data2 = gError;

   pHead->checksum = MakeCrc( (BYTE *)pHead , sizeof( IPC_HEADER )- 2 );

   IPC_SendData0( (BYTE *)pHead, sizeof( IPC_HEADER ) ); 
   
   return TRUE;

}
void IPC_RunProcess0( void )
{
     BYTE RcvHead[30];
     BYTE RcvByte;
     BYTE  Crc,RcvCrc;
     LPIPC_HEADER pHead;

  //   while( TRUE )
     {
        RcvByte = IPC_RcvData_Interrupt0( RcvHead, sizeof( IPC_HEADER ) );
        pHead = ( LPIPC_HEADER )RcvHead;

         Crc =  MakeCrc(  RcvHead , sizeof( IPC_HEADER )- 2 );
         RcvCrc = pHead->checksum;

         if(  RcvByte == sizeof( IPC_HEADER ) && RcvCrc == Crc &&
              pHead->stx == 0x02 && pHead->etx == 0x03 )
         {
              if( pHead->RWflag ==  IPC_MODE_READ )
                   IPC_SndProcess0( RcvHead );
              else IPC_RcvProcess0( RcvHead );

          }
          else
          {
             IPC_Send_Response0( RcvHead, SYS_ERROR);
             IPC_ResetCount0();
          }

     }

}
 void IPC_Send_Response0( BYTE *Data, BYTE Res )
{
     LPIPC_HEADER mLpHead;

     mLpHead = (LPIPC_HEADER)Data;

     mLpHead->Command = Res;
     mLpHead->data1 = 0;
     mLpHead->data2 = 0;
     mLpHead-> checksum = MakeCrc( (BYTE *)mLpHead , sizeof( IPC_HEADER )- 2 );

     IPC_SendData0( Data, sizeof( IPC_HEADER ) );
}

void IPC_RcvProcess0( BYTE *Data )
{
      LPIPC_HEADER pHead;

      pHead   = (LPIPC_HEADER)Data;
      if(  pHead->Command < sizeof(IPC0Rcvfun)/2 )
      {
             if( IPC0Rcvfun[pHead->Command]( pHead ) == TRUE )        //  Run Command
             {
                 IPC_Send_Response0( Data, SYS_OK );
             }
             else
             {
                 IPC_Send_Response0( Data, SYS_ERROR);
              }
       }
       else
       {
           IPC_Send_Response0( Data, SYS_ERROR );
        }

}


void IPC_SndProcess0( BYTE *Data )
{
      LPIPC_HEADER pHead;

      pHead = (LPIPC_HEADER)Data;
      if( pHead->Command < sizeof(IPC0Sndfun)/2  )
      {
          if( IPC0Sndfun[pHead->Command]( pHead ) == FALSE )        //  Run Command
              IPC_Send_Response0( Data, SYS_ERROR );
      }
      else
      {
           IPC_Send_Response0( Data, SYS_ERROR );
      }
}

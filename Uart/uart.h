#ifndef   __USERUART_HEADER
#define   __USERUART_HEADER                 

#include "../UserDefine.h"
         
char  Tgetchar1( void );
void  Tputchar1( char c );
void  Usrprintf1( char *string );     
void  FlashUsrprintf1( const char  *string );  
void  MyPrint1(char flash* format, ...);
//BYTE  RcvRemocon( void );
BYTE  IPC_RcvData1( BYTE *Buffer, BYTE len );
BYTE  IPC_RcvData_Interrupt1( BYTE *Buffer, BYTE len );
BYTE  IPC_SendData1( BYTE *Buffer, BYTE len ); 
BYTE  IPC_Get_RxCount1( void );
void  IPC_ResetCount1( void );


char  Tgetchar0( void );
void  Tputchar0(char c );
void  Usrprintf0( char *string );     
void  FlashUsrprintf0( const char  *string );  
void  MyPrint0(char flash* format, ...);
BYTE  IPC_RcvData0( BYTE *Buffer, BYTE len );
BYTE  IPC_RcvData_Interrupt0( BYTE *Buffer, BYTE len );
BYTE  IPC_SendData0( BYTE *Buffer, BYTE len ); 
BYTE  IPC_Get_RxCount0( void );
void  IPC_ResetCount0( void );


#endif       

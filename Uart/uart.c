#include <stdarg.h>
#include <stdio.h>
#include "uart.h"

#define RXB8 1
#define TXB8 0
#define UPE  2
#define OVR  3
#define FE   4
#define UDRE 5
#define RXC  7

#define FRAMING_ERROR (1<<FE)
#define PARITY_ERROR (1<<UPE)
#define DATA_OVERRUN (1<<OVR)
#define DATA_REGISTER_EMPTY (1<<UDRE)
#define RX_COMPLETE (1<<RXC)
        
extern WORD  gTime1ms;

#define RX_BUFFER_SIZE0 250
char rx_buffer0[RX_BUFFER_SIZE0];
unsigned char rx_wr_index0=0,rx_rd_index0=0,rx_counter0=0;
BOOL rx_buffer_overflow0=FALSE;
char mRcvErrFlag0 = 0;

#define RX_BUFFER_SIZE1 250
char rx_buffer1[RX_BUFFER_SIZE1];
unsigned char rx_wr_index1=0,rx_rd_index1=0,rx_counter1=0;
BOOL rx_buffer_overflow1=FALSE;
char mRcvErrFlag1 = 0;

// USART1 Receiver interrupt service routine
interrupt [USART1_RXC] void usart1_rx_isr(void)
{
   char status,data;
   status = UCSR1A;
   data   = UDR1;

   if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0 )
   {
      rx_buffer1[rx_wr_index1++]=data;
      if (rx_wr_index1 == RX_BUFFER_SIZE1) rx_wr_index1=0;
      if (++rx_counter1 == RX_BUFFER_SIZE1)
      {
         rx_counter1 = 0;
         rx_buffer_overflow1 = TRUE;
      }
      //gOldUartTime1ms = gTime1ms;      
   }
}

// Get a character from the USART1 Receiver buffer
//#pragma used+
char getchar1( void )
{
   char data;
   //while (rx_counter1==0);
    if( rx_counter1 >0 )
    {
      data = rx_buffer1[rx_rd_index1++];
      if (rx_rd_index1 == RX_BUFFER_SIZE1) rx_rd_index1=0;

       #asm("cli")
       --rx_counter1;
       #asm("sei")
       mRcvErrFlag1 = 0;
       return data;     
    }
    else
    {                       
       mRcvErrFlag1 = 1;
       return 0;   
    }
}

//#pragma used-              
BYTE  IPC_Get_RxCount1( void )
{
   return rx_counter1;
}

void IPC_ResetCount1( void )
{
   #asm("cli")
   rx_counter1 = 0;
   rx_rd_index1 = 0;
   rx_wr_index1 = 0;
   #asm("sei")        
}

char Mygetchar1( BYTE flag )
{                         
      WORD oldTime1ms;           
      char status,data;           
      
      while ( 1 )
      {                              
          if( flag )
               oldTime1ms = gTime1ms;
         
          while ( ((status=UCSR1A) & RX_COMPLETE) == 0 )
          {             
              if( flag )
              {
                 if( (gTime1ms - oldTime1ms) > 300 ) //old 300
                 {     
                      return 0;
                 }
              }                                          
          };                                                  
          
          data = UDR1;
          if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
          return data;
      };
}

char Tgetchar1( void )
{
      char status,data;
      while ( 1 )
      {
          while ( ((status=UCSR1A) & RX_COMPLETE)==0 );
              data = UDR1;
          if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
         return data;
      };
}                                                                                                  

void Tputchar1( char c )
{
     while ((UCSR1A & DATA_REGISTER_EMPTY)==0);
     UDR1 = c;
}  

void Usrprintf1( char  *string )
{       
    while( *string != '\0' )
    {  
        Tputchar1(*string++); 
    }  
}                

void FlashUsrprintf1( const char *string )
{ 
    while( *string != '\0' )
    {  
        Tputchar1(*string++); 
    }
}                        

void MyPrint1( char flash* format, ...)
{
      char str[100]; 

      va_list arg; 
      va_start(arg, format); 

      vsprintf( str, format, arg); 
      va_end(arg); 

      Usrprintf1( str ); // putchar1()를 스트링으로 전송하는 함수입니다.-아래 기술할께요~
}

BYTE  IPC_RcvData1( BYTE *Buffer, BYTE len )
{            
   BYTE i=0;
 
   while( i < len )
   {
        Buffer[i] = Mygetchar1(i);
        i++;                        
   }
   return  i; 
}  


BYTE  IPC_RcvData_Interrupt1( BYTE *Buffer, BYTE len )
{
   BYTE i=0;
   char dat = 0;
   WORD oldTime1ms;     
   oldTime1ms = gTime1ms;   
   
   while( i < len )
   {
       dat = getchar1();
       if( mRcvErrFlag1 == 0  )
       {      
          Buffer[i] = dat;
          i++;
       }       
       if( (gTime1ms - oldTime1ms) > 3000 ) //old 300
       {
          IPC_ResetCount1();
          return 0;
       }
   }
   return  i;
}

BYTE IPC_SendData1( BYTE *Buffer, BYTE len )
{                 
   BYTE i;
   i= 0;
   while( i < len )
   {
     Tputchar1(Buffer[i++]);
   }

   return  i;             
}                                  


// USART0 Receiver interrupt service routine
interrupt [USART0_RXC] void usart0_rx_isr(void)
{
   char status,data;
   status=UCSR0A;
   data=UDR0;
   
   if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
   {
      rx_buffer0[rx_wr_index0++]=data;    
      if (rx_wr_index0 == RX_BUFFER_SIZE0) rx_wr_index0=0;
      if (++rx_counter0 == RX_BUFFER_SIZE0)
      {
        rx_counter0=0;
        rx_buffer_overflow0=TRUE;
      }
   }
}

// Get a character from the USART1 Receiver buffer
char getchar0( void )
{
    char data;
    if( rx_counter0 >0 )
    {
      data = rx_buffer0[rx_rd_index0++];
      if (rx_rd_index0 == RX_BUFFER_SIZE0) rx_rd_index0=0;

       #asm("cli")
       --rx_counter0;
       #asm("sei")
       mRcvErrFlag0 = 0;
       return data;     
    }
    else
    {                       
       mRcvErrFlag0 = 1;
       return 0;   
    }
}

//#pragma used-              
BYTE  IPC_Get_RxCount0( void )
{
   return rx_counter0;
}

void IPC_ResetCount0( void )
{
   #asm("cli")
   rx_counter0 = 0;
   rx_rd_index0 = 0;
   rx_wr_index0 = 0;
   #asm("sei")        
}

char Mygetchar0( BYTE flag )
{                         
      WORD oldTime1ms;           
      char status,data;           
      
      while ( 1 )
      {                              
          if( flag )
               oldTime1ms = gTime1ms;
         
          while ( ((status=UCSR0A) & RX_COMPLETE) == 0 )
          {             
              if( flag )
              {
                 if( (gTime1ms - oldTime1ms) > 300 ) //old 300
                 {     
                      return 0;
                 }
              }                                          
          };                                                  
          
          data = UDR0;
          if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
          return data;
      };
}

char Tgetchar0( void )
{
      char status,data;
      while ( 1 )
      {
          while ( ((status=UCSR0A) & RX_COMPLETE)==0 );
              data = UDR0;
          if ((status & (FRAMING_ERROR | PARITY_ERROR | DATA_OVERRUN))==0)
         return data;
      };
}                                                                                                  

void Tputchar0( char c )
{
     while ((UCSR0A & DATA_REGISTER_EMPTY)==0);
     UDR0 = c;
}  

void Usrprintf0( char  *string )
{       
    while( *string != '\0' )
    {  
        Tputchar0(*string++); 
    }  
}                

void FlashUsrprintf0( const char *string )
{ 
    while( *string != '\0' )
    {  
        Tputchar0(*string++); 
    }
}                        

void MyPrint0( char flash* format, ...)
{
      char str[100]; 

      va_list arg; 
      va_start(arg, format); 

      vsprintf( str, format, arg); 
      va_end(arg); 

      Usrprintf0( str ); // putchar1()를 스트링으로 전송하는 함수입니다.-아래 기술할께요~
}

BYTE  IPC_RcvData0( BYTE *Buffer, BYTE len )
{            
   BYTE i=0;
 
   while( i < len )
   {
        Buffer[i] = Mygetchar0(i);
        i++;                        
   }
   return  i; 
}            

BYTE IPC_RcvData_Interrupt0( BYTE *Buffer, BYTE len )
{
   BYTE i=0;
   char dat = 0;
   WORD oldTime1ms;     
   oldTime1ms = gTime1ms;   
   
   while( i < len )
   {
       dat = getchar0();
       if( mRcvErrFlag0 == 0  )
       {      
          Buffer[i] = dat;
          i++;
       }       
       if( (gTime1ms - oldTime1ms) > 3000 ) //old 300
       {
          IPC_ResetCount0();
          return 0;
       }
   }
   return  i;
}

BYTE IPC_SendData0( BYTE *Buffer, BYTE len )
{                 
   BYTE i;
   i= 0;
   while( i < len )
   {
     Tputchar0(Buffer[i++]);
   }

   return  i;             
}                                  

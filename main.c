#include <mega128.h>
#include <stdio.h>
#include <delay.h>
#include <math.h>
#include <string.h>   

#include "DAC7611/DAC7611.h"
#include "Uart/uart.h"
#include "IPC/IPClib.h"
#include "InAdc/InAdc.h"
#include "InEEprom/InEepromLib.h"

const float DacArray[12] = {10.0f, 20.0f, 30.0f, 40.20f, 13.20f, 16.94f, 21.28f, 25.82f, 30.57f, 35.4f, 40.0f, 55.9f}; 

// Variables
int  gVoltage;
BYTE gMode;
BOOL gRunFlag;
int  gDepth; 
int  gSpeed;
int  gElCount=0;
BYTE gFlag;
int  gDose;
BYTE gError;
int  gAdcLoc=0;    
int  gElLoc=0;
int  gMotorPos1=0;
int  gMotorPos2=0;


WORD gTime1ms;
WORD goldTime1ms;
BYTE WaitEvent( void );
BYTE gElMatrix[4];
int  gCurState=0;
int  gCalValue0,gCalValue1;
int  gDutyOff=0;
BOOL gElCompletFlag = FALSE;
int  gShift=0;
//int  gReadVol;
int  gVolAdjCount=0;
int  gVolChkCount = 0;
//int  gInitCount=0;
BYTE gCurMode;
BOOL gGenMode=FALSE;
BOOL gReadyActionFlag=FALSE;

void InitSettingData(void);
void LoadInEeprom( void);
void InitData(void);

//const int LowVolAdj[4] = {0, 8, 7, 0};
 
// Timer 0 overflow interrupt service routine
interrupt [TIM0_OVF] void timer0_ovf_isr(void)
{
    // Reinitialize Timer 0 value
    TCNT0 = 0x06;   //1ms
    // Place your code here
    gTime1ms++;    
}

void PulseGenerator1( void )
{
   // Reinitialize Timer1 value
    TCNT1H=0xB1E0 >> 8;           //10ms
    TCNT1L=0xB1E0 & 0xff;

    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
          gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
          gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;   
          
          PORTC = gCalValue0;   
          gCurState = 1;  
       }      
       else if( gCurState == 1 )
       {
          PORTC = gCalValue1;             
          gCurState = 2;
       }                        
       else if( gCurState == 2 )
       {         
          PORTC = gCalValue0;         
          gCurState = 3;       
       }
       else if( gCurState == 3 )
       {
          PORTC = gCalValue1;               
          gCurState = 4;      
       }
       else if( gCurState == 4 )
       {
          PORTC = gCalValue0;         
          gCurState = 5;         
       }                    
       else if( gCurState == 5 )
       {              
          gDutyOff = 0;
          PORTC = gCalValue1;         
          gCurState = 6;        
       }                                     
       else if( gCurState == 6 )
       {    
          gDutyOff++;
          if( gDutyOff >8)  
          { 
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {  
                PORTC = 0;
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }
}

void PulseGenerator2( void )
{
     // Reinitialize Timer1 value
    TCNT1H=0xE013 >> 8;          //     0.4ms
    TCNT1L=0xE013 & 0xff;

    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
          gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
          gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;     
          
          PORTC = gCalValue0;  
          gDutyOff = 0; 
          gCurState = 1;  
       }                        
       else if( gCurState == 1 )
       {
          gDutyOff++;
          if( gDutyOff >10 ) gCurState = 2;
       }      
       else if( gCurState == 2 )
       {                 
          gDutyOff = 0; 
          PORTC = gCalValue1;             
          gCurState = 3;
       }                        
       else if( gCurState == 3 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >11) gCurState = 4;       
       }
       else if( gCurState == 4 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 5;      
       } 
       else if( gCurState == 5 )
       {    
          gDutyOff++;
          if( gDutyOff >297)     //150ms
          {    
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {     
                PORTC = 0x00; 
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }    
}

void PulseGenerator3( void )
{
   // Reinitialize Timer1 value
    TCNT1H=0xE700 >> 8;          //     0.4ms
    TCNT1L=0xE700 & 0xff;

    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
          gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
          gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;   
          
          PORTC = gCalValue0;  
          gDutyOff = 0; 
          
          gCurState = 1;
       }      
       else if( gCurState == 1 )
       {       
          gDutyOff++;
          if( gDutyOff >47 )gCurState = 2;
          
       }                        
       else if( gCurState == 2 )
       {             
          gDutyOff = 0;
          PORTC = gCalValue1;             
          gCurState = 3;
       }
       else if( gCurState == 3 )
       {                
           PORTC = gCalValue0; 
           gDutyOff++;
           if( gDutyOff >47 )gCurState = 4;                           
       }
       else if( gCurState == 4 )
       {  
          gDutyOff = 0;
          PORTC = gCalValue1;               
          gCurState = 5;      
       }
       else if( gCurState == 5 )
       {
          PORTC = gCalValue0;  
          gDutyOff++;
          if( gDutyOff >47 ) gCurState = 6;       
       }                    
       else if( gCurState == 6 )
       {              
          gDutyOff = 0;
          PORTC = gCalValue1;         
          gCurState = 7;        
       }                                     
       else if( gCurState == 7 )
       {    
          gDutyOff++;
          if( gDutyOff >246)  
          { 
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {         
                PORTC = 0;
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }
}

void PulseGenerator4( void )
{
     // Reinitialize Timer1 value
    TCNT1H=0xE013 >> 8;          //     0.4ms
    TCNT1L=0xE013 & 0xff;

    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
          gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
          gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;     
          
          PORTC = gCalValue0;  
          gDutyOff = 0; 
          gCurState = 1;  
       }                        
       else if( gCurState == 1 )
       {
          gDutyOff++;
          if( gDutyOff >11 )gCurState = 2;
       }      
       else if( gCurState == 2 )
       {                 
          gDutyOff = 0; 
          PORTC = gCalValue1;             
          gCurState = 3;
       }                        
       else if( gCurState == 3 )
       {         
          PORTC = gCalValue0;
          gDutyOff++; 
          if( gDutyOff >11) gCurState = 4;       
       }
       else if( gCurState == 4 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 5;      
       }
       else if( gCurState == 5 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >11) gCurState = 6;       
       }
       else if( gCurState == 6 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 7;      
       } 
       else if( gCurState == 7 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >11) gCurState = 8;       
       }
       else if( gCurState == 8 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 9;      
       } 
       else if( gCurState == 9 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >11) gCurState = 10;       
       }
       else if( gCurState == 10 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 11;      
       }  
       else if( gCurState == 11 )
       {    
          gDutyOff++;
          if( gDutyOff >294)     //150ms
          {    
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {     
                PORTC = 0x00; 
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }    
}

void PulseGenerator5( void )
{
    int i=0;
    // Reinitialize Timer1 value       
    
    #if 0        
    TCNT1H=0xB1E0 >> 8;           //10ms
    TCNT1L=0xB1E0 & 0xff;
    #else
    TCNT1H=0xC1;
    TCNT1L=0x80;     
    #endif
              
    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
         // gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
         // gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;   
          gCalValue0 = gElMatrix[gElLoc]<<4;
          gCalValue1 = 0; 
                    
          for( i=0; i< 4; i++)
          {
             if( gElMatrix[gElLoc]&(0x08>>i)) 
              break;  
          }                                  
          gShift = i;  
                   
          gShift++; 
          if( gShift > 3 ) gShift = 0;  
          
          PORTC = gCalValue0|(0x08>>gShift);   
          gCurState = 1;  
       }      
       else if( gCurState == 1 )
       {
          PORTC = gCalValue1;             
          gCurState = 2;
       }                        
       else if( gCurState == 2 )
       {  
          gShift++;
          if( gShift > 3 ) gShift = 0;
          PORTC = gCalValue0|(0x08>>gShift);         
          gCurState = 3;       
       }
       else if( gCurState == 3 )
       {
          PORTC = gCalValue1;               
          gCurState = 4;      
       }
       else if( gCurState == 4 )
       {
          gShift++;
          if( gShift > 3 ) gShift = 0;
          PORTC = gCalValue0|(0x08>>gShift);               
          gCurState = 5;         
       }                    
       else if( gCurState == 5 )
       {              
          gDutyOff = 0;
          PORTC = gCalValue1;         
          gCurState = 6;        
       }                                     
       else if( gCurState == 6 )
       {    
          gDutyOff++;
          if( gDutyOff >8)  
          { 
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {  
                PORTC = 0;
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }
}

void PulseGenerator6( void )
{
     // Reinitialize Timer1 value
    TCNT1H=0xE600 >> 8;          //     0.4ms
    TCNT1L=0xE600 & 0xff;

    // Place your code here
    if( gRunFlag==TRUE && gElCompletFlag == FALSE )
    { 
       if( gCurState == 0 )
       {                
          gCalValue0 = gElMatrix[gElLoc]<<4 |(~gElMatrix[gElLoc])&0x0f; //((~gElMatrix[gElLoc]<<4)&0xf0)| gElMatrix[gElLoc];     
          gCalValue1 = gCalValue0&0x0f; // (~gElMatrix[gElLoc])&0x0f;     
          
          PORTC = gCalValue0;  
          gDutyOff = 0; 
          gCurState = 1;  
       }                        
       else if( gCurState == 1 )
       {
          gDutyOff++;
          if( gDutyOff >14 )gCurState = 2;
       }      
       else if( gCurState == 2 )
       {                 
          gDutyOff = 0; 
          PORTC = gCalValue1;             
          gCurState = 3;
       }                        
       else if( gCurState == 3 )
       {         
          PORTC = gCalValue0;
          gDutyOff++; 
          if( gDutyOff >15) gCurState = 4;       
       }
       else if( gCurState == 4 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 5;      
       }
       else if( gCurState == 5 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >15) gCurState = 6;       
       }
       else if( gCurState == 6 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 7;      
       } 
       else if( gCurState == 7 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >15) gCurState = 8;       
       }
       else if( gCurState == 8 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 9;      
       } 
       else if( gCurState == 9 )
       {         
          PORTC = gCalValue0; 
          gDutyOff++;
          if( gDutyOff >15) gCurState = 10;       
       }
       else if( gCurState == 10 )
       {            
          gDutyOff = 0; 
          PORTC = gCalValue1;               
          gCurState = 11;      
       }  
       else if( gCurState == 11 )
       {    
          gDutyOff++;
          if( gDutyOff > 363)     //150ms
          {    
             gCurState = 0;
             gElLoc++;   
             if( gElLoc > 3 )
             {     
                PORTC = 0x00; 
                gElLoc = 0;
                gElCompletFlag = TRUE;
             }
          }        
       }
   }    
}

interrupt [TIM1_OVF] void timer1_ovf_isr(void)
{
     if( gGenMode==FALSE ) 
          PulseGenerator5(); 
     else PulseGenerator6();
}

void PortInit( void )
{                 
    // PORTA
    // bit 7 : N.C
    // bit 6 : N.C 
    // bit 5 : EPG 2 out(LED)
    // bit 4 : EPG 1 out(LED)
    // bit 3 : DAC7611 LD  out
    // bit 2 : DAC7611 CS  out
    // bit 1 : DAC7611 CLK out
    // bit 0 : DAC7611 SDI out
    DDRA    = 0x3f;     
    PORTA   = 0x04; 
    
    //PORTB 
    // bit 7 : N.C
    // bit 6 : LF398 Sample Hold out
    // bit 5 : N.C
    // bit 4 : N.C
    // bit 3 : N.C
    // bit 2 : N.C
    // bit 1 : N.C
    // bit 0 : N.C
    DDRB    = 0x40;      
    PORTB   = 0x01;          
                    
    //PORTC        
    //bit 7: ELECT7    
    //bit 6: ELECT6        
    //bit 5: ELECT5
    //bit 4: ELECT4
    //bit 3: ELECT3
    //bit 2: ELECT2
    //bit 1: ELECT1
    //bit 0: ELECT0
    DDRC    = 0xff;   
    PORTC   = 0x00;
                 
    //PORTD        
    //bit 7: (OUT) Voltage Read Select    
    //bit 6: NC        
    //bit 5: NC
    //bit 4: (IN)FET destruction sen
    //bit 3: TXD1
    //bit 2: RXD1
    //bit 1: NC
    //bit 0: NC    
    DDRD    = 0x80;      
    PORTD   = 0x00;      
    
    DDRE    = 0x12;     
    //PORTE   = 0x54;
    
    DDRF    = 0xC0;      
    PORTF   = 0x00;    
    
    DDRG    = 0xff;     
    PORTG   = 0x00;         
     
    // Timer/Counter 0 initialization
    // Clock source: System Clock
    // Clock value: 250.000 kHz
    // Mode: Normal top=0xFF
    // OC0 output: Disconnected
    // Timer Period: 1 ms
    ASSR=0;
    TCCR0=0x04;
    TCNT0=0x06;
    OCR0=0x00;                      
   
   // Timer/Counter 1 initialization
   // Clock source: System Clock
   // Clock value: 2000.000 kHz
   // Mode: Normal top=0xFFFF
   // OC1A output: Disconnected
   // OC1B output: Disconnected
   // OC1C output: Disconnected
   // Noise Canceler: Off
   // Input Capture on Falling Edge
   // Timer Period: 10 ms
   // Timer1 Overflow Interrupt: On
   // Input Capture Interrupt: Off
   // Compare A Match Interrupt: Off
   // Compare B Match Interrupt: Off
   // Compare C Match Interrupt: Off  
   /*
   TCCR1A=0x00;
   TCCR1B=0x02;
   TCNT1H=0xB1;
   TCNT1L=0xE0;
   ICR1H=0x00;
   ICR1L=0x00;
   OCR1AH=0x00;
   OCR1AL=0x00;
   OCR1BH=0x00;
   OCR1BL=0x00;
   OCR1CH=0x00;
   */
   
// Timer/Counter 1 initialization
// Clock source: System Clock
// Clock value: 16000.000 kHz
// Mode: Normal top=0xFFFF
// OC1A output: Disconnected
// OC1B output: Disconnected
// OC1C output: Disconnected
// Noise Canceler: Off
// Input Capture on Falling Edge
// Timer Period: 0.4 ms
// Timer1 Overflow Interrupt: On
// Input Capture Interrupt: Off
// Compare A Match Interrupt: Off
// Compare B Match Interrupt: Off
// Compare C Match Interrupt: Off
#if 0
TCCR1A=0x00;
TCCR1B= 0x01;
TCNT1H=0xE7;
TCNT1L=0x00;
#else
 TCCR1A=0x00;
 TCCR1B=0x01;
 TCNT1H=0xC1;
 TCNT1L=0x80;
#endif
ICR1H=0x00;
ICR1L=0x00;
OCR1AH=0x00;
OCR1AL=0x00;
OCR1BH=0x00;
OCR1BL=0x00;
OCR1CH=0x00;
OCR1CL=0x00;

   // Timer(s)/Counter(s) Interrupt(s) initialization
   TIMSK=0x05;
   ETIMSK=0x00;             
    

// USART0 initialization
// Communication Parameters: 8 Data, 1 Stop, No Parity
// USART0 Receiver: On
// USART0 Transmitter: On
// USART0 Mode: Asynchronous
// USART0 Baud Rate: 38400 (Double Speed Mode)
   UCSR0A=0x02;
   UCSR0B=0x98;
   UCSR0C=0x06;
   UBRR0H=0x00;
   UBRR0L=0x33;

   // USART1 initialization
   // Communication Parameters: 8 Data, 1 Stop, No Parity
   // USART1 Receiver: On
   // USART1 Transmitter: On
   // USART1 Mode: Asynchronous
   // USART1 Baud Rate: 57600 (Double Speed Mode)
   UCSR1A=0x02;
   UCSR1B=0x98;
   UCSR1C=0x06;
   UBRR1H=0x00;
   UBRR1L=0x22;  
   
   // ADC initialization
   // ADC Clock frequency: 1000.000 kHz
   // ADC Voltage Reference: AREF pin
   ADMUX  = 0x00 & 0xff;
   ADCSRA = 0x84;    
}

void InitData(void)
{
   gCurMode = CUR_INIT;
   gVoltage=100;
   gMode=0;
   gRunFlag = FALSE;
   gDepth=0; 
   gSpeed=1;
   gFlag=0;
   gError = (1<<ERROR_NOTLCD);
   gDose = 0;
   
   // A B C D
   // - - + -
   // - - - +
   // + - - -
   // - + - - 
   gElMatrix[0] = 0x02;
   gElMatrix[1] = 0x01;
   gElMatrix[2] = 0x08;
   gElMatrix[3] = 0x04;     
}
void InitSettingData(void)
{
   DAC7611_WriteVoltage(gVoltage);
}

void SystemInit( void )
{
   PortInit();
   InitData();             
                       
   LoadInEeprom();
   
   DAC7611_init(  );  
   
   InitSettingData();    
                  
   gGenMode = PINB.0?TRUE:FALSE;
   
   if( gGenMode==TRUE ) 
   {         
     HIGH_PGM2_LED;  
     // A B C D
     // + + - -
     // + - + -
     // + - - +
     // + - + - 
     gElMatrix[0] = 0x0C;
     gElMatrix[1] = 0x0A;
     gElMatrix[2] = 0x09;
     gElMatrix[3] = 0x0A;    
     
     TCCR1A=0x00;
     TCCR1B=0x01;
     TCNT1H=0xE7;
     TCNT1L=0x00;
   }
   else
   {
     //TCCR1B= 0x02;
     HIGH_PGM1_LED; 
     
     // A B C D
     // - - + -
     // - - - +
     // + - - -
     // - + - - 
     gElMatrix[0] = 0x02;
     gElMatrix[1] = 0x01;
     gElMatrix[2] = 0x08;
     gElMatrix[3] = 0x04;  
      
     #if 0  //10ms
        TCCR1A=0x00;
        TCCR1B=0x02;
        TCNT1H=0xB1;
        TCNT1L=0xE0;
    #else   //1ms
        TCCR1A=0x00;
        TCCR1B=0x01;
        TCNT1H=0xC1;
        TCNT1L=0x80;
    #endif
     

     /*
     TCCR1A=0x00;
     TCCR1B=0x02;
     TCNT1H=0xB1;
     TCNT1L=0xE0;
     */
   }                
}                                                  


BYTE WaitEvent( void )
{

    while ( 1 )
    {       
       if( IPC_Get_RxCount0() >=  sizeof( IPC_HEADER ) )
       {
           goldTime1ms = gTime1ms;
           return EVN_RCVUART0;
       }
       else if( IPC_Get_RxCount1() >=  sizeof( IPC_HEADER ) )
       {
           goldTime1ms = gTime1ms;
           return EVN_RCVUART1;
       }
       else if( (gTime1ms-goldTime1ms) > 300 ) // 50=200ms
       { 
         /* if( (gTime1ms- gOldUartTime1ms) > 6000 )
          {
             gOldUartTime1ms = gTime1ms;
             if( IPC_Get_RxCount1() > 0 )             
             {
                IPC_ResetCount1();
             }
          }
          */
          goldTime1ms = gTime1ms;
           
          return EVN_TIMEOVER;
       }
    }
}

void SaveInEeprom( void )
{
   EEPROM_BODY mEDat;                            
            
   memset((void *)&mEDat,0 ,sizeof( EEPROM_BODY));    
   
   mEDat.AkFlag = 'A';
   mEDat.Run  = gRunFlag?1:0;
   mEDat.Dose1 = (BYTE)((gDose>>8)&0xff);
   mEDat.Dose2 = (BYTE)(gDose&0xff);   
   mEDat.Voltage = gVoltage ;
   mEDat.Depth = gDepth;
   mEDat.Speed = gSpeed;
   mEDat.Flag  = gFlag;   
   mEDat.Map1  = (gElMatrix[0]<<4)&0xf0 | gElMatrix[1]&0x0f;
   mEDat.Map2  = (gElMatrix[2]<<4)&0xf0 | gElMatrix[3]&0x0f;            
   E2pWriteLen((BYTE*)&mEDat, E_EP_MODE, sizeof( EEPROM_BODY));        
}

void LoadInEeprom( void ) 
{
   BYTE mData[20];
   LPEEPROM_BODY mEDat;                            
            
   memset((void *)&mData,0 ,20 );
   E2pReadLen( mData, E_EP_MODE, sizeof( EEPROM_BODY)); 
   mEDat =(LPEEPROM_BODY)mData ;
   
   if( mEDat->AkFlag == 'A' )
   {
      gMode = 0; //= mEDat->Mode;
      //gRunFlag = mEDat->Run?TRUE:FALSE;
      gDose = (int)mEDat->Dose1<<8|mEDat->Dose2;
      if( gDose < 0 ) gDose = 0;
      if( gDose > 3 ) gDose = 3;     
   
      gVoltage = mEDat->Voltage;   
      if( gVoltage < 60 ) gVoltage = 60;
      if( gVoltage > 120 ) gVoltage = 120;
      
      gDepth = mEDat->Depth;
      if( gDepth < 0 ) gDepth = 0;
      if( gDepth > 3 ) gDepth = 3;
      
      gSpeed = mEDat->Speed;  
      if( gSpeed < 0 ) gSpeed = 0;
      if( gSpeed > 2 ) gSpeed = 2;
   
      gFlag = mEDat->Flag;       
      gElMatrix[0] = (mEDat->Map1>>4)&0x0f;
      gElMatrix[1] = mEDat->Map1&0x0f;
      gElMatrix[2] = (mEDat->Map2>>4)&0x0f;
      gElMatrix[3] = mEDat->Map2&0x0f;            

      if( gVoltage > 50 ) LOW_VOLRY;
      else  HIGH_VOLRY;
   }
   else
   {
      InitData();           
      SaveInEeprom();
   }  
}

void ADCProcessor( void )
{  
   // 0: Heat Protect
   // 1: output voltage 
   // 2: elect current
   int mIndexVol=0;     
   int mVol;
   int mTemp; 
   float mCalvol;
   mVol= read_adc( gAdcLoc );  
   
   if( gAdcLoc == 0 )
   {
      if( mVol > 25)
      {
         gError |= (1<<ERROR_HEATSINK);  //2.5V
         gCurMode =  CUR_ERROR;
      } 
      else
      {
         gError &= ~(1<<ERROR_HEATSINK);  //2.5V
      }
   }
   else if( gAdcLoc == 1 )
   {
      if( gMode == MODE_READY && gFlag == FLAG_VOLADJ )
      {           
        
        if( gVoltage> 50 )
        {       
           if( gVolChkCount > 0 )
           {
              gVolChkCount--;
           }                 
           else   //2*600ms = 1.2sec
           {
              if(gVoltage < 20 ) mIndexVol = 0;
              else  mIndexVol = (gVoltage-20)/10;
                              
              mCalvol = DacArray[mIndexVol];
              
              //gReadVol =(int)(60.0f+(float)mVol*2.2f);
                           
              if( (float)mVol > (mCalvol-mCalvol*0.2f) && 
                  (float)mVol < (mCalvol+mCalvol*0.2f) )
              {
              
                 gFlag = FLAG_READY;  
                 if( gError & (1<<ERROR_VOL) )
                 {             
                     gVolAdjCount++; //300ms
                     if( gVolAdjCount > 3 )  //300ms*3
                     { 
                        gVolAdjCount = 0;
                        gError &= ~(1<<ERROR_VOL);  //2.5V
                     }  
                 }
                 else
                 {
                    gError &= ~(1<<ERROR_VOL);  //2.5V
                 }   
              }
              else
              {
                 gFlag = FLAG_VOLADJ;  
                 gVolAdjCount++; //300ms
                 if( gVolAdjCount > 3 )  //300ms*3
                {
                    gVolAdjCount = 0;              
                    gError |= (1<<ERROR_VOL);                
                    gCurMode =  CUR_ERROR;
                } 
              }
           }
         }   
         else
         {           
           if( gVolChkCount > 0 )
           {
              gVolChkCount--;
           }
           else
           {              
              if(gVoltage < 20 ) mIndexVol = 0;
              else  mIndexVol = (gVoltage-20)/10;
                              
              mCalvol = DacArray[mIndexVol];
                  
             // mTemp = LowVolAdj[gVoltage/10-2];
             // gReadVol =(int)(mTemp+20.0f+(float)mVol*0.68f);               
              if( (float)mVol > (mCalvol-mCalvol*0.2f) && 
                  (float)mVol < (mCalvol+mCalvol*0.2f) )
              {
                 gFlag = FLAG_READY;   
                 if( gError & (1<<ERROR_VOL) )
                 {             
                    gVolAdjCount++; //300ms
                    if( gVolAdjCount > 3 )  //300ms*3
                    { 
                      gVolAdjCount = 0;
                      gError &= ~(1<<ERROR_VOL);  //2.5V
                    }  
                 }
                 else
                 { 
                   gError &= ~(1<<ERROR_VOL);  //2.5V
                 }
              }  
              else
              {
                gFlag = FLAG_VOLADJ;  
                gVolAdjCount++; //300ms
                if( gVolAdjCount > 3 )  //300ms*3
                {
                   gVolAdjCount = 0;              
                   gError |= (1<<ERROR_VOL);                
                   gCurMode =  CUR_ERROR;
                } 
              }
           }
         }    
         
         if( IN_FET_SEN )
         {                   
            PORTC = 0x00; 
            gError |= (1<<ERROR_VOL); 
            gCurMode =  CUR_ERROR;   
         }
 
      }
      else
      {
          gVolAdjCount = 0; //2020-09-04
      }
   }
   else if( gAdcLoc == 2 )
   {   
      if( gRunFlag==TRUE && gElCompletFlag == TRUE )
      {   
         gRunFlag = FALSE;
         if( mVol > 25)
         {  
            gError &= ~(1<<ERROR_ELOUT);  //2.5V  
           
            gElCount++;
            if( gElCount > 999 ) gElCount = 999;    
            HIGH_COMPLETE_LED;
         } 
         else
         {         
            gError |= (1<<ERROR_ELOUT);  //2.5V
            gCurMode =  CUR_ERROR;
            
           // LOW_COMPLETE_LED; 
         }   
         HIGH_SH;  
      }        
   }   
   gAdcLoc++;
   if( gAdcLoc > 2 ) gAdcLoc = 0;        
}
 
void DisplayLed( void )
{       
    if( gError > ERROR_NO )      
    { 
       HIGH_WARRING_LED;  
       LOW_COMPLETE_LED; 
    }
    else
    {
       LOW_WARRING_LED; 
       
       if( gFlag == FLAG_COMPLETE )
             HIGH_COMPLETE_LED;
       else  LOW_COMPLETE_LED;
    }
}
void UserProcessor( void )
{
   if( gCurMode == CUR_INIT )
   {             
      DAC7611_WriteVoltage(0);             
      LOW_PWM;
      LOW_OUTRY;        
      gMode = MODE_STOP;
      gFlag = FLAG_STADNBY;    
      
      gCurMode = CUR_OK;    
            
     // LOW_COMPLETE_LED; 
     // LOW_WARRING_LED;
   }
   else if( gCurMode == CUR_OK )
   {
       ADCProcessor();      
       DisplayLed();
   } 
   else if( gCurMode == CUR_ERROR )
   { 
       gCurMode = CUR_INIT; 
       // gInitCount = 0; 
       LOW_COMPLETE_LED; 
       HIGH_WARRING_LED;
   }
}

void main()
{
   BYTE wEvent;
   int mTimeUart0,mTimeUart1;     
   
   SystemInit( );
   
   mTimeUart0 = mTimeUart1 = 0;    
   // Global enable interrupts
   #asm("sei");
   
   while ( TRUE )
   {
      wEvent = WaitEvent();
      if( wEvent == EVN_RCVUART0 )
      {
          IPC_RunProcess0( );  //handle 
          mTimeUart0 = 0;     
          gError &= ~(1<<ERROR_NOTHANDLE); 
      }
      else if( wEvent == EVN_RCVUART1 )
      {
          IPC_RunProcess1( );  //LCD Pannel
          mTimeUart1 = 0;
          gError &= ~(1<<ERROR_NOTLCD);  
      }
      else if(wEvent == EVN_TIMEOVER )
      {           
          UserProcessor();  
          
          if( ++mTimeUart0 > 7 ) //2.1sec
          {
             mTimeUart0 = 0;
             gError |= (1<<ERROR_NOTHANDLE);  
             gCurMode = CUR_ERROR;
          }
          if( ++mTimeUart1 > 7 ) //2.1sec
          {
             mTimeUart1 = 0;  
             gError |= (1<<ERROR_NOTLCD); 
             gCurMode = CUR_ERROR;
          }            
      }    
   }      
}


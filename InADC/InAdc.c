#include <mega128.h>
#include <delay.h>
#include "InAdc.h"

#define ADC_VREF_TYPE 0x00

// Read the AD conversion result
int read_adc( BYTE adc_input )
{
  WORD temp;
  int  RetVal;

  ADMUX = adc_input | (ADC_VREF_TYPE & 0xff);
  // Delay needed for the stabilization of the ADC input voltage
  delay_us(10);
  // Start the AD conversion
  ADCSRA|=0x40;
  // Wait for the AD conversion to complete
  while ((ADCSRA & 0x10)==0);
  ADCSRA |=0x10;

 // return ADCW;
  temp  = ADCW;

  RetVal =  (int)(5.0f*10.0f*(float)temp/1024.0f);

  return RetVal;
}

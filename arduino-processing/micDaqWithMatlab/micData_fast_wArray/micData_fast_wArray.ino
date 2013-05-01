/***************************************************************************
This code sends analog data from Pin0 on Arduino into the serial port. MATLAB
is used to log the data to user computer. The communication begins when both 
Arduino and MATLAB exchange a header character "s" with each other.
***************************************************************************/
//Defines and Typedefs
#define MATLAB          0

#define ARRAYSIZE       1000
#define MICIN_1         0       //To ADC0

#if MATLAB == 1
  #define BAUDRATE	1000000	// Baud rate of UART in bps
#else
  #define BAUDRATE	115200	// Baud rate of UART in bps
#endif
  

// Define various ADC prescaler
const  uint8_t PS_16 = (1 << ADPS2);
const  uint8_t PS_32 = (1 << ADPS2) | (1 << ADPS0);
const  uint8_t PS_64 = (1 << ADPS2) | (1 << ADPS1);
const  uint8_t PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);

//variable declarations
uint16_t flag=1;
uint8_t readData;

//data variables
volatile byte incomingMMG1;
extern volatile uint16_t writePointer=0;
extern volatile uint16_t readPointer=0;

void setup (){
  //change the baud rate to 1Mbps
  UBRR0 &= 0x0001;
  
  //Serial.begin(115200) ;
  Serial.begin(BAUDRATE) ;              //start UART0 at 1Mbps
  pinMode(MICIN_1,INPUT);
  pinMode(6,OUTPUT);                //for checking on the oscilloscope
  
  //clear buffers
  memset( (void *)incomingMMG1, 0, sizeof(incomingMMG1) );
  
  //clear ADCSRA and ADCSRB
  ADCSRA = 0;
  ADCSRB = 0;
  
  //Disable the digital capabilities of Analog pins
  DIDR0 = 0x3F;                      //setting all 6 bits in the register

  // set up the ADC speed
  ADCSRA |= PS_16;                  // set our own prescaler to 64 
  
  //set up the ADC data to be in ADCH register (only 8 bits, ignore last 2 bits)
  ADMUX |= (1 << REFS0);           //set reference voltage
  ADMUX |= (1 << ADLAR);           //ADCH holds High 8 bits and ADCL holds Low 2 bits
  
  //Synchronize with MATLAB by sending and receiving a token
  #if MATLAB == 1
  while (flag!=0){
    if(Serial.available()>0 && Serial.read()=='s'){
      readData='s';
      flag=0;
    }
    Serial.println(flag);
    delay(100);
  }
  #endif

  //Manually start the ADC conversions
  ADCSRA |= (1 << ADATE);  //enabble auto trigger
  ADCSRA |= (1 << ADIE);   //enable interrupts when measurement complete
  ADCSRA |= (1 << ADEN);   //enable ADC
  ADCSRA |= (1 << ADSC);   //start ADC measurements
  sei();                   //enable interrupts
}

ISR(ADC_vect) {            //when new ADC value ready
  incomingMMG1[writePointer++] = ADCH;     //update the variable incomingAudio with new value from A0 (between 0 and 255)
  //PORTD=PORTD^0xff;        //test the frequency on the scope  
  if (writePointer >= ARRAYSIZE)  writePointer=0;  //circular array  
}

void loop(){
  if (readPointer<writePointer){
    Serial.println(incomingMMG1[readPointer++]);     
    //PORTD=PORTD^0xff;        //test the frequency on the scope  
  }else{
    if (readPointer >= ARRAYSIZE) readPointer=0;  //circular array 
  }  
}

//ISR(ADC_vect) {
//  incomingMMG1 = ADCH;
//}
//
//void loop(){
//  Serial.write(incomingMMG1);
//}


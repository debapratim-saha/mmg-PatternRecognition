/***************************************************************************
This code sends analog data from Pin0 on Arduino into the serial port. MATLAB
is used to log the data to user computer. The communication begins when both 
Arduino and MATLAB exchange a header character "s" with each other.
***************************************************************************/
// Define various ADC prescaler
const unsigned char PS_16 = (1 << ADPS2);
const unsigned char PS_32 = (1 << ADPS2) | (1 << ADPS0);
const unsigned char PS_64 = (1 << ADPS2) | (1 << ADPS1);
const unsigned char PS_128 = (1 << ADPS2) | (1 << ADPS1) | (1 << ADPS0);

//variable declarations
int micInAmp = 1;
int flag=1;
char readData;
byte incomingMMG1;

void setup (){
  //change the baud rate to 1Mbps
  UBRR0 &= 0x0001;
  
  //Serial.begin(115200) ;
  Serial.begin(1000000) ;              //start UART0 at 1Mbps
  pinMode(micInAmp,INPUT);
  
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
  while (flag!=0){
    if(Serial.available()>0 && Serial.read()=='s'){
      readData='s';
      flag=0;
    }
    Serial.println(flag);
    delay(100);
  }

  //Manually start the ADC conversions
  ADCSRA |= (1 << ADATE);  //enabble auto trigger
  ADCSRA |= (1 << ADIE);   //enable interrupts when measurement complete
  ADCSRA |= (1 << ADEN);   //enable ADC
  ADCSRA |= (1 << ADSC);   //start ADC measurements
  sei();//enable interrupts
}

ISR(ADC_vect) {//when new ADC value ready
  incomingMMG1 = ADCH;//update the variable incomingAudio with new value from A0 (between 0 and 255)
  PORTD=PORTD^0xff;
}

void loop(){
  Serial.println(incomingMMG1);
}


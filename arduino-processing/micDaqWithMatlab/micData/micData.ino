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
int micInAmp = 0;
int flag=1;
char readData;

void setup (){
  //change the baud rate to 1Mbps
  UBRR0 &= 0x01;
  
  //Serial.begin(115200) ;
  Serial.begin(1000000) ;
  pinMode(micInAmp,INPUT);
  
  //Disable the digital capabilities of Analog pins
  DIDR0 = 0x3F;                    //setting all 6 bits in the register

  // set up the ADC speed
  ADCSRA |= PS_16;          // set our own prescaler to 64 
  
  //Synchronize with MATLAB by sending and receiving a token
//  while (flag!=0){
//    if(Serial.available()>0 && Serial.read()=='s'){
//      readData='s';
//      flag=0;
//    }
//    Serial.println(flag);
//    delay(100);
//  }
}

void loop(){
    Serial.println(analogRead(micInAmp));
    PORTD=PORTD^0xff;
}


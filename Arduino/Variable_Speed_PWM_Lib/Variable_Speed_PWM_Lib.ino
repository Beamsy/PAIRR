#include "PCA9685.h"
#include <Wire.h>

PCA9685 pwm;

void setup() {
  Serial.begin(9600);
  Wire.begin();
  Wire.setClock(400000);
  pwm.resetDevices();

  pwm.init(B000000);
  pwm.setPWMFrequency(50);
  pwm.setChannelPWM(0, 300);
  delay(1000);
  move(0, 500, 0);
  
  
}

void loop() {
  // put your main code here, to run repeatedly:

}

// pos between 120 and 500
void move(int pin, uint16_t pos, uint8_t speed){
  uint16_t currentPos = pwm.getChannelPWM(pin);
  if(currentPos<pos){
    for(currentPos;currentPos<pos;currentPos++){
      pwm.setChannelPWM(pin, currentPos);
      delayMicroseconds(2000);
    }
  }
  
}


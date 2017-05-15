/* import the LED control library */
#include "LedControl.h"
/* import the arduino wire library */
#include <Wire.h>
/* import the adafruit servo driver library */
#include <Adafruit_PWMServoDriver.h>

/* create an new LedControle object called lc1
 * the parameters assign pin numbers as follows (shown in order of assignment) 
 * 13 is data in pin (DIN), 11 is clock pin (CLK), 12 is the load pin (CS).
 * the last int is used to denote how many displays are connected. */
LedControl lc1=LedControl(13,11,12,2);

/* create a new servo driver object call pwm1 */
Adafruit_PWMServoDriver pwm1 = Adafruit_PWMServoDriver(0x40);

/* define key positions for the servos:
 * NECK ROTATION: full right=235, full left=375, middle=304(start position)
 * NECK TILT: full up = 395, full down=270, middle=315(start position)
 * SHOULDER ROTATION: full down=485(start position), full up=235 */
#define SERVOMIN 150          // a minimum value, approx 0 degress
#define SERVOMAX 650          // a maximum value, aprox 180 degrees
#define NECKROTMIDDLE 304     // start position
#define NECKROTMIDDLE 304     // start position
#define NECKROTRIGHT 234
#define NECKROTLEFT 374
#define NECKTILTMIDDLE 365    // start position
#define NECKTILTFORWARD 300
#define NECKTILTBACK 450
#define SHOULDERDOWN 480      // start position
#define SHOULDERUP 315
#define ELBOWDOWN 225         // start position
#define ELBOWUP 415
#define WRISTMIDDLE 300         // start position
#define WRISTROTATELEFT 350
#define WRISTROTATERIGHT 250

/* set up a variable to store the address of a particular servo
 * available addresses run from 0 to 15 */
uint8_t servoNeckRotate = 0; // this is the neck rotation servo address
uint8_t servoNeckTilt = 1; // this is the neck tilt servo address
uint8_t servoShoulder = 2; // this is the shoulder servo address
uint8_t servoElbow = 3; // this is the elbow servo address
uint8_t servoWrist = 4; // this is the wrist servo address

/* set up a variable to quickly adjust animation length for all animations */
int aniDly = 25;
/* set up a variable to place a very short delay between pulses
 *  to allow for speed adjustment of robot movement */
int mvDly = 4;
/* set up a variable to place a short delay each complete movement */
int cmpMvDly = 100;
/* set up a variable for the value of the digital input pin
 * and a variable to store the read value */
int digitalPin = 7;
int pinVal = 0;

void setup()
{
  /* start the serial monitor, used for debugging */
  Serial.begin(9600);
  
  /* make sure chip is not in power save mode
   * shutdown(int-address of display, boolean-false to turn of power save) */
  lc1.shutdown(0,false);
  lc1.shutdown(1,false);
    
  /* make sure the display is clear
   * clearDisplay(int-address of display) */
  lc1.clearDisplay(0);
  lc1.clearDisplay(1);

  /* set brightness for the display
   * setIntensity(int - address of display, int brightness level 0-15)*/
  lc1.setIntensity(0,1);
  lc1.setIntensity(1,1);
  
  /* begin running the PWM code
   * and set the frequcncy they run at */
  pwm1.begin();
  pwm1.setPWMFreq(50);
  yield();

  /* set the initial start positions for all the servos
   * setPWM(servo address, start position of pulse, end position of pulse) */
  pwm1.setPWM(servoNeckRotate, 0, NECKROTMIDDLE);
  pwm1.setPWM(servoNeckTilt, 0, NECKTILTFORWARD);
  pwm1.setPWM(servoShoulder, 0, SHOULDERDOWN);
  pwm1.setPWM(servoElbow, 0, ELBOWDOWN);  
  pwm1.setPWM(servoWrist, 0, WRISTMIDDLE);
 
  /* set a short delay after set up and before routine begins */
  delay(1000);
}

void loop()
{
  
  /* read the digital input pin, and store the value in pinVal */
  pinVal = digitalRead(digitalPin);

  /* output the value to the serial monitor for debugging*/
  Serial.println(pinVal);
  
  /* Check the value of pinVal.
   * if it's greater than zero then execute the code
   * that animates the robot, otherwise the loop runs 
   * again and keeps reading the pin */ 
  if (pinVal > 0) 
  {

    /* call the single frame function defined below the loop
     * set parameters to address each individual display
     * 0=right eye, 1=left eye */
    eyeClosed(0,1);
    delay(1000);

    /* call the 'wake up head' function defined below the loop 
     * to lift the head up to middle */
    wakeUpHead();
    delay(1000);

    /* make the eyes blink by calling the eye animation functions 
     * defined below the loop set parameters to address each 
     * individual display and the delay between frames */
    EyeClosedToOpen(0,1,aniDly);
    EyeOpenToClosed(0,1,aniDly);
    EyeClosedToOpen(0,1,aniDly);
    EyeOpenToClosed(0,1,aniDly);
    EyeClosedToOpen(0,1,aniDly);
    delay(1000);

    /* call the 'shake head' function defined below the loop
     * rotates neck to indicate no */
    shakeHead();
    delay(1000);
  
    /* call the 'nod head' function defined below the loop
     * tilts the neck to indicate yes */
    nodHead();
    delay(1000);

    /* call the 'lift shoulder' function defined below the loop
     * lifts the upper arm from down to up */
    liftShoulder();
    delay(1000);
  
    /* call the 'lift elbow' function defined below the loop
     * raises the lower arm from down to up */
    liftElbow();
    delay(1000);

    /* call the 'wave hand' function defined below the loop
     * rotates the wrist from middle, left to right and back to middle */
    waveHand();
    delay(1000);

    /* call the 'drop elbow' function defined below the loop
     * drops the lower arm from up to down */
    dropElbow();
    delay(1000);

    /* call the 'drop shoulder' function defined below the loop
     * lowers the upper arm from up to down */
    dropShoulder();
    delay(1000);

    /* make the eyes blink to closed */
    EyeClosedToOpen(0,1,aniDly);
    EyeOpenToClosed(0,1,aniDly);

    /* call the sleepy head fucntion defined below the loop
     * drops the head back to sleep */
    sleepyHead();
    delay(1000);

    /* clear the displays */
    lc1.clearDisplay(0);
    lc1.clearDisplay(1);
  
  }
  /* wait 3 seconds before taking another reading */
  delay(3000);
  
}

/* DEFINE SERVO FUNCTIONS: to be called in the main loop */

/* neck tilt: 'wake up' from forward to middle */
void wakeUpHead()
{
  /* down to up */
  for (uint16_t pulselen = NECKTILTFORWARD; pulselen <= NECKTILTMIDDLE; pulselen++)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* neck tilt: 'sleepy head' from middle to forward */
void sleepyHead()
{
  /* down to up */
  for (uint16_t pulselen = NECKTILTMIDDLE; pulselen >= NECKTILTFORWARD; pulselen--)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* neck rotation: indicating 'no' */
void shakeHead()
{     
  /* middle to right */
  for (uint16_t pulselen = NECKROTMIDDLE; pulselen >= NECKROTRIGHT; pulselen--)
  {
    pwm1.setPWM(servoNeckRotate, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* right to left */
  for (uint16_t pulselen = NECKROTRIGHT; pulselen <= NECKROTLEFT; pulselen++)
  {
    pwm1.setPWM(servoNeckRotate, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* left to right */
  for (uint16_t pulselen = NECKROTLEFT; pulselen >= NECKROTRIGHT; pulselen--)
  {
    pwm1.setPWM(servoNeckRotate, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* right to middle */
  for (uint16_t pulselen = NECKROTRIGHT; pulselen <= NECKROTMIDDLE; pulselen++)
  {
    pwm1.setPWM(servoNeckRotate, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* neck tilt: indicating 'yes' */
void nodHead()
{     
  /* middle to down */
  for (uint16_t pulselen = NECKTILTMIDDLE; pulselen >= NECKTILTFORWARD; pulselen--)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* down to up */
  for (uint16_t pulselen = NECKTILTFORWARD; pulselen <= NECKTILTBACK; pulselen++)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* up to down */
  for (uint16_t pulselen = NECKTILTBACK; pulselen >= NECKTILTFORWARD; pulselen--)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* down to middle */
  for (uint16_t pulselen = NECKTILTFORWARD; pulselen <= NECKTILTMIDDLE; pulselen++)
  {
    pwm1.setPWM(servoNeckTilt, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* shoulder lift: raise upper arm by rotatating sholder from down to up */
void liftShoulder()
{
  /* down to up */
  for (uint16_t pulselen = SHOULDERDOWN; pulselen >= SHOULDERUP; pulselen--)
  {
    pwm1.setPWM(servoShoulder, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* shoulder drop: lower upper arm by rotatating sholder from up to down */
void dropShoulder()
{
  /* up to down */
  for (uint16_t pulselen = SHOULDERUP; pulselen <= SHOULDERDOWN; pulselen++)
  {
    pwm1.setPWM(servoShoulder, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* elbow lift: raise lower arm by rotatating elbow from down to up */
void liftElbow()
{
  /* down to up */
  for (uint16_t pulselen = ELBOWDOWN; pulselen <= ELBOWUP; pulselen++)
  {
    pwm1.setPWM(servoElbow, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* elbow drop: raise lower arm by rotatating elbow from down to up */
void dropElbow()
{
  /* up to down */
  for (uint16_t pulselen = ELBOWUP; pulselen >= ELBOWDOWN; pulselen--)
  {
    pwm1.setPWM(servoElbow, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* wave hand: rotates the wrist from middle, left to right and back to middle */
void waveHand()
{
  /* middle to left */
  for (uint16_t pulselen = WRISTMIDDLE; pulselen <= WRISTROTATELEFT; pulselen++)
  {
    pwm1.setPWM(servoWrist, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* left to right */
  for (uint16_t pulselen = WRISTROTATELEFT; pulselen >= WRISTROTATERIGHT; pulselen--)
  {
    pwm1.setPWM(servoWrist, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* right to left */
  for (uint16_t pulselen = WRISTROTATERIGHT; pulselen <= WRISTROTATELEFT; pulselen++)
  {
    pwm1.setPWM(servoWrist, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
  /* left to middle */
  for (uint16_t pulselen = WRISTROTATELEFT; pulselen >= WRISTMIDDLE; pulselen--)
  {
    pwm1.setPWM(servoWrist, 0, pulselen);
    delay(mvDly);
  }
  delay(cmpMvDly);
}

/* DEFINE LED FUNCTIONS: to be called in the main loop */

/* single frame for eye open */
void eyeOpen(int dispAddr01, int dispAddr02)
{
  /* switch leds on by setting values for an entire row
   * setRow(int - address of display, int - row number, int 0-255 to address the leds)
   * by declaring int dispAddr as an argument allows reuse of this function for 
   * multiple displays */
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr01,1,126);
  lc1.setRow(dispAddr02,1,126);
  lc1.setRow(dispAddr01,2,195);
  lc1.setRow(dispAddr02,2,195);
  lc1.setRow(dispAddr01,3,219);
  lc1.setRow(dispAddr02,3,219);
  lc1.setRow(dispAddr01,4,219);
  lc1.setRow(dispAddr02,4,219);
  lc1.setRow(dispAddr01,5,195);
  lc1.setRow(dispAddr02,5,195);
  lc1.setRow(dispAddr01,6,126);
  lc1.setRow(dispAddr02,6,126);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,7,60);
}

/* single frame for eye open */
void eyeClosed(int dispAddr01, int dispAddr02)
{
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,120);
  lc1.setRow(dispAddr01,2,240);
  lc1.setRow(dispAddr01,3,240);
  lc1.setRow(dispAddr01,4,240);
  lc1.setRow(dispAddr01,5,240);
  lc1.setRow(dispAddr01,6,120);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,120);
  lc1.setRow(dispAddr02,2,240);
  lc1.setRow(dispAddr02,3,240);
  lc1.setRow(dispAddr02,4,240);
  lc1.setRow(dispAddr02,5,240);
  lc1.setRow(dispAddr02,6,120);
  lc1.setRow(dispAddr02,7,60);
}

/* animation for eyes closing, 
 * takes two parameters
 * the display address and the delay between frames
 */
void EyeOpenToClosed(int dispAddr01, int dispAddr02, int animationDelay)
{
  // frame01
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,126);
  lc1.setRow(dispAddr01,2,195);
  lc1.setRow(dispAddr01,3,219);
  lc1.setRow(dispAddr01,4,219);
  lc1.setRow(dispAddr01,5,195);
  lc1.setRow(dispAddr01,6,126);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,126);
  lc1.setRow(dispAddr02,2,195);
  lc1.setRow(dispAddr02,3,219);
  lc1.setRow(dispAddr02,4,219);
  lc1.setRow(dispAddr02,5,195);
  lc1.setRow(dispAddr02,6,126);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame02
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,126);
  lc1.setRow(dispAddr01,2,198);
  lc1.setRow(dispAddr01,3,222);
  lc1.setRow(dispAddr01,4,222);
  lc1.setRow(dispAddr01,5,198);
  lc1.setRow(dispAddr01,6,126);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,126);
  lc1.setRow(dispAddr02,2,198);
  lc1.setRow(dispAddr02,3,222);
  lc1.setRow(dispAddr02,4,222);
  lc1.setRow(dispAddr02,5,198);
  lc1.setRow(dispAddr02,6,126);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame03
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,124);
  lc1.setRow(dispAddr01,2,204);
  lc1.setRow(dispAddr01,3,220);
  lc1.setRow(dispAddr01,4,220);
  lc1.setRow(dispAddr01,5,204);
  lc1.setRow(dispAddr01,6,124);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,124);
  lc1.setRow(dispAddr02,2,204);
  lc1.setRow(dispAddr02,3,220);
  lc1.setRow(dispAddr02,4,220);
  lc1.setRow(dispAddr02,5,204);
  lc1.setRow(dispAddr02,6,124);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame04
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,124);
  lc1.setRow(dispAddr01,2,216);
  lc1.setRow(dispAddr01,3,216);
  lc1.setRow(dispAddr01,4,216);
  lc1.setRow(dispAddr01,5,216);
  lc1.setRow(dispAddr01,6,124);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,124);
  lc1.setRow(dispAddr02,2,216);
  lc1.setRow(dispAddr02,3,216);
  lc1.setRow(dispAddr02,4,216);
  lc1.setRow(dispAddr02,5,216);
  lc1.setRow(dispAddr02,6,124);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame05
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,120);
  lc1.setRow(dispAddr01,2,240);
  lc1.setRow(dispAddr01,3,240);
  lc1.setRow(dispAddr01,4,240);
  lc1.setRow(dispAddr01,5,240);
  lc1.setRow(dispAddr01,6,120);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,120);
  lc1.setRow(dispAddr02,2,240);
  lc1.setRow(dispAddr02,3,240);
  lc1.setRow(dispAddr02,4,240);
  lc1.setRow(dispAddr02,5,240);
  lc1.setRow(dispAddr02,6,120);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
}

/* animation for eyes opening */
void EyeClosedToOpen(int dispAddr01, int dispAddr02, int animationDelay)
{
  // frame01
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,120);
  lc1.setRow(dispAddr01,2,240);
  lc1.setRow(dispAddr01,3,240);
  lc1.setRow(dispAddr01,4,240);
  lc1.setRow(dispAddr01,5,240);
  lc1.setRow(dispAddr01,6,120);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,120);
  lc1.setRow(dispAddr02,2,240);
  lc1.setRow(dispAddr02,3,240);
  lc1.setRow(dispAddr02,4,240);
  lc1.setRow(dispAddr02,5,240);
  lc1.setRow(dispAddr02,6,120);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame02
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,124);
  lc1.setRow(dispAddr01,2,216);
  lc1.setRow(dispAddr01,3,216);
  lc1.setRow(dispAddr01,4,216);
  lc1.setRow(dispAddr01,5,216);
  lc1.setRow(dispAddr01,6,124);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,124);
  lc1.setRow(dispAddr02,2,216);
  lc1.setRow(dispAddr02,3,216);
  lc1.setRow(dispAddr02,4,216);
  lc1.setRow(dispAddr02,5,216);
  lc1.setRow(dispAddr02,6,124);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame03
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,124);
  lc1.setRow(dispAddr01,2,204);
  lc1.setRow(dispAddr01,3,220);
  lc1.setRow(dispAddr01,4,220);
  lc1.setRow(dispAddr01,5,204);
  lc1.setRow(dispAddr01,6,124);
  lc1.setRow(dispAddr01,7,60);
  delay(animationDelay);
  // frame04
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,126);
  lc1.setRow(dispAddr01,2,198);
  lc1.setRow(dispAddr01,3,222);
  lc1.setRow(dispAddr01,4,222);
  lc1.setRow(dispAddr01,5,198);
  lc1.setRow(dispAddr01,6,126);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,126);
  lc1.setRow(dispAddr02,2,198);
  lc1.setRow(dispAddr02,3,222);
  lc1.setRow(dispAddr02,4,222);
  lc1.setRow(dispAddr02,5,198);
  lc1.setRow(dispAddr02,6,126);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
  // frame05
  lc1.setRow(dispAddr01,0,60);
  lc1.setRow(dispAddr01,1,126);
  lc1.setRow(dispAddr01,2,195);
  lc1.setRow(dispAddr01,3,219);
  lc1.setRow(dispAddr01,4,219);
  lc1.setRow(dispAddr01,5,195);
  lc1.setRow(dispAddr01,6,126);
  lc1.setRow(dispAddr01,7,60);
  lc1.setRow(dispAddr02,0,60);
  lc1.setRow(dispAddr02,1,126);
  lc1.setRow(dispAddr02,2,195);
  lc1.setRow(dispAddr02,3,219);
  lc1.setRow(dispAddr02,4,219);
  lc1.setRow(dispAddr02,5,195);
  lc1.setRow(dispAddr02,6,126);
  lc1.setRow(dispAddr02,7,60);
  delay(animationDelay);
}



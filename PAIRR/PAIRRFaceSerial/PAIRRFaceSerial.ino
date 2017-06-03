/* Import the LEDEyes library */
#include <LEDEyes.h>

/* import the arduino wire library */
#include <Wire.h>
/* import the adafruit servo driver library */
#include <Adafruit_PWMServoDriver.h>

/******* Create and assign members *******/

/* create a new servo driver object call pwm1 */
Adafruit_PWMServoDriver pwm1 = Adafruit_PWMServoDriver(0x40);

/* Create LEDEyes object called ledEyes */
LEDEyes ledEyes;

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

// Keeps count of how long PAIRR has been active
int awakeTimer = 4;

// Set to true when PAIRR is awake (PIR detects motion)
bool isAwake = false;

// Used to compare against serial Input numbers
int wakeUp = 1;
int receivedResults = 2;

/****** Setup arduino *******/

void setup()
{
  /* start the serial monitor, used for receiving inputs from the Pi */
  Serial.begin(9600);
  
  /* begin running the PWM code
   * and set the frequecncy they run at */
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
  if (Serial.available())
  {
    // Get the number that is sent over serial, in this case from the RPi.
    // Must subtract the ASCII value of zero (48) 
    // to get the true value from the character that is sent
    int serialInput = (Serial.read() - '0');
    int wakeUp = 1;


    // First case is wake up, triggered by the PIR on the Pi, 
    // only triggers if robot is not awake already
    if (serialInput == wakeUp && false == isAwake)
    {
      motionDetected();
      isAwake = true;
      delay(3000);
    }
    else if (serialInput == receivedResults)
    {
      ledEyes.eyesResultRecv();
      // Fail safe, incase the PIR doesn't trigger first for some reason
      isAwake = true;
      delay(3000);
    }
  }

  // Robot blinks whilst waiting for input and then sleeps after 4 loops through
  if (true == isAwake && 0 < awakeTimer)
  {
    ledEyes.eyesRest();
    awakeTimer--;
  } 
  else
  {
    sleepRobot();
  }
}

/* Functions used in the if statements above, just makes it easier to read */

void motionDetected()
{
  ledEyes.eyesAwake();
  /* call the 'wake up head' function defined below the loop 
  * to lift the head up to middle */
  wakeUpHead();
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
}

void sleepRobot()
{
  sleepyHead();
  ledEyes.clearDisplays();
  isAwake = false;
  awakeTimer = 4;
}

/* DEFINE SERVO FUNCTIONS */ 

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

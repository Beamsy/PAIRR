
/* Import the LEDEyes library */
#include "LEDEyes.h"

/* import the arduino wire library */
#include "Wire.h"
/* import the adafruit servo driver library */
#include "PCA9685.h"

/******* Create and assign members *******/

/* create a new servo driver object call pwm1 */
PCA9685 pwm1;

/* Create LEDEyes object called ledEyes */
LEDEyes ledEyes;

/* define key positions for the servos:
 * NECK ROTATION: full right=235, full left=375, middle=304(start position)
 * NECK TILT: full up = 395, full down=270, middle=315(start position)
 * SHOULDER ROTATION: full down=485(start position), full up=235 */
#define SERVOMIN 150          // a minimum value, approx 0 degress
#define SERVOMAX 650          // a maximum value, aprox 180 degrees
#define NECKROTMIDDLE 335     // start position
#define NECKROTRIGHT 234
#define NECKROTLEFT 374
#define NECKTILTMIDDLE 395    // start position
#define NECKTILTFORWARD 320
#define NECKTILTBACK 450
#define SHOULDERDOWN 520      // start position
#define SHOULDERUP 300
#define ELBOWDOWN 230         // start position
#define ELBOWUP 400
#define WRISTMIDDLE 330         // start position
#define WRISTLEFT 400
#define WRISTRIGHT 260

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
  
  /* start serial, used for receiving inputs from the Pi */
  Serial.begin(9600);
  /* begin running the PWM code
   * and set the frequecncy they run at */
  Wire.begin();
  pwm1.resetDevices();
  ledEyes.init(true);
  
  pwm1.init(B000000);
  pwm1.setPWMFrequency(50);

  /* set the initial start positions for all the servos
   * setChannelPWM(servo address, start position of pulse, end position of pulse) */
  pwm1.setChannelPWM(servoNeckRotate, NECKROTMIDDLE);
  pwm1.setChannelPWM(servoNeckTilt, NECKTILTMIDDLE);
  pwm1.setChannelPWM(servoShoulder, SHOULDERDOWN);
  pwm1.setChannelPWM(servoElbow, ELBOWDOWN);  
  pwm1.setChannelPWM(servoWrist, WRISTMIDDLE);
 
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

    // Wake up, triggered by the PIR on the Pi
    if (serialInput == wakeUp)
    {
      if (!isAwake)
      {
        isAwake = true;
        motionDetected();
      }
      else
      {
        // Keep PAIRR awake if motion is detect but don't run the wakeup 
        // sequence as he's already awake
        awakeTimer++;
      }
    }

    // Run the results received animation
    else if (serialInput == receivedResults)
    {
      // If the ID gets scanned when PAIRR is asleep, wake up head
      if (!isAwake)
      {
        ledEyes.eyeCenter();
        wakeUpHead();
      }
      awakeTimer += 10;
      resultsReceived();
    }
  }

  // Robot blinks whilst waiting for input and then sleeps after 4 loops through
  if (isAwake && 0 < awakeTimer)
  {
    ledEyes.eyesBlink();
    awakeTimer--;
  } 
  else if (isAwake) 
  {
    sleepRobot();
  }
}

/* Functions used in the if statements above, just makes it easier to read */

void motionDetected()
{
  ledEyes.eyeCenter();
  /* call the 'wake up head' function defined below the loop 
  * to lift the head up to middle */
  wakeUpHead();
  delay(1000);

  // Using the LEDEyes library, I am calling the eyesAwake function 
  // which runs the wake up routine
  ledEyes.eyesAwake();
  
  /* call the 'lift shoulder' function defined below the loop
  * lifts the upper arm from down to up */
  liftShoulder();
  
  /* call the 'lift elbow' function defined below the loop
   * raises the lower arm from down to up */
  liftElbow();
  delay(1000);

  ledEyes.happyEyes();
  
  /* call the 'wave hand' function defined below the loop
   * rotates the wrist from middle, left to right and back to middle */
  waveHand();
  delay(1000);

  ledEyes.eyeCenter();
  
  /* call the 'drop elbow' function defined below the loop
   * drops the lower arm from up to down */
  waveArm();
}

// Function to be called when results are received, sets 
// the robot in an awake state and runs the results animation
void resultsReceived()
{
  isAwake = true;
  
  liftElbow();
  ledEyes.eyesResultRecv();
  dropElbow();
      
  // Reset the awake timer each time ID is scanned
  awakeTimer = 4;
}

// Reset member variables so the robot is in an off state
// and run the sleep animation, also clearing led boards
void sleepRobot()
{
  ledEyes.droopyEyes();
  delay(500);
  sleepyHead();
  delay(100);
  wakeUpHead();
  ledEyes.surprisedEyes1();
  delay(750);
  sleepyHead();
  ledEyes.clearDisplays();
  isAwake = false;
  awakeTimer = 4;
}

/* DEFINE SERVO FUNCTIONS */ 
void move(int pin, uint16_t pos, uint8_t speed)
{
  uint16_t currentPos = pwm1.getChannelPWM(pin);
  if(currentPos<pos){
    for(currentPos;currentPos<pos;currentPos++){
      pwm1.setChannelPWM(pin, currentPos);
      delayMicroseconds(speed);
    }
  }else if(currentPos>pos){
    for(currentPos;currentPos>pos;currentPos--){
      pwm1.setChannelPWM(pin, currentPos);
      delayMicroseconds(speed);
    }
  }else if(currentPos==pos){
    delay(cmpMvDly);
  }
}


/* neck tilt: 'wake up' from forward to middle */
void wakeUpHead()
{
  /* down to up */
  move(servoNeckTilt, NECKTILTMIDDLE, 50);
}

/* neck tilt: 'sleepy head' from middle to forward */
void sleepyHead()
{
  move(servoNeckTilt, NECKTILTFORWARD, 200);
}

/* neck rotation: indicating 'no' */
void shakeHead()
{     
  /* middle to right */
  move(servoNeckRotate, NECKROTRIGHT, 100);
  delay(cmpMvDly);
  /* right to left */
  move(servoNeckRotate, NECKROTLEFT, 100);
  delay(cmpMvDly);
  /* left to right */
  move(servoNeckRotate, NECKROTRIGHT, 100);
  delay(cmpMvDly);
  /* right to middle */
  move(servoNeckRotate, NECKROTMIDDLE, 100);
  delay(cmpMvDly);
}

/* neck tilt: indicating 'yes' */
void nodHead()
{     
  /* middle to down */
  move(servoNeckTilt, NECKTILTFORWARD, 100);
  delay(cmpMvDly);
  /* down to up */
  move(servoNeckTilt, NECKTILTBACK, 100);
  delay(cmpMvDly);
  /* up to down */
  move(servoNeckTilt, NECKTILTFORWARD, 100);
  delay(cmpMvDly);
  /* down to middle */
  move(servoNeckTilt, NECKTILTMIDDLE, 100);
  delay(cmpMvDly);
}

/* shoulder lift: raise upper arm by rotatating sholder from down to up */
void liftShoulder()
{
  /* down to up */
  move(servoShoulder, SHOULDERUP, 100);
  delay(cmpMvDly);
}

/* shoulder drop: lower upper arm by rotatating sholder from up to down */
void dropShoulder()
{
  /* up to down */
  move(servoShoulder, SHOULDERDOWN, 100);
  delay(cmpMvDly);
}

/* elbow lift: raise lower arm by rotatating elbow from down to up */
void liftElbow()
{
  /* down to up */
  move(servoElbow, ELBOWUP, 100);
  delay(cmpMvDly);
}

/* elbow drop: raise lower arm by rotatating elbow from down to up */
void dropElbow()
{
  /* up to down */
  move(servoElbow, ELBOWDOWN, 100);
  delay(cmpMvDly);
}

/* wave hand: rotates the wrist from middle, left to right and back to middle */
void waveHand()
{
  /* middle to left */
  move(servoWrist, WRISTRIGHT, 100);
  delay(cmpMvDly);
  /* left to right */
  move(servoWrist, WRISTLEFT, 100);
  delay(cmpMvDly);
  /* right to left */
  move(servoWrist, WRISTRIGHT, 100);
  delay(cmpMvDly);
  /* left to middle */
  move(servoWrist, WRISTMIDDLE, 100);
  delay(cmpMvDly);
}

void waveArm()
{
  move(servoShoulder, SHOULDERUP, 100);
  move(servoElbow, 360, 100);
  delay(500);
  for(int i=0; i<3; i++){
    move(servoElbow, ELBOWUP, 50);
    delay(200);
    move(servoElbow, 360, 50);
    delay(200);
  }
  move(servoElbow, ELBOWDOWN, 100);
  move(servoShoulder, SHOULDERDOWN, 100);
}



/* 
 *  Project PAIRR - Petroc Artificially Intelligent Robot Recruiter
 *  
 *  Sprint 1: Create Arduino Controlled Robot Arm
 *  
 *  Sketch: Servo Control
 *  Control 3 Servo motors with analog pots 
 *  to direct arm movements by articulating
 *  Shoulder, elbow and wrist.
 */

#include <Servo.h>              // Import the servo library

Servo servo_shoulder;           // Initialize an instance of a servo object for the shoulder
Servo servo_elbow;              // Initialize an instance of a servo object for the elbow
Servo servo_wrist;              // Initialize an instance of a servo object for the wrist

// Create Variables for pin assignments, allows for easy pin rearranging later on when code gets longer
int potpin_shoulder = 4;        // Declare an int variable, and assign it a value, to be used for the analog pin number for the shoulder pot input 
int potpin_elbow = 2;           // Declare an int variable, and assign it a value, to be used for the pin number for the elbow pot input
int potpin_wrist = 0;           // Declare an int variable, and assign it a value, to be used for the pin number for the wrist pot input

int digipin_shoulder = 9;       // Declare an int variable, and assign it a value, to be used for the digital pin number to attach to the shoulder servo
int digipin_elbow = 11;         // Declare an int variable, and assign it a value, to be used for the digital pin number to attach to the elbow servo
int digipin_wrist = 13;         // Declare an int variable, and assign it a value, to be used for the digital pin number to attach to the wrist servo

int val_shoulder;               // Declare a variable to read and store the value from the analog pin connected to shoulder servo
int val_elbow;                  // Declare a variable to read and store the value from the analog pin connected to elbow servo
int val_wrist;                  // Declare a variable to read and store the value from the analog pin connected to wrist servo

void setup() {  
  servo_shoulder.attach(digipin_shoulder);    // Connect the shoulder servo object to the digital pin defined earlier
  servo_elbow.attach(digipin_elbow);          // Connect the elbow servo object to the digital pin defined earlier      
  servo_wrist.attach(digipin_wrist);          // Connect the wrist servo object to the digital pin defined earlier
}

void loop() {
  // Read and digitise a value from the position of the pots
  val_shoulder = analogRead(potpin_shoulder);     // Reads the value of the shoulder pot and assigns it to val_shoulder
  val_elbow = analogRead(potpin_elbow);           // Reads the value of the elbow pot and assigns it to val_elbow
  val_wrist = analogRead(potpin_wrist);           // analogRead will generate a value between 0 and 1023 based on the pot position
  
  // Scale the digitised pot values from 0>1023 to 0>180. Note: values 'mirror' mapped for motors mounted with rotor facing left.
  val_shoulder = map(val_shoulder, 0, 1023, 50, 180);   // Scale val_shoulder so it can be used to position the shoulder servo (value between 0 and 180)
  val_elbow = map(val_elbow, 0, 1023, 180, 50);         // Scale val_elbow so it can be used to position the elbow servo (value between 0 and 180)
  val_wrist = map(val_wrist, 0, 1023, 50, 180);         // Scale val_wrist so it can be used to position the wrist servo (value between 0 and 180)

  // Write the values out to the servos
  servo_shoulder.write(val_shoulder);                   // sets the shoulder servo position according to the scaled value
  servo_elbow.write(val_elbow);                         // sets the elbow servo position according to the scaled value
  servo_wrist.write(val_wrist);                         // sets the wrist servo position according to the scaled value
  delay(15);                                            // Waits for the servo to get into position before reading / writing any additional values
}

// END

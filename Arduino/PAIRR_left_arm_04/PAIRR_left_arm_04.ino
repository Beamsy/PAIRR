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

#include <VarSpeedServo.h>      // Import the modofied Servo library that allows for motor speed control

VarSpeedServo servo_shoulder;   // Initialize an instance of a servo object for the shoulder
VarSpeedServo servo_elbow;      // Initialize an instance of a servo object for the elbow
VarSpeedServo servo_wrist;      // Initialize an instance of a servo object for the wrist

int digipin_shoulder = 13;      // Use a variable for the pin allocation number of the shoulder
int digipin_elbow = 11;         // Use a variable for the pin allocation number of the elbow
int digipin_wrist = 9;          // Use a variable for the pin allocation number of the wrist

// Initial Set Up
void setup() {  
  servo_shoulder.attach(digipin_shoulder);    // Connect the shoulder servo object to the digital pin defined earlier
  servo_elbow.attach(digipin_elbow);          // Connect the elbow servo object to the digital pin defined earlier      
  servo_wrist.attach(digipin_wrist);          // Connect the wrist servo object to the digital pin defined earlier

  servo_shoulder.write(165);       // Sets the intial position of the shoulder 
  servo_elbow.write(10);           // Sets the intial position of the elbow
  servo_wrist.write(85);           // Sets the initial position of the wrist
}

// Main Loop
void loop() { 
  // Return position when loop repeats 
  servo_shoulder.write(165, 35, false);       // Sets the return state of the shoulder - position, speed, true/false(finish move before moving on) 
  servo_elbow.write(10, 35, false);           // Sets the return state of the elbow
  servo_wrist.write(85, 35, false);           // Sets the return position of the wrist
  delay(5000);                                // Pause for 5 seconds before moving on

  // Raise the arm
  servo_elbow.write(100, 35, false);          // Bend at the elbow
  servo_shoulder.write(100, 35, true);        // Raise the shoulder                 

  // Run the wave loop
  int x;
  for (x = 0; x < 4; x ++) {
    servo_wrist.write(120, 60, true);         // Move to 120 deg at a rate of 60
    servo_wrist.write(50, 60, true);          // Move to 50 deg at a rate of 60    
    }
}

// END

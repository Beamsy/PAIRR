/*
 *  Project PAIRR - Petroc Artificially Intelligent Robot Recruiter
 *
 *  Sprint 1: Create Arduino Controlled Robot Arm
 *
 *  Sketch: Arm Wave on Motion Detection
 *  Use Raspberry Pi and PIR sensor to send an input that
 *  triggers the servoes to create arm movements by articulating
 *  Shoulder, elbow and wrist.
 */

#include <VarSpeedServo.h>      // Import the modofied Servo library that allows for motor speed control

VarSpeedServo servo_shoulder;   // Initialize an instance of a servo object for the shoulder
VarSpeedServo servo_elbow;      // Initialize an instance of a servo object for the elbow
VarSpeedServo servo_wrist;      // Initialize an instance of a servo object for the wrist

int digipin_shoulder = 13;      // Use a variable for the pin allocation number of the shoulder
int digipin_elbow = 11;         // Use a variable for the pin allocation number of the elbow
int digipin_wrist = 9;          // Use a variable for the pin allocation number of the wrist
int piInputPin = A3;            // Use a variable for the pin to read an analog input from the Pi

// Initial Set Up
void setup() {
  servo_shoulder.attach(digipin_shoulder);    // Connect the shoulder servo object to the digital pin defined earlier
  servo_elbow.attach(digipin_elbow);          // Connect the elbow servo object to the digital pin defined earlier
  servo_wrist.attach(digipin_wrist);          // Connect the wrist servo object to the digital pin defined earlier

  pinMode(piInputPin, INPUT);      // sets the piInputPin as input

  servo_shoulder.write(165);       // Sets the intial position of the shoulder
  servo_elbow.write(10);           // Sets the intial position of the elbow
  servo_wrist.write(85);           // Sets the initial position of the wrist
}

// Main Loop
void loop() {

  int val = 0;                              // Create variable to hold the input pin value, reset to zero each iteration
  val = analogRead(piInputPin);             // Read the value going into piInputPin and store in val

  // Movement loop. Execute if piInputPin has voltage above 3v
  if (val > 614) {
    // Raise elbow and shoulder, then wave
    servo_elbow.write(110, 40, false);
    servo_shoulder.write(110, 30, true);

    // Wave hand then back to centre
    servo_wrist.write(120, 80, true);
    servo_wrist.write(50, 80, true);
    servo_wrist.write(120, 80, true);
    servo_wrist.write(50, 80, true);
    servo_wrist.write(120, 80, true);
    servo_wrist.write(50, 80, true);
    servo_wrist.write(85, 80, true);

    // Lower elbow and shoulder
    servo_shoulder.write(165, 30, false);
    servo_elbow.write(10, 40, false);
    delay(2000);
    }

}

// END

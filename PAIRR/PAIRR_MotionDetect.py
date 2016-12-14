#!/usr/bin/python

# Import needed to use the GPIO
import RPi.GPIO as GPIO
from time import sleep

# Tells the program which numbering scheme you're using for the GPIO pins,
# BCM is the "Broadcom SOC channel", the name of the pins, as opposed
# to the physical numbering of the pins (BOARD).
GPIO.setmode(GPIO.BCM)

# Name the GPIO pins used by the PIR sensor and LEDs
pirPin = 18
#systemLedPin = 24
motionLedPin = 23

# Set the PIR pin as an input and ledPins as outputs
GPIO.setup(pirPin, GPIO.IN)
#GPIO.setup(systemLedPin, GPIO.OUT)
GPIO.setup(motionLedPin, GPIO.OUT)

# This will show before the program runs to provide a bit of information
# about the program and show it is running
print "PIR test"
print "To stop the program hit CTRL+C"
#GPIO.output(systemLedPin, True)             # Turn on the red LED
GPIO.output(motionLedPin, False)            # Turn off the green LED
print "Ready!"

# Run a continuous loop listening for an input from the PIR
try:
    while True:
        # Checks if there's an input from the PIR
        if GPIO.input(pirPin):
            print "Motion Detected!"
            GPIO.output(motionLedPin, True)     # Turn on Green LED
        # If no input detected turns the LED off.
        else:
            print "Coast Clear"
            GPIO.output(motionLedPin, False)    # Turn off green LED
        sleep(0.1)
except KeyboardInterrupt:
    GPIO.cleanup()
    exit(0)

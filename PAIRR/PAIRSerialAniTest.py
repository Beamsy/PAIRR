# Imports to use the GPIO pins,
# the Time library for the sleep function
# and the serial connection from serialConnect
import RPi.GPIO as GPIO
import time
import serial

# Tells the program which numbering scheme you're using for the GPIO pins,
# BCM is the "Broadcom SOC channel", the name of the pins, as opposed
# to the physical numbering of the pins (BOARD).
GPIO.setmode(GPIO.BCM)

# Assign the pin used for the PIR sensor
PIR_PIN = 7

# Set the PIR pin as an input
GPIO.setup(PIR_PIN, GPIO.IN)

# Try catch to allow the program to be stopped when a key is pressed
try:
    
    # Sets up serial connectionand 
    serialConnection = serial.Serial('/dev/ttyACM0', 9600)
    time.sleep(2)

    print "PIR Module Test (CTRL+C to exit)"
    print "Ready"
    # Continuous loop listening for the PIR input, when this is
    # detected call the serialConnect() method which will send
    # the given number over serial to the given port number.
    while True:
        inputNum = raw_input()
        
        # Write number to serial port
        serialConnection.write(inputNum)
except KeyboardInterrupt:
    print "Quit"
    GPIO.cleanup()


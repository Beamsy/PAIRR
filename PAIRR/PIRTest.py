# Imports needed to use the GPIO and sleep function from time
import RPi.GPIO as GPIO
from time import sleep

# Tells the program which numbering scheme you're using for the GPIO pins,
# BCM is the "Broadcom SOC channel", the name of the pins, as opposed
# to the physical numbering of the pins (BOARD).
GPIO.setmode(GPIO.BCM)

# Name the GPIO pins used by the PIR sensor and LED
pirPin = 18
ledPin = 23

said = False
# Set the PIR pin as an input and ledPin as out
GPIO.setup(pirPin, GPIO.IN)
GPIO.setup(ledPin, GPIO.OUT)

# This will show before the program runs to provide a bit of information
# about the program
print "PIR test"
print "To stop the program hit CTRL+C"
print "Ready!"
GPIO.output(ledPin, 1)
sleep(1)
GPIO.output(ledPin, 0)
sleep(1)
try:
    # Continuous loop listening for an input from the PIR
    while True:
        # Checks if there's an input from the PIR
        if GPIO.input(pirPin):
            # Turns on ledPin for one second then turns it off
            GPIO.output(ledPin, 1)
            print "Motion!"
            said = True
        # waits one second before sensing again.
        elif not GPIO.input(pirPin) and not said:
            GPIO.output(ledPin, 0)
            print "Safe!"
            said = False
        sleep(0.1)
except KeyboardInterrupt:
    GPIO.cleanup()
    print "Exiting"
    exit(0)

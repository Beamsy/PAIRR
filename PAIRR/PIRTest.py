# Imports needed to use the GPIO and sleep function from time
import RPi.GPIO as GPIO
import time

# Tells the program which numbering scheme you're using for the GPIO pins,
# BCM is the "Broadcom SOC channel", the name of the pins, as opposed
# to the physical numbering of the pins (BOARD).
GPIO.setmode(GPIO.BCM)

# Name the GPIO pins used by the PIR sensor and LED
pirPin = 7
ledPin = 6

# Set the PIR pin as an input and ledPin as out
GPIO.setup(pirPin, GPIO.IN)
GPIO.setup(ledPin, GPIO.OUT)

# This will show before the program runs to provide a bit of information
# about the program
print "PIR test"
print "To stop the program hit CTRL+C"
print "Ready!"

# Continuous loop listening for an input from the PIR
while True:
    # Checks if there's an input from the PIR
    if GPIO.input(pirPin):
        print "Motion Detected!"
        # Turns on ledPin for one second then turns it off
        GPIO.output(ledPin, True)
        time.sleep(1)
        GPIO.output(ledPin, False)
        time.sleep(2)
    # waits one second before sensing again.
    time.sleep(1)

#!/usr/bin/python

# Import needed to use the GPIO
import RPi.GPIO as GPIO
from time import sleep
import ConfigParser


# Tells the program which numbering scheme you're using for the GPIO pins,
# BCM is the "Broadcom SOC channel", the name of the pins, as opposed
# to the physical numbering of the pins (BOARD).


GPIO.setmode(GPIO.BCM)
config = ConfigParser.SafeConfigParser()
config.read('Config/GPIO.cfg')


# Name the GPIO pins
pir_pin = config.get('Pins', 'pir')
motion_led_pin = config.get('Pins', 'motion_led')
good_button_pin = config.get('Pins', 'good_button')
bad_button_pin = config.get('Pins', 'bad_button')


# Set the PIR pin as an input and ledPins as outputs
GPIO.setup(pir_pin, GPIO.IN)
GPIO.setup(motion_led_pin, GPIO.OUT)
GPIO.setup(good_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(bad_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.output(motion_led_pin, False)            # Turn off the green LED


def wait_for_motion():
    # Run a continuous loop listening for an input from the PIR
    try:
        while True:
            # Checks if there's an input from the PIR
            if GPIO.input(pir_pin):
                GPIO.output(motion_led_pin, True)     # Turn on Green LED
                return True
            # If no input detected turns the LED off.
            else:
                GPIO.output(motion_led_pin, False)    # Turn off green LED
            sleep(0.1)
    except KeyboardInterrupt:
        GPIO.cleanup()
        exit(0)


def cleanup():
    GPIO.cleanup()

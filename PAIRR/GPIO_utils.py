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

pinout_section = 'Pinout'
# Name the GPIO pins
pir_pin = int(config.get(pinout_section, 'pir'))
system_led_pin = int(config.get(pinout_section, 'system_led'))
motion_led_pin = int(config.get(pinout_section, 'motion_led'))
good_button_pin = int(config.get(pinout_section, 'good_button'))
bad_button_pin = int(config.get(pinout_section, 'bad_button'))

# Set the PIR pin as an input and ledPins as outputs
GPIO.setup(pir_pin, GPIO.IN)
GPIO.setup(motion_led_pin, GPIO.OUT)
GPIO.setup(good_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(bad_button_pin, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(system_led_pin, GPIO.OUT)
GPIO.output(motion_led_pin, False)            # Turn off the green LED
GPIO.output(system_led_pin, True)


# Function to cleanup the GPIO pins
def cleanup():
    GPIO.cleanup()


def check_for_motion():
    # Checks if there's an input from the PIR
    if GPIO.input(pir_pin):
        GPIO.output(motion_led_pin, True)     # Turn on Green LED
        return True
    # If no input detected turns the LED off.
    else:
        GPIO.output(motion_led_pin, False)    # Turn off green LED
        return False


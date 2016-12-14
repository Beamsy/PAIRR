import RPi.GPIO as GPIO
from time import sleep

GPIO.setmode(GPIO.BCM)

pirPin = 18

GPIO.setup(pirPin, GPIO.IN)

def detect_move():
    if GPIO.input(pirPin):
        return True
    else:
        return False

# Imports needed for serial connection and the time library(sleep function)
import serial
import time

# Sets up serial connection to given port and writes a number to it
def serialConnect(numberToSend):
    serialConnection = serial.Serial('/dev/ttyACM1', 9600)
    time.sleep(2)
    serialConnection.write(numberToSend)
    return



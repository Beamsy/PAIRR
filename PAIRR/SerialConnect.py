# Imports needed for serial connection and the time library(sleep function)
import serial
serial_connection = None

WAKEUP = 1
RECEIVEDRESULTS = 2
SLEEP = 3
LOADING = 4
LOOKSCANNER = 5
LOOKBACKPROP = 6
LOOKMIDDLE = 7


def __init__():
    global serial_connection
    serial_connection = serial.Serial('/dev/ttyACM0', 9600)
    print "Serial Initiated"
    return


# Sets up serial connection to given port and writes a number to it
def serial_connect(number_to_send):
    serial_connection.write(str(number_to_send))
    return

def serial_wait():
    while True:
        if(serial_connection.read()=='a'):
	    return

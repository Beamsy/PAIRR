# Imports needed for serial connection and the time library(sleep function)
import serial
serial_connection = None

# Defines constants used by the arduino for various
WAKEUP = 1
RECEIVEDRESULTS = 2
SLEEP = 3
LOADING = 4
LOOKSCANNER = 5
LOOKBACKPROP = 6
LOOKMIDDLE = 7


# An init fucntion to set up the seial connection on
def __init__():
    global serial_connection
    serial_connection = serial.Serial('/dev/ttyACM0', 9600)
    print "Serial Initiated"
    return


# Writes a number to the serial connection
def serial_connect(number_to_send):
    serial_connection.write(str(number_to_send))
    return


# Waits for the serial connection to be sent an 'a' character by the arduino
def serial_wait():
    while True:
        if serial_connection.read() == 'a':
            return

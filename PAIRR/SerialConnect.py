# Imports needed for serial connection and the time library(sleep function)
import serial
serial_connection = None


def __init__():
    global serial_connection
    serial_connection = serial.Serial('/dev/ttyACM0', 9600)
    print "Serial Initiated"
    return


# Sets up serial connection to given port and writes a number to it
def serial_connect(number_to_send):
    serial_connection.write(str(number_to_send))
    return



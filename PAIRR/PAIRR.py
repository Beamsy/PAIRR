if __name__ == "__main__":

    # Imports various libraries and modules used
    from voice_engine import say
    import SerialConnect
    from sys import argv
    import os
    from time import sleep
    # Prints the directory of the script
    print argv[0]
    # Changes the working directory to the location of the script
    # This is so relative imports can work correctly
    os.chdir(os.path.dirname(argv[0]))
    print os.getcwd()

    # Further imports
    import db_access
    import student_access
    import GPIO_utils
    import AI

    # Says initiating using voice engine. This causes a lot of error messages to be printed
    # This is due to the ALSA Python library implementation
    say("Initiating")
    # Initiates the serial connection
    SerialConnect.__init__()
    said = False

    # Initiates the database, and assigns the connection object to the db variable
    db = db_access.__init__()
    sleep(2)

    # Try catch to perform GPIO cleanup
    try:
        # Main loop
        while True:
            # If motion detected, start main body of script
            if GPIO_utils.check_for_motion():
                # Say the string
                say("Hi there, I'm PAIRR, the Petroc Artificially Intelligent Robot!")
                # Sends a wakeup command to the arduino to make the robot to perform a waking up animation
                SerialConnect.serial_connect(SerialConnect.WAKEUP)
                # Wait for the animation to finish
                SerialConnect.serial_wait()
                # Asks for someone to come scan their id
                say("Please come scan your student id!")
                # Looks at the scanner
                SerialConnect.serial_connect(SerialConnect.LOOKSCANNER)
                # Wait for animation to finish
                SerialConnect.serial_wait()
                # Await scanner input. Scanner acts like normal text input followed by enter keypress
                code = raw_input("Waiting for input")
                # Prints what is scanned to the terminal
                print code
                # Puts the students name into a student variable
                student = student_access.get_name(db, code)
                greeting = 'Hello {0}.'.format(student)
                # Sends a command to look to the middle
                SerialConnect.serial_connect(SerialConnect.LOOKMIDDLE)
                SerialConnect.serial_wait()
                print greeting
                # Speaks Hello student
                say(greeting)
                # Starts the AI module
                AI.__init__(student_access.get_a_lvls(db, code))
            # Sleep in loop
            sleep(0.5)
    except KeyboardInterrupt:
        GPIO_utils.cleanup()
        exit(0)

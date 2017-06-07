if __name__ == "__main__":
    from voice_engine import say
    import SerialConnect
    from sys import argv
    import os
    from time import sleep
    print argv[0]
    os.chdir(os.path.dirname(argv[0]))
    print os.getcwd()
    import db_access
    import student_access
    import GPIO_utils
    import AI
    say("Initiating")
    SerialConnect.__init__()
    said = False
    db = db_access.__init__()
    try:
        while True:
            if GPIO_utils.check_for_motion():
                say("Hi there, please come scan your student id!")
                SerialConnect.serial_connect(SerialConnect.WAKEUP)
                SerialConnect.serial_connect(SerialConnect.LOOKSCANNER)
                code = raw_input("Waiting for input")
                student = student_access.get_name(db, code)
                greeting = 'Hello {0}.'.format(student)
                SerialConnect.serial_connect(SerialConnect.LOOKMIDDLE)
                SerialConnect.serial_wait()
                say(greeting)
                AI.__init__(student_access.get_a_lvls(db, code))
            sleep(0.5)
    except KeyboardInterrupt:
        GPIO_utils.cleanup()
        exit(0)

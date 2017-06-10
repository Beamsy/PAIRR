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
    sleep(2)
    try:
        while True:
            if GPIO_utils.check_for_motion():
                say("Hi there, I'm PAIRR, the Petroc Artificially Intelligent Robot!")
                SerialConnect.serial_connect(SerialConnect.WAKEUP)
		SerialConnect.serial_wait()
		say("Please come scan your student id!")
                SerialConnect.serial_connect(SerialConnect.LOOKSCANNER)
		SerialConnect.serial_wait()
                code = raw_input("Waiting for input")
		print code
                student = student_access.get_name(db, code)
                greeting = 'Hello {0}.'.format(student)
		print greeting
                SerialConnect.serial_connect(SerialConnect.LOOKMIDDLE)
                SerialConnect.serial_wait()
		print greeting
                say(greeting)
                AI.__init__(student_access.get_a_lvls(db, code))
            sleep(0.5)
    except KeyboardInterrupt:
        GPIO_utils.cleanup()
        exit(0)

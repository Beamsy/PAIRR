from voice_engine import say
import db_access
import student_access
from GPIO_utils import wait_for_motion
say("Initiating")
said = False
db = db_access.__init__()
while True:
    if wait_for_motion():
        code = raw_input()
        student = student_access.name(db, code)
        greeting = 'Hello {0}.'.format(student)
        say(greeting)
        print greeting


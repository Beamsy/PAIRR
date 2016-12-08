import voice_engine
from voice_engine import say
import db_access
import student_access
say("Initiating")
db = db_access.__init__()
while True:
    code = raw_input()
    student = student_access.name(db, code)
    greeting = 'Hello {0}.'.format(student)
    say(greeting)
    print greeting


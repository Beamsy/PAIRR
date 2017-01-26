import voice_engine
from voice_engine import say
<<<<<<< HEAD
import name

=======
import db_access
import student_access
>>>>>>> origin/master
say("Initiating")
said = False
db = db_access.__init__()
while True:
    '''if pir_util.detect_move() and said is False:
        say("Hey you there")
        said = True'''
    code = raw_input()
    student = student_access.name(db, code)
    greeting = 'Hello {0}.'.format(student)
    say(greeting)
    print greeting


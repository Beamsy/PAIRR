import voice_engine
from voice_engine import say
import name
say("Initiating")
while True:
    code = raw_input()
    student = name.name(code)
    greeting = 'Hello {0}.'.format(student)
    say(greeting)
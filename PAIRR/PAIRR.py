import voice_engine
import name
code = raw_input()
student = name.name(code)
greeting = 'Hello there {0}, how are you today?'.format(student)
voice_engine.say(greeting)
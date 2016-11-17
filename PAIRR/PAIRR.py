import voice_engine
while True:
    phrase = raw_input('What should I say? ')
    voice_engine.say(phrase)
import pyttsx
engine = pyttsx.init()
engine.startLoop(False)
def say(utterance):
    engine.say(utterance)
    engine.iterate()
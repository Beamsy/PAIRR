# Import the pyttsx module. This must be installed (sudo pip install pyttsx)
import pyttsx
# Create an engine object, this allows us to send commands to the speech engine
engine = pyttsx.init()

# Using startLoop with a false parameter allows us to use an external loop
engine.startLoop(False)


# This is the only function provided, it simply speaks a string passed to it
def say(utterance):
    # This is the actual pass through to the speech engine
    engine.say(utterance)
    # And this tells the engine to speak the command and move on.
    engine.iterate()

    
# Usage for this module is merely an import of the whole module,
# and import_name.say("Say this")

# this is a change
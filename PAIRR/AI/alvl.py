class Alvl():

    idnum = None
    weights = [0.5 for count in range(3)]

    def __init__(self, pidnum):
        print "a level " + str(pidnum) + " initiated"
        idnum = pidnum


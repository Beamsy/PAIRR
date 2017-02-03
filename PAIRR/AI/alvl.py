class Alvl:

    identifier = None
    idnum = None
    weights = [0.5 for count in range(3)]

    def __init__(self, _idnum, _identifier):
        print "a level " + str(_idnum) + " initiated"
        idnum = _idnum
        identifier = _identifier


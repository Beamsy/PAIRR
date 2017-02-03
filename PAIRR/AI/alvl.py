class Alvl:

    identifier = None
    idnum = None
    weights = [0.5 for count in range(3)]

    def __init__(self, _idnum, _identifier):
        print "a level " + str(_idnum) + " initiated"
        self.idnum = _idnum
        self.identifier = _identifier

    def __repr__(self):
        return "ALevel: {} with ID {}".format(self.identifier,
                                              self.idnum)

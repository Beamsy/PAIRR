class Alvl:

    identifier = None
    id_num = None
    weights = None

    def __init__(self, _id_num, _identifier):
        print "a level " + str(_id_num) + " initiated"
        self.id_num = _id_num
        self.identifier = _identifier
        self.weights = [0.5 for count in range(3)]

    def __repr__(self):
        return "ALevel: {} with ID {}".format(self.identifier,
                                              self.idnum)

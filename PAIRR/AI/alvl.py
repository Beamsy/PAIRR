class Alvl:

    identifier = None
    id_num = None
    weights = None

    def __init__(self, _id_num, _identifier, _weights):
        print "a level " + str(_id_num) + " initiated"
        self.id_num = _id_num
        self.identifier = _identifier
        self.weights = _weights

    def __repr__(self):
        return "ALevel: {} with ID {}".format(self.identifier,
                                              self.idnum)

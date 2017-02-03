class Neuron:

    identifier = None
    idnum = None
    total = 0

    def __init__(self, _idnum, _identifier):
        self.idnum = _idnum
        self.identifier = _identifier
        print "neuron " + str(self.idnum) + " initiated"

    def sum_weighted_inputs(self, alvls_studied, alvl_list):
        print "Summing neuron " + str(self.idnum)
        total = 0
        for i in alvls_studied:
            total = total + alvl_list[i].weights[self.idnum]
        self.total = total

    def get_total(self):
        return self.total

    def __repr__(self):
        return '{}: {} {}'.format(self.__class__.__name__,
                                  self.identifier,
                                  self.idnum)

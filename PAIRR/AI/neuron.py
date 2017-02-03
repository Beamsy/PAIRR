class Neuron:

    identifier = None
    id_num = None
    total = 0

    def __init__(self, _id_num, _identifier):
        self.id_num = _id_num
        self.identifier = _identifier
        print "neuron " + str(self.id_num) + " initiated"

    def sum_weighted_inputs(self, alvls_studied, alvl_list):
        print "Summing neuron " + str(self.id_num)
        total = 0
        for i in alvls_studied:
            total = total + alvl_list[i].weights[self.id_num]
        self.total = total

    def get_total(self):
        return self.total

    def __repr__(self):
        return '{}: {} {}'.format(self.__class__.__name__,
                                  self.identifier,
                                  self.id_num)

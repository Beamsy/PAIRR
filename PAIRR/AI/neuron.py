class Neuron:

    idnum = None
    total = 0

    def __init__(self, pidnum):
        self.idnum = pidnum
        print "neuron " + str(self.idnum) + " initiated"

    def sum_weighted_inputs(self, alvls_studied, alvl_list):
        print "Summing neuron " + str(self.idnum)
        total = 0
        for i in alvls_studied:
            total = total + alvl_list[i].weights[self.idnum]
        self.total = total

    def get_total(self):
        return self.total

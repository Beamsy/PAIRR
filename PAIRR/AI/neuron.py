class Neuron():
    idnum = None
    total = 0
    def __init__(self, pidnum):
        self.idnum = pidnum
        print "neuron " + str(self.idnum) + " initiated"

    def sum_weighted_inputs(self, alvls, alvllist):
        print "Summing neuron " + str(self.idnum)
        total = 0
        for i in alvls:
            total = total + alvllist[i].weights[self.idnum]
        self.total = total

# A class to represent a neuron in the neural net.
# As our neural net contains only one hidden layer, with each neuron is this layer mapped to
# A single output neuron, we have removed the Degree class and added an identifier
# to this neuron class that correlates to a degree


class Neuron:

    identifier = None
    id_num = -1
    # The total attribute, once processed using the sum_weighted_inputs
    total = 0

    # An __init__ method to make neuron objects
    def __init__(self, _id_num, _identifier):
        self.id_num = _id_num
        self.identifier = _identifier
        print "neuron " + str(self.id_num) + " initiated"

    # The main workhorse method. The net works by selecting the neuron with the highest total weight
    # to do this, we need to know the weights of all the neurons in the network, so we get the total weight
    # of each neuron
    def sum_weighted_inputs(self, alvls_studied):
        print "Summing neuron " + str(self.id_num)
        total = 0
        for a_lvl in alvls_studied:
            total = total + a_lvl.weights[self.id_num]
        self.total = total

    # A method to return the total attribute. This is necessary for the sorted method to work
    def get_total(self):
        return self.total

    # A __repr__ method, to see an in depth discussion of why this is needed, see the alvl class
    def __repr__(self):
        return '{}: {} {}'.format(self.__class__.__name__,
                                  self.identifier,
                                  self.id_num)

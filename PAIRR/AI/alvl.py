# A class to represent the idea of "an A Level as an input neuron"
# Shares identifier and id_num attributes with neuron class


class Alvl:

    identifier = None
    id_num = None
    # Weights, when initialised, is an area containing the weights to the neurons
    # with the id_num of the position of the weight in the array
    # for example, the weight for the neuron with the id 10, is at position 10 in the array
    weights = None

    # An __init__ function that creates the object. It requires all attributes to be passed to it
    def __init__(self, _id_num, _identifier, _weights):
        print "a level " + str(_id_num) + " initiated"
        self.id_num = _id_num
        self.identifier = _identifier
        self.weights = _weights

    # This __repr__ method assists in debugging, as it allows the object to be represented in a string
    # This means that in the debugger, it shows an object as "ALevel: French with ID 2
    # as apposed to merely an ALevel at a memory location
    def __repr__(self):
        return "ALevel: {} with ID {}".format(self.identifier,
                                              self.idnum)

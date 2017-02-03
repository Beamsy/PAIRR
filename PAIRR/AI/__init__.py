from neuron import Neuron
from alvl import Alvl
neuronlist = [Neuron(count) for count in range(3)]
alvllist = [Alvl(count) for count in range(6)]
alvls = {1, 3, 5}
alvllist[5].weights[2] = 0.75
for i in range(neuronlist.__len__()):
    neuronlist[i].sum_weighted_inputs(alvls, alvllist)
for i in range(neuronlist.__len__()):
    print neuronlist[i].total
selected = sorted(neuronlist, key=lambda neuron: Neuron.total, reverse=True) #Sorts neurons by reverse weighting

print "Neuron " + str(selected[0].idnum) + ": " + str(selected.total)

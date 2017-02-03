from neuron import Neuron
from alvl import Alvl
degree_list = NotImplemented
neuron_list = [Neuron(count) for count in range(3)]
alvl_list = [Alvl(count) for count in range(6)]
alvls_studied = {1, 3, 5}
alvl_list[5].weights[2] = 0.75
for i in range(neuron_list.__len__()):
    neuron_list[i].sum_weighted_inputs(alvls_studied, alvl_list)
for i in range(neuron_list.__len__()):
    print neuron_list[i].total
selected = sorted(neuron_list, key=Neuron.get_total, reverse=True)[0]  # Sorts neurons by reverse weighting
print "Neuron " + str(selected.idnum) + ": " + str(selected.total)

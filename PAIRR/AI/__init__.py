from neuron import Neuron
from alvl import Alvl

alvl_names = ["Environmental Science", "Media Studies", "French", "Computer Science", "Physics", "Economics"]
degree_list = ["Animal Conservation", "Human Bio-science", "Computing"]
neuron_list = [Neuron(count, degree_list[count]) for count in range(degree_list.__len__())]
alvl_list = [Alvl(count, alvl_names[count]) for count in range(alvl_names.__len__())]
alvls_studied = {1, 2, 4}
alvl_list[3].weights[2] = 1

for i in range(neuron_list.__len__()):
    neuron_list[i].sum_weighted_inputs(alvls_studied, alvl_list)

for i in range(neuron_list.__len__()):
    print neuron_list[i].total

selected = sorted(neuron_list, key=Neuron.get_total, reverse=True)[0]  # Sorts neurons by reverse weighting
print "Neuron " + str(selected.id_num) + ": " + str(selected.total)
print "You should study: " + selected.identifier

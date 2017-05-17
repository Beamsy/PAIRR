
from neuron import Neuron
from alvl import Alvl
import json
import os


# Opens save state file
def __init__():
    from neuron import Neuron
    from alvl import Alvl
    file_path = os.path.dirname(alvl.__file__)
    # Opens save state file
    json_file = open(os.path.join(file_path, "ai_saved_state.json"), mode="r")

    # Loads save state file into json deserialiser
    json_data = json.load(json_file)

    # Declare empty lists
    a_lvl_list = []
    a_lvl_names = []
    neuron_list = []

    # Iterates through 'ALevels' portion of json_data and populates empty lists above
    for item in json_data['ALevels']:
        a_lvl_list.append(Alvl(item['id_num'], str(item['identifier']), item['weights']))
        a_lvl_names.append(str(item['identifier']))

    # Does the same as above for the 'Degrees' portion of json_data
    for item in json_data['Degrees']:
        neuron_list.append(Neuron(item['id_num'], str(item['identifier'])))

    # Current user input
    a_lvl1 = a_lvl_list[a_lvl_names.index(raw_input("Enter A Levels one line at a time: "))]
    a_lvl2 = a_lvl_list[a_lvl_names.index(raw_input("A Level 2: "))]
    a_lvl3 = a_lvl_list[a_lvl_names.index(raw_input("A Level 3: "))]
    a_lvls_studied = {a_lvl1, a_lvl2, a_lvl3}

    # Performs total weight summation for all neurons individually
    for i in range(neuron_list.__len__()):
        neuron_list[i].sum_weighted_inputs(a_lvls_studied)

    # Sorts neurons by reverse weighting and selects highest weighted
    selected = sorted(neuron_list, key=Neuron.get_total, reverse=True)[0]

    # Prints the highest weighted neuron id and total
    print "Neuron " + str(selected.id_num) + ": " + str(selected.total)

    # Prints the identifier of the selected neuron (the output!)
    print "You should study: " + selected.identifier

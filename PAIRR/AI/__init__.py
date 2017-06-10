def __init__(a_lvls):
    from neuron import Neuron
    from alvl import Alvl
    import json
    import os
    import platform
    import voice_engine
    import SerialConnect
    from time import sleep

    # Opens save state file and oads save state file into json deserialiser
    with open("AI/ai_saved_state.json", mode="r") as json_file:
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

    if not a_lvls:
        # Current user input
        a_lvl1 = a_lvl_list[a_lvl_names.index(raw_input("Enter A Levels one line at a time: "))]
        a_lvl2 = a_lvl_list[a_lvl_names.index(raw_input("A Level 2: "))]
        a_lvl3 = a_lvl_list[a_lvl_names.index(raw_input("A Level 3: "))]
        a_lvls_studied = {a_lvl1, a_lvl2, a_lvl3}
    elif a_lvls:
        a_lvl1 = a_lvl_list[a_lvls[0]]
        a_lvl2 = a_lvl_list[a_lvls[1]]
        a_lvl3 = a_lvl_list[a_lvls[2]]
        a_lvls_studied = {a_lvl1, a_lvl2, a_lvl3}

    # Performs total weight summation for all neurons individually
    for i in range(neuron_list.__len__()):
        neuron_list[i].sum_weighted_inputs(a_lvls_studied)

    # Sorts neurons by reverse weighting and selects highest weighted
    selected = sorted(neuron_list, key=Neuron.get_total, reverse=True)[0]
    SerialConnect.serial_connect(SerialConnect.LOADING)
    SerialConnect.serial_wait()
    # Prints the highest weighted neuron id and total
    print "Neuron " + str(selected.id_num) + ": " + str(selected.total)
    SerialConnect.serial_connect(SerialConnect.RECEIVEDRESULTS)
    # Says the identifier of the selected neuron (the output!)
    voice_engine.say("You should study: " + selected.identifier)
    SerialConnect.serial_wait()
    # This section of code will only run if the computer it is running on is ARM based.
    # This means it will not run on a normal computer, but will run on a Raspberry Pi.
    if 'arm' in platform.machine():
        import GPIO_utils

        def add_event_detects():
            GPIO_utils.GPIO.add_event_detect(GPIO_utils.good_button_pin, GPIO_utils.GPIO.RISING,
                                             callback=increase_relation, bouncetime=300)
            GPIO_utils.GPIO.add_event_detect(GPIO_utils.bad_button_pin, GPIO_utils.GPIO.RISING,
                                             callback=decrease_relation, bouncetime=300)

        def remove_event_detects():
            GPIO_utils.GPIO.remove_event_detect(GPIO_utils.good_button_pin)
            GPIO_utils.GPIO.remove_event_detect(GPIO_utils.bad_button_pin)

        def backwards_propagation():
            add_event_detects()
            sleep(10)
            remove_event_detects()

        def increase_relation(channel):
            remove_event_detects()
            update_saved_state(+1)

        def decrease_relation(channel):
            remove_event_detects()
            update_saved_state(-1)

        def update_saved_state(update):
            print "State updated! "+str(update)
            for a_lvl in a_lvls_studied:
                for item in json_data['ALevels']:
                    if item['id_num'] == a_lvl.id_num:
                        item['weights'][selected.id_num] += update * 0.01
            with open("AI/ai_saved_state.json", mode="w") as json_file:
                json.dump(json_data, json_file)

        sleep(2.5)
        voice_engine.say("Was this a good recommendation or not?")
        voice_engine.say("Please help me learn by pressing green for good and red for bad.")
        SerialConnect.serial_connect(SerialConnect.LOOKBACKPROP)
	SerialConnect.serial_wait()
        backwards_propagation()
        voice_engine.say("Thank you!")
        SerialConnect.serial_connect(SerialConnect.SLEEP)
	SerialConnect.serial_wait()

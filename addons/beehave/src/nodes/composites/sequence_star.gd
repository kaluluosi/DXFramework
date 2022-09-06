# Special implementation of sequencer who will execute
# successful nodes only once until all nodes were successful

extends Composite

class_name SequenceStar,  "res://addons/beehave/icons/sequencer_star.svg"

var successful_index = 0

func tick(actor, blackboard):
	for c in get_children():
		if c.get_index() < successful_index:
			continue

		var response = c.tick(actor, blackboard)

		if c is Condition:
			blackboard.set("__last_condition", c)
			blackboard.set("__last_condition_status", response)

		if response != SUCCESS:
			if response == FAILURE:
				successful_index = 0
			if c is Action and response == RUNNING:
				blackboard.set("__running_action", c)
			return response
		else:
			successful_index += 1

	if successful_index == get_child_count():
		successful_index = 0
		return SUCCESS
	else:
		successful_index = 0
		return FAILURE

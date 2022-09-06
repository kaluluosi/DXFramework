# Special implementation of a selector that will
# "wait" for running nodes and will not re-attempt
# to execute previous nodes until that node is either
# FAILED or SUCCEEDED
extends Composite

class_name SelectorStar,  "res://addons/beehave/icons/selector_star.svg"


var last_execution_index = 0

func tick(actor, blackboard):
	for c in get_children():
		if c.get_index() < last_execution_index:
			continue

		var response = c.tick(actor, blackboard)

		if c is Condition:
			blackboard.__last_condition = c
			blackboard.__last_condition_status = response

		if response != FAILURE:
			if c is Action and response == RUNNING:
				blackboard.__running_action = c
			if response == SUCCESS:
				last_execution_index = 0
			return response
		else:
			last_execution_index += 1

	last_execution_index = 0
	return FAILURE

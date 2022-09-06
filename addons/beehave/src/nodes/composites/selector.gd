extends Composite

class_name Selector,  "res://addons/beehave/icons/selector.svg"

func tick(actor, blackboard):
	for c in get_children():
		var response = c.tick(actor, blackboard)

		if c is Condition:
			blackboard.set("__last_condition", c)
			blackboard.set("__last_condition_status", response)

		if response != FAILURE:
			if c is Action and response == RUNNING:
				blackboard.set("__running_action", c)
			return response

	return FAILURE

extends Decorator

class_name Inverter,  "res://addons/beehave/icons/inverter.svg"


func tick(action, blackboard):
	for c in get_children():
		var response = c.tick(action, blackboard)

		if response == SUCCESS:
			return FAILURE
		if response == FAILURE:
			return SUCCESS

		if c is Leaf and response == RUNNING:
			blackboard.__running_action = c
		return RUNNING

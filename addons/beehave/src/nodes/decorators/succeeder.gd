extends Decorator

class_name AlwaysSucceed, "res://addons/beehave/icons/succeed.svg"


func tick(action, blackboard):
	for c in get_children():
		var response = c.tick(action, blackboard)
		if response == RUNNING:
			return RUNNING
		return SUCCESS

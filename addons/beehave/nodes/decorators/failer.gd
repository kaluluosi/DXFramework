extends Decorator

class_name AlwaysFail,  '../../icons/fail.svg'


func tick(action, blackboard):
	for c in get_children():
		var response = c.tick(action, blackboard)
		if response == RUNNING:
			return RUNNING
	return FAILURE

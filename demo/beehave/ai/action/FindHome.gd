extends Action

export var key:String


func tick(actor, blackboard:Dictionary) -> int:

	var homes = get_tree().get_nodes_in_group('Home')
	if homes:
		blackboard[key] = homes[0]
		return SUCCESS
	else:
		return FAILED

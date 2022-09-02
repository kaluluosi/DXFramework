extends Action

export var key:String


func tick(actor, blackboard:Blackboard) -> int:

	var homes = get_tree().get_nodes_in_group('Home')
	if homes:
		blackboard.set(key, homes[0])
		return SUCCESS
	else:
		return FAILED

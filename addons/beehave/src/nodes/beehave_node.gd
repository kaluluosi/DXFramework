extends BeehaveTree

class_name BeehaveNode,  "res://addons/beehave/icons/action.svg"

enum { SUCCESS, FAILURE, RUNNING }

func tick(actor, blackboard:Dictionary) -> int:
	return SUCCESS

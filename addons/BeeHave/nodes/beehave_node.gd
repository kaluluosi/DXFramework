extends BeehaveTree

class_name BeehaveNode,  '../icons/action.svg'

enum { SUCCESS, FAILURE, RUNNING }

func tick(actor, blackboard:Blackboard) -> int:
	return SUCCESS


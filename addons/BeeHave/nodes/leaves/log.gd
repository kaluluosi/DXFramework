class_name LogAction, '../../icons/log.svg'
extends Action

export(String, MULTILINE) var text:String = 'hello'


func tick(actor, blackboard:Blackboard) -> int:
	print_debug(text)
	return SUCCESS

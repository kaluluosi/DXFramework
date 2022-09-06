class_name LogAction, "res://addons/beehave/icons/log.svg"
extends Action

export(String, MULTILINE) var text:String = 'hello'


func tick(actor, blackboard:Dictionary) -> int:
	print_debug(text)
	return SUCCESS

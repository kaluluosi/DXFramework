tool
class_name State, "res://addons/hfsm/icons/state.svg"
extends HFSM

func _get_configuration_warning():
	
	if not get_parent() is HFSM:
		return "parent must be HFSM node"

	return ""

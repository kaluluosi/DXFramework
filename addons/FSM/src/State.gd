tool
class_name State, 'res://addons/FSM/asset/state.svg'
extends FSM


func enter(actor) -> void:
	pass

func exit(actor) -> void:
	pass

func tick(actor, delta) -> void:
	pass


func can_transition_to(state_name:String) -> bool:
	return false

func _get_configuration_warning() -> String:

	if not get_parent() is FSM:
		return "父节点必须是FSM节点"

	return ""

func to_string():
	return name

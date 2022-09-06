tool
class_name HFSM, "res://addons/hfsm/icons/statemachine.svg"
extends Node



func _ready():
	if get_script() == load("res://addons/hfsm/src/hfsm.gd"):
		push_error("HFSM node is useless, don't instance it! Use StateMachine insteal.")
		breakpoint


func _get_configuration_warning() -> String:
	return "HFSM node is useless, don't instance it! Use StateMachine insteal."


func enter(actor:Node, blackboard:Dictionary):
	pass
	
func tick(actor:Node, blackboard:Dictionary, delta:float):
	pass
	
func exit(actor:Node, blackboard:Dictionary):
	pass


func can_transition_to(state_name:String) -> bool:
	return false
	
func transition_to(state_name:String):
	pass

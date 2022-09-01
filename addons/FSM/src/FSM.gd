class_name FSM,'res://addons/FSM/asset/statemachine.svg'
extends Node


func enter(actor) -> void:
	pass

func exit(actor) -> void:
	pass

func tick(actor, delta) -> void:
	pass

func can_transition_to(state_name:String) -> bool:
	return false

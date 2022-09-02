tool
extends EditorPlugin

const Blackboard = preload("res://addons/beehave/src/blackboard.gd")

func _init():
	print("Beehave initialized!")

func _enter_tree() -> void:
	add_custom_type('Blackboard', 'Resource', Blackboard,load('res://addons/beehave/icons/blackboard.svg'))

func _exit_tree() -> void:
	remove_custom_type('Blackboard')

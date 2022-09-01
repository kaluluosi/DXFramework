tool
extends EditorPlugin

const Blackboard = preload('blackboard.gd')

func _init():
	print("Beehave initialized!")

func _enter_tree() -> void:
	add_custom_type('Blackboard', 'Resource', Blackboard,load('res://addons/BeeHave/icons/blackboard.svg'))

func _exit_tree() -> void:
	remove_custom_type('Blackboard')

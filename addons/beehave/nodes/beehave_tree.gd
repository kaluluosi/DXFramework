extends Node
class_name BeehaveTree, '../icons/icon.png'

func _ready():
	if get_script() == load('res://addons/BeeHave/nodes/beehave_tree.gd'):
		push_error("BeehaveTree node is useless, don't instance it! Use BeehaveRoot insteal.")
		breakpoint

func _get_configuration_warning() -> String:
	return "BeehaveTree node is useless, don't instance it! Use BeehaveRoot insteal."

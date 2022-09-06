extends Label

export var beehave_root:NodePath

onready var _beehave_root:BeehaveRoot = get_node(beehave_root)

func _process(delta: float) -> void:
	var running_node = _beehave_root.blackboard.get('__running_action')
	if running_node:
		text = running_node.name
	else:
		text = ''



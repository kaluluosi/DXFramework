tool
extends BeehaveTree

class_name BeehaveRoot, '../icons/tree.svg'

enum {
SUCCESS = 0
FAILURE = 1
RUNNING = 2
}

enum ProcessMode {
	PHYSICS_PROCESS,
	IDLE,
	MANUAL
}

export (bool) var enabled = false setget set_enable
export (NodePath) var actor_node_path
export (ProcessMode) var process_mode = ProcessMode.PHYSICS_PROCESS

var actor : Node

onready var blackboard = Blackboard.new()

func _ready():
	if Engine.editor_hint:
		return

	if self.get_child_count() != 1:
		push_error("Beehave error: Root should have one child")
		self.enabled = false
		return

	set_enable(enabled)

	actor = get_parent()
	if actor_node_path:
		actor = get_node(actor_node_path)

func _process(delta):
	if Engine.editor_hint:
		return

	if process_mode == ProcessMode.IDLE:
		tick(delta)

func _physics_process(delta):
	if Engine.editor_hint:
		return

	if process_mode == ProcessMode.PHYSICS_PROCESS:
		tick(delta)

func tick(delta):
	blackboard.set("delta", delta)

	var status = self.get_child(0).tick(actor, blackboard)

	if status != RUNNING:
		blackboard.set("running_action", null)

func get_running_action():
	if blackboard.has("running_action"):
		return blackboard.get("running_action")
	return null

func get_last_condition():
	if blackboard.has("last_condition"):
		return blackboard.get("last_condition")
	return null

func get_last_condition_status():
	if blackboard.has("last_condition_status"):
		var status = blackboard.get("last_condition_status")
		if status == SUCCESS:
			return "SUCCESS"
		elif status == FAILURE:
			return "FAILURE"
		else:
			return "RUNNING"
	return ""

func set_enable(value):
	if value:
		enabled = true
		set_process(self.enabled)
		set_physics_process(self.enabled)
	else:
		enabled = false
		set_process(self.enabled)
		set_physics_process(self.enabled)



func _get_configuration_warning() -> String:
	if self.get_child_count() != 1:
		return "Beehave error: Root should have one child"

	for c in get_children():
		if not c is BeehaveNode:
			return "Beehave error: %s is not BeehaveNode"%[c.name]

	return ""

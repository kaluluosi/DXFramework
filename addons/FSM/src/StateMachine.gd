tool
class_name StateMachine, 'res://addons/FSM/asset/statemachine.svg'
extends FSM

enum ProcessMode {
	PHYSIC_PROCESS, # 用_physic_process驱动
	IDLE, # 用_process
	MANUAL,# 手动驱动(由外部调用tick驱动)
}

signal transitioned(state_name)

export var enabled:bool = true # tick开关
export var actor_node_path:NodePath # 宿主节点路径，不设置就默认取父节点
export var start_state_path:NodePath
export(ProcessMode) var process_mode = ProcessMode.PHYSIC_PROCESS

var active_state:FSM
var _actor

func _ready() -> void:

	if Engine.editor_hint:
		return

	if actor_node_path.is_empty():
		_actor = owner
	else:
		_actor = get_node(actor_node_path)

	yield(_actor, 'ready')
	enter(_actor)

func enter(actor):
	active_state = get_node(start_state_path)
	print("%s 状态 %s| >> %s"%[owner,name,active_state.name])
	active_state.enter(actor)


func exit(actor):
	active_state.exit(actor)

func tick(actor, delta):
	active_state.tick(actor, delta)


func _process(delta: float) -> void:
	if enabled and not Engine.editor_hint:
		if process_mode == ProcessMode.IDLE:
			tick(_actor, delta)
			_check_state()

func _physics_process(delta: float) -> void:
	if enabled and not Engine.editor_hint:
		if process_mode == ProcessMode.PHYSIC_PROCESS:
			tick(_actor, delta)
			_check_state(_actor)

# 通过检查孩子的can_transition_to来自动跳转
func _check_state(actor=null):
	for state in get_children():
		if state is State and active_state.can_transition_to(state.name):
			transition_to(state.name, actor)

# 手动跳转
func transition_to(state_name:String, actor=null):
	if active_state.name == state_name:
		return

	print("%s 状态 %s| %s >> %s"%[owner,name,active_state.name, state_name])
	active_state.exit(actor)
	active_state = get_node(state_name)
	active_state.enter(actor)
	emit_signal('transitioned')

func _get_configuration_warning() -> String:
	if get_parent() is FSM:
		return "父节点不可一是FSM"

	for c in get_children():
		if not c is FSM:
			return "%s 节点不是FSM节点" %[c.name]

	if start_state_path.is_empty():
		return "Start State Path必须设置初始状态节点"
	elif not get_node(start_state_path) in get_children():
		return "Start State Path不是状态机的直接孩子"

	return ""


func can_transition_to(state_name:String) -> bool:
	return false


func to_string():
	return "%s"%[active_state.to_string()]

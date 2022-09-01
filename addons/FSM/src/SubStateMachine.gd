tool
class_name SubStateMachine, 'res://addons/FSM/asset/statemachine.svg'
extends State


signal transitioned(state_name)

export var start_state_path:NodePath

var active_state:FSM

func enter(actor):
	active_state = get_node(start_state_path)
	print("%s 状态 %s| >> %s"%[owner,name,active_state.name])
	active_state.enter(actor)

func exit(actor):
	active_state.exit(actor)

func tick(actor, delta):
	active_state.tick(actor, delta)
	_check_state()

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
	return "%s|%s" %[name , active_state.to_string()]

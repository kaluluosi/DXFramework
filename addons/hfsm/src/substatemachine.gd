tool
class_name SubStateMachine, "res://addons/hfsm/icons/substatemachine.svg"
extends State

signal transitioned(from, to)

export(NodePath) var start_state_path

var active_state:State setget _no_set,get_active_state

func _ready():
	if Engine.editor_hint:
		return
	
	assert(get_child_count(), 'StateMachine error: should have one state')
	
	for c in get_children():
		c.actor = actor
		c.blackboard = blackboard

func _get_configuration_warning():
	if start_state_path.is_empty():
		return "start_state_path must set"
	
	if get_node(start_state_path) is State == false:
		return "start_state_path is not a state"
	
	if get_node(start_state_path) == self:
		return "start_state_path can't be itself"
		
	if not get_parent() is HFSM:
		return "parent must be HFSM node"
	
	if (get_node(start_state_path) in get_children()) == false:
		return "start_state_path is not children"
	
	return ""	

func _no_set(value) -> void:
	pass

func get_active_state() -> State:
	return active_state

func enter():
	if Engine.editor_hint:
		return
	
	# transition_to 要用到actor，因此只好缓存了actor到成员变量
	self.actor = actor
	self.blackboard = blackboard
	active_state = get_node(start_state_path)
	active_state.enter()

	print_debug("{actor}  {state_machine}| enter >> {state}".format(
		{
			"actor":actor.name,
			"state_machine":name,
			"state":active_state.name
		}
	))

func exit():
	if Engine.editor_hint:
		return
	active_state.exit()
	print_debug("{actor}  {state_machine}| {state} >> exit".format(
		{
			"actor":actor.name,
			"state_machine":name,
			"state":active_state.name
		}
	))
	active_state = null


# call it while MANUAL mode
# 如果是手动模式，你需要手动调用这个
func tick(delta:float):
	if active_state:
		active_state.tick(delta)
		_check_state()

# 手动跳转
func transition_to(state_name:String):
	if active_state.name == state_name:
		return
	
	# 这里要用到actor，因此只好缓存了actor到成员变量
	print_debug("{actor}  {state_machine}| {from} >> {to}".format(
		{
			"actor":actor.name,
			"state_machine":name,
			"from":active_state.name,
			"to":state_name
		}
	))
	var from = active_state.name
	var to = state_name
	active_state.exit()
	active_state = get_node(state_name)
	active_state.enter()
	emit_signal('transitioned', from, to)
	
# 通过检查孩子的can_transition_to来条件驱动自动跳转
func _check_state():
	for state in get_children():
		if state is State and active_state.can_transition_to(state.name):
			transition_to(state.name)


class_name WaitAction, "res://addons/beehave/icons/wait.svg"
extends Action

export var wait_time:float = 1
var _timer:SceneTreeTimer

func tick(actor, blackboard:Dictionary) -> int:
	# 如果_timer为空则表示新一轮等待
	if _timer == null:
		_timer = get_tree().create_timer(wait_time)

	if _timer.time_left > 0:
		return RUNNING
	else:
		# 等待结束把_timer置空，表示这一轮等待结束
		_timer = null
		return SUCCESS

extends Action

export var wait_time_min:float = 1
export var wait_time_max:float = 5
var _timer:SceneTreeTimer

func tick(actor, blackboard:Blackboard) -> int:
	# 如果_timer为空则表示新一轮等待
	if _timer == null:
		_timer = get_tree().create_timer(rand_range(wait_time_min,wait_time_max))

	if _timer.time_left > 0:
		return RUNNING
	else:
		# 等待结束把_timer置空，表示这一轮等待结束
		_timer = null
		return SUCCESS

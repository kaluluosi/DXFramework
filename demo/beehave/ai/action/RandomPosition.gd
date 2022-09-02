extends Action
const Bee = preload("res://demo/beehave/entity/bee.gd")

export var key:String

func tick(actor:Bee, blackboard:Blackboard) -> int:
	seed(OS.get_unix_time()+get_instance_id())
	var size = get_viewport().size
	var pos = Vector2(rand_range(0,size.x), rand_range(0,size.y))
	blackboard.set(key, pos)
	return SUCCESS

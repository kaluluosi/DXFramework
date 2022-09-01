extends Action
const Bee = preload("res://demo/beehave/entity/Bee.gd")

export var key:String

func tick(actor:Bee, blackboard:Blackboard) -> int:
	var pos = Vector2(rand_range(0,500), rand_range(0,500))
	blackboard.set(key, pos)
	return SUCCESS

extends Action

const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')

export var key:String

func tick(actor:Bee, blackboard:Blackboard) -> int:

	var flower:Flower = blackboard.get(key)
	if not flower:
		return FAILED

	flower.enter(actor)
	return SUCCESS
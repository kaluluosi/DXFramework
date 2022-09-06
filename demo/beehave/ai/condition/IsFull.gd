extends Condition

const Bee = preload("res://demo/beehave/entity/bee.gd")
const Flower = preload('res://demo/beehave/entity/flower.gd')


func tick(actor:Bee, blackboard:Dictionary) -> int:

	if actor.is_full():
		return SUCCESS
	else:
		return FAILED

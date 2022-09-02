extends Condition

const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')


func tick(actor:Bee, blackboard:Blackboard) -> int:

	if actor.is_full():
		return SUCCESS
	else:
		return FAILED

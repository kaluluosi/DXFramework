extends Condition


const Bee = preload("res://demo/beehave/entity/Bee.gd")


func tick(actor:Bee, blackboard:Blackboard) -> int:
	if actor.is_empty():
		return SUCCESS
	else:
		return FAILED


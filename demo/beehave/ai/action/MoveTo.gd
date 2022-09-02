extends Action
const Bee = preload("res://demo/beehave/entity/bee.gd")
const Flower = preload('res://demo/beehave/entity/flower.gd')

export var key:String
export var distance:float = 10

func tick(actor:Bee, blackboard:Blackboard) -> int:

	var target = blackboard.get(key)

	if not target:
		return FAILED

	var result = actor.move_to(target, distance)
	if result:
		return SUCCESS
	else:
		return RUNNING

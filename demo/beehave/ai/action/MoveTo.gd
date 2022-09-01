extends Action
const Bee = preload("res://demo/beehave/entity/Bee.gd")

export var key:String


func tick(actor:Bee, blackboard:Blackboard) -> int:

	var target = blackboard[key]

	if not target:
		return FAILED

	var result = actor.move_to(target)
	if result:
		return SUCCESS
	else:
		return RUNNING

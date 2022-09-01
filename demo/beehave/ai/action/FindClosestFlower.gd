extends Action
const Bee = preload("res://demo/beehave/entity/Bee.gd")

export var key:String

func tick(actor:Bee, blackboard:Blackboard) -> int:

	var flowers = actor.get_flowers()
	if not flowers:
		return FAILED

	var closest =null
	var distance = INF

	for f in flowers:
		var dist = actor.global_position.distance_to(f.global_position)
		if dist < distance:
			distance = dist
			closest = f

	blackboard[key] = closest
	return SUCCESS

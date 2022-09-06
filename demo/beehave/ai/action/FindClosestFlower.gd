extends Action
const Bee = preload("res://demo/beehave/entity/bee.gd")
const Flower = preload('res://demo/beehave/entity/flower.gd')

export var key:String
export(Flower.State) var state = Flower.State.GROW

func tick(actor:Bee, blackboard:Dictionary) -> int:

	var flowers = actor.get_flowers()
	if not flowers:
		return FAILED

	var closest =null
	var distance = INF

	for f in flowers:
		var dist = actor.global_position.distance_to(f.global_position)
		if dist < distance and f.state == state and not f.is_bee_inside():
			distance = dist
			closest = f

	blackboard[key] = closest
	return SUCCESS

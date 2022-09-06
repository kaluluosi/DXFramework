extends Action
const Bee = preload("res://demo/beehave/entity/bee.gd")

export var key:String
export var distance:float = 10

func tick(actor:Bee, blackboard:Dictionary) -> int:

	var pos = blackboard.get(key)
	if pos:
		var result = actor.move_to_position(pos,distance)
		if result:
			return SUCCESS
		else:
			return RUNNING
	else:
		return FAILED

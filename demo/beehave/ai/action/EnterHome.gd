extends Action

const Bee = preload("res://demo/beehave/entity/bee.gd")
const Flower = preload('res://demo/beehave/entity/flower.gd')
const Home = preload("res://demo/beehave/entity/home.gd")

export var key:String

func tick(actor:Bee, blackboard:Blackboard) ->int:

	var home:Home = blackboard.get(key)
	if not home:
		return FAILED

	home.enter(actor)
	return SUCCESS

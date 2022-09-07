extends Action

const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')
const Home = preload("res://demo/beehave/entity/Home.gd")

export var key:String

func tick(actor:Bee, blackboard:Dictionary) ->int:

	var home:Home = blackboard.get(key)
	if not home:
		return FAILED

	home.enter(actor)
	return SUCCESS

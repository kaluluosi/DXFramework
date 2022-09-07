extends Condition

const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')
const Home = preload("res://demo/beehave/entity/Home.gd")



func tick(actor:Bee, blackboard:Dictionary) -> int:

	if actor.is_full():
		return SUCCESS
	else:
		return FAILED

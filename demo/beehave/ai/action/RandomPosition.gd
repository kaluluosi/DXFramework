extends Action
const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')
const Home = preload("res://demo/beehave/entity/Home.gd")


export var key:String

func tick(actor:Bee, blackboard:Dictionary) -> int:
	seed(OS.get_unix_time()+get_instance_id())
	var size = get_viewport().size
	var pos = Vector2(rand_range(0,size.x), rand_range(0,size.y))
	blackboard[key] = pos
	return SUCCESS

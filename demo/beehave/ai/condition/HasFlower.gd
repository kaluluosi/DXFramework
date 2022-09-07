extends Condition


const Bee = preload("res://demo/beehave/entity/Bee.gd")
const Flower = preload('res://demo/beehave/entity/Flower.gd')
const Home = preload("res://demo/beehave/entity/Home.gd")


export(Flower.State) var state = Flower.State.GROW

func tick(actor:Bee, blackboard:Dictionary) -> int:

	var flowers = get_tree().get_nodes_in_group('Flower')
	for f in flowers:
		if f.state == Flower.State.GROW:
			return SUCCESS

	return FAILED

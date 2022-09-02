extends Condition


const Bee = preload("res://demo/beehave/entity/bee.gd")
const Flower = preload('res://demo/beehave/entity/flower.gd')

export(Flower.State) var state = Flower.State.GROW

func tick(actor:Bee, blackboard:Blackboard) -> int:

	var flowers = get_tree().get_nodes_in_group('Flower')
	for f in flowers:
		if f.state == Flower.State.GROW:
			return SUCCESS

	return FAILED

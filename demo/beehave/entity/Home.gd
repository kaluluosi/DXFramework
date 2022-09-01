extends MeshInstance2D


var bees:Array = []


func enter(bee:Node2D):
	bee.get_parent().remove_child(bee)
	bees.append(bee)

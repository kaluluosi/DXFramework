extends MeshInstance2D
const Bee = preload('res://demo/beehave/entity/Bee.gd')

export var honey = 0
onready var progressbar = $ProgressBar

var bees:Array = []


func enter(bee:Bee):
	bee.get_parent().remove_child(bee)
	bees.append(bee)

func exit(bee:Bee):
	bees.erase(bee)
	get_tree().current_scene.add_child(bee)
	bee.global_position = global_position


func _on_TakeOffTimer_timeout() -> void:

	for bee in bees:
		bee = bee as Bee
		var amount = min(bee.honey, bee.honey_per_sec)
		bee.honey -= amount

		#先不考虑上限
		honey += amount
		if bee.honey == 0:
			exit(bee)


func _process(delta: float) -> void:

	progressbar.value = honey
	progressbar.max_value = 1000

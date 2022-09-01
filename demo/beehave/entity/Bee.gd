extends KinematicBody2D

var input_vector:Vector2
var velocity:Vector2
var speed = 200

var max_honey:float = 30
var honey = 0
var honey_per_sec = 10

onready var flower_detector:Area2D = $FlowerDetector

func _move(direction:Vector2):
	velocity = direction*speed


func _physics_process(delta: float) -> void:
	_move(input_vector)
	_update_facing()
	velocity = move_and_slide(velocity)

func _update_facing():
	if input_vector.x !=0:
		$Bee.flip_h = input_vector.x == 1

func move_to(target:Node2D, distance:float = 30) -> bool:
	if global_position.distance_to(target.global_position)<distance:
		input_vector = Vector2.ZERO
		return true

	input_vector = global_position.direction_to(target.global_position)
	return false

func get_flowers():
	var areas = flower_detector.get_overlapping_areas()
	for area in areas:
		if not area.is_in_group('Flower'):
			areas.erase(area)
	return areas

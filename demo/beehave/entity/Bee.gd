extends KinematicBody2D

var input_vector:Vector2
var velocity:Vector2
export var speed = 200

var max_honey:float = 30
var honey = 0
var honey_per_sec = 10

onready var flower_detector:Area2D = $FlowerDetector
onready var behav:BeehaveRoot = $BeehaveRoot
onready var progressbar:ProgressBar = $ProgressBar

func is_full():
	return honey >= max_honey

func is_empty():
	return honey == 0

func _move(direction:Vector2):
	velocity = direction*speed
	_update_facing()
	velocity = move_and_slide(velocity)


func _physics_process(delta: float) -> void:
	_move(input_vector)

func _update_facing():
	if input_vector.x !=0:
		$Bee.flip_h = input_vector.x > 0

func move_to(target:Node2D, distance:float = 30) -> bool:
	return move_to_position(target.global_position, distance)

func move_to_position(pos:Vector2, distance:float=30) -> bool:
	if global_position.distance_to(pos)<distance:
		input_vector = Vector2.ZERO
		return true

	input_vector = global_position.direction_to(pos)
	return false

func get_flowers():
	var areas = flower_detector.get_overlapping_areas()
	var flowers = []
	for area in areas:
		if area.is_in_group('Flower'):
			flowers.append(area)
	return flowers


func _process(delta: float) -> void:
	progressbar.max_value = max_honey
	progressbar.value = honey

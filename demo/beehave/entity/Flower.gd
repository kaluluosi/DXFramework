extends Area2D
const Bee = preload("res://demo/beehave/entity/bee.gd")
const IndicatorTscn = preload("res://demo/beehave/ui/indicator.tscn")

enum State{
	GROW,
	RECOVERING
}

export var max_honey:float = 100
var honey:float = 0
var honey_recover_per_sec = 10

var state = State.GROW

onready var sprite = $Flower
onready var slot = $Slot
onready var suck_timer =$SuckTimer
onready var recover_timer = $RecoverTimer
onready var progressbar:ProgressBar = $ProgressBar
var _bee:Bee

func _ready() -> void:
	honey = max_honey

func is_bee_inside():
	return _bee != null

func enter(bee:Bee):
	if _bee:
		return
	_bee = bee

	_bee.get_parent().remove_child(_bee)
	slot.add_child(_bee)
	_bee.global_position = slot.global_position
	_bee.behav.enabled = false
	suck_timer.start()

func exit():
	if not _bee:
		return
	print_debug('exit bee')
	slot.remove_child(_bee)
	get_tree().current_scene.add_child(_bee)
	_bee.global_position = slot.global_position
	_bee.behav.enabled = true
	_bee = null


func _on_SuckTimer_timeout() -> void:

	if not _bee:
		suck_timer.stop()

	var honey_per_sec = _bee.honey_per_sec

	# 还有多少油水可榨
	var amount = min(honey, honey_per_sec)
	# bee能拿多少
	var bee_can_take = _bee.max_honey-_bee.honey

	var real_amount = min(bee_can_take, amount)
	honey -= real_amount
	_bee.honey += real_amount
#	print_debug('flower -%s = %s'%[real_amount, honey])
#	print_debug('bee +%s = %s'%[real_amount, _bee.honey])
	var indicator = IndicatorTscn.instance()
	indicator.value = real_amount
	indicator.global_position = global_position
	get_tree().current_scene.add_child(indicator)

	if honey <= 0 or _bee.is_full():
		suck_timer.stop()
		exit()

	if honey <= 0:
		recover_timer.start()
		state = State.RECOVERING


func _on_RecoverTimer_timeout() -> void:
	honey += honey_recover_per_sec
	honey = clamp(honey, 0, max_honey)
	if honey >= max_honey:
		recover_timer.stop()
		state = State.GROW


func _process(delta: float) -> void:
	progressbar.value = honey
	progressbar.max_value = max_honey

	sprite.modulate.r = honey/max_honey

extends KinematicBody2D

enum Gait{
	Walk,
	Run,
	Sprint
}

onready var stand_collisionshape = $StandCollisionShape
onready var crouch_collisionshape = $CrouchCollisionShape

# 各种状态下的最大速度
export var max_walk_speed:float = 100
export var max_run_speed:float = 120
export var max_sprint_speed:float = 240

# 各种状态下的跳跃速度
export var jump_speed = 270
export var run_jump_speed = 300
export var max_jump_count = 2


# 各种状态下的重力系数
export var default_gravity_scale:float = 10
export var jump_gravity_scale:float = 5
export var attack_gravity = 2

# 最大下落速度
export var max_default_fall:float = 270
export var max_wall_fall:float = 60
export var max_attack_fall:float = 120

# 能力
export var can_crouch = true
export var can_jump = true
export var can_sprint = true
export var can_swim = true

# 成员
var input_vector:Vector2
var velocity:Vector2
var max_speed:float = 100
var max_fall_speed:float = max_default_fall
var gravity_scale:float = default_gravity_scale
var accel:float = 500
var deccel:float = 500
var jump_count = 0
var facing = 1
var gait_mode = Gait.Run setget _set_gait_mode

# 标记
var is_crouching:bool = false


func _ready():
	self.gait_mode = Gait.Run

func _input(event):
	
	input_vector = Input.get_vector(
		'p1_left','p1_right',
		'p1_up', 'p1_down'
	)


func _set_gait_mode(value):
	gait_mode = value
	match gait_mode:
		Gait.Walk:
			max_speed = max_walk_speed
		Gait.Run:
			max_speed = max_run_speed
		Gait.Sprint:
			max_speed = max_sprint_speed
		_:
			max_speed = max_walk_speed


func get_default_gravity():
	return ProjectSettings["physics/2d/default_gravity"]


func _physics_process(delta):
	velocity_process(delta)
	gravity_process(delta)
	_move(delta)

func _move(delta):
	velocity = move_and_slide(velocity,Vector2.UP)

func gravity_process(delta):
	velocity.y += get_default_gravity()*gravity_scale*delta

# 加速减速流程
func velocity_process(delta):
	# 加速
	if input_vector.x !=0:
		velocity.x = move_toward(velocity.x, input_vector.x*max_speed, accel*delta)
	# 减速
	else:
		velocity.x = move_toward(velocity.x, 0, deccel*delta)

func launch(launch_velocity:Vector2=Vector2.UP*jump_speed, x_override:bool=false, y_override:bool=false):
	if x_override:
		velocity.x = launch_velocity.x
	else:
		velocity.x += launch_velocity.x

	if y_override:
		velocity.y = launch_velocity.y
	else:
		velocity.y += launch_velocity.y


func can_do_jump():
	return jump_count<max_jump_count


extends CharacterBody3D

var run_speed = 12
var walk_speed = 5
var turn_speed = 90
var gravity = 9.8

var ia_moving_h = false
var ia_moving_v = false

var _direction = Vector3()
var _velocity = Vector3()
var _fall = Vector3()

@onready var body = $player_body
@onready var head = $player_body/player_head
@onready var anm = $player_anm
@onready var ftp_sound = $player_body/player_foot/sfx_footstep

func _physics_process(delta):
	_direction = Vector3()
	
	# Movement
	if Input.is_action_pressed("player_walk_front"):
		_direction -= transform.basis.z
		ia_moving_v = true
	elif Input.is_action_pressed("player_walk_back"):
		_direction += transform.basis.z
		ia_moving_v = true
	else:
		ia_moving_v = false
	if Input.is_action_pressed("player_walk_left"):
		_direction -= transform.basis.x
		ia_moving_h = true
	elif Input.is_action_pressed("player_walk_right"):
		_direction += transform.basis.x
		ia_moving_h = true
	else:
		ia_moving_h = false
		
	# Rotation
	if Input.is_action_pressed("player_look_left"):
		rotate_y(deg_to_rad(turn_speed * delta))
	if Input.is_action_pressed("player_look_right"):
		rotate_y(deg_to_rad(-turn_speed * delta))
	
	# Gravity
	$player_colision.disabled = false
	if not is_on_floor():
		_fall.y -= gravity * delta
	else:
		_fall.y = 0
	head.rotation.x = deg_to_rad(0)
	
	#Run
	if Input.is_action_pressed("player_run"):
		walk_speed = run_speed
		anm.playback_speed = 2
	else:
		walk_speed = 5
		anm.speed_scale = 1
	
	# Footsteps
	if ia_moving_v || ia_moving_h:
		anm.play("anm_walking")
	else:
		anm.play("anm_idle")
	
	_direction = _direction.normalized()
	_velocity = _direction * walk_speed
	set_velocity(_velocity)
	set_up_direction(Vector3.UP)
	move_and_slide()
	_velocity = _velocity
	set_velocity(_fall)
	set_up_direction(Vector3.UP)
	set_floor_stop_on_slope_enabled(true)
	move_and_slide()

# Change footstep pitch
func _on_player_audio_finished():
	ftp_sound.pitch_scale = randf_range(.8, 1.2)

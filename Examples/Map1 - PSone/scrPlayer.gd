extends KinematicBody

var run_speed = 12
var walk_speed = 5
var turn_speed = 90
var gravity = 9.8

var ia_moving_h = false
var ia_moving_v = false

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var body = $player_body
onready var head = $player_body/player_head
onready var anm = $player_anm
onready var ftp_sound = $player_body/player_foot/sfx_footstep

func _physics_process(delta):
	direction = Vector3()
	
	# Movement
	if Input.is_action_pressed("player_walk_front"):
		direction -= transform.basis.z
		ia_moving_v = true
	elif Input.is_action_pressed("player_walk_back"):
		direction += transform.basis.z
		ia_moving_v = true
	else:
		ia_moving_v = false
	if Input.is_action_pressed("player_walk_left"):
		direction -= transform.basis.x
		ia_moving_h = true
	elif Input.is_action_pressed("player_walk_right"):
		direction += transform.basis.x
		ia_moving_h = true
	else:
		ia_moving_h = false
		
	# Rotation
	if Input.is_action_pressed("player_look_left"):
		rotate_y(deg2rad(turn_speed * delta))
	if Input.is_action_pressed("player_look_right"):
		rotate_y(deg2rad(-turn_speed * delta))
	
	# Gravity
	$player_colision.disabled = false
	if not is_on_floor():
		fall.y -= gravity * delta
	else:
		fall.y = 0
	head.rotation.x = deg2rad(0)
	
	#Run
	if Input.is_action_pressed("player_run"):
		walk_speed = run_speed
		anm.playback_speed = 2
	else:
		walk_speed = 5
		anm.playback_speed = 1
	
	# Footsteps
	if ia_moving_v || ia_moving_h:
		anm.play("anm_walking")
	else:
		anm.play("anm_idle")
	
	direction = direction.normalized()
	velocity = direction * walk_speed
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP, true)

# Change footstep pitch
func _on_player_audio_finished():
	ftp_sound.pitch_scale = rand_range(.8, 1.2)

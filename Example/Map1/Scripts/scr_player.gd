extends KinematicBody

var turning_amount = 10.0

var run_speed = 12
var walk_speed = 5
var turn_speed = 90
var acceleration = 20
var gravity = 9.8

var is_h_walking = false
var is_v_walking = false

var direction = Vector3()
var velocity = Vector3()
var fall = Vector3()

onready var body = $player_body
onready var head = $player_body/player_head
onready var anm = $player_anm
onready var ftp_sound = $player_body/player_foot/sfx_footstep

func _ready():
	#mouse lock
	if GameManeger.is_mouse_locked:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	direction = Vector3()
	
	#Movment
	#move foward
	if Input.is_action_pressed("player_walk_front"):
		direction -= transform.basis.z
		is_h_walking = true
	#move backward
	elif Input.is_action_pressed("player_walk_back"):
		direction += transform.basis.z
		is_h_walking = true
	else:
		is_h_walking = false
	#move left
	if Input.is_action_pressed("player_walk_left"):
		direction -= transform.basis.x
		is_v_walking = true
	#move right
	elif Input.is_action_pressed("player_walk_right"):
		direction += transform.basis.x
		is_v_walking = true
	else:
		is_v_walking = false
		
		#rotate left
		if Input.is_action_pressed("player_look_left"):
			rotate_y(deg2rad(turn_speed * delta))
		#rotate right
		if Input.is_action_pressed("player_look_right"):
			rotate_y(deg2rad(-turn_speed * delta))
	
		#gravity
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
	
	#Footstep
	if is_h_walking == true || is_v_walking == true:
		anm.play("anm_walking")
	else:
		anm.play("anm_idle")
	
	direction = direction.normalized()
	velocity = velocity.linear_interpolate(direction * walk_speed, acceleration * delta)
	velocity = move_and_slide(velocity, Vector3.UP)
	move_and_slide(fall, Vector3.UP, true)

#change footstep pitch
func _on_player_audio_finished():
	ftp_sound.pitch_scale = rand_range(.8, 1.2)

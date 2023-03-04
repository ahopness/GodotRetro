extends CharacterBody2D

const WALK_SPEED = 90
var _velocity = Vector2()

# Movement
func _physics_process(delta):
	if Input.is_action_pressed("player_look_left"):
		_velocity.x = -WALK_SPEED
		
		$sprPlayer.flip_h = false
		$sprPlayer.play("walk")
	elif Input.is_action_pressed("player_look_right"):
		_velocity.x =  WALK_SPEED
		
		$sprPlayer.flip_h = true
		$sprPlayer.play("walk")
	else:
		_velocity.x = 0
		
		$sprPlayer.play("idle")
	
	set_velocity(_velocity)
	set_up_direction(Vector2(0, -1))
	move_and_slide()

extends KinematicBody2D

const WALK_SPEED = 90
var velocity = Vector2()

# Movement
func _physics_process(delta):
	if Input.is_action_pressed("player_look_left"):
		velocity.x = -WALK_SPEED
		
		$sprPlayer.flip_h = false
		$sprPlayer.play("walk")
	elif Input.is_action_pressed("player_look_right"):
		velocity.x =  WALK_SPEED
		
		$sprPlayer.flip_h = true
		$sprPlayer.play("walk")
	else:
		velocity.x = 0
		
		$sprPlayer.play("idle")
	
	move_and_slide(velocity, Vector2(0, -1))

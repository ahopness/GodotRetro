extends KinematicBody2D

const WALK_SPEED = 90

var velocity = Vector2()

func _physics_process(delta):
	#velocity.y += delta * GRAVITY

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

	# We don't need to multiply velocity by delta because "move_and_slide" already takes delta time into account.

	# The second parameter of "move_and_slide" is the normal pointing up.
	# In the case of a 2D platformer, in Godot, upward is negative y, which translates to -1 as a normal.
	move_and_slide(velocity, Vector2(0, -1))

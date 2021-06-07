extends Node

func _process(delta):
	#Exit
	if Input.is_action_just_pressed("player_exit"):
		get_tree().quit()

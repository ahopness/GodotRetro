extends Node

# Exit
func _process(delta):
	if Input.is_action_just_pressed("player_exit"):
		get_tree().quit()

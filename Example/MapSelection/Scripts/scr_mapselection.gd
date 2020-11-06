extends Control

func _on_btn_debug_pressed():
	get_tree().change_scene("res://Example/Map1/Scenes/scn_map1.tscn")


func _on_btn_streets_pressed():
	get_tree().change_scene("res://Example/Map2/Scenes/scn_map2.tscn")

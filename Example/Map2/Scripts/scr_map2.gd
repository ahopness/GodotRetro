extends Spatial

var layer_1_active = true
var layer_2_active = true

onready var layer_1 = $CanvasLayer/ImageEffect/BackBufferCopy
onready var layer_2 = $CanvasLayer/ImageEffect/BackBufferCopy2

func _process(delta):
	if Input.is_action_just_pressed("player_switch_1"):
		layer_1_active =! layer_1_active
	if Input.is_action_just_pressed("player_switch_2"):
		layer_2_active =! layer_2_active
	
	layer_1.visible = layer_1_active
	layer_2.visible = layer_2_active

extends Node

onready var shaders_layer_1 = [
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS B&W",
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS ColorPrecision",
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS Grain",
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS SGrain",
	$"CanvasLayer/VHS/Shader/SSS Layer 3/SSS LD",
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS BCC",
	$"CanvasLayer/VHS/Shader/SSS Layer 1/SSS Sharpness"
]
onready var shaders_layer_2 = [
	$"CanvasLayer/VHS/Shader/SSS Layer 2/SSS TV",
	$"CanvasLayer/VHS/Shader/SSS Layer 2/SSS VHS",
	$"CanvasLayer/VHS/Shader/SSS Layer 2/SSS VHSGlitch",
	$"CanvasLayer/VHS/Shader/SSS Layer 2/SSS VHSPause",
	$"CanvasLayer/VHS/Shader/SSS Layer 2/SSS VHSSimpleGlitch"
]

onready var shader_currect_text_1 = $CanvasLayer/UI/layer_1
onready var shader_currect_text_2 = $CanvasLayer/UI/layer_2

onready var state_indcator = $CanvasLayer/UI/State;

var shader_selected_1 = 0;
var shader_selected_2 = 0;

func _process(delta):
	if Input.is_action_just_pressed("player_switch_1"):
		shader_selected_1 += 1
	if Input.is_action_just_pressed("player_switch_2"):
		shader_selected_2 += 1
	
	if shader_selected_1 >= 8:
		shader_selected_1 = 0
	if shader_selected_2 >= 6:
		shader_selected_2 = 0
	
	match shader_selected_1:
		0:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : disabled"
		1:
			shaders_layer_1[0].visible = true
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : B&W"
		2:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = true
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : ColorPrecision"
		3:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = true
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : Grain"
		4:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = true
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : Simple Grain"
		5:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = true
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : Lens Distortion"
		6:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = true
			shaders_layer_1[6].visible = false
			shader_currect_text_1.text = "SSS Layer 1 : Better CC"
		7:
			shaders_layer_1[0].visible = false
			shaders_layer_1[1].visible = false
			shaders_layer_1[2].visible = false
			shaders_layer_1[3].visible = false
			shaders_layer_1[4].visible = false
			shaders_layer_1[5].visible = false
			shaders_layer_1[6].visible = true
			shader_currect_text_1.text = "SSS Layer 1 : Sharpness"
	match shader_selected_2:
		0:
			shaders_layer_2[0].visible = false
			shaders_layer_2[1].visible = false
			shaders_layer_2[2].visible = false
			shaders_layer_2[3].visible = false
			shaders_layer_2[4].visible = false
			shader_currect_text_2.text = "SSS Layer 2 : disabled"
		1:
			shaders_layer_2[0].visible = true
			shaders_layer_2[1].visible = false
			shaders_layer_2[2].visible = false
			shaders_layer_2[3].visible = false
			shaders_layer_2[4].visible = false
			shader_currect_text_2.text = "SSS Layer 2 : TV"
		2:
			shaders_layer_2[0].visible = false
			shaders_layer_2[1].visible = true
			shaders_layer_2[2].visible = false
			shaders_layer_2[3].visible = false
			shaders_layer_2[4].visible = false
			shader_currect_text_2.text = "SSS Layer 2 : VHS"
		3:
			shaders_layer_2[0].visible = false
			shaders_layer_2[1].visible = false
			shaders_layer_2[2].visible = true
			shaders_layer_2[3].visible = false
			shaders_layer_2[4].visible = false
			shader_currect_text_2.text = "SSS Layer 2 : VHSGlitch"
		4:
			shaders_layer_2[0].visible = false
			shaders_layer_2[1].visible = false
			shaders_layer_2[2].visible = false
			shaders_layer_2[3].visible = true
			shaders_layer_2[4].visible = false
			shader_currect_text_2.text = "SSS Layer 2 : VHSPause"
		5:
			shaders_layer_2[0].visible = false
			shaders_layer_2[1].visible = false
			shaders_layer_2[2].visible = false
			shaders_layer_2[3].visible = false
			shaders_layer_2[4].visible = true
			shader_currect_text_2.text = "SSS Layer 2 : VHSSimpleGlitch"
	
	if shader_selected_2 == 4:
		state_indcator.text = "llPause"
	else:
		state_indcator.text = ">Play"

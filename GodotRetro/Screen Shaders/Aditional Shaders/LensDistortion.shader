//CRT SHADER ORIGINALY CREADED BY "hiulit" FROM GITHUB 
//MODIFYED TO LENS DISTORTION SHADER BY AHOPNESS (@ahopness)
//
//GITHUB LINK : https://github.com/hiulit/Godot-3-2D-CRT-Shader

shader_type canvas_item;

uniform bool show_curvature = true;
uniform float curvature_x_amount : hint_range(2.5, 15.0, 0.01) = float(6.0); 
uniform float curvature_y_amount : hint_range(2.5, 15.0, 0.01) = float(4.0);

vec2 uv_curve(vec2 uv) {
	if (show_curvature) {
		uv = uv * 2.0 - 1.0;
		vec2 offset = abs(uv.yx) / vec2(curvature_x_amount, curvature_y_amount);
		uv = uv + uv * offset * offset;
		uv = uv * 0.5 + 0.5;
	}

	return uv;
}

void fragment() {
	vec2 screen_uv = uv_curve(SCREEN_UV);
	vec3 color = texture(SCREEN_TEXTURE, screen_uv).rgb;
	
	COLOR = vec4(color, 1.0);
}
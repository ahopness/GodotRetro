//SHADER ORIGINALY CREADED BY "keijiro" FROM GITHUB
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : https://github.com/keijiro/KinoGlitch#license
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//GITHUB LINK : https://github.com/keijiro/KinoGlitch

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float _ScanLineJitter : hint_range(.2, 1) = .25; // (displacement, threshold)
uniform float _VerticalJump : hint_range(0, 1) = .01;   // (amount, time)
uniform float _HorizontalShake : hint_range(0, 1) = 0;
uniform float _ColorDrift : hint_range(0, 1) = .02;     // (amount, time)


float nrand(float x, float y){
	 return fract(sin(dot(vec2(x, y), vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment(){
	float sl_thresh = dot(vec2(1.0 - _ScanLineJitter * 1.2), vec2(1.0 - _ScanLineJitter * 1.2));
	float sl_disp = 0.002 + pow(_ScanLineJitter, 3) * 0.05;
	vec2 sl = vec2(sl_disp, sl_thresh);
	
	float _verticalJumpTime = TIME * _VerticalJump * 11.3;
	vec2 vj = vec2(_VerticalJump, _verticalJumpTime);
	
	float hs = _HorizontalShake * 0.2;
	
	vec2 cd = vec2(_ColorDrift * 0.04f, TIME * 606.11f);
	
	float u = FRAGCOORD.x / (1.0 / SCREEN_PIXEL_SIZE).x;
	float v = FRAGCOORD.y / (1.0 / SCREEN_PIXEL_SIZE).y;
	
	 // Scan line jitter
	float jitter = nrand(v, TIME) * 2.0 - 1.0;
	jitter *= step(sl.y, abs(jitter)) * sl.x;
	
	 // Vertical jump
	float jump = mix(v, fract(v + vj.y), vj.x);
	
	// Horizontal shake
	float shake = (nrand(TIME, 2) - 0.5) * hs;
	
	// Color drift
	float drift = sin(jump + cd.y) * cd.x;
	
	vec4 final1 = texture(SCREEN_TEXTURE, fract(vec2(u + jitter + shake, jump)));
	vec4 final2 = texture(SCREEN_TEXTURE, fract(vec2(u + jitter + shake + drift, jump)));
	
	vec4 render = vec4(final1.r, final2.g, final1.b, 1);
	
	COLOR = render;
}
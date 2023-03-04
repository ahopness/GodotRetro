//SHADER ORIGINALY CREADED BY "jcant0n" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/XssSDs#

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float amount :hint_range(0.0, 1.5) = 1.0;

vec2 Circle(float Start, float Points, float Point) {
	float Rad = (3.141592 * 3.0 * (1.0 / Points)) * (Point + Start);
	return vec2(sin(Rad), cos(Rad));
}

void fragment(){
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	vec2 PixelOffset = amount / (1.0 / SCREEN_PIXEL_SIZE).xy;
	
	float Start = 2.0 / 14.0;
	vec2 Scale = 0.66 * 4.0 * 2.0 * PixelOffset.xy;
	
	vec3 N0 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 0.0) * Scale).rgb;
	vec3 N1 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 1.0) * Scale).rgb;
	vec3 N2 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 2.0) * Scale).rgb;
	vec3 N3 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 3.0) * Scale).rgb;
	vec3 N4 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 4.0) * Scale).rgb;
	vec3 N5 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 5.0) * Scale).rgb;
	vec3 N6 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 6.0) * Scale).rgb;
	vec3 N7 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 7.0) * Scale).rgb;
	vec3 N8 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 8.0) * Scale).rgb;
	vec3 N9 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 9.0) * Scale).rgb;
	vec3 N10 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 10.0) * Scale).rgb;
	vec3 N11 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 11.0) * Scale).rgb;
	vec3 N12 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 12.0) * Scale).rgb;
	vec3 N13 = texture(SCREEN_TEXTURE, uv + Circle(Start, 14.0, 13.0) * Scale).rgb;
	vec3 N14 = texture(SCREEN_TEXTURE, uv).rgb;
	
	float W = 1.0 / 15.0;
	
	vec3 color = vec3(0,0,0);
	
	color.rgb = 
		(N0 * W) +
		(N1 * W) +
		(N2 * W) +
		(N3 * W) +
		(N4 * W) +
		(N5 * W) +
		(N6 * W) +
		(N7 * W) +
		(N8 * W) +
		(N9 * W) +
		(N10 * W) +
		(N11 * W) +
		(N12 * W) +
		(N13 * W) +
		(N14 * W);
	
	COLOR = vec4(color.rgb,1.0);
}


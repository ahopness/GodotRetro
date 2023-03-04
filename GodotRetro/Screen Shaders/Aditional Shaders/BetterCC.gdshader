//SHADER ORIGINALY CREADED BY "Wunkolo" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/tllfRf

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform vec4 Shadows :source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform vec4 Midtones :source_color = vec4(0.0, 0.0, 0.0, 1.0); 
uniform vec4 Hilights :source_color = vec4(0.0, 0.0, 0.0, 1.0);

vec3 InvLerp( vec3 A, vec3 B, vec3 t){
	return (t - A) / (B - A);
}

vec3 ColorGrade( in vec3 InColor ){
	// Calculate the three offseted colors up-front
	vec3 OffShadows  = InColor + Shadows.xyz;
	vec3 OffMidtones = InColor + Midtones.xyz;
	vec3 OffHilights = InColor + Hilights.xyz;
	
	// Linearly interpolate between the 3 new colors, piece-wise
	return mix(
		// We pick which of the two control points to interpolate from based on which side of
		// 0.5 the input color channel lands on
		mix(OffShadows,  OffMidtones, InvLerp(vec3(0.0), vec3(0.5), InColor)), // <  0.5
		mix(OffMidtones, OffHilights, InvLerp(vec3(0.5), vec3(1.0), InColor)), // >= 0.5
		greaterThanEqual(InColor, vec3(0.5))
	);
}

void fragment(){
	vec2 uv = FRAGCOORD.xy / vec2(1.0 / SCREEN_PIXEL_SIZE.xy);
	COLOR.a = 1.0;
	COLOR.rgb = texture(SCREEN_TEXTURE, uv).rgb;
	COLOR.rgb = ColorGrade(COLOR.rgb);
	
	//COLOR.rgb = pow(COLOR.rgb, vec3(2.2));
}
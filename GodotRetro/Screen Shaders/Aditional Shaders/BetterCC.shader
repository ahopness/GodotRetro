//SHADER ORIGINALY CREADED BY "Wunkolo" FROM SHADERTOY
//PORTED AND MODIFYED  TO GODOT BY AHOPNESS (@ahopness)
//
//SHADERTOY LINK : https://www.shadertoy.com/view/tllfRf

shader_type canvas_item;

uniform vec3 Shadows = vec3(0.0, 0.0, 0.0); // Remove some red from the shadows(make it more cyan)
uniform vec3 Midtones = vec3(0.0, 0.0, 0.0); // Add a bit of blue-green to the midtones
uniform vec3 Hilights = vec3(0.5, 0.0, 0.0); // Add some red to the hilights

vec3 InvLerp( vec3 A, vec3 B, vec3 t){
	return (t - A) / (B - A);
}

vec3 ColorGrade( in vec3 InColor ){
	// Calculate the three offseted colors up-front
	vec3 OffShadows  = InColor + Shadows;
	vec3 OffMidtones = InColor + Midtones;
	vec3 OffHilights = InColor + Hilights;
	
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
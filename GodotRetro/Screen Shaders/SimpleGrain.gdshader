//SHADER ORIGINALY CREADED BY "juniorxsound" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/ldScWw

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float amount :hint_range(0.0, 0.4) = 0.1;

float grain (vec2 st, float time){
	return fract(sin(dot(st.xy, vec2(17.0,180.)))* 2500. + time);
}

void fragment(){
	//Coords
	vec2 uv =  FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	
	//Produce some noise based on the coords
	vec3 grainPlate = vec3(grain(uv, TIME));
	
	//Get the image
	vec4 img = texture(SCREEN_TEXTURE, uv);
	
	//Mix the two signals together
	vec3 mixer = mix(img.rgb, grainPlate, amount);
	
	
	COLOR = vec4(mixer,1.0); 
}
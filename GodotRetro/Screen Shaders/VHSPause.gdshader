//SHADER ORIGINALY CREADED BY "caaaaaaarter" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3
//SHADERTOY LINK : https://www.shadertoy.com/view/4lB3Dc

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float shake_amount_x  : hint_range(1, 500) = 250.0;
uniform float shake_amount_y  : hint_range(1, 500) = 40.0;
uniform float white_hlines : hint_range(0, 50) = 50;
uniform float white_vlines : hint_range(0,80) = 80;

float rand(vec2 co){
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

void fragment(){
	vec4 texColor = vec4(0);
	// get position to sample
	vec2 samplePosition =  FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	
	float whiteNoise = 9999.0;
	
	// Jitter each line left and right
	samplePosition.x = samplePosition.x+(rand(vec2(TIME,UV.y))-0.5)/shake_amount_x;
	// Jitter the whole picture up and down
	samplePosition.y = samplePosition.y+(rand(vec2(TIME))-0.5)/shake_amount_y;
	// Slightly add color noise to each line
	texColor = texColor + (vec4(-0.5)+vec4(rand(vec2(UV.y,TIME)),rand(vec2(UV.y,TIME+1.0)),rand(vec2(UV.y,TIME+2.0)),0))*0.1;
	
	// Either sample the texture, or just make the pixel white (to get the staticy-bit at the bottom)
	whiteNoise = rand(vec2(floor(samplePosition.y*white_vlines),floor(samplePosition.x*white_hlines))+vec2(TIME,0));
	if (whiteNoise > 11.5-30.0*samplePosition.y || whiteNoise < 1.5-5.0*samplePosition.y) {
		// Sample the texture.
		//samplePosition.y = 1.0-samplePosition.y; //Fix for upside-down texture
		texColor = texColor + texture(SCREEN_TEXTURE,samplePosition);
	}else{
		// Use white. (I'm adding here so the color noise still applies)
		texColor = vec4(1);
	}
	COLOR = texColor;
}
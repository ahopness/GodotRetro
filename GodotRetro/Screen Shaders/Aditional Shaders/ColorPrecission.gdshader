//SHADER ORIGINALY CREADED BY "abelcamarena" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/tsKGDm

// Looking for ditheirng? I reccomend using this shader instead : 
// https://github.com/WittyCognomen/godot-psx-shaders/blob/master/shaders/psx_dither_post.shader
// https://github.com/WittyCognomen/godot-psx-shaders/tree/master/shaders/dithers

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float SCREEN_WIDTH = 320.; // Lower num - bigger pixels (this will be the screen width)
uniform float COLOR_FACTOR :hint_range(0., 10.) = 4.;   // Higher num - higher colors quality

void fragment(){                  
	// Reduce pixels            
	vec2 size = SCREEN_WIDTH * SCREEN_PIXEL_SIZE.xy/SCREEN_PIXEL_SIZE.x;
	vec2 coor = floor( UV * size) ;
	vec2 uv =  FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	
	// Get source color
	vec3 col = texture(SCREEN_TEXTURE, uv).xyz;     
	
	// Reduce colors    
	col = floor(col * COLOR_FACTOR) / COLOR_FACTOR;    
	
	// Output to screen
	COLOR = vec4(col,1.);
}
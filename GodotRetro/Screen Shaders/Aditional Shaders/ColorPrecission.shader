//SHADER ORIGINALY CREADED BY "abelcamarena" FROM SHADERTOY
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//
//SHADERTOY LINK : https://www.shadertoy.com/view/tsKGDm

shader_type canvas_item;

uniform float SCREEN_WIDTH = 320.; // Lower num - bigger pixels (this will be the screen width)
uniform float COLOR_FACTOR :hint_range(0., 10.) = 4.;   // Higher num - higher colors quality
//uniform float DITHERING_STRENTH :hint_range(0., .07) = 0.005; // Be carefull with this one, dithering can get messy really easily

//const mat4 ditherTable = mat4(
//	vec4(-4.0, 0.0, -3.0, 1.0),
//	vec4(2.0, -2.0, 3.0, -1.0),
//	vec4(-3.0, 1.0, -4.0, 0.0),
//	vec4(3.0, -1.0, 2.0, -2.0)
//);

void fragment(){                  
	// Reduce pixels            
	vec2 size = SCREEN_WIDTH * SCREEN_PIXEL_SIZE.xy/SCREEN_PIXEL_SIZE.x;
	vec2 coor = floor( UV * size) ;
	vec2 uv = coor / size;   
	uv.y = (uv.y - 1.0) * -1.0;
	
	// Get source color
	vec3 col = texture(SCREEN_TEXTURE, uv).xyz;     
	
	// Dithering - CURRECTLY NOT WORKING IN 3.2.3
	//int row = int( coor.x ) % 4;
	//int column = int( coor.y ) % 4;
	//col += ditherTable[row][column] * DITHERING_STRENTH;
	
	// Reduce colors    
	col = floor(col * COLOR_FACTOR) / COLOR_FACTOR;    
	
	// Output to screen
	COLOR = vec4(col,1.);
}
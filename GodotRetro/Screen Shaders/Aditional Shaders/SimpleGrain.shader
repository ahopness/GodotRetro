//SHADER ORIGINALY CREADED BY "juniorxsound" FROM SHADERTOY
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//
//SHADERTOY LINK : https://www.shadertoy.com/view/ldScWw

shader_type canvas_item;

varying float time;

void vertex(){
	time = TIME;
}

float grain (vec2 st){
	return fract(sin(dot(st.xy, vec2(17.0,180.)))* 2500. + time);
}

void fragment(){
	//Coords
	vec2 uv = UV;
	uv.y = (uv.y - 1.0) * -1.0;
	
	//Produce some noise based on the coords
	vec3 grainPlate = vec3(grain(uv));
	
	//Get the image
	vec4 img = texture(SCREEN_TEXTURE, uv);
	
	//Mix the two signals together
	vec3 mixer = mix(img.rgb, grainPlate, .1);
	
	
	COLOR = vec4(mixer,1.0); 
}
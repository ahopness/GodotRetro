//SHADER ORIGINALY CREADED BY "demofox" FROM SHADERTOY
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//
//SHADERTOY LINK : https://www.shadertoy.com/view/XdXSzX

shader_type canvas_item;

void fragment(){
	vec2 percent = UV;
	percent.y = 1.0 - percent.y;
	
	vec3 pixelColor = texture(SCREEN_TEXTURE, percent).xyz;
	
	float mode = 3.0;
	if (mode > 3.0){
		// sRGB monitors grey scale coefficients
		float pixelGrey = dot(pixelColor, vec3(0.2126, 0.7152, 0.0722));
		pixelColor = vec3(pixelGrey);
	}else if (mode > 2.0){
		// SD television grey scale coefficients
		float pixelGrey = dot(pixelColor, vec3(0.3, 0.59, 0.11));
		pixelColor = vec3(pixelGrey);
	}else if (mode > 1.0){
		// naive grey scale conversion - average R,G and B
		float pixelGrey = dot(pixelColor, vec3(1.0/3.0));
		pixelColor = vec3(pixelGrey);
	}else{
		// color
	}
	
	COLOR = vec4(pixelColor, 1.0);	
}
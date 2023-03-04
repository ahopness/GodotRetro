//SHADER ORIGINALY CREADED BY "paniq" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/MdcGzj

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float color_depth :hint_range(0.0, 255.0) = 100.0;
uniform float color_number :hint_range(0.0, 50.0) = 20.0;

const mat3 rgb2ycbcr = mat3(
    vec3(0.299, -0.168736, 0.5), 
    vec3(0.587, -0.331264, -0.418688),   
    vec3(0.114, 0.5, -0.081312)
);
const mat3 ycbcr2rgb = mat3(
    vec3(1.0, 1.0, 1.0),
    vec3(0.0, -0.344136, 1.772), 
    vec3(1.402, -0.714136, 0.0)
);

// simulating 8:4:4 compression ratio (16bit)
vec3 compress_ycbcr_844 (vec3 rgb) {
	vec3 ycbcr = rgb2ycbcr * rgb;
	ycbcr.r = floor(ycbcr.r * color_depth + 0.5) / color_depth;
	ycbcr.gb += 0.5;
	ycbcr.gb = floor(ycbcr.gb * color_number + 0.5) / color_number;
	ycbcr.gb -= 0.5;    
	return ycbcr2rgb * ycbcr;
}


void fragment(){
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	vec3 rgb = texture(SCREEN_TEXTURE, uv).rgb;
	rgb = compress_ycbcr_844(rgb);
	
	COLOR = vec4(rgb,1.0);
}
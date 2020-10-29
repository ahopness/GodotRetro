//SHADER ORIGINALY CREADED BY "Gaktan" FROM SHADERTOY
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//
//SHADERTOY LINK : https://www.shadertoy.com/view/Ms3XWH#

shader_type canvas_item;

uniform float range = 0.03;
uniform float noiseQuality = 250.0;
uniform float noiseIntensity = 0.007;
uniform float offsetIntensity = 0.01;
uniform float colorOffsetIntensity = 0.9;

float rand(vec2 co){
	return fract(sin(dot(co.xy ,vec2(12.9898,78.233))) * 43758.5453);
}

float verticalBar(float pos, float uvY, float offset){
	float edge0 = (pos - range);
	float edge1 = (pos + range);
	
	float x = smoothstep(edge0, pos, uvY) * offset;
	x -= smoothstep(pos, edge1, uvY) * offset;
	return x;
}

void fragment(){
	vec2 uv = UV.xy;
	uv.y = (uv.y - 1.0) * -1.0;
	
	for (float i = 0.0; i < 0.71; i += 0.1313){
		float d = mod(TIME - tan(TIME * 0.24 * i), 0);
		float o = sin(1.0 - tan(TIME * 0.24 * i));
		o *= offsetIntensity;
		uv.x += verticalBar(d, uv.y, o);
	}
	
	float uvY = uv.y;
	uvY *= noiseQuality;
	uvY = float(int(uvY)) * (1.0 / noiseQuality);
	float noise = rand(vec2(TIME * 0.00001, uvY));
	uv.x += noise * noiseIntensity;
	
	vec2 offsetR = vec2(0.006 * sin(TIME), 0.0) * colorOffsetIntensity;
	vec2 offsetG = vec2(0.0073 * (cos(TIME * 0.97)), 0.0) * colorOffsetIntensity;
	
	float r = texture(SCREEN_TEXTURE, uv + offsetR).r;
	float g = texture(SCREEN_TEXTURE, uv + offsetG).g;
	float b = texture(SCREEN_TEXTURE, uv).b;
	
	vec4 tex = vec4(r, g, b, 1.0);
	COLOR = tex;
}
//SHADER ORIGINALY CREADED BY "ompuco" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3, WEBGL
//SHADERTOY LINK : https://www.shadertoy.com/view/XlsczN

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float blur_amount :hint_range(0.0, 8.0) = 3.0;
uniform float signal_quality :hint_range(0.0, 0.5) = 0; 
uniform float bottom_strenth :hint_range(0.0, 6.0) = 3.0;
uniform sampler2D grain_tex; 

float grain (vec2 st, float iTime) {
    return fract(sin(dot(st.xy, vec2(17.0,180.)))* 2500. + iTime);
}

vec3 rgb2yiq(vec3 c){   
	return vec3(
		(0.2989 * c.x + 0.5959 * c.y + 0.2115 * c.z),
		(0.5870 * c.x - 0.2744 * c.y - 0.5229 * c.z),
		(0.1140 * c.x - 0.3216 * c.y + 0.3114 * c.z)
		);
}
vec3 yiq2rgb(vec3 c){
	return vec3(
		(1.0 * c.x + 1.0 * c.y + 1.0 * c.z),
		(0.956 * c.x - 0.2720 * c.y - 1.1060 * c.z),
		(0.6210 * c.x - 0.6474 * c.y + 1.7046 * c.z)
		);
}
        
vec2 Circle(float Start, float Points, float Point){
	float Rad = (3.141592 * 2.0 * (1.0 / Points)) * (Point + Start);
	return vec2(-(.3+Rad), cos(Rad));
}

vec3 Blur(vec2 uv, float f, float d, float iTime, sampler2D iChannel0){
	float t = (sin(iTime * 5.0 + uv.y * 5.0)) / 10.0;
	float b = 1.0;
	
	t = 0.0;
	vec2 PixelOffset = vec2(d + .0005 * t, 0);
	
	float Start = 2.0 / 14.0;
	vec2 Scale = 0.66 * blur_amount * 2.0 * PixelOffset.xy;
	
	vec3 N0 = texture(iChannel0, uv + Circle(Start, 14.0, 0.0) * Scale).rgb;
	vec3 N1 = texture(iChannel0, uv + Circle(Start, 14.0, 1.0) * Scale).rgb;
	vec3 N2 = texture(iChannel0, uv + Circle(Start, 14.0, 2.0) * Scale).rgb;
	vec3 N3 = texture(iChannel0, uv + Circle(Start, 14.0, 3.0) * Scale).rgb;
	vec3 N4 = texture(iChannel0, uv + Circle(Start, 14.0, 4.0) * Scale).rgb;
	vec3 N5 = texture(iChannel0, uv + Circle(Start, 14.0, 5.0) * Scale).rgb;
	vec3 N6 = texture(iChannel0, uv + Circle(Start, 14.0, 6.0) * Scale).rgb;
	vec3 N7 = texture(iChannel0, uv + Circle(Start, 14.0, 7.0) * Scale).rgb;
	vec3 N8 = texture(iChannel0, uv + Circle(Start, 14.0, 8.0) * Scale).rgb;
	vec3 N9 = texture(iChannel0, uv + Circle(Start, 14.0, 9.0) * Scale).rgb;
	vec3 N10 = texture(iChannel0, uv + Circle(Start, 14.0, 10.0) * Scale).rgb;
	vec3 N11 = texture(iChannel0, uv + Circle(Start, 14.0, 11.0) * Scale).rgb;
	vec3 N12 = texture(iChannel0, uv + Circle(Start, 14.0, 12.0) * Scale).rgb;
	vec3 N13 = texture(iChannel0, uv + Circle(Start, 14.0, 13.0) * Scale).rgb;
	vec3 N14 = texture(iChannel0, uv).rgb;
	
	vec4 clr = texture(iChannel0, uv);
	float W = 1.0 / 15.0;
	
	clr.rgb= 
		(N0 * W) +
		(N1 * W) +
		(N2 * W) +
		(N3 * W) +
		(N4 * W) +
		(N5 * W) +
		(N6 * W) +
		(N7 * W) +
		(N8 * W) +
		(N9 * W) +
		(N10 * W) +
		(N11 * W) +
		(N12 * W) +
		(N13 * W) +
		(N14 * W);
	
	return  vec3(clr.xyz)*b;
}
        
void fragment(){
	float d = 0.1 * 1.0 / 50.0;
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	
	float s = signal_quality * grain(vec2(uv.x, uv.y * 777777777777777.0), TIME); // Sorry... 
	// Main tearing
	float e = min(0.30, pow(max(0.0, cos(uv.y * 4.0 + 0.3) - 0.75) * (s + 0.5) * 1.0, 3.0)) * 25.0;
	s -= pow(texture(SCREEN_TEXTURE, vec2(0.01 + (uv.y * 32.0) / 32.0, 1.0)).r, 1.0);
	uv.x += e * abs(s * 3.0);
	// Bootom tearing
	float r = texture(grain_tex, vec2(mod(TIME * 10.0, mod(TIME * 10.0, 256.0) * (1.0 / 256.0)), 0.0)).r * (2.0 * s);
	uv.x += abs(r * pow(min(0.003, (uv.y - 0.15)) * bottom_strenth, 2.0));
	
	// Apply blur
	d = 0.051 + abs(sin(s / 4.0));
	float c = max(0.0001, 0.002 * d);
	
	COLOR.xyz = Blur(uv, 0.0, c + c * (uv.x), TIME, SCREEN_TEXTURE);
	float y = rgb2yiq(COLOR.xyz).r;
	
	uv.x += 0.01 * d;
	c *= 6.0;
	COLOR.xyz = Blur(uv, 0.333 ,c, TIME, SCREEN_TEXTURE);
	float i = rgb2yiq(COLOR.xyz).g;
	
	uv.x += 0.005 * d;
	
	c *= 2.50;
	COLOR.xyz = Blur(uv, 0.666, c, TIME, SCREEN_TEXTURE);
	float q = rgb2yiq(COLOR.xyz).b;
	
	COLOR.xyz = yiq2rgb(vec3(y, i, q)) - pow(s + e * 2.0, 3.0);
	COLOR.xyz *= smoothstep(1.0, 0.999, uv.x - .1);
}
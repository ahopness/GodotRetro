//SHADER ORIGINALY CREADED BY "keijiro" FROM GITHUB
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : MIT
//COMATIBLE WITH : GLES2, GLES3
//GITHUB LINK : https://github.com/keijiro/KinoTube/

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float _bleeding :hint_range(0, 1) = 0.5;
uniform float _fringing :hint_range(0, 1) = 0.5;
uniform float _scanline :hint_range(0, 1) = 0.5;
uniform bool linearColorSpace = true;

vec3 LinearToGammaSpace (vec3 linRGB){
	linRGB = max(linRGB, vec3(0, 0, 0));
	return max(1.055 * pow(linRGB, vec3(0.416666667)) - 0.055, 0);
}
vec3 GammaToLinearSpace (vec3 sRGB){
	return sRGB * (sRGB * (sRGB * 0.305306011 + 0.682171111) + 0.012522878);
}

vec3 RGB2YIQ(vec3 rgb){
	rgb = clamp(rgb, 0, 1);
	if (!linearColorSpace){
		rgb = LinearToGammaSpace(rgb);
	}
	return mat3(vec3(0.299,  0.587,  0.114),
				vec3(0.596, -0.274, -0.322),
				vec3(0.211, -0.523,  0.313)) * rgb;
}
vec3 YIQ2RGB(vec3 yiq){
	vec3 rgb = mat3(vec3(1,  0.956,  0.621),
				    vec3(1, -0.272, -0.647),
				    vec3(1, -1.106,  1.703)) * yiq;
	
	rgb = clamp(rgb, 0, 1);
	if (!linearColorSpace){
		rgb = GammaToLinearSpace(rgb);
	}
	
	return rgb;
}

vec3 SampleYIQ(vec2 uv, float du, sampler2D _MainTex){
	uv.x += du;
	return RGB2YIQ(texture(_MainTex, uv).rgb);
}

void fragment(){
	float bleedWidth = 0.04 * _bleeding;  // width of bleeding
	float bleedStep = 2.5 / (1.0 / SCREEN_PIXEL_SIZE).x; // max interval of taps
	float bleedTaps = ceil(bleedWidth / bleedStep);
	float bleedDelta = bleedWidth / bleedTaps;
	float fringeWidth = 0.0025 * _fringing; // width of fringing
	
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	vec3 yiq = SampleYIQ(uv, 0, SCREEN_TEXTURE);
	
        // Bleeding
        for (float i = 0.0; i < bleedTaps; i++)
        {
            yiq.y += SampleYIQ(uv, - bleedTaps * i, SCREEN_TEXTURE).y;
            yiq.z += SampleYIQ(uv, + bleedTaps * i, SCREEN_TEXTURE).z;
        }
        yiq.yz /= bleedTaps + 1.0;

        // Fringing
        float y1 = SampleYIQ(uv, - fringeWidth, SCREEN_TEXTURE).x;
        float y2 = SampleYIQ(uv, + fringeWidth, SCREEN_TEXTURE).x;
        yiq.yz += y2 - y1;

        // Scanline
        float scan = sin(uv.y * 500.0 * PI);
        scan = mix(1.0, (scan + 1.0) / 2.0, _scanline);

        COLOR =  vec4(YIQ2RGB(yiq * scan), 1);
}
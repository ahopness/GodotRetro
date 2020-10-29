//SHADER ORIGINALY CREADED BY "marmitoTH" FROM GITHUB
//
//GITHUB LINK : https://github.com/marmitoTH/godot-psx-shaders

shader_type spatial; 
render_mode skip_vertex_transform, diffuse_lambert_wrap, specular_phong, ambient_light_disabled;

uniform vec4 color : hint_color;
uniform sampler2D albedoTex : hint_albedo;
uniform samplerCube cubemap;
uniform float reflection_intensity : hint_range(0, 1);
uniform float specular_intensity : hint_range(0, 1);
uniform float resolution = 256;
uniform float cull_distance = 5;
uniform float affine_texture_mapping_amount : hint_range(0,2);
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(.0, .0);

varying vec4 vertex_coordinates;
varying vec3 reflection_coordinates;

void vertex() {
	UV = UV * uv_scale + uv_offset;
	
	float vertex_distance = length((MODELVIEW_MATRIX * vec4(VERTEX, 1.0)));
	
	VERTEX = (MODELVIEW_MATRIX * vec4(VERTEX, 1.0)).xyz;
	float vPos_w = (PROJECTION_MATRIX * vec4(VERTEX, 1.0)).w;
	VERTEX.xy = vPos_w * floor(resolution * VERTEX.xy / vPos_w) / resolution;
	vertex_coordinates = vec4(UV * VERTEX.z, VERTEX.z, .0);
	
	if (vertex_distance > cull_distance)
		VERTEX = vec3(.0);
	
	// Get camera position
	vec4 invcamx = INV_CAMERA_MATRIX[0];
	vec4 invcamy = INV_CAMERA_MATRIX[1];
	vec4 invcamz = INV_CAMERA_MATRIX[2];
	vec4 invcamw = INV_CAMERA_MATRIX[3];
	
	vec3 camera_position = -invcamw.xyz * mat3(invcamx.xyz, invcamy.xyz, invcamz.xyz);
	
	// Calculate reflections
	vec3 vertex_world = (CAMERA_MATRIX * vec4(VERTEX, 1.0)).xyz;
	reflection_coordinates = reflect(normalize(vertex_world - camera_position), normalize(WORLD_MATRIX * vec4(NORMAL, 0.0)).xyz);
	reflection_coordinates.z *= -1.0;
}

void fragment() {
	vec4 tex = texture(albedoTex, mix(vertex_coordinates.xy /vertex_coordinates.z, UV.xy, affine_texture_mapping_amount));
	vec4 cube = texture(cubemap, reflection_coordinates);
	
	ALBEDO = mix(tex.rgb * color.rgb, cube.rgb, reflection_intensity);
	SPECULAR = specular_intensity;
}
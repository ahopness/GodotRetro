//SHADER GRABED FROM THE BOOK OF SHADERS
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//SHADERTOY LINK : https://thebookofshaders.com/edit.php#03/space.frag

shader_type spatial;
render_mode cull_disabled, specular_disabled, diffuse_lambert;

void fragment(){
	vec2 st = UV;
	vec3 final = vec3(st.x, st.y, 0.0);
	ALBEDO = final;
}
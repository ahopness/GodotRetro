//SHADER GRABED FROM THE BOOK OF SHADERS
//PORTED AND MODIFYED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//SHADERTOY LINK : https://thebookofshaders.com/edit.php#03/space.frag

shader_type canvas_item;

void fragment(){
	vec2 st = UV;
	vec4 final = vec4(st.x, st.y, 0.0, 1.0);
	COLOR = final;
}
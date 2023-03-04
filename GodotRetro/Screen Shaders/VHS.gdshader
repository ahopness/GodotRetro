//SHADER ORIGINALY CREADED BY "FMS_Cat" FROM SHADERTOY
//MODIFIED AND PORTED TO GODOT BY AHOPNESS (@ahopness)
//LICENSE : CC0
//COMATIBLE WITH : GLES2, GLES3
//SHADERTOY LINK : https://www.shadertoy.com/view/XtBXDt

shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

uniform float tape_wave_amount :hint_range (0, .04) = 0.003;
uniform float tape_crease_amount :hint_range (0, 15) = 2.5;
uniform float color_displacement :hint_range (0, 5) = 1;
uniform float lines_velocity :hint_range (0, 5) = 0.1;

vec3 tex2D( sampler2D _tex, vec2 _p ){
	vec3 col = texture( _tex, _p ).xyz;
	if ( 0.5 < abs( _p.x - 0.5 ) ) {
		col = vec3( 0.1 );
	}
	return col;
}

float hash( vec2 _v ){
	return fract( sin( dot( _v, vec2( 89.44, 19.36 ) ) ) * 22189.22 );
}

float iHash( vec2 _v, vec2 _r ){
	float h00 = hash( vec2( floor( _v * _r + vec2( 0.0, 0.0 ) ) / _r ) );
	float h10 = hash( vec2( floor( _v * _r + vec2( 1.0, 0.0 ) ) / _r ) );
	float h01 = hash( vec2( floor( _v * _r + vec2( 0.0, 1.0 ) ) / _r ) );
	float h11 = hash( vec2( floor( _v * _r + vec2( 1.0, 1.0 ) ) / _r ) );
	vec2 ip = vec2( smoothstep( vec2( 0.0, 0.0 ), vec2( 1.0, 1.0 ), mod( _v*_r, 1. ) ) );
	return ( h00 * ( 1. - ip.x ) + h10 * ip.x ) * ( 1. - ip.y ) + ( h01 * ( 1. - ip.x ) + h11 * ip.x ) * ip.y;
}

float noise( vec2 _v ){
	float sum = 0.;
	for( float i=1.0; i<9.0; i++ ){
	sum += iHash( _v + vec2( i ), vec2( 2. * pow( 2., float( i ) ) ) ) / pow( 2., float( i ) );
	}
	return sum;
}

void fragment(){
	vec2 uv = FRAGCOORD.xy / (1.0 / SCREEN_PIXEL_SIZE).xy;
	vec2 uvn = uv;
	vec3 col = vec3( 0.0 );
	
	// tape wave
	uvn.x += ( noise( vec2( uvn.y, TIME ) ) - 0.5 )* 0.005;
	uvn.x += ( noise( vec2( uvn.y * 100.0, TIME * 10.0 ) ) - 0.5 ) * tape_wave_amount;
	
	// tape crease
	float tcPhase = clamp( ( sin( uvn.y * 8.0 - TIME * PI * 1.2 ) - 0.92 ) * noise( vec2( TIME ) ), 0.0, 0.01 ) * tape_crease_amount;
	float tcNoise = max( noise( vec2( uvn.y * 100.0, TIME * 10.0 ) ) - 0.5, 0.0 );
	uvn.x = uvn.x - tcNoise * tcPhase;
	
	// switching noise
	float snPhase = smoothstep( 0.03, 0.0, uvn.y );
	uvn.y += snPhase * 0.3;
	uvn.x += snPhase * ( ( noise( vec2( uv.y * 100.0, TIME * 10.0 ) ) - 0.5 ) * 0.2 );
	
	col = tex2D( SCREEN_TEXTURE, uvn );
	col *= 1.0 - tcPhase;
	col = mix(
		col,
		col.yzx,
		snPhase
	);
	
	// bloom
	for( float x = -4.0; x < 2.5; x += 1.0 ){
		col.xyz += vec3(
		tex2D( SCREEN_TEXTURE, uvn + vec2( x - 0.0, 0.0 ) * 0.007 ).x,
		tex2D( SCREEN_TEXTURE, uvn + vec2( x - color_displacement, 0.0 ) * 0.007 ).y,
		tex2D( SCREEN_TEXTURE, uvn + vec2( x - color_displacement * 2.0, 0.0 ) * 0.007 ).z
		) * 0.1;
	}
	col *= 0.6;
	
	// ac beat
	col *= 1.0 + clamp( noise( vec2( 0.0, uv.y + TIME * lines_velocity ) ) * 0.6 - 0.25, 0.0, 0.1 );
	
	COLOR = vec4( col, 1.0 );
}
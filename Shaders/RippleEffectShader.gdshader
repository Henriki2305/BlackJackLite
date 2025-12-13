shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

uniform float width = 0.0;
uniform float spot = 0.00;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;

void fragment() {
	vec2 su = SCREEN_UV;
	float ar = SCREEN_PIXEL_SIZE.y/SCREEN_PIXEL_SIZE.x;
	vec2 c = vec2(0.5,0.5);
	vec2 ssu = (su-vec2(0.0,0.5))/vec2(1.0,ar)+vec2(0.0,0.5);
	vec2 cdist = ssu-c;
	float di = length(cdist);
	float rat;
	if (di == 0.0)
		{rat = 1.0;}
	else {
		rat = spot/di;
	}
	if( di < spot+width && (di > spot-width || width >= spot) ){
		vec2 ce = ((cdist)*rat-cdist)/2.0;
		vec2 cop = ssu+ce;
		cop = (cop-vec2(0.0,0.5))*vec2(1.0,ar)+vec2(0.0,0.5);
		vec4 n = texture(SCREEN_TEXTURE,cop,1.0);
		COLOR = n;
		//COLOR = vec4(UV,1.0,1.0);
	}
	else{
		COLOR = vec4(UV,1.0,0.0);
	}
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

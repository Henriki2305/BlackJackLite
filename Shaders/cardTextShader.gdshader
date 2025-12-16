shader_type canvas_item;

uniform bool rare = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	if (rare){
		vec4 pixelColor = texture(TEXTURE, UV);
		float t = TIME*0.25+25.0*UV.x+40.0*UV.y;
		float rr = 0.0;
		float gg = 0.0;
		float bb = 0.0;
		if (mod(t,3.0)>=1.0&&mod(t,3.0)<=2.0){
			gg = mod(t,3.0)-1.0;
			rr = 1.0-(mod(t,3.0)-1.0);
		}
		if (mod(t,3.0)>2.0){
			bb = mod(t,3.0)-2.0;
			gg = 1.0-(mod(t,3.0)-2.0);
		}
		if (mod(t,3.0)<1.0){
			rr = mod(t,3.0);
			bb = 1.0-(mod(t,3.0));
		}
		rr = 1.0-((1.0-rr)*(1.0-rr));
		gg = 1.0-((1.0-gg)*(1.0-gg));
		bb = 1.0-((1.0-bb)*(1.0-bb));
		COLOR = vec4(rr,gg,bb,pixelColor.a);
		}
	// Called for every pixel the material is visible on.
}//void light() {//	// Called for every pixel for every light affecting the CanvasItem.//	// Uncomment to replace the default light processing function with this one.//}
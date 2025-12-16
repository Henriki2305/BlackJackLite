shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform bool shadow = false;
uniform bool cursed = false;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	if (cursed) {
		vec4 unholyColor = vec4(0.5,0.05,0.10,pixelColor.a);
		pixelColor = unholyColor*pixelColor;
	}
	if (shadow){
		vec4 shadowColor = vec4(0.2,0.2,0.2,pixelColor.a);
		pixelColor = shadowColor*pixelColor;
	}
	COLOR = pixelColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

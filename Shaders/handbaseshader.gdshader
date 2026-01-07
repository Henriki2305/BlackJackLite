shader_type canvas_item;
uniform float colorness = 0.0;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	vec4 newColor = vec4(colorness,0.00,0.00,pixelColor.a);
	COLOR = newColor;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

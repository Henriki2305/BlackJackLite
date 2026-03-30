shader_type canvas_item;

uniform vec3 col1;
uniform vec3 col2;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec3 str1 = vec3(color.r,color.g,color.b) * col1;
	vec3 str2 = vec3(1.0-color.r,1.0-color.g,1.0-color.b)*col2;
	vec3 str = mix(str1,str2,0.5);
	COLOR = vec4(str.r,str.g,str.b,color.a);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

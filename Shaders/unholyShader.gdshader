shader_type canvas_item;

uniform bool rare = false;

void vertex() {
	// Called for every vertex the material is visible on.
}
uniform bool shadow = false;
uniform bool cursed = false;
uniform bool gold = false;
uniform bool used = false;
uniform float linewidth = 0.30;
uniform float linespeed = 2.5;
uniform vec4 linecolor = vec4(1.0,1.0,1.0,1.0);
uniform float linetriptime = 2;
uniform float linewaittime = 2.0;

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
	if (gold){
		pixelColor = vec4(0.65,0.62,0.21,pixelColor.a);
		if (texture(TEXTURE,UV).a != 0.0) {
			float phase = mod(TIME * linespeed, linetriptime+linewaittime);
			float ypos = 3.0*(phase/linetriptime)-UV.x;
			float offset = abs(ypos-UV.y);
			if (offset < linewidth){
				if (offset < 0.35*linewidth)
				pixelColor = linecolor;
				else{
					
					float lev = (offset-0.35*linewidth)/(0.65*linewidth);
					vec3 color = lev*pixelColor.rgb + (1.0-lev)*linecolor.rgb;
					pixelColor = vec4(color, pixelColor.a);
				}
			}
		}
	}
	COLOR = pixelColor;
	if (rare){
		float zx = 2.0*UV.x+UV.y;
		float zy = 2.0*UV.x-UV.y;
		if((mod(zx*4.0,2.0)<1.0 && mod(zy*4.0,2.0)<1.0 || mod(zx*4.0,2.0)>1.0 && mod(zy*4.0,3.0)>1.0)&&mod(zx*4.0,4.0)<1.0&&mod(zy*4.0,4.0)<1.0){
		vec4 pixelColor = texture(TEXTURE, UV);
		float t = TIME*0.25+2.50*UV.x+4.00*UV.y;
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
		COLOR = vec4(rr,gg,bb,pixelColor.a*0.6);
			}
		}
		if (used){
		vec4 usedColor = vec4(0.07,0.07,0.07,COLOR.a);
		COLOR = usedColor*COLOR;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}

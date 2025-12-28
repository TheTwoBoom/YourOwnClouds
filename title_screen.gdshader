shader_type canvas_item;

uniform float scale = 50.0;
uniform float speed = 0.5;
uniform vec4 line_color : source_color = vec4(1.0);
uniform float thickness = 0.05;

vec2 rotateUV(vec2 uv, vec2 pivot, float rotation) {
	float cosa = cos(rotation);
	float sina = sin(rotation);
	uv -= pivot;
	return vec2(
		cosa * uv.x - sina * uv.y,
		cosa * uv.y + sina * uv.x 
	) + pivot;
}

void fragment() {
    vec2 uv = FRAGCOORD.xy / scale;
	uv.x += TIME*3.5*speed;
	uv.y += TIME*2.5*speed;
	uv = rotateUV(uv, vec2(1, 1), PI/4.0);
    float v = step(1.0 - thickness, abs(fract(uv.x) - 0.5));
    float h = step(1.0 - thickness, abs(fract(uv.y) - 0.5));
    float g = max(v, h);
	vec4 final_color = line_color * vec4(UV, 0.7, (UV.x+0.05)*0.8);
    COLOR = mix(vec4(0.0), final_color, g);
}

void vertex() {
  VERTEX += vec2(0.0, 0.0);
}
shader_type canvas_item;

void fragment() {
	vec2 uv = UV;
	uv.y += sin(UV.x * 20.0 + TIME * 2.0) * 0.01;
	COLOR = texture(TEXTURE, uv);
}

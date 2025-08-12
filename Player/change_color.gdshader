shader_type canvas_item;

uniform vec3 base: source_color;
uniform vec3 secondary: source_color;
uniform vec3 og_base: source_color;
uniform vec3 og_secondary: source_color;

void fragment() {
	if (distance(texture(TEXTURE, UV).rgb, og_base) < 0.01) {
        vec3 modulate = COLOR.rgb / og_base;
        COLOR.rgb = modulate * base;
    }
    if (distance(texture(TEXTURE, UV).rgb, og_secondary) < 0.01) {
        vec3 modulate = COLOR.rgb / og_secondary;
        COLOR.rgb = modulate * secondary;
    }
}

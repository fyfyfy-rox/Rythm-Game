shader_type canvas_item;
uniform sampler2D screen_texture : hint_screen_texture;
uniform vec4 water_colour : source_color;
uniform sampler2D wave_noise : repeat_enable;
uniform sampler2D mask;


void fragment() {
	vec2 water_wave = (texture(wave_noise, UV + 0.15 * TIME).rg -0.5) * 0.01;
	vec4 mask_color = texture(mask, UV).rgba;
	vec4 sprite_color = texture(TEXTURE, UV).rgba;
	vec2 uv = vec2(SCREEN_UV.x , SCREEN_UV.y - UV.y) + water_wave;
	vec4 colour = texture(screen_texture, uv);
	float mix_value = 1.0 - UV.y;

	float avg_colour = (colour.r + colour.g + colour.b) / 3.0;
	avg_colour = pow(avg_colour, 1.4);
	mix_value += avg_colour;


	mix_value = clamp(mix_value, 0.0, 0.7);
	COLOR = mix(water_colour, colour, mix_value);

	if (mask_color.a != 0.0) {
		sprite_color.a = 0.0;
		COLOR = sprite_color;
	}
}

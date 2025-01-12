shader_type canvas_item;

// Uniforms for customization
uniform float time_speed : hint_range(0.1, 5.0) = 1.0; // Speed of the animation
uniform float wave_amplitude : hint_range(0.0, 1.0) = 0.02; // Strength of the wave distortion
uniform float glow_intensity : hint_range(0.0, 1.0) = 0.5; // Intensity of the glow
uniform float wave_frequency : hint_range(1.0, 10.0) = 4.0; // Wave frequency
uniform vec3 base_color : source_color = vec3(0.1, 0.3, 0.8); // Default deep blue
uniform float blue_boost : hint_range(0.0, 1.0) = 0.5; // Adds deeper blue
uniform sampler2D wave_noise; // Noise texture for the magic effect

void fragment() {
    // Add time-based animation
    float time = TIME * time_speed;

    // Create a wavy distortion using a combination of sine wave and noise texture
    float wave_effect = sin(UV.x * wave_frequency + time) * wave_amplitude;
    vec2 wave_uv = UV + vec2(wave_effect, 0.0) + (texture(wave_noise, UV + vec2(time * 0.2, 0.0)).rg - 0.5) * wave_amplitude;

    // Base magical glow color
    vec3 glow_color = base_color;

    // Boost the blue component for a deeper blue effect
    glow_color.b += blue_boost;

    // Add a pulsing effect to the glow
    float pulse = 0.5 + 0.5 * sin(time * 3.0); // Pulsates between 0 and 1
    glow_color *= (1.0 + pulse * glow_intensity);

    // Calculate gradient blending (to focus glow more on one side)
    float gradient = clamp(1.0 - UV.y, 0.0, 1.0); // Stronger at the bottom
    glow_color *= gradient;

    // Mix the original texture color with the glow
    vec4 original_color = texture(TEXTURE, wave_uv);
    COLOR = mix(original_color, vec4(glow_color, 1.0), glow_intensity);
}

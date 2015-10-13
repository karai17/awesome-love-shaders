// Simple vignette shader for LÖVE
// License: CC0
// Version: 1.0
// Author:  Landon Manning
// Email:   LManning17@gmail.com

uniform bool  u_correct_ratio = false;
uniform float u_radius        = 0.75;
uniform float u_softness      = 0.45;
uniform float u_opacity       = 0.5;

vec4 effect(vec4 color, sampler2D texture, vec2 texCoords, vec2 screenCoords) {
	vec4 texColor = texture2D(texture, texCoords);
	vec2 position = (screenCoords.xy / love_ScreenSize.xy) - vec2(0.5);

	if (u_correct_ratio) {
		position.x *= love_ScreenSize.x / love_ScreenSize.y;
	}

	float vignette = smoothstep(
		u_radius,
		u_radius - u_softness,
		length(position)
	);

	texColor.rgb = mix(
		texColor.rgb,
		texColor.rgb * vignette,
		u_opacity
	);

	return texColor * color;
}

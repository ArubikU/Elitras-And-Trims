#version 150

#moj_import <fog.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform float GameTime;
uniform vec4 FogColor;

in vec4 lightMapColor;
in float vertexDistance;
in vec4 vertexColor;
in vec2 texCoord0;
in vec2 texCoord1;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color         = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    vec4 emissiveColor = texture(Sampler0, texCoord0); // USED FOR ARMOR TRIMS

    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);

    if (color.a < 0.1) {discard;}

    float opacity = ceil(color.a * 255);
    if(opacity == 254)
      {
        float animationTime = GameTime * 1000;
        vec4 animatedFade = mix(  fragColor, emissiveColor, pow(sin(animationTime + texCoord0.x*1.1),2)  );
        fragColor = animatedFade;
      }
      else{
        fragColor *= lightMapColor;
      }
}

// Modifications made by ManuelXXVI
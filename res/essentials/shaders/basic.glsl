@VERTEX
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec2 aTex;

layout (std140) uniform Matrices{
    mat4 projection;
    mat4 view;
};

out vec2 tex_coord;
uniform mat4 model;


void main() {
	gl_Position = projection *  view * model * vec4(aPos, 1.0f);
    tex_coord = aTex;
}


@FRAGMENT
#version 330 core
in vec2 tex_coord;
out vec4 frag_color;


struct Material {
    vec3 ambient;
    //vec3 diffuse;
    //vec3 specular;
    //float shininess;
    vec2 tex_repeat;
    vec2 tex_offset;
    bool is_textured;
};


uniform sampler2D texture_sample;
uniform Material material;

void main() {
    frag_color = vec4(material.ambient, 1.0f);

    if (material.is_textured) {
        vec2 final_coord = (tex_coord + material.tex_offset) * material.tex_repeat;
        frag_color *= texture(texture_sample, final_coord);
    }
}

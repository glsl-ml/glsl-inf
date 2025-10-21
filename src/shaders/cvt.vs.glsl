// Conversion from one data type another
// The file is generic. Shared for all architectures
/*
Support matrix

FP32 to BF16
*/

#version 330 core
// Fullscreen triangle via gl_VertexID
const vec2 verts[3] = vec2[3](
  vec2(-1.0, -3.0),
  vec2(-1.0,  1.0),
  vec2( 3.0,  1.0)
);

void main() {
  gl_Position = vec4(verts[gl_VertexID], 0.0, 1.0);
}

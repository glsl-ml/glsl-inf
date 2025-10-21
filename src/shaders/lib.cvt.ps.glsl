#version 330 core

#include "types.glsl"

#define MASK_16_HI 0xFFFF0000
#define MASK_16_LO 0x0000FFFF

/**
Convert 2 vec4 floats into bfloat16 in 1 vec4
*/
vec4 fn_cvt_fp32_to_bf16_v4_v8(vec4 val1, vec4 val2) {
  val1.x = val1.x & MASK_16_HI;
  val1.y = val1.y & MASK_16_HI;
  val1.z = val1.z & MASK_16_HI;
  val1.w = val1.w & MASK_16_HI;
  
  val2.x = val2.x & MASK_16_HI;
  val2.y = val2.y & MASK_16_HI;
  val2.z = val2.z & MASK_16_HI;
  val2.w = val2.w & MASK_16_HI;

  val1.y = val1.y >> 16;
  val1.w = val1.w >> 16;

  val2.y = val2.y >> 16;
  val2.w = val2.w >> 16;

  val1.x = val1.x | val1.y;
  val1.y = val1.z | val1.w;
  val1.z = val2.x | val2.y;
  val1.w = val2.z | val2.w;

  return val1;
}

/**
Convert 1 vec4 floats into bfloat16 in 1 vec2
*/
vec2 fn_cvt_fp32_to_bf64_v2_v4(vec4 val) {
  vec2 o;

  val.x = val.x & MASK_16_LO;
  val.y = val.y & MASK_16_LO;
  val.z = val.z & MASK_16_LO;
  val.w = val.w & MASK_16_LO;

  o.x = val.x;
  o.x = o.x | (val.y >> 16);
  o.y = val.z;
  o.y = o.y | (val.w >> 16);

  return o;
}


/**
Convert 1 vec4 bfloat16 into float in 2 vec4
*/

vec8 fn_cvt_bf16_to_fp32_v8_v4(vec4 val) {
  vec4 hi, lo;
  hi.x = (val.x & MASK_16_LO);
  hi.y = (val.x & MASK_16_HI) >> 16;
  hi.z = (val.y & 0x0000FFFF);
  hi.w = (val.y & MASK_16_LO) >> 16;

  lo.x = (val.z & MASK_16_LO);
  lo.y = (val.z & MASK_16_HI) >> 16;
  lo.z = (val.w & MASK_16_LO);
  lo.w = (val.w & MASK_16_HI) >> 16;

  return {hi, lo};
}

/**
Convert 1 vec2 bfloat16 into floats in 1 vec4
*/
vec4 fn_cvt_bf16_to_fp32_v4_v2(vec2 val) {
  vec4 o;
  o.x = val.x & MASK_16_HI;
  o.y = (val.x & MASK_16_LO) >> 16;
  o.z = val.y & MASK_16_HI;
  o.w = (val.y & MASK_16_LO) >> 16;

  return o;
}

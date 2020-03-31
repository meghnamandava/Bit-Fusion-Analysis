#include <stdint.h>
#include "ap_cint.h"

void bitfusion(uint4 in, uint4 weight, uint1 s_in, uint1 s_weight, uint3 in_width, uint3 weight_width, uint8 psum) {
    if (s_in == 1 && s_weight == 1) {
        if (in_width == 1 && weight_width == 4) {
            psum = (uint8) ((int2) in * (int4) weight);
        } else if (in_width == 2 && weight_width == 4) {
            psum = (uint8) ((int2) in * (int4) weight);
        } else if (in_width == 4 && weight_width == 1) {
            psum = (uint8) ((int4) in * (int2) weight);
        } else if (in_width == 4 && weight_width == 2) {
            psum = (uint8) ((int4) in * (int2) weight);
        } else if (in_width == 4 && weight_width == 4) {
            psum = (uint8) ((int4) in * (int4) weight);
        } else {
            psum = (uint8) ((int2) in * (int2) weight);
        }
    } else if (s_in == 0 && s_weight == 1) {
        if (in_width == 1 && weight_width == 4) {
            psum = (uint8) ((uint2) in * (int4) weight);
        } else if (in_width == 2 && weight_width == 4) {
            psum = (uint8) ((uint2) in * (int4) weight);
        } else if (in_width == 4 && weight_width == 1) {
            psum = (uint8) ((uint4) in * (int2) weight);
        } else if (in_width == 4 && weight_width == 2) {
            psum = (uint8) ((uint4) in * (int2) weight);
        } else if (in_width == 4 && weight_width == 4) {
            psum = (uint8) ((uint4) in * (int4) weight);
        } else {
            psum = (uint8) ((uint2) in * (int2) weight);
        }   
    } else if (s_in == 0 && s_weight == 0) {
        if (in_width == 1 && weight_width == 4) {
            psum = (uint8) ((uint2) in * (uint4) weight);
        } else if (in_width == 2 && weight_width == 4) {
            psum = (uint8) ((uint2) in * (uint4) weight);
        } else if (in_width == 4 && weight_width == 1) {
            psum = (uint8) ((uint4) in * (uint2) weight);
        } else if (in_width == 4 && weight_width == 2) {
            psum = (uint8) ((uint4) in * (uint2) weight);
        } else if (in_width == 4 && weight_width == 4) {
            psum = (uint8) ((uint4) in * (uint4) weight);
        } else {
            psum = (uint8) ((uint2) in * (uint2) weight);
        } 
    } else if (s_in == 1 && s_weight == 0) {
        if (in_width == 1 && weight_width == 4) {
            psum = (uint8) ((int2) in * (uint4) weight);
        } else if (in_width == 2 && weight_width == 4) {
            psum = (uint8) ((int2) in * (uint4) weight);
        } else if (in_width == 4 && weight_width == 1) {
            psum = (uint8) ((int4) in * (uint2) weight);
        } else if (in_width == 4 && weight_width == 2) {
            psum = (uint8) ((int4) in * (uint2) weight);
        } else if (in_width == 4 && weight_width == 4) {
            psum = (uint8) ((int4) in * (uint4) weight);
        } else {
            psum = (uint8) ((int2) in * (uint2) weight);
        }
    }
}
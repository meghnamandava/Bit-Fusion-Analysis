#include "ap_cint.h"

void bitfusion(uint4 in, uint4 weight, uint1 s_in, uint1 s_weight, uint3 in_width, uint3 weight_width, uint8 psum);

int main() {

    uint4 i;
    uint4 j;
    uint3 in_width = 1;
    uint3 weight_width = 1;
    uint1 s_weight = 0;
    uint1 s_in = 0;
    uint8 psum;
    for (i = 0; i <= 1; i++) {
        for (j = 0; j <= 1; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j);                
        }
    }

    in_width = 2;
    weight_width = 2;
    s_weight = 0;
    s_in = 0;
    for (i = 0; i <= 3; i++) {
        for (j = 0; j <= 3; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j);                
        }
    }

    in_width = 4;
    weight_width = 4;
    s_weight = 0;
    s_in = 0;
    for (i = 0; i <= 15; i++) {
        for (j = 0; j <= 15; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j);                
        }
    }

    in_width = 4;
    weight_width = 4;
    s_weight = 1;
    s_in = 1;
    for (i = -8; i <= 7; i++) {
        for (j = -8; j <= 7; j++) {
            bitfusion((int4) i, (int4) j, s_in, s_weight, in_width, weight_width, psum);
            assert((uint8)psum == i*j);                
        }
    }
    return 0;
}
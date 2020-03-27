#include <stdint.h>
#include "ap_cint.h"

void bitfusion(ap_uint<4> in, ap_uint<4> weight, ap_uint<1> s_in, ap_uint<1> s_weight, ap_uint<3> in_width, ap_uint<3> weight_width, ap_uint<8> psum);

int main() {

    ap_uint<4> i;
    ap_uint<4> j;
    ap_uint<3> in_width = 1;
    ap_uint<3> weight_width = 1;
    ap_uint<1> s_weight = 0;
    ap_uint<1> s_in = 0;
    ap_uint<8> psum;
    for (i = 0; i <= 1; i++) {
        for (j = 0; j <= 1; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j)                
        }
    }

    ap_uint<3> in_width = 2;
    ap_uint<3> weight_width = 2;
    ap_uint<1> s_weight = 0;
    ap_uint<1> s_in = 0;
    ap_uint<8> psum;
    for (i = 0; i <= 3; i++) {
        for (j = 0; j <= 3; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j)                
        }
    }

    ap_uint<3> in_width = 4;
    ap_uint<3> weight_width = 4;
    ap_uint<1> s_weight = 0;
    ap_uint<1> s_in = 0;
    ap_uint<8> psum;
    for (i = 0; i <= 15; i++) {
        for (j = 0; j <= 15; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            assert(psum == i*j)                
        }
    }

    ap_uint<3> in_width = 4;
    ap_uint<3> weight_width = 4;
    ap_uint<1> s_weight = 1;
    ap_uint<1> s_in = 1;
    ap_uint<8> psum;
    for (i = -8; i <= 7; i++) {
        for (j = -8; j <= 7; j++) {
            bitfusion((ap_int<4>) i, (ap_int<4>) j, s_in, s_weight, in_width, weight_width, psum);
            assert((ap_uint<8>)psum == i*j)                
        }
    }
    return 0;
}
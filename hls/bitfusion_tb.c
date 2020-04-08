#include "ap_cint.h"
#include <stdint.h>
#include <stdio.h>
#include <assert.h>

void bitfusion(uint4 in, uint4 weight, uint1 s_in, uint1 s_weight, uint3 in_width, uint3 weight_width, uint8 *psum);

int main() {
    static uint4 i = 0;
    static uint4 j = 0;
    static int4 k = 0;
    static int4 l = 0;
    static uint3 in_width = 1;
    static uint3 weight_width = 1;
    static uint1 s_weight = 0;
    static uint1 s_in = 0;
    uint8 psum;
    for (i = 0; i <= 1; i++) {
        for (j = 0; j <= 1; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, &psum);
            if (psum != i*j) {
                printf("i: %d, j: %d, psum: %d\n", i, j, psum);
            	return 1;
            }
        }
    }

    in_width = 2;
    weight_width = 2;
    s_weight = 0;
    s_in = 0;
    for (i = 0; i <= 3; i++) {
        for (j = 0; j <= 3; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, &psum);
            if (psum != i*j) return 1;                
        }
    }

    /*in_width = 4;
    weight_width = 4;
    s_weight = 0;
    s_in = 0;
    for (i = 13; i <= 15; i++) {
        for (j = 13; j <= 14; j++) {
            bitfusion(i, j, s_in, s_weight, in_width, weight_width, psum);
            if (psum != i*j) {
            	//printf("fail\n");
            	return 1;
            } else {
            	//printf("psum: %d, correct: %d\n", psum, i*j);
            }
        }
    }*/

    /*in_width = 4;
    weight_width = 4;
    s_weight = 1;
    s_in = 1;
    for (k = -8; k <= 7; k++) {
        for (l = -8; l <= 7; l++) {
            bitfusion(k, l, s_in, s_weight, in_width, weight_width, psum);
            if ((int8)psum != k*l) return 1;
        }
    }*/

    bitfusion(15, 15, 0, 0, 4, 4, &psum);
    if (psum != 225) return 1;

    bitfusion(-8, -8, 1, 1, 4, 4, &psum);
    if ((int8)psum != 64) return 1;

    bitfusion(-8, 7, 1, 1, 4, 4, &psum);
    if ((int8)psum != -56) return 1;

    return 0;
}

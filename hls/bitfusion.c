#include <stdint.h>
#include <ap_cint.h>

void bitfusion(ap_uint<4> in, ap_uint<4> weight, ap_uint<1> s_in, ap_uint<1> s_weight, ap_uint<3> in_width, ap_uint<3> weight_width, ap_uint<8> psum) {
    /*if (in_width == 1 && weight_width == 1) {
        if (s_in == 1 && s_weight == 1) {
            out = (ap_int<1>) in * (ap_int<1>) weight;
        } else if (s_in == 0 && s_weight == 0) {
            out = (ap_uint<1>) in * (ap_uint<1>) weight;
        }
    }*/
    if (s_in == 1 && s_weight == 1) {
        psum = (ap_int<in_width>) in * (ap_int<weight_width>) weight;
    } else if (s_in == 0 && s_weight == 1) {
        psum = (ap_uint<in_width>) in * (ap_int<weight_width>) weight;
    } else if (s_in == 0 && s_weight == 0) {
        psum = (ap_uint<in_width>) in * (ap_uint<weight_width>) weight;
    } else if (s_in == 1 && s_weight == 0) {
        psum = (ap_int<in_width>) in * (ap_uint<weight_width>) weight;
    }
}
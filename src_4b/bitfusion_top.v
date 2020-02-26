`timescale 1ns/1ns

module bitfusion_top (
        input CLK_125MHZ_FPGA,
        input [3:0] in,
        input [3:0] weight,
        input [2:0] in_width,
        input [2:0] weight_width,
        input s_in,
        input s_weight,
        output [7:0] psum
    );

    //need to mux inputs??

    fusion_unit fu0(
        .clk(CLK_125MHZ_FPGA),
        .in(in_reg),
        .weight(weight_reg),
        .in_width(in_width_reg),
        .weight_width(weight_width_reg),
        .s_in(s_in_reg),
        .s_weight(s_weight_reg),
        .psum_fwd(psum)
    );


endmodule
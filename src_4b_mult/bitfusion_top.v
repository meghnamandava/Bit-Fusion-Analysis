`timescale 1ns/1ns

module bitfusion_top (
        input CLK_125MHZ_FPGA,
        input [3:0] in,
        input [3:0] weight,
        input s_in,
        input s_weight,
        output [7:0] psum
    );

    //need to mux inputs??

    fusion_unit fu0(
        .clk(CLK_125MHZ_FPGA),
        .in(in),
        .weight(weight),
        .s_in(s_in),
        .s_weight(s_weight),
        .psum_fwd(psum)
    );


endmodule
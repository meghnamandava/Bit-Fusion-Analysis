`timescale 1ns/1ns

module bitfusion_top (
        input clk,
        input [3:0] in,
        input [3:0] weight,
        input [2:0] in_width,
        input [2:0] weight_width,
        input s_in,
        input s_weight,
        output [7:0] psum
    );

    //need to mux inputs??
    reg [7:0] in_reg;
    reg [7:0] weight_reg;
    reg [3:0] in_width_reg;
    reg [3:0] weight_width_reg;
    reg s_in_reg;
    reg s_weight_reg;

    fusion_unit fu0(
        .clk(clk),
        .in(in_reg),
        .weight(weight_reg),
        .in_width(in_width_reg),
        .weight_width(weight_width_reg),
        .s_in(s_in_reg),
        .s_weight(s_weight_reg),
        .psum_fwd(psum)
    );

    always @(posedge clk) begin
        in_reg <= in;
        weight_reg <= weight;
        in_width_reg <= in_width;
        weight_width_reg <= weight_width;
        s_in_reg <= s_in;
        s_weight_reg <= s_weight;
        //psum <= psum_fwd;
    end

endmodule
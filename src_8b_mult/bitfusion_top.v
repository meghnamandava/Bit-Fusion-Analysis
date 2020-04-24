module bitfusion_top #(parameter COL_WIDTH=13) (
    input clk,
    input [7:0] in,
    input [7:0] weight,
    input [18:0] psum_in,
    //input [3:0] in_width,
    //input [3:0] weight_width,
    input s_in,
    input s_weight,
    output [18:0] psum_fwd //max widths for 2b parallelism
    );

    //need to mux inputs??

    reg [7:0] in_reg;
    reg [7:0] weight_reg;
    reg [18:0] psum_in_reg;
    //reg [3:0] in_width_reg;
    //reg [3:0] weight_width_reg;
    reg s_in_reg;
    reg s_weight_reg;
    //wire [(COL_WIDTH*4)-1:0] psum_fwd;

    fusion_unit fu0(
        .clk(clk),
        .in(in_reg),
        .weight(weight_reg),
        .psum_in(psum_in_reg),
        //.in_width(in_width_reg),
        //.weight_width(weight_width_reg),
        .s_in(s_in_reg),
        .s_weight(s_weight_reg),
        .psum_fwd(psum_fwd)
    );

    always @(posedge clk) begin
        in_reg <= in;
        weight_reg <= weight;
        psum_in_reg <= psum_in;
        //in_width_reg <= in_width;
        //weight_width_reg <= weight_width;
        s_in_reg <= s_in;
        s_weight_reg <= s_weight;
        //psum <= psum_fwd;
    end

endmodule
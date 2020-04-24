module array_top #(parameter COL_WIDTH=13, parameter ARRAY_SIZE=8) (
    input clk,

    input [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights,
    input [ARRAY_SIZE-1:0] [7:0] inputs,

    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,

    output reg [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] psums
    );

    //need to mux inputs??

    reg [ARRAY_SIZE-1:0] [7:0] in_reg;
    reg [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0]  weight_reg;
    reg [(COL_WIDTH*4)-1:0] psum_in_reg;
    reg [3:0] in_width_reg;
    reg [3:0] weight_width_reg;
    reg s_in_reg;
    reg s_weight_reg;
    wire [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] psum_fwd;

    systolic_array sa0(
        .clk(clk),
        .inputs(in_reg),
        .weights(weight_reg),
        .in_width(in_width_reg),
        .weight_width(weight_width_reg),
        .s_in(s_in_reg),
        .s_weight(s_weight_reg),
        .psum_fwd(psum_fwd)
    );

    always @(posedge clk) begin
        in_reg <= inputs;
        weight_reg <= weights;
        in_width_reg <= in_width;
        weight_width_reg <= weight_width;
        s_in_reg <= s_in;
        s_weight_reg <= s_weight;
        psum <= psum_fwd;
    end

endmodule
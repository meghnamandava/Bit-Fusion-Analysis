module fusion_unit (
    input [3:0] in,
    input [3:0] weight,
    input [2:0] in_width,
    input [2:0] weight_width,
    input s_in,
    input s_weight,
    output [7:0] psum_fwd
    );

    wire [2:0] shift0;
    wire [2:0] shift1;
    wire [2:0] shift2;
    wire [2:0] shift3;


    wire [9:0] prod0;
    wire [9:0] prod1;
    wire [9:0] prod2;
    wire [9:0] prod3;

    wire [1:0] weight_signed, in_signed;

    assign weight_signed = (weight_width == 3'b100) ? 2'b10 : 2'b11;
    assign in_signed = (in_width == 3'b100) ? 2'b10 : 2'b11;

    shift_lookup sl(
        .in_width(in_width),
        .weight_width(weight_width),
        .row0({shift1, shift0}),
        .row1({shift3, shift2})
    );

    bitbrick bb0(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight[1:0]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift0),
        .prod(prod0)
    );

    bitbrick bb1(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight[3:2]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift1),
        .prod(prod1)
    );

    bitbrick bb2(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight[1:0]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift2),
        .prod(prod2)
    );
        
    bitbrick bb3(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight[3:2]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift3),
        .prod(prod3)
    );

    assign psum_fwd = prod0 + prod1 + prod2 + prod3;

endmodule

    
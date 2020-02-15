module fusion_unit (
    input [7:0] in,
    input [7:0] weight,
    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,
    output [15:0] psum_fwd
    );

    wire [2:0] shift0;
    wire [2:0] shift1;
    wire [2:0] shift2;
    wire [2:0] shift3;
    wire [2:0] shift4;
    wire [2:0] shift5;
    wire [2:0] shift6;
    wire [2:0] shift7;
    wire [2:0] shift8;
    wire [2:0] shift9;
    wire [2:0] shift10;
    wire [2:0] shift11;
    wire [2:0] shift12;
    wire [2:0] shift13;
    wire [2:0] shift14;
    wire [2:0] shift15;
    wire [3:0] big_shift0, big_shift1, big_shift2, big_shift3;

    wire [9:0] prod0;
    wire [9:0] prod1;
    wire [9:0] prod2;
    wire [9:0] prod3;
    wire [9:0] prod4;
    wire [9:0] prod5;
    wire [9:0] prod6;
    wire [9:0] prod7;
    wire [9:0] prod8;
    wire [9:0] prod9;
    wire [9:0] prod10;
    wire [9:0] prod11;
    wire [9:0] prod12;
    wire [9:0] prod13;
    wire [9:0] prod14;
    wire [9:0] prod15;

    wire [15:0] sum0, sum1, sum2, sum3;

    shift_lookup sl(
        .in_width(in_width),
        .weight_width(weight_width),
        .row0({shift3, shift2, shift1, shift0}),
        .row1({shift7, shift6, shift5, shift4}),
        .row2({shift11, shift10, shift9, shift8}),
        .row3({shift15, shift14, shift13, shift12}),
        .big_shift({big_shift3, big_shift2, big_shift1, big_shift0})
    );

    bitbrick bb0(
        .x(in[1:0]),
        .s_x(s_in),
        .y(weight[1:0]),
        .s_y(s_weight),
        .shift(shift0),
        .prod(prod0)
    );

    bitbrick bb1(
        .x(in[1:0]),
        .s_x(s_in),
        .y(weight[3:2]),
        .s_y(s_weight),
        .shift(shift1),
        .prod(prod1)
    );

    bitbrick bb2(
        .x(in[1:0]),
        .s_x(s_in),
        .y(weight[5:4]),
        .s_y(s_weight),
        .shift(shift2),
        .prod(prod2)
    );

    bitbrick bb3(
        .x(in[1:0]),
        .s_x(s_in),
        .y(weight[7:6]),
        .s_y(s_weight),
        .shift(shift3),
        .prod(prod3)
    );

    bitbrick bb4(
        .x(in[3:2]),
        .s_x(s_in),
        .y(weight[1:0]),
        .s_y(s_weight),
        .shift(shift4),
        .prod(prod4)
    );
        
    bitbrick bb5(
        .x(in[3:2]),
        .s_x(s_in),
        .y(weight[3:2]),
        .s_y(s_weight),
        .shift(shift5),
        .prod(prod5)
    );

    bitbrick bb6(
        .x(in[3:2]),
        .s_x(s_in),
        .y(weight[5:4]),
        .s_y(s_weight),
        .shift(shift6),
        .prod(prod6)
    );

    bitbrick bb7(
        .x(in[3:2]),
        .s_x(s_in),
        .y(weight[7:6]),
        .s_y(s_weight),
        .shift(shift7),
        .prod(prod7)
    );

    bitbrick bb8(
        .x(in[5:4]),
        .s_x(s_in),
        .y(weight[1:0]),
        .s_y(s_weight),
        .shift(shift8),
        .prod(prod8)
    );  

    bitbrick bb9(
        .x(in[5:4]),
        .s_x(s_in),
        .y(weight[3:2]),
        .s_y(s_weight),
        .shift(shift9),
        .prod(prod9)
    );  

    bitbrick bb10(
        .x(in[5:4]),
        .s_x(s_in),
        .y(weight[5:4]),
        .s_y(s_weight),
        .shift(shift10),
        .prod(prod10)
    ); 

    bitbrick bb11(
        .x(in[5:4]),
        .s_x(s_in),
        .y(weight[7:6]),
        .s_y(s_weight),
        .shift(shift11),
        .prod(prod11)
    );  

    bitbrick bb12(
        .x(in[7:6]),
        .s_x(s_in),
        .y(weight[1:0]),
        .s_y(s_weight),
        .shift(shift12),
        .prod(prod12)
    );  

    bitbrick bb13(
        .x(in[7:6]),
        .s_x(s_in),
        .y(weight[3:2]),
        .s_y(s_weight),
        .shift(shift13),
        .prod(prod13)
    ); 

    bitbrick bb14(
        .x(in[7:6]),
        .s_x(s_in),
        .y(weight[5:4]),
        .s_y(s_weight),
        .shift(shift14),
        .prod(prod14)
    ); 

    bitbrick bb15(
        .x(in[7:6]),
        .s_x(s_in),
        .y(weight[7:6]),
        .s_y(s_weight),
        .shift(shift15),
        .prod(prod15)
    ); 

    fusion_subunit fs0 (
        .prod0(prod0),
        .prod1(prod1),
        .prod2(prod4),
        .prod3(prod5),
        .shift(big_shift0),
        .sum(sum0)
    );

    fusion_subunit fs1 (
        .prod0(prod2),
        .prod1(prod3),
        .prod2(prod6),
        .prod3(prod7),
        .shift(big_shift1),
        .sum(sum1)
    );

    fusion_subunit fs2 (
        .prod0(prod8),
        .prod1(prod9),
        .prod2(prod12),
        .prod3(prod13),
        .shift(big_shift2),
        .sum(sum2)
    );

    fusion_subunit fs3 (
        .prod0(prod10),
        .prod1(prod11),
        .prod2(prod14),
        .prod3(prod15),
        .shift(big_shift3),
        .sum(sum3)
    );

    assign psum_fwd = sum0 + sum1 + sum2 + sum3;

endmodule

    
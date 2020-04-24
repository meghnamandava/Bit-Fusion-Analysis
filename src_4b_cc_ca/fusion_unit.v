module fusion_unit (
    input clk,
    input [3:0] in,
    input [3:0] weight,
    input [2:0] in_width,
    input [2:0] weight_width,
    input s_in,
    input s_weight,
    output reg [17:0] psum_fwd
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

    wire [8:0] col1, col2;
    wire [17:0] total;
    wire [17:0] stotal = $signed(col1)+$signed(col2);
    wire [8:0] scol1 = $signed(prod0)+$signed(prod2);
    wire [8:0] scol2 = $signed(prod1)+$signed(prod3);
    assign col1 = sign ? scol1 : prod0 + prod2;
    assign col2 = sign ? scol2 : prod1 + prod3;
    assign total = sign ? stotal : col1 + col2;
    assign sum = split_column ? {col2, col1} : total;

    always @(posedge clk) begin
        psum_fwd <= sum;
    end

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

endmodule

    
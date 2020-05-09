module fusion_unit_wrong #(parameter COL_WIDTH=13) (

    input clk,
    input [7:0] in,
    input [31:0] weight,
    input [(COL_WIDTH*4)-1:0] psum_in,
    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,
    output reg [(COL_WIDTH*4)-1:0] psum_fwd //max widths for 2b parallelism
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

    wire [(COL_WIDTH*2)-1:0] sum0, sum1, sum2, sum3;
    wire [3:0] weight_signed, in_signed;
    wire [31:0] weight_bb = (in_width[3:2] == 2'b00) ? weight : (in_width[3] == 1'b1) ? 
                            {weight[7:0], weight[7:0], weight[7:0], weight[7:0]} : 
                            {weight[15:8], weight[15:8], weight[7:0], weight[7:0]};


    shift_lookup sl(
        .in_width(in_width),
        .weight_width(weight_width),
        .row0({shift3, shift2, shift1, shift0}),
        .row1({shift7, shift6, shift5, shift4}),
        .row2({shift11, shift10, shift9, shift8}),
        .row3({shift15, shift14, shift13, shift12}),
        .big_shift({big_shift3, big_shift2, big_shift1, big_shift0})
    );

    sign_lookup signlu(
        .in_width(in_width),
        .weight_width(weight_width),
        .in_signed(in_signed),
        .weight_signed(weight_signed)
    );

    bitbrick bb0(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight_bb[1:0]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift0),
        .prod(prod0)
    );

    bitbrick bb1(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight_bb[3:2]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift1),
        .prod(prod1)
    );

    bitbrick bb2(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight_bb[5:4]),
        .s_y(s_weight & weight_signed[2]),
        .shift(shift2),
        .prod(prod2)
    );

    bitbrick bb3(
        .x(in[1:0]),
        .s_x(s_in & in_signed[0]),
        .y(weight_bb[7:6]),
        .s_y(s_weight & weight_signed[3]),
        .shift(shift3),
        .prod(prod3)
    );

    bitbrick bb4(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight_bb[9:8]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift4),
        .prod(prod4)
    );
        
    bitbrick bb5(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight_bb[11:10]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift5),
        .prod(prod5)
    );

    bitbrick bb6(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight_bb[13:12]),
        .s_y(s_weight & weight_signed[2]),
        .shift(shift6),
        .prod(prod6)
    );

    bitbrick bb7(
        .x(in[3:2]),
        .s_x(s_in & in_signed[1]),
        .y(weight_bb[15:14]),
        .s_y(s_weight & weight_signed[3]),
        .shift(shift7),
        .prod(prod7)
    );

    bitbrick bb8(
        .x(in[5:4]),
        .s_x(s_in & in_signed[2]),
        .y(weight_bb[17:16]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift8),
        .prod(prod8)
    );  

    bitbrick bb9(
        .x(in[5:4]),
        .s_x(s_in & in_signed[2]),
        .y(weight_bb[19:18]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift9),
        .prod(prod9)
    );  

    bitbrick bb10(
        .x(in[5:4]),
        .s_x(s_in & in_signed[2]),
        .y(weight_bb[21:20]),
        .s_y(s_weight & weight_signed[2]),
        .shift(shift10),
        .prod(prod10)
    ); 

    bitbrick bb11(
        .x(in[5:4]),
        .s_x(s_in & in_signed[2]),
        .y(weight_bb[23:22]),
        .s_y(s_weight & weight_signed[3]),
        .shift(shift11),
        .prod(prod11)
    );  

    bitbrick bb12(
        .x(in[7:6]),
        .s_x(s_in & in_signed[3]),
        .y(weight_bb[25:24]),
        .s_y(s_weight & weight_signed[0]),
        .shift(shift12),
        .prod(prod12)
    );  

    bitbrick bb13(
        .x(in[7:6]),
        .s_x(s_in & in_signed[3]),
        .y(weight_bb[27:26]),
        .s_y(s_weight & weight_signed[1]),
        .shift(shift13),
        .prod(prod13)
    ); 

    bitbrick bb14(
        .x(in[7:6]),
        .s_x(s_in & in_signed[3]),
        .y(weight_bb[29:28]),
        .s_y(s_weight & weight_signed[2]),
        .shift(shift14),
        .prod(prod14)
    ); 

    bitbrick bb15(
        .x(in[7:6]),
        .s_x(s_in & in_signed[3]),
        .y(weight_bb[31:30]),
        .s_y(s_weight & weight_signed[3]),
        .shift(shift15),
        .prod(prod15)
    ); 

    fusion_subunit #(.COL_WIDTH(COL_WIDTH)) fs0 (
        .p0(prod0),
        .p1(prod1),
        .p2(prod4),
        .p3(prod5),
        .shift(big_shift0),
        .split_column(weight_width[1] || weight_width[0]),        
        .sign(s_in | s_weight),
        .sum(sum0)
    );

    fusion_subunit #(.COL_WIDTH(COL_WIDTH))  fs1 (
        .p0(prod2),
        .p1(prod3),
        .p2(prod6),
        .p3(prod7),
        .shift(big_shift1),
        .split_column(weight_width[1] || weight_width[0]),        
        .sign(s_in | s_weight),
        .sum(sum1)
    );

    fusion_subunit #(.COL_WIDTH(COL_WIDTH))  fs2 (
        .p0(prod8),
        .p1(prod9),
        .p2(prod12),
        .p3(prod13),
        .shift(big_shift2),
        .split_column(weight_width[1] || weight_width[0]),
        .sign(s_in | s_weight),
        .sum(sum2)
    );

    fusion_subunit #(.COL_WIDTH(COL_WIDTH))  fs3 (
        .p0(prod10),
        .p1(prod11),
        .p2(prod14),
        .p3(prod15),
        .shift(big_shift3),
        .split_column(weight_width[1] || weight_width[0]),
        .sign(s_in | s_weight),
        .sum(sum3)
    );

    wire [(COL_WIDTH*4)-1:0] stotal = $signed(sum0) + $signed(sum1) + $signed(sum2) + $signed(sum3) + $signed(psum_in) ;

    always @(posedge clk) begin
        casez (weight_width)
                4'b1000: begin //8b
                            psum_fwd[(COL_WIDTH*2)-1:0] <= (s_in | s_weight) ? stotal[(COL_WIDTH*2)-1:0] : sum0 + sum1 + sum2 + sum3 + psum_in;
                            psum_fwd[(COL_WIDTH*4)-1:(COL_WIDTH*2)] <= (s_in | s_weight) ? stotal[(COL_WIDTH*4)-1:(COL_WIDTH*2)] : {(COL_WIDTH*2){1'b0}};
                        end
                4'b0100: begin //4b
                            psum_fwd[(COL_WIDTH*2)-1:0] <= sum0 + sum2 + psum_in[(COL_WIDTH*2)-1:0];
                            psum_fwd[(COL_WIDTH*4)-1:(COL_WIDTH*2)] <= sum1 + sum3 + psum_in[(COL_WIDTH*4)-1:(COL_WIDTH*2)];
                        end
                4'b00zz: begin //2b, 1b
                            psum_fwd[(COL_WIDTH)-1:0] <= sum0[(COL_WIDTH)-1:0] + sum2[(COL_WIDTH)-1:0] + psum_in[(COL_WIDTH)-1:0];
                            psum_fwd[(COL_WIDTH*2)-1:COL_WIDTH] <= sum0[(COL_WIDTH*2)-1:COL_WIDTH] + sum2[(COL_WIDTH*2)-1:COL_WIDTH] + psum_in[(COL_WIDTH*2)-1:COL_WIDTH];
                            psum_fwd[(COL_WIDTH*3)-1:COL_WIDTH*2] <= sum1[(COL_WIDTH)-1:0] + sum3[(COL_WIDTH)-1:0] + psum_in[(COL_WIDTH*3)-1:COL_WIDTH*2];
                            psum_fwd[(COL_WIDTH*4)-1:COL_WIDTH*3] <= sum1[(COL_WIDTH*2)-1:COL_WIDTH] + sum3[(COL_WIDTH*2)-1:COL_WIDTH] + psum_in[(COL_WIDTH*4)-1:COL_WIDTH*3];
                        end
        endcase        
        //psum_fwd <= sum0 + sum1 + sum2 + sum3 + psum_in;
    end
    //assign psum_fwd = sum0 + sum1 + sum2 + sum3 + psum_in;

endmodule

    
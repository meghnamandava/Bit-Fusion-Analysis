module bitbrick (
    input [1:0] x,
    input s_x,
    input [1:0] y,
    input s_y,
    input [2:0] shift,
    output [9:0] prod
    );

    wire [2:0] x1, y1;
    wire ha0_co;
    wire fa0_sum, fa0_co;
    wire ha1_co;
    wire fa1_sum, fa1_co;
    wire ha2_co;
    wire [5:0] p;
    wire fa2_sum, fa2_co;

    assign x1[1:0] = x[1:0];
    assign y1[1:0] = y[1:0];

    assign x1[2] = s_x & x[1];
    assign y1[2] = s_y & y[1];

    assign p[0] = x1[0] & y1[0];

    half_adder ha0(
        .in1(x1[1] & y1[0]), 
        .in2(x1[0] & y1[1]), 
        .sum(p[1]), 
        .carry_out(ha0_co)
        );

    full_adder fa0(
        .in1(~(x1[0] & y1[2])), 
        .in2(x1[1] & y1[1]), 
        .carry_in(ha0_co),
        .sum(fa0_sum),
        .carry_out(fa0_co)
        );



    half_adder ha1(
        .in1(fa0_sum), 
        .in2(~(x1[2] & y1[0])), 
        .sum(p[2]), 
        .carry_out(ha1_co)
        );

    full_adder fa1(
        .in1(~(x1[1] & y1[2])), 
        .in2(~(x1[2] & y1[1])), 
        .carry_in(fa0_co),
        .sum(fa1_sum),
        .carry_out(fa1_co)
        );


    full_adder ha2(
        .in1(fa1_sum), 
        .in2(ha1_co), 
        .carry_in(1'b1),
        .sum(p[3]), 
        .carry_out(ha2_co)
        );
    // half_adder ha2(
    //     .in1(fa1_sum), 
    //     .in2(ha1_co), 
    //     .sum(p[3]), 
    //     .carry_out(ha2_co)
    //     );

    full_adder fa2(
        .in1(fa1_co), 
        .in2(x1[2] & y1[2]), 
        .carry_in(ha2_co),
        .sum(p[4]),
        .carry_out(fa2_co)  
        );

    half_adder ha3(
        .in1(fa2_co),
        .in2(1'b1),
        .sum(p[5]),
        .carry_out()
    );    

    assign prod = (($signed(p) << 4) >>> 4) << shift; 
endmodule

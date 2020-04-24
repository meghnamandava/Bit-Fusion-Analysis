module half_adder (
    input in1,
    input in2,
    output sum,
    output carry_out
    );

assign sum = in1 ^ in2;
assign carry_out = in1 & in2;


endmodule
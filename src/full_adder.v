module full_adder (
    input in1,
    input in2,
    input carry_in,
    output sum,
    output carry_out
    );

wire a, b, c;

assign a = in1 ^ in2;
assign b = a & carry_in;
assign c = in1 & in2;
assign sum = a ^ carry_in;
assign carry_out = b | c;


endmodule
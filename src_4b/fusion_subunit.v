module fusion_subunit (
    input [9:0] p0,
    input [9:0] p1,
    input [9:0] p2,
    input [9:0] p3,
    input [3:0] shift,
    input sign,
    output [15:0] sum
    );

    wire [15:0] sign_shift;
    assign sign_shift = (($signed(p0) << 5) >>> 5) + 
                        (($signed(p1) << 5) >>> 5) + 
                        (($signed(p2) << 5) >>> 5) + 
                        (($signed(p3) << 5) >>> 5);
    assign sum = sign ? sign_shift << shift : (p0 + p1 + p2 + p3) << shift;

endmodule    
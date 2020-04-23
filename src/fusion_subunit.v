module fusion_subunit (
    input [9:0] p0,
    input [9:0] p1,
    input [9:0] p2,
    input [9:0] p3,
    input [3:0] shift,
    input split_column, //1 if 2bit or 1bit, 0 if 4b or 8b
    input sign,
    output [25:0] sum
    );

    //WITHOUT COLUMN ADDERS, ORIGINAL

    /*wire [15:0] sign_shift;
    assign sign_shift = (($signed(p0) << 5) >>> 5) + 
                        (($signed(p1) << 5) >>> 5) + 
                        (($signed(p2) << 5) >>> 5) + 
                        (($signed(p3) << 5) >>> 5);
    assign sum = sign ? sign_shift << shift : (p0 + p1 + p2 + p3) << shift;*/

    // WITH COLUMN ADDERS

    wire [12:0] col1, col2;
    wire [15:0] total;
    assign col1 = sign ? (($signed(p0) << 3) >>> 3) + (($signed(p2) << 3) >>> 3) : p0 + p2;
    assign col2 = sign ? (($signed(p1) << 3) >>> 3) + (($signed(p3) << 3) >>> 3) : p1 + p3;
    assign total = sign ? (($signed(col1) << 3) >>> 3) + (($signed(col2) << 3) >>> 3) : col1 + col2;
    assign sum = split_column ? {col2, col1} : total << shift;

    // for 2bit: p0+p2, p1+p3
    // 4bit & 8 bit: nothing

endmodule    
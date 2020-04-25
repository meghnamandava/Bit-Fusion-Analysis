module fusion_subunit #(parameter COL_WIDTH=13) (
    input [9:0] p0,
    input [9:0] p1,
    input [9:0] p2,
    input [9:0] p3,
    input [3:0] shift,
    input split_column, //1 if 2bit or 1bit, 0 if 4b or 8b
    input sign,
    output [(COL_WIDTH*2)-1:0] sum
    );

    //WITHOUT COLUMN ADDERS, ORIGINAL

    /*wire [15:0] sign_shift;
    assign sign_shift = (($signed(p0) << 5) >>> 5) + 
                        (($signed(p1) << 5) >>> 5) + 
                        (($signed(p2) << 5) >>> 5) + 
                        (($signed(p3) << 5) >>> 5);
    assign sum = sign ? sign_shift << shift : (p0 + p1 + p2 + p3) << shift;*/

    // WITH COLUMN ADDERS

    wire [COL_WIDTH-1:0] col1, col2;
    wire [(COL_WIDTH*2)-1:0] total;
    wire [(COL_WIDTH*2)-1:0] stotal = $signed(col1)+$signed(col2);//(($signed(col1) << 13) >>> 13) + (($signed(col2) << 13) >>> 13);
    wire [COL_WIDTH-1:0] scol1 = $signed(p0)+$signed(p2);//(($signed(p0) << 2) >>> 2) + (($signed(p2) << 2) >>> 2);
    wire [COL_WIDTH-1:0] scol2 = $signed(p1)+$signed(p3);//(($signed(p1) << 2) >>> 2) + (($signed(p3) << 2) >>> 2);
    assign col1 = sign ? scol1 : p0 + p2;
    assign col2 = sign ? scol2 : p1 + p3;
    assign total = sign ? stotal : col1 + col2;
    assign sum = split_column ? {col2, col1} : total << shift;

    // for 2bit: p0+p2, p1+p3
    // 4bit & 8 bit: nothing

endmodule    
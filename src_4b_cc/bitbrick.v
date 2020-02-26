module bitbrick (
    input [1:0] x,
    input s_x,
    input [1:0] y,
    input s_y,
    input [2:0] shift,
    output [9:0] prod
    );

    wire [2:0] x1, y1;
    wire [5:0] p0, p1, p2;
    wire [5:0] p3 = 6'b101000;
    wire [5:0] p;
    

    assign x1[1:0] = x[1:0];
    assign y1[1:0] = y[1:0];

    assign x1[2] = s_x & x[1];
    assign y1[2] = s_y & y[1];

    assign p0 = {~(y1[0] & x1[2]), y1[0] & x1[1], y1[0] & x1[0]};
    assign p1 = {~(y1[1] & x1[2]), y1[1] & x1[1], y1[1] & x1[0]} << 1;
    assign p2 = {y1[2] & x1[2], ~(y1[2] & x1[1]), ~(y1[2] & x1[0]) } << 2;

    assign p = p0 + p1 + p2 + p3;    

    assign prod = (($signed(p) << 4) >>> 4) << shift; 
endmodule

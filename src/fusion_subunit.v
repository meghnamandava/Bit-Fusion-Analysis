module fusion_subunit (
    input [9:0] prod0,
    input [9:0] prod1,
    input [9:0] prod2,
    input [9:0] prod3,
    input [3:0] shift,
    output [15:0] sum
    );

    
    assign sum = (prod0 + prod1 + prod2 + prod3) << shift;

endmodule    
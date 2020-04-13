`timescale 1ns/1ns

module systolic_array #(parameter ARRAY_SIZE=8) 
    (
        input clk,
        //input rst,

        /* Control */ 

        input [3:0] in_width,
        input [3:0] weight_width,
        input s_in,
        input s_weight,

        /* Inputs */ 

        input [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights,
        input [ARRAY_SIZE-1:0] [7:0] inputs,

        /* Outputs */

        output reg [ARRAY_SIZE-1:0] [31:0] psums 
    );

    wire [(ARRAY_SIZE*(ARRAY_SIZE+1))-1:0] [31:0] psum_fwds;

    genvar i;
    genvar j;

    /*// Zero out psums if reset 
    generate 
        for (i=0; i<(ARRAY_SIZE*(ARRAY_SIZE+1)); i=i+1) begin: reset
            always @(posedge clk) begin
                if (rst) begin
                    psum_fwds[i] <= 0;
                end   
            end 
        end
    endgenerate*/

    // Set psums output to the last row 
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: last_psum_row
            always @(posedge clk) begin
                psums[i] <= psum_fwds[(ARRAY_SIZE*ARRAY_SIZE)+i];
            end
        end
    endgenerate

    // Psum_in for top row of fusion units should zero
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: first_psum_row
            assign psum_fwds[i] = 32'b0;
        end
    endgenerate

    generate 
        for (i=1; i<=ARRAY_SIZE; i=i+1) begin: rows
            for (j=1; j<ARRAY_SIZE; j=j+1) begin: columns
                fusion_unit fu (
                    .in(inputs[i-1]),
                    .weight(weights[(i*j)-1]),
                    .psum_in(psum_fwds[(i*j)-1]),
                    .in_width(in_width),
                    .weight_width(weight_width),
                    .s_in(s_in),
                    .s_weight(s_weight),
                    .psum_fwd(psum_fwds[((i+1)*j)-1])
                );
            end
        end 
    endgenerate

endmodule    








`timescale 1ns/1ns

module systolic_array #(parameter ARRAY_SIZE=8, parameter LOG_ARRAY_SIZE=3) 
    (
        /* Inputs */
        clk,
        in_width,
        weight_width,
        s_in,
        s_weight,
        weights,
        inputs,

        /* Outputs */
        psums 

    );

    localparam COL_WIDTH = 10+LOG_ARRAY_SIZE;

    input clk,

    /* Control */ 

    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,

    /* Inputs */ 

    input [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights,
    input [ARRAY_SIZE-1:0] [7:0] inputs,

    /* Outputs */

    output [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] psums 

    wire [(ARRAY_SIZE*(ARRAY_SIZE+1))-1:0] [(COL_WIDTH*4)-1:0] psum_fwds;

    genvar i;
    genvar j;


    // Set psums output to the last row 
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: last_psum_row
            assign psums[i] = psum_fwds[(ARRAY_SIZE*ARRAY_SIZE)+i];
        end
    endgenerate

    // Psum_in for top row of fusion units should be zero
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: first_psum_row
            assign psum_fwds[i] = {(COL_WIDTH*4){1'b0}};
        end
    endgenerate

    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: rows
            for (j=0; j<ARRAY_SIZE; j=j+1) begin: columns
                fusion_unit #(.COL_WIDTH(COL_WIDTH)) fu (
                    .clk(clk),
                    .in(inputs[i]),
                    .weight(weights[(i*ARRAY_SIZE)+j]),
                    .psum_in(psum_fwds[(i*ARRAY_SIZE)+j]),
                    .in_width(in_width),
                    .weight_width(weight_width),
                    .s_in(s_in),
                    .s_weight(s_weight),
                    .psum_fwd(psum_fwds[((i+1)*ARRAY_SIZE)+j])
                );
            end
        end 
    endgenerate

endmodule    








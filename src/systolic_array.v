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

        //`ifdef IVERILOG
        input [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights,
        input [ARRAY_SIZE-1:0] [7:0] inputs,
        //`endif

        // `ifndef IVERILOG
        // input [7:0] weights [(ARRAY_SIZE*ARRAY_SIZE)-1:0],
        // input [7:0] inputs [ARRAY_SIZE-1:0],
        // `endif

        /* Outputs */

        //`ifdef IVERILOG
        output [ARRAY_SIZE-1:0] [51:0] psums 
        //`endif

        // `ifndef IVERILOG
        // output reg [31:0] psums [ARRAY_SIZE-1:0] 
        // `endif
    );

    //`ifdef IVERILOG
    wire [(ARRAY_SIZE*(ARRAY_SIZE+1))-1:0] [51:0] psum_fwds;
    //`endif

    // `ifndef IVERILOG
    // wire [31:0] psum_fwds [(ARRAY_SIZE*(ARRAY_SIZE+1))-1:0];
    // `endif
    
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
            assign psums[i] = psum_fwds[(ARRAY_SIZE*ARRAY_SIZE)+i];
        end
    endgenerate

    // Psum_in for top row of fusion units should zero
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: first_psum_row
            assign psum_fwds[i] = 52'b0;
        end
    endgenerate

    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: rows
            for (j=0; j<ARRAY_SIZE; j=j+1) begin: columns
                fusion_unit fu (
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








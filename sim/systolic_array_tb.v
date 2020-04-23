`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000
`define CLOCKS_PER_SAMPLE 2500

module systolic_array_tb #(parameter ARRAY_SIZE=8) ();

    reg clk;
    initial clk = 0;
    always #(5) clk <= ~clk;

    reg [7:0] weights_mem [(8*ARRAY_SIZE)-1:0];
    reg [7:0] inputs_mem [(8*ARRAY_SIZE)-1:0];

    //`ifdef IVERILOG
    wire [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights;
    wire [ARRAY_SIZE-1:0] [7:0] inputs;
    wire [ARRAY_SIZE-1:0] [31:0] psums;
    //`endif

    // `ifndef IVERILOG
    // reg [7:0] weights [(ARRAY_SIZE*ARRAY_SIZE)-1:0];
    // reg [7:0] inputs [ARRAY_SIZE-1:0];
    // wire [31:0] psums [ARRAY_SIZE-1:0];
    // `endif

    reg rst;
    reg [3:0] in_width;
    reg [3:0] weight_width;
    reg s_in;
    reg s_weight;
    genvar i;
    generate 
        for (i=0; i<ARRAY_SIZE*ARRAY_SIZE; i=i+1) begin: load_weights
           assign weights[i] = weights_mem[i];
        end
    endgenerate
    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: load_inputs
           assign inputs[i] = inputs_mem[i];
        end
    endgenerate
    //assign inputs = {56'b0, 8'b1};


    systolic_array sa0(
        .clk(clk),
        //.rst(rst),
        .in_width(in_width),
        .weight_width(weight_width),
        .s_in(s_in),
        .s_weight(s_weight),
        .weights(weights),
        .inputs(inputs),
        .psums(psums)
    );

    initial begin
        //$vcdpluson;
        `ifdef IVERILOG
            $dumpfile("systolic_array_tb.fst");
            $dumpvars(0,systolic_array_tb);
        `endif

        #20
        @ (posedge clk);
        in_width = 8;
        weight_width = 8;
        s_weight = 0;
        s_in = 0;
        
        rst = 1;
        repeat (5) @(posedge clk); #1;             // Hold reset for 30 cycles
        rst = 0;
        $readmemh("../inputs.hex", inputs_mem, 0);
        $readmemh("../weights.hex", weights_mem, 0);

        /*`ifdef IVERILOG
        weights = {weights_mem[0],weights_mem[1],weights_mem[2],weights_mem[3],weights_mem[4],weights_mem[5],weights_mem[6],weights_mem[7]};
        inputs = inputs_mem[0];
        `endif*/

        $display("Weights: %d", weights[0]);
        $display("Inputs: %d %d", inputs[0], inputs[1]);
        repeat (10) @(posedge clk); #1;
        $display("Matrix row: %h", psums);

        $finish();
        //$vcdplusoff;
    end

endmodule

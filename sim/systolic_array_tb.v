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

    `ifdef IVERILOG
    reg [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights;
    reg [ARRAY_SIZE-1:0] [7:0] inputs;
    wire [ARRAY_SIZE-1:0] [31:0] psums;
    `endif

    `ifndef IVERILOG
    reg [7:0] weights [(ARRAY_SIZE*ARRAY_SIZE)-1:0];
    reg [7:0] inputs [ARRAY_SIZE-1:0];
    wire [31:0] psums [ARRAY_SIZE-1:0];
    `endif

    reg rst;
    reg [3:0] in_width;
    reg [3:0] weight_width;
    reg s_in;
    reg s_weight;
    integer i;
    integer j;
    integer a;

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
        in_width = 1;
        weight_width = 1;
        s_weight = 0;
        s_in = 0;
        
        rst = 1;
        repeat (30) @(posedge clk); #1;             // Hold reset for 30 cycles
        rst = 0;
        $readmemh("../inputs.hex", inputs_mem);
        $readmemh("../weights.hex", weights_mem);

        `ifdef IVERILOG
        weights = {weights_mem[0],weights_mem[1],weights_mem[2],weights_mem[3],weights_mem[4],weights_mem[5],weights_mem[6],weights_mem[7]};
        inputs = inputs_mem[0];
        `endif

        `ifndef IVERILOG
        weights = weights_mem;
        inputs = inputs_mem[0];
        `endif

        $display("Weights: %h", weights);
        $display("Inputs: %h", inputs[0]);
        @(posedge clk); #1;
        $display("Matrix row: %d", psums);


        $finish();
        //$vcdplusoff;
    end

endmodule

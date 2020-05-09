`timescale 1ns/1ns

`define SECOND 1000000000
`define MS 1000000
`define CLOCKS_PER_SAMPLE 2500

module accelerator_tb #(parameter ARRAY_SIZE=8, parameter LOG_ARRAY_SIZE=3) ();

    reg clk;
    initial clk = 1;
    always #(1) clk <= ~clk;

    localparam COL_WIDTH = 10+LOG_ARRAY_SIZE;

    reg [(ARRAY_SIZE*8)-1:0] weights_mem [ARRAY_SIZE-1:0];
    reg [(ARRAY_SIZE*8)-1:0] inputs_mem [ARRAY_SIZE-1:0];

    reg [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] weights;
    reg [ARRAY_SIZE-1:0] [7:0]  inputs;
    wire [ARRAY_SIZE-1:0] [51:0] psums;
    wire [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] obuf_out;

    reg rst;
    reg [3:0] in_width;
    reg [3:0] weight_width;
    reg s_in;
    reg s_weight;
    reg write_w;
    reg write_in;
    reg read_w;
    reg read_in;
    reg read_o;
    wire [63:0] cycle_count;


    accelerator acc(
        .clk(clk),
        .rst(rst),
        .in_width(in_width),
        .weight_width(weight_width),
        .s_in(s_in),
        .s_weight(s_weight),
        .wbuf_in(weights),
        .write_w(write_w),
        .ibuf_in(inputs),
        .write_in(write_in),
        .read_w(read_w),
        .read_in(read_in),
        .read_o(read_o),
        .cycle_count(cycle_count),
        .obuf_out(obuf_out)

    );

    initial begin
        //$vcdpluson;
        `ifdef IVERILOG
            $dumpfile("accelerator_tb.fst");
            $dumpvars(0,accelerator_tb);
        `endif

        #20
        @ (posedge clk);
        in_width = 8;
        weight_width = 8;
        s_weight = 0;
        s_in = 0;
        
        rst = 1;
        repeat (6) @(posedge clk); #2;  
        rst = 0;
        $readmemh("../inputs.hex", inputs_mem, 0);
        $readmemh("../weights.hex", weights_mem, 0);
        read_o = 0;
        read_w = 0;
        read_in = 0;
        write_w = 1;
        weights = {weights_mem[0], weights_mem[1], weights_mem[2], weights_mem[3], weights_mem[4], weights_mem[5], weights_mem[6], weights_mem[7]};
        write_in = 1;
        inputs = inputs_mem[0];
        #2;
        write_w = 0;
        write_in = 1;
        inputs = inputs_mem[1];
        #2;
        write_in = 1;
        inputs = inputs_mem[2];
        #2;
        write_in = 1;
        inputs = inputs_mem[3];
        #2;
        write_in = 1;
        inputs = inputs_mem[4];
        #2;
        write_in = 1;
        inputs = inputs_mem[5];
        #2;
        write_in = 1;
        inputs = inputs_mem[6];
        #2;
        write_in = 1;
        inputs = inputs_mem[7];
        #2;
        write_in = 0;
        read_in = 1;
        read_w = 1;
        #2;
        read_w = 0;
        #16;
        read_o = 1;
        $display("Matrix row: %h", obuf_out);
        #2;
        read_o = 1;
        $display("Matrix row: %h", obuf_out);
        

 

        //$display("Weights: %d", weights[0]);
        //$display("Inputs: %d %d", inputs[0], inputs[1]);
        repeat (10) @(posedge clk); #1;
        //$display("Matrix row: %h", acc.obuf.mem[0]);

        $finish();
        //$vcdplusoff;
    end

endmodule

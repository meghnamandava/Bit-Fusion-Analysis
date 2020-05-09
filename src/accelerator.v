`timescale 1ns/1ns

module accelerator #(parameter ARRAY_SIZE=8, parameter LOG_ARRAY_SIZE=3) 
    (
    input clk, 
    input rst,
    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,
    input [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] wbuf_in,
    input write_w,
    input [ARRAY_SIZE-1:0] [7:0] ibuf_in,
    input write_in,
    input read_w,
    input read_in,
    input read_o,
    output reg [63:0] cycle_count,
    output [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] obuf_out

    );

    localparam LOG_DEPTH = 5; //buffer depth
    localparam COL_WIDTH = 10+LOG_ARRAY_SIZE;
 

    reg[LOG_ARRAY_SIZE-1:0] ctr;

    wire write_o;

    wire read_in, read_w, read_o;

    reg [LOG_DEPTH-1:0] in_addr_read, w_addr_read, o_addr_read;
    reg [LOG_DEPTH-1:0] in_addr_write, w_addr_write, o_addr_write;

    wire [LOG_DEPTH-1:0] in_addr, w_addr, o_addr;

    wire [ARRAY_SIZE-1:0] [7:0] ibuf_out;
    wire [(ARRAY_SIZE*ARRAY_SIZE)-1:0] [7:0] wbuf_out;
    wire [ARRAY_SIZE-1:0] [(COL_WIDTH*4)-1:0] obuf_in; 

    //cycle counter
    always @(posedge clk) begin
        if (rst) begin
            cycle_count <= 0;
        end
        else begin
            cycle_count <= cycle_count + 1;
        end
    end

    //buffer control counter
    always @(posedge clk) begin
        if (rst) begin
            ctr <= 0;
        end
        else begin
            ctr <= (ctr == {LOG_ARRAY_SIZE{1'b1}}) ? 0 : ctr + 1;
        end
    end

    //buffer read/write enables and addresses
    //assign read_in = 1;//(ctr == 0) ? 1 : 0;
    //assign read_w = (ctr == 0) ? 1 : 0;
    //assign read_o = 0; // TODO
    assign write_o = 1;
    assign in_addr = (read_in == 1) ? in_addr_read : in_addr_write;
    assign w_addr = (read_w == 1) ? w_addr_read : w_addr_write;
    assign o_addr = (read_o == 1) ? o_addr_read : o_addr_write;

    always @(posedge clk) begin
        if (read_in == 1) begin
            in_addr_read <= (in_addr_read == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : in_addr_read + 1;
        end 
        if (read_w == 1) begin
            w_addr_read <= (w_addr_read == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : w_addr_read + 1;
        end
        if (read_o == 1) begin
            o_addr_read <= (o_addr_read == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : o_addr_read + 1;
        end
        if (write_in == 1) begin
            in_addr_write <= (in_addr_write == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : in_addr_write + 1;
        end  
        if (write_w == 1) begin
            w_addr_write <= (w_addr_write == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : w_addr_write + 1;
        end
        if (write_o == 1) begin
            o_addr_write <= (o_addr_write == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : o_addr_write + 1;
        end 
        if (rst) begin
            w_addr_read <= {LOG_DEPTH{1'b0}};
            in_addr_read <= {LOG_DEPTH{1'b0}};
            o_addr_read <= {LOG_DEPTH{1'b0}};
            w_addr_write <= {LOG_DEPTH{1'b0}};
            in_addr_write <= {LOG_DEPTH{1'b0}};
            o_addr_write <= {LOG_DEPTH{1'b0}};            
        end 
    end

    ibuf #(.WIDTH(8*ARRAY_SIZE)) ibuf (
        .clk(clk),
        .en(read_in),
        .we(write_in),
        .addr(in_addr),
        .din(ibuf_in),
        .dout(ibuf_out)
    );

    mem #(.WIDTH(8*ARRAY_SIZE*ARRAY_SIZE)) wbuf (
        .clk(clk),
        .en(read_w),
        .we(write_w),
        .addr(w_addr),
        .din(wbuf_in),
        .dout(wbuf_out)
    );

    // output bus size 52 bits per column
    mem #(.WIDTH(COL_WIDTH*4*ARRAY_SIZE)) obuf ( 
        .clk(clk),
        .en(read_o),
        .we(write_o),
        .addr(o_addr),
        .din(obuf_in),
        .dout(obuf_out)
    );

    systolic_array sa (
        .clk(clk),
        .in_width(in_width),
        .weight_width(weight_width),
        .s_in(s_in),
        .s_weight(s_weight),
        .weights(wbuf_out),
        .inputs(ibuf_out),
        .psums(obuf_in) 
    );

endmodule    
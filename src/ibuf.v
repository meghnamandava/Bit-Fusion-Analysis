module ibuf #(parameter DEPTH = 32, parameter LOG_DEPTH = 5, parameter WIDTH = 8, parameter ARRAY_SIZE=8) (
    input clk,
    input en,
    input we,
    input [LOG_DEPTH-1:0] addr,
    input [WIDTH-1:0] din,
    output [WIDTH-1:0] dout
    );
    
    wire [ARRAY_SIZE-1:0] [LOG_DEPTH-1:0] in_addr_w;
    wire [ARRAY_SIZE-1:0] [LOG_DEPTH-1:0] in_addr;

    genvar i;

    generate 
        for (i=0; i<ARRAY_SIZE; i=i+1) begin: rows
            assign in_addr_w[i] = (addr + i == {LOG_DEPTH{1'b1}}) ? {LOG_DEPTH{1'b0}} : addr + i;
            assign in_addr[i] = we ? in_addr_w[i] : addr;
            mem ibuf_row (
                .clk(clk),
                .en(en),
                .we(we),
                .addr(in_addr[i]),
                .din(din[((i+1)*8)-1:i*8]),
                .dout(dout[((i+1)*8)-1:i*8])
            );
        end 
    endgenerate


endmodule
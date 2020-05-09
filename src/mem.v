module mem #(parameter DEPTH = 32, parameter LOG_DEPTH = 5, parameter WIDTH = 8) (
    input clk,
    input en,
    input we,
    input [LOG_DEPTH-1:0] addr,
    input [WIDTH-1:0] din,
    output reg [WIDTH-1:0] dout
    );
    
    reg [WIDTH-1:0] mem [DEPTH-1:0];

    always @(posedge clk) begin
        if (en)
            dout <= mem[addr];
    end

    always @(posedge clk) begin
        if (we)
            mem[addr] <= din;
    end

endmodule
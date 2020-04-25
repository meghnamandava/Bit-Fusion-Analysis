module fixed2 #(parameter COL_WIDTH=11) (
    input clk,
    input [7:0] in,
    input [1:0] weight,
    input [COL_WIDTH-1:0] psum_in,
    input s_in,
    input s_weight,
    output reg [COL_WIDTH-1:0] psum_fwd
    );

    always @(posedge clk) begin
        if (s_in == 1'b1 && s_weight == 1'b1) begin
            psum_fwd <= ($signed(in) * $signed(weight)) + psum_in;
        end else if (s_in == 1'b1 && s_weight == 1'b0) begin
            psum_fwd <= ($signed(in) * weight) + psum_in;
        end else if (s_in == 1'b0 && s_weight == 1'b1) begin
            psum_fwd <= (in * $signed(weight)) + psum_in;
        end else if (s_in == 1'b0 && s_weight== 1'b0) begin
            psum_fwd <= (in * weight) + psum_in;
        end
    end    


endmodule

    
module fusion_unit (
    input clk,
    input [7:0] in,
    input [7:0] weight,
    input s_in,
    input s_weight,
    output reg [18:0] psum_fwd
    );

    always @(posedge clk) begin
        if (s_in == 1'b1 && s_weight == 1'b1) begin
            psum_fwd <= $signed(in) * $signed(weight);
        end else if (s_in == 1'b1 && s_weight == 1'b0) begin
            psum_fwd <= $signed(in) * weight;
        end else if (s_in == 1'b0 && s_weight == 1'b1) begin
            psum_fwd <= in * $signed(weight);
        end else if (s_in == 1'b0 && s_weight== 1'b0) begin
            psum_fwd <= in * weight;
        end
    end    


endmodule

    
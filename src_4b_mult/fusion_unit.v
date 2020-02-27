module fusion_unit (
    input clk,
    input [3:0] in,
    input [3:0] weight,
    input s_in,
    input s_weight,
    output reg [7:0] psum_fwd
    );

    reg [3:0] in_reg;
    reg [3:0] weight_reg;
    reg s_in_reg;
    reg s_weight_reg;

    always @(posedge clk) begin
        in_reg <= in;
        weight_reg <= weight;
        s_in_reg <= s_in;
        s_weight_reg <= s_weight;
        if (s_in_reg == 1'b1 && s_weight_reg == 1'b1) begin
            psum_fwd <= $signed(in_reg) * $signed(weight_reg);
        end else if (s_in_reg == 1'b1 && s_weight_reg == 1'b0) begin
            psum_fwd <= $signed(in_reg) * weight_reg;
        end else if (s_in_reg == 1'b0 && s_weight_reg == 1'b1) begin
            psum_fwd <= in_reg * $signed(weight_reg);
        end else if (s_in_reg == 1'b0 && s_weight_reg == 1'b0) begin
            psum_fwd <= in_reg * weight_reg;
        end
    end    


endmodule

    
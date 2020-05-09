module fixed2 #(parameter COL_WIDTH=11) (
    input [7:0] in,
    input [7:0] weight,
    input [COL_WIDTH-1:0] psum_in,
    input s_in,
    input s_weight,
    output reg [COL_WIDTH-1:0] psum_fwd
    );

    always @(*) begin
        if (s_in == 1'b1 && s_weight == 1'b1) begin
            psum_fwd <= ($signed(in[7:6]) * $signed(weight[7:6])) +
                        ($signed(in[5:4]) * $signed(weight[5:4])) +
                        ($signed(in[3:2]) * $signed(weight[3:2])) + 
                        ($signed(in[1:0]) * $signed(weight[1:0])) + psum_in;
        end else if (s_in == 1'b1 && s_weight == 1'b0) begin
            psum_fwd <= ($signed(in[7:6]) * weight[7:6]) + 
                        ($signed(in[5:4]) * weight[5:4]) + 
                        ($signed(in[3:2]) * weight[3:2]) + 
                        ($signed(in[1:0]) * weight[1:0]) + psum_in;
        end else if (s_in == 1'b0 && s_weight == 1'b1) begin
            psum_fwd <= (in[7:6] * $signed(weight[7:6])) +
                        (in[5:4] * $signed(weight[5:4])) +
                        (in[3:2] * $signed(weight[3:2])) +
                        (in[1:0] * $signed(weight[1:0])) + psum_in;
        end else if (s_in == 1'b0 && s_weight== 1'b0) begin
            psum_fwd <= (in[7:6] * weight[7:6]) +
                        (in[5:4] * weight[5:4]) +
                        (in[3:2] * weight[3:2]) +
                        (in[1:0] * weight[1:0]) + psum_in;
        end
    end    


endmodule

    
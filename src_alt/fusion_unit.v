module fusion_unit #(parameter COL_WIDTH=13) (

    input clk,
    input [7:0] in,
    input [7:0] weight,
    input [(COL_WIDTH*4)-1:0] psum_in,
    input [3:0] in_width,
    input [3:0] weight_width,
    input s_in,
    input s_weight,
    output reg [(COL_WIDTH*4)-1:0] psum_fwd //max widths for 2b parallelism
    );

    reg [(COL_WIDTH*4)-1:0] psum_temp;
    wire [(COL_WIDTH*4)-1:0] signed_temp;

    always @(*) begin

        casez ({in_width, weight_width})
            8'b00zz0100: begin //1x4, 2x4
                        psum_temp[(COL_WIDTH*2)-1:0] <= (in[1:0]+in[3:2]+in[5:4]+in[7:6])*weight[3:0];
                        psum_temp[(COL_WIDTH*4)-1:(COL_WIDTH*2)] <= (in[1:0]+in[3:2]+in[5:4]+in[7:6])*weight[7:4];
                        end
            8'b00zz1000: begin //1x8, 2x8
                        psum_temp <= (in[1:0]+in[3:2]+in[5:4]+in[7:6])*weight;
                        end
            8'b010000zz: begin //4x1, 4x2
                        psum_temp[(COL_WIDTH)-1:0] <= weight[1:0]*(in[3:0]+in[7:4]);
                        psum_temp[(COL_WIDTH*2)-1:COL_WIDTH] <= weight[3:2]*(in[3:0]+in[7:4]);
                        psum_temp[(COL_WIDTH*3)-1:COL_WIDTH*2] <= weight[5:4]*(in[3:0]+in[7:4]);
                        psum_temp[(COL_WIDTH*4)-1:COL_WIDTH*3] <= weight[7:6]*(in[3:0]+in[7:4]);
                        end
            8'b100000zz: begin //8x1, 8x2 
                        psum_temp[(COL_WIDTH)-1:0] <= weight[1:0]*in;
                        psum_temp[(COL_WIDTH*2)-1:COL_WIDTH] <= weight[3:2]*in;
                        psum_temp[(COL_WIDTH*3)-1:COL_WIDTH*2] <= weight[5:4]*in;
                        psum_temp[(COL_WIDTH*4)-1:COL_WIDTH*3] <= weight[7:6]*in;
                        end
            8'b01000100: begin //4x4 
                        psum_temp[(COL_WIDTH*2)-1:0] <= (in[3:0]+in[7:4])*weight[3:0];
                        psum_temp[(COL_WIDTH*4)-1:(COL_WIDTH*2)] <= (in[3:0]+in[7:4])*weight[7:4];
                        end      
            8'b01001000: begin //4x8
                        psum_temp <= (in[3:0]+in[7:4])*weight;
                        end                             
            8'b10000100: begin //8x4
                        psum_temp[(COL_WIDTH*2)-1:0] <= in*weight[3:0];
                        psum_temp[(COL_WIDTH*4)-1:(COL_WIDTH*2)] <= in*weight[7:4];
                        end               
            8'b10001000: begin //8x8 
                        psum_temp <= in*weight;
                        end   
            default: begin
                        psum_temp[(COL_WIDTH)-1:0] <= weight[1:0]*(in[1:0]+in[3:2]+in[5:4]+in[7:6]);
                        psum_temp[(COL_WIDTH*2)-1:COL_WIDTH] <= weight[3:2]*(in[1:0]+in[3:2]+in[5:4]+in[7:6]);
                        psum_temp[(COL_WIDTH*3)-1:COL_WIDTH*2] <= weight[5:4]*(in[1:0]+in[3:2]+in[5:4]+in[7:6]);
                        psum_temp[(COL_WIDTH*4)-1:COL_WIDTH*3] <= weight[7:6]*(in[1:0]+in[3:2]+in[5:4]+in[7:6]);
                    end
        endcase

    end

    always @(posedge clk) begin
        psum_fwd <= psum_temp;
    end
    //assign psum_fwd = sum0 + sum1 + sum2 + sum3 + psum_in;

endmodule

    
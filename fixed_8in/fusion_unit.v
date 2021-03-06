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

    wire [(COL_WIDTH*4)-1:0] sum8, sum4, sum2;
    
    fixed8 #(.COL_WIDTH(13)) fixed8(
        .in(in),
        .weight(weight),
        .psum_in(psum_in),
        .s_in(s_in),
        .s_weight(s_weight),
        .psum_fwd(sum8)
        );

    genvar i;

    generate 
        for (i=0; i<4; i=i+1) begin: bit2
            fixed2 #(.COL_WIDTH(COL_WIDTH)) fixed2(
                .in(in),
                .weight(weight[(i*2)+1:i*2]),
                .psum_in(psum_in[(COL_WIDTH*(i+1))-1:COL_WIDTH*i]),
                .s_in(s_in),
                .s_weight(s_weight),
                .psum_fwd(sum2[(COL_WIDTH*(i+1))-1:COL_WIDTH*i])
            );
        end     
    endgenerate     

    generate 
        for (i=0; i<2; i=i+1) begin: bit4
            fixed4 #(.COL_WIDTH(COL_WIDTH)) fixed4(
                .in(in),
                .weight(weight[(i*4)+3:i*4]),
                .psum_in(psum_in[(COL_WIDTH*(i+1)*2)-1:COL_WIDTH*i*2]),
                .s_in(s_in),
                .s_weight(s_weight),
                .psum_fwd(sum4[(COL_WIDTH*(i+1)*2)-1:COL_WIDTH*i*2])
            );
        end    
    endgenerate 

    always@(posedge clk) begin
        if (weight_width == 4'b1000) begin
            psum_fwd <= sum8;
            end
        if (weight_width == 4'b0100) begin 
            psum_fwd <= sum4;
            end
        if (weight_width == 4'b0010 | in_width == 4'b0001) begin
            psum_fwd <= sum2;
            end
    end

endmodule

    
module fusion_unit #(parameter COL_WIDTH=11) (

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
    
    fixed8 #(.COL_WIDTH(11)) fixed8(
        .clk(clk),
        .in(in),
        .weight(weight),
        .psum_in(psum_in),
        .s_in(s_in),
        .s_weight(s_weight),
        .psum_fwd(sum8)
        );

    genvar i;

    generate 
        for (i=0; i<4; i=i+1) begin: rows
            fixed2 #(.COL_WIDTH(11)) fixed2(
                .clk(clk),
                .in(in[1:0]+in[3:2]+in[5:4]+in[7:6]),
                .weight(weight[(i*2)+1:i*2]),
                .psum_in(psum_in[(COL_WIDTH*(i+1))-1:COL_WIDTH*i]),
                .s_in(s_in),
                .s_weight(s_weight),
                .psum_fwd(sum2[(COL_WIDTH*(i+1))-1:COL_WIDTH*i])
            );
    end     

    generate 
        for (i=0; i<2; i=i+1) begin: rows
            fixed4 #(.COL_WIDTH(11)) fixed4(
                .clk(clk),
                .in(in[3:0]+in[7:4]),
                .weight(weight[(i*4)+3:i*4]),
                .psum_in(psum_in[(COL_WIDTH*(i+1)*2)-1:COL_WIDTH*i*2]),
                .s_in(s_in),
                .s_weight(s_weight),
                .psum_fwd(sum4[(COL_WIDTH*(i+1)*2)-1:COL_WIDTH*i*2])
            );
    end 

    always@(posedge clk) begin
        if (in_width == 4'b1000) begin
            psum_fwd <= sum8;
            end
        if (in_width == 4'b0100) begin 
            psum_fwd <= sum4;
            end
        if (in_width == 4'b0010 | in_width == 4'b0001) begin
            psum_fwd <= sum2;
            end
    end

endmodule

    
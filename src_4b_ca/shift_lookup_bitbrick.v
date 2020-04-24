module shift_lookup (
    input [2:0] in_width,
    input [2:0] weight_width,
    output reg [5:0] row0,
    output reg [5:0] row1
    );

    always @(*) begin

        casez ({weight_width, in_width})
            6'b0zz100: begin
                        row0 = 6'b0;              //1x4, 2x4
                        row1 = 6'b010010;
                        end
            6'b1000zz: 
                        begin
                        row0 = 6'b010000;  //4x1, 4x2
                        row1 = 6'b010000;
                        end
            6'b100100: begin
                        row0 = 6'b010000;  //4x4
                        row1 = 6'b100010; 
                        end                    
            default: begin
                    row0 = 6'b0; 
                    row1 = 6'b0;
                    end
        endcase
    end

endmodule    
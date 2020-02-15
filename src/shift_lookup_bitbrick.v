module shift_lookup (
    input [3:0] in_width,
    input [3:0] weight_width,
    output reg [11:0] row0,
    output reg [11:0] row1,
    output reg [11:0] row2,
    output reg [11:0] row3,
    output reg [15:0] big_shift
    );

    always @(*) begin

        casez ({weight_width, in_width})
            8'b00zz0100: begin
                        row0 = 12'b0;              //1x4, 2x4
                        row1 = 12'b010010010010;
                        row2 = 12'b0;
                        row3 = 12'b010010010010;
                        end
            8'b00zz1000: begin
                        row0 = 12'b0;             //1x8, 2x8
                        row1 = 12'b010010010010;
                        row2 = 12'b100100100100;
                        row3 = 12'b110110110110;
                        end
            8'b010000zz: 
                        begin
                        row0 = 12'b010000010000;  //4x1, 4x2
                        row1 = 12'b010000010000;
                        row2 = 12'b010000010000;
                        row3 = 12'b010000010000;
                        end
            8'b100000zz: begin
                        row0 = 12'b110100010000;  //8x1, 8x2 
                        row1 = 12'b110100010000;   
                        row2 = 12'b110100010000;   
                        row3 = 12'b110100010000;
                        end
            8'bzz00zz00: begin
                        row0 = 12'b010000010000;  //4x4, 4x8, 8x4, 8x8 
                        row1 = 12'b100010100010;
                        row2 = 12'b010000010000; 
                        row3 = 12'b100010100010;   
                        end                    
            default: begin
                    row0 = 12'b0; 
                    row1 = 12'b0;
                    row2 = 12'b0;
                    row3 = 12'b0;
                    end
        endcase


        case ({weight_width, in_width}) 
            8'b01001000: big_shift = 16'b0100010000000000; //4x8
            8'b10000100: big_shift = 16'b0100000001000000; //8x4
            8'b10001000: big_shift = 16'b1000010001000000; //8x8                      
            default: big_shift = 16'b0;
        endcase

    end

endmodule    
module sign_lookup (
    input [3:0] in_width,
    input [3:0] weight_width,
    output reg [3:0] in_signed,
    output reg [3:0] weight_signed
    );

    always @(*) begin
        case (in_width)
            4'b0001,
            4'b0010: in_signed = 4'b1111;
            4'b0100: in_signed = 4'b1010;
            4'b1000: in_signed = 4'b1000;
            default: in_signed = 4'b1000;
        endcase

        case (weight_width)
            4'b0001,
            4'b0010: weight_signed = 4'b1111;
            4'b0100: weight_signed = 4'b1010;
            4'b1000: weight_signed = 4'b1000;
            default: weight_signed = 4'b1000;
        endcase
    end

endmodule
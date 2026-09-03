module gray2binary(
    input wire enable,
    input wire [3:0] in_gray,
    output reg [3:0] out_binary
);

    always @(*) begin
        if (enable) begin
            out_binary[3] = in_gray[3];
            out_binary[2] = out_binary[3]^in_gray[2];
            out_binary[1] = out_binary[2]^ in_gray[1];
            out_binary[0] = out_binary[1] ^ in_gray[0];
        end
        else begin
            out_binary = 4'b0000;
        end
    end
    endmodule
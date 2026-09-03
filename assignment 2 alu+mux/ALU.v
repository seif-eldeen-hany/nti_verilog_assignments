module ALU #(
    parameter width = 8
) (
    in_a,
    in_b,
    opcode,

    alu_out,
    a_is_zero
);

input wire [width-1 :0] in_a,in_b;
input wire [2:0] opcode;
output reg [width-1:0] alu_out;
output wire a_is_zero;

assign a_is_zero = (in_a ==0) ? 1'b1:1'b0;

always @(*) begin

        case (opcode)
            3'b000: alu_out = in_a; //pass a
            3'b001: alu_out = in_a-in_b; //subtract
            3'b010: alu_out = in_a+in_b; // addition
            3'b011: alu_out = in_a&in_b; // AND
            3'b100: alu_out = in_a^in_b; // XOR
            3'b101: alu_out = in_b; // pass b
            3'b110: alu_out = in_a; // pass a
            3'b111: alu_out = in_a; // pass a
            default: alu_out = in_a; //default case

        endcase
end


endmodule
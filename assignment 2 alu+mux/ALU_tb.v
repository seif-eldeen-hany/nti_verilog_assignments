`timescale 1ns/1ps

module ALU_tb;
parameter width = 8;

reg [width-1:0] in_a , in_b;
reg [2:0] opcode;

wire [width-1:0] alu_out;
wire a_is_zero;

ALU #(.width(width)) DUT (
    .in_a(in_a),
    .in_b(in_b),
    .opcode(opcode),
    .alu_out(alu_out),
    .a_is_zero(a_is_zero)
);

initial begin
    $monitor("Time=%0t |opcode=%b |in_a=%b |in_b=%b |alu_out=%b | a_is_zero=%b", 
                 $time,opcode,in_a,in_b,alu_out,a_is_zero);

        opcode = 3'b000; in_a = 8'b10100101; in_b = 8'b01011010; #10;
        
        opcode = 3'b001; in_a = 8'b00010100; in_b = 8'b00000101; #10;
        
        opcode = 3'b010; in_a = 8'b00110010; in_b = 8'b00011001; #10;
        
        opcode = 3'b011; in_a = 8'b11110000; in_b = 8'b10101010; #10;
        
        opcode = 3'b100; in_a = 8'b11001100; in_b = 8'b10101010; #10;
        
        opcode = 3'b101; in_a = 8'b10100101; in_b = 8'b01011010; #10;
        
        opcode = 3'b110; in_a = 8'b11001100; in_b = 8'b00000000; #10;
        
        opcode = 3'b111; in_a = 8'b11101110; in_b = 8'b00010001; #10;
        
        opcode = 3'b000; in_a = 8'b00000000; in_b = 8'b11111111; #10;
        $finish;
end
endmodule

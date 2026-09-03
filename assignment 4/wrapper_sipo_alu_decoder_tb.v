module wrapper_sipo_alu_decoder_tb;

reg clk;
reg reset_n;
reg series_in;
reg shift_en;

wire [7:0] alu_out;
wire a_is_zero;

wrapper_sipo_alu_decoder DUT(
    .clk(clk),
    .reset_n(reset_n),
    .series_in(series_in),
    .shift_en(shift_en),
    .alu_out(alu_out),
    .a_is_zero(a_is_zero)
);

always #5 clk= !clk;
integer  i;
reg [19:0] bits_array ;

initial begin
    clk =0;


    //for alu_en
    bits_array[19]=1'b1;

    // for opcode 
    bits_array[18:16]=3'b000;

    // for in_a
    bits_array[15:8] =8'b10001101;

    // for in_b
    bits_array[7:0] =8'b00111011;

    reset_n<=0;
    shift_en<=1;
    repeat(3) @ (posedge clk);

    reset_n<=1;
    for(i=19 ; i>=0; i=i-1)begin
        @ (negedge clk);
        series_in<=bits_array[i];
    end
    @(posedge clk);
    shift_en<=0;
    repeat(4) @ (posedge clk);

$stop; 
end

endmodule
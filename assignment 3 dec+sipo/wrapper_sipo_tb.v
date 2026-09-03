`timescale 1ns/1ps

module wrapper_sipo_tb;

reg clk;
reg reset_n;
reg series_in;

wire [7:0] data_out;

wrapper_sipo DUT(
    .clk(clk),
    .reset_n(reset_n),
    .series_in(series_in),
    .data_out(data_out)
);

initial begin
    clk = 0;
end
always #5 clk = ~clk; 

initial begin
    $monitor("Time=%0t|reset_n=%b|series_in=%b|data_out=%b",
                $time ,reset_n   ,series_in   ,data_out   );
end

initial begin
    reset_n =0; #10;

    reset_n =1;
    series_in =1; #10;

    series_in =0; #10;

    series_in =1; #10;

$finish;
end
endmodule
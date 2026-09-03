`timescale 1ns/1ps

module sipo_shift_reg_tb;

localparam n = 3;
    reg clk;
    reg reset_n;
    reg series_in;

    wire [n-1:0] data_out;

    sipo_shift_reg #(.n(n)) dut_n_3 (
        .clk(clk),
        .reset_n(reset_n),
        .series_in(series_in),
        .data_out(data_out)
    );
    initial  clk=0;

    always #5 clk=~clk;

    initial
    begin
        series_in=1;
        reset_n=0;
        #10;
        reset_n=1;
        #40;
        series_in=0;
        #40; 
        $finish;
        
    end
    
endmodule 
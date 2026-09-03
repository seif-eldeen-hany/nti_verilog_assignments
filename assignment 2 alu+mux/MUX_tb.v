`timescale 1ns/1ps
module MUX_tb;
parameter width = 5;

reg [width-1:0] in0;
reg [width-1:0] in1;
reg sel;
wire [width-1:0] mux_out;

MUX #(.width(width)) uut (
    .in0(in0),
    .in1(in1),
    .sel(sel),
    .mux_out(mux_out)
);

initial begin
    $monitor("At time %0t sel=%b in0=%b in1=%b, mux_out=%b", $time, sel, in0, in1, mux_out);

    sel = 0;
    in0 = 5'b10101; in1 = 5'b00000;
    #5;
    sel = 0;
    in0 = 5'b01010; in1 = 5'b00000;
    #5;
    sel = 1;
    in0 = 5'b00000; in1 = 5'b10101;
    #5;
    sel = 1;
    in0 = 5'b00000; in1 = 5'b01010;
    #5;
    $finish;
end

endmodule
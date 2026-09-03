module MUX #(
    parameter width =5;
) (
    in0,
    in1,
    sel,
    mux_out
);

input wire [width-1:0] in0,in1;
input wire sel;

output wire [width-1:0] mux_out ;

assign mux_out = (sel) ? in1:in0;
    
endmodule
module sipo_shift_reg #( parameter WIDTH = 20) 
(
    input clk,
    input rst_n,
    input series_in,
    input wire shift_en,
    output reg [WIDTH-1:0] parallel_out
);
always @(posedge clk or negedge rst_n )
begin
    if(~rst_n)
    begin
        parallel_out <=0;
    end
    else if(shift_en)
    begin
        parallel_out <= {parallel_out[WIDTH-2:0] , series_in};
    end
end
endmodule  
module sipo_shift_reg #( parameter n = 20) 
(
    input clk,
    input reset_n,
    input series_in,
    input wire shift_en,
    output reg [n-1:0] data_out

);
always @(posedge clk or negedge reset_n )
begin
    if(~reset_n)
    begin
        data_out <=0;
    end
    else if(shift_en)
    begin
        data_out <= {data_out[n-2:0] , series_in};
    end
end
     
endmodule 
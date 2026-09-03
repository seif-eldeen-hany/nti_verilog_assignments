module PISO #(
    parameter WIDTH = 20
) (
    input clk,
    input rst_n,
    input [WIDTH-1:0] parallel_in,
    input en,

    output reg serial_out,
    output reg valid
);
    reg[4:0] counter;
    reg[WIDTH-1:0]shift_reg;
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n)begin
            serial_out<=1'b0;
            valid<=1'b0;
            counter<=5'b0;
            shift_reg<=0;
        end
        else if(en)begin
            shift_reg<=parallel_in;
            counter<=5'b0;
            serial_out<=1'b0;
            valid<=1'b0;
        end 
        else if(counter==WIDTH)begin
            serial_out<=1'b0;
            valid<=1'b0;
        end
        else begin
            valid<=1'b1;
            serial_out<=shift_reg[WIDTH-1];
            counter<= counter+1'b1;
            shift_reg<= shift_reg<<1'b1;
        end
    end
endmodule
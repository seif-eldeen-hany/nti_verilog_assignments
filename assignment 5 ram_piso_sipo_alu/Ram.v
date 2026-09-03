module Ram #(
    parameter ADDR_WIDTH =8,
    parameter DATA_WIDTH = 20
) (
    input clk,
    input rst_n,
    input write_en,
    input [ADDR_WIDTH-1 :0] address,
    input [DATA_WIDTH-1 :0] din,
    input read_en,

    output reg [DATA_WIDTH-1 :0] dout,
    output reg valid 
);

    reg [DATA_WIDTH-1 :0] mem [0:2**ADDR_WIDTH-1];

    always @(posedge clk or negedge rst_n ) begin
        if(~rst_n)begin
            dout<=20'b0;
            valid<=1'b0;
        end else begin
            if(write_en)begin
                mem[address]<=din;
            end
            if(read_en)begin
                dout<=mem[address];
                valid<=1'b1;
            end
            else valid<=1'b0;
        end
         
    end
    

endmodule
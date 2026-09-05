module edge_counter (
    input  wire clk,
    input  wire rst_n,
    input  wire tick,

    output reg [3:0]count
);

    always @(posedge clk or negedge rst_n) begin
           if (!rst_n)
            count<= 4'b0000;
        else if (tick)
            count<= count+4'b0001;
        else
            count<=count;
    end

endmodule
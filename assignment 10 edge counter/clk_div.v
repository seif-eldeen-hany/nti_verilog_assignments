module clk_div#(
    parameter toggle_count=15_000_000  // 30Mhz/(2*0.5Hz) toggles everry 15000000
)(
    input  wire clk_30mhz,
    input  wire rst_n,
    output reg  clk_half_hz
);
 
    reg [24:0] count;

    always @(posedge clk_30mhz or negedge rst_n) begin
        if (!rst_n) begin
            count<= 25'd0;
            clk_half_hz<= 1'b0;
        end else if(count==toggle_count - 1) begin
            count<= 25'd0;
            clk_half_hz<= ~clk_half_hz;
        end else begin
            count<= count+25'd1;
        end
    end
endmodule

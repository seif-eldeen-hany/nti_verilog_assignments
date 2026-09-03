module light_chaser#()
(
    input wire clk,
    input wire rst_n,
    input wire hold_n,

    output reg [9:0] out
);  

    wire enable_pulse;

    enable_gen #(.input_clk(50_000_000) , .output_clk(12_500_000)) 
    e_g(
        .clk_in(clk),
        .rst_n(rst_n),
        .enable_pulse(enable_pulse)
    );

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out <= 10'b10000_00000;// reset to initial value
        end else if(enable_pulse) begin
            if(hold_n) begin
                out <= {out[0],out[9:1]}; // shift right
            end else if (!hold_n) begin
                out <= out; // hold its value when hold_n is low
            end
        end
    end
endmodule
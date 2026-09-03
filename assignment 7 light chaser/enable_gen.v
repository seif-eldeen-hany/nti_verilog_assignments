module enable_gen#(
    parameter input_clk=50_000_000,
    parameter output_clk=8
)(
    input wire clk_in,
    input wire rst_n,

    output reg enable_pulse
);
    localparam max_count = (input_clk / output_clk) -1;
    localparam counter_width= $clog2(max_count+1);

    reg [counter_width-1:0] counter;

    always @(posedge clk_in or negedge rst_n)begin
        if (!rst_n)begin
            counter<=0;
            enable_pulse<= 1'b0;
        end 
        else if(counter == max_count)begin
                enable_pulse<=1'b1;
                counter<=0;
        end
        else begin
            enable_pulse<=1'b0;
            counter<=counter+1;
        end
        end
    endmodule
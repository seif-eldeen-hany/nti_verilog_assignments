module edge_detector_moore(
    input clk,
    input in,
    input rst_n,
    
    output reg moore_out
);
    //state assignment
    localparam idle=2'b00;
    localparam tick=2'b01;
    localparam Wait=2'b10;

    reg [1:0] cs,ns;
 
    //state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            cs<=idle;
        end else begin
            cs<=ns;
        end
    end

    //next state logic
    always @(*) begin
        case (cs)
            idle: ns= in? tick:idle;
            tick: ns=Wait;
            Wait: ns= in? Wait:idle;
            default: ns=idle;
        endcase
    end

    //output logic
    always @(*) begin
        moore_out= (cs == tick);
    end
endmodule
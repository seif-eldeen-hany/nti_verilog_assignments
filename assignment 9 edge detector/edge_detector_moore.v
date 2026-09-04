module edge_detector_moore(
    input clk,
    input a,
    input rst,
    
    output reg moore_out
);
    //state assignment
    localparam idle=2'b00;
    localparam tick=2'b01;
    localparam Wait=2'b10;

    reg [1:0] cs,ns;

    //state register
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            cs<=idle;
        end else begin
            cs<=ns;
        end
    end

    //next state logic
    always @(*) begin
        case (cs)
            idle: a? (ns=tick):(ns=idle); 
            tick: (ns=Wait);
            Wait: a? (ns=Wait):(ns=idle); 
            default: ns=idle;
        endcase
    end

    //output logic
    always @(*) begin
        moore_out<= (cs == tick);
    end
endmodule
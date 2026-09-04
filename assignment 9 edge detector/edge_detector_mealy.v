module edge_detector_mealy(
    input wire clk,
    input wire a,
    input wire rst,
    
    output reg mealy_out
);
    //state assignment
    localparam idle = 1'b0;
    localparam Wait = 1'b1;

    reg cs,ns;

    //state register
    always@(posedge clk or posedge rst)begin
        if (rst) begin
            cs<=idle;
        end else begin
            cs <=ns;
        end
    end

    //next state logic
    always @(*) begin
        case (cs)
            idle: a? (ns=Wait):(ns=idle); 
            Wait: a? (ns=Wait):(ns=idle); 
            default:ns=idle; 
        endcase
    end

    //output logic
    always @(*) begin
        mealy_out = ((cs == idle) && (a == 1'b1));
    end
endmodule
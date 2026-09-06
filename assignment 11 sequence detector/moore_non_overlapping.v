module moore_non_overlapping (
    input clk,
    input rst_n,
    input serial_in,

    output wire result
);
    //state assignments
    localparam idle=3'b000;//no found
    localparam f1=3'b001;// found 1
    localparam f11=3'b010;// found 11
    localparam f110=3'b011;// found 110
    localparam f1101=3'b100;// found 1101
    localparam f11010=3'b101;// found 11010
    localparam FOUND=3'b110;

    reg [2:0] cs,ns;
    //state register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) cs<=idle;
        else cs<=ns;
    end

    //input logic
    always @(*) begin
        case (cs)
            idle:  ns= serial_in ? f1:idle; 
            f1:    ns= serial_in ? f11:idle; 
            f11:   ns= serial_in ? f11:f110; 
            f110:  ns= serial_in ? f1101:idle; 
            f1101: ns= serial_in ? f11:f11010; 
            f11010:ns= serial_in ? FOUND:idle;
            FOUND: ns= serial_in ? f1:idle;
            default: ns=idle;
        endcase
    end

    //output logic
    assign result =(cs==FOUND);
endmodule
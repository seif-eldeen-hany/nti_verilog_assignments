module stream_parity_gen (
    input wire clk,
    input wire rst,
    input wire serial_in,
    output reg valid,
    output reg parity_out
);

    reg [7:0] shift_reg;
    reg [3:0] bit_counter;

    function calc_parity;
        input [7:0] data;
        begin
            calc_parity=^data; // XOR on the 8 bits
        end
    endfunction

    always @(posedge clk) begin
        if (rst) begin
            parity_out<=1'b0;
            valid<=1'b0;
            shift_reg<=8'b0;
            bit_counter<=4'b0;
        end else begin
            shift_reg<={shift_reg[6:0], serial_in};

            if (bit_counter< 4'b0111) begin
                bit_counter<=bit_counter + 1'b1;
                valid<=1'b0;
            end else begin
                valid <= 1'b1;
                parity_out <= calc_parity({shift_reg[6:0], serial_in}); //problm 2 parity_out <= calc_parity(shift_reg); //fix the line upward
                bit_counter <= 4'b0000;
            end
        end 
    end
endmodule
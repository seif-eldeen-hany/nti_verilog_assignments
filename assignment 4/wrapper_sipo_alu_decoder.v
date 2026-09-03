module wrapper_sipo_alu_decoder(
    input clk,
    input reset_n,
    input series_in,
    input shift_en,

    output wire [7:0] alu_out,
    output wire a_is_zero
);

    wire [19:0] data_out;

    sipo_shift_reg #(.n(20)) SSR(
        .clk(clk),
        .reset_n(reset_n),
        .series_in(series_in),
        .shift_en(shift_en),
        .data_out(data_out)
    );

    ALU #(.width(8)) A1 (
        .alu_en(data_out[19]),
        .opcode(data_out[18:16]),
        .in_a(data_out[15:8]),
        .in_b(data_out[7:0]),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );    
endmodule
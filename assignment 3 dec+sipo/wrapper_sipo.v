module wrapper_sipo #(
    parameter n=3
)(
    input clk,
    input reset_n,
    input series_in,

    output wire [7:0] data_out
);

    wire [n-1:0] wire_internal;

    sipo_shift_reg #(.n(n)) ssr (
        .clk(clk),
        .reset_n(reset_n),
        .series_in(series_in),
        .data_out(wire_internal)
    );

    decoder_3to8 D_3to8(
        .data_in(wire_internal),
        .decoder_out(data_out)
    );
endmodule 
module wrapper(
    input  wire clk_30mhz,
    input  wire rst_n,
    input  wire in,
    output wire [6:0] seg_out
);

    wire clk_half_hz;
    wire tick;
    wire [3:0] count;

    clk_div CD (
        .clk_30mhz(clk_30mhz),
        .rst_n(rst_n),
        .clk_half_hz(clk_half_hz)
    );

    edge_detector_moore EDM (
        .clk(clk_half_hz),
        .in(in),
        .rst_n(rst_n),
        .moore_out(tick)
    );

    edge_counter EC (
        .clk(clk_half_hz),
        .rst_n(rst_n),
        .tick(tick),
        .count(count)
    );

    segment7_decoder DEC (
        .in_binary(count),
        .seg_out(seg_out)
    );

endmodule
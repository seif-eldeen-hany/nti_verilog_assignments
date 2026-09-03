module wrapper_g2b_7seg(
    input wire enable,
    input wire [3:0] in_gray,
    output wire [6:0] seg_out
);

    wire [3:0] out_binary__in_binary;

    gray2binary g2b(
        .enable(enable),
        .in_gray(in_gray),
        .out_binary(out_binary__in_binary)
    );

    binary2_7seg b2s(
        .enable(enable),
        .binary(out_binary__in_binary),
        .seg(seg_out)
    );
    endmodule
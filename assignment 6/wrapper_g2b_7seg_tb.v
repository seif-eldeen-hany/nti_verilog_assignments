module wrapper_g2b_7eg_tb;
reg enable;
reg [3:0] in_gray;

wire [6:0] seg_out;

wrapper_g2b_7seg uut (
    .enable(enable),
    .in_gray(in_gray),
    .seg_out(seg_out)
);

initial begin
enable = 1'b0;
in_gray = 4'b0000;
in_gray = 4'b0010;
in_gray = 4'b0110;

enable = 1'b1;
in_gray = 4'b0000;
in_gray = 4'b1000;
in_gray = 4'b0100;
in_gray = 4'b0110;
in_gray = 4'b1100;
in_gray = 4'b0010;
in_gray = 4'b1111;

repeat (10) begin
    #10 in_gray =$random_range(0, 15);
end

end


endmodule
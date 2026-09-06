// Combined testbench for: 11010110101
// mealy_non_overlapping, mealy_overlapping,
// moore_non_overlapping, moore_overlapping
module sequence_detector_tb;

    reg clk;
    reg rst_n;
    reg serial_in;

    wire result_mealy_nonover;
    wire result_mealy_over;
    wire result_moore_nonover;
    wire result_moore_over;

    mealy_non_overlapping dut_mealy_nonover (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .result(result_mealy_nonover)
    );

    mealy_overlapping dut_mealy_over (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .result(result_mealy_over)
    );

    moore_non_overlapping dut_moore_nonover(
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .result(result_moore_nonover)
    );

    moore_overlapping dut_moore_over(
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .result(result_moore_over)
    );

    always #5 clk = ~clk;

    reg [10:0] seq = 11'b110101_10101;
    integer i;

    initial begin
        clk= 0;
        rst_n= 0;
        serial_in= 0;

        repeat(2) @(negedge clk);
        rst_n = 1;

        $display("time  in  mealy_nonover  mealy_over  moore_nonover  moore_over");
        
        $monitor ("%4t  %b     %b             %b          %b             %b",
          $time, serial_in,
          result_mealy_nonover, result_mealy_over,
          result_moore_nonover, result_moore_over);

        for (i= 10;i>=0;i=i-1) begin
            @(negedge clk);
            serial_in= seq[i];
        end

        @(negedge clk);

        $display("sim stop");
        $stop;
    end

endmodule
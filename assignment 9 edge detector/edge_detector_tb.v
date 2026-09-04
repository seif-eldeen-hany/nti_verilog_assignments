module edge_detector_tb;
    reg clk;
    reg a;
    reg rst;

    wire mealy_out;
    wire moore_out;

    //dut instantiation
    edge_detector_mealy mealy1(
        .clk(clk),
        .a(a),
        .rst(rst),

        .mealy_out(mealy_out)
    );

    edge_detector_moore moore1(
        .clk(clk),
        .a(a),
        .rst(rst),

        .moore_out(moore_out)
    );

    always #5 clk = ~clk;

    initial begin
        $monitor("Time: %0t | rst=%b | clk=%b | a=%b | mealy_out=%b | moore_out=%b", 
                 $time,       rst,     clk,     a,     mealy_out,     moore_out);

        clk = 0;
        rst = 1;
        a = 0;

        repeat(2) @(negedge clk);
        rst = 0;

        @(negedge clk);

        a = 1;
        @(negedge clk);
        a = 0;

        repeat(3) @(negedge clk);

        a = 1;
        repeat(3) @(negedge clk);
        a = 0;

        repeat(5) @(negedge clk);
        $stop; 
    end
endmodule
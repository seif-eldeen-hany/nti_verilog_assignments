module tb_wrapper();

    reg clk_30mhz;
    reg rst_n;
    reg in;

    wire [6:0] seg_out;

    wrapper dut (
        .clk_30mhz(clk_30mhz),
        .rst_n(rst_n),
        .in(in),
        .seg_out(seg_out)
    );

    defparam dut.CD.toggle_count = 5;

    initial begin
        clk_30mhz= 0;
        forever #17 clk_30mhz = ~clk_30mhz;
    end

    initial begin
        $monitor("Time = %0t | rst_n = %b | in = %b | seg_out = %b", $time, rst_n, in, seg_out);
        rst_n = 0;
        in = 0;
        #100;

        rst_n = 1;
        #100;

        in = 1;
        #500; 
        in = 0;
        #500;

        in = 1;
        #500;
        in = 0;
        #500;

        in = 1;
        #500;
        in = 0;
        #500;

        $stop;
    end
endmodule
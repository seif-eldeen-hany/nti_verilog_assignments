module light_chaser_tb;
    reg clk;
    reg rst_n;
    reg hold_n;
    wire [9:0] out;

    light_chaser dut(
        .clk(clk),
        .rst_n(rst_n),
        .hold_n(hold_n),
        .out(out)
    );

    always #10 clk = ~clk; //T=2ns,f=50MHz

    //task to compare output with expected
task check_output(input [9:0] expected);
        begin
            if (out === expected) begin
                $display("[PASS] Time=%0t ns: Output matches expected value = %b", $time, out);
            end else begin
                $display("[FAIL] Time=%0t ns: Expected = %b, Got = %b", $time, expected, out);
            end
        end
    endtask

        // task to test hold_n
task set_hold(input reg hold_val, input integer duration_ns);
        begin
            hold_n = hold_val;
            #duration_ns;
        end
    endtask

    initial begin
        clk=0;
        rst_n=0;
        hold_n=1;
        $display("sim start");
        //hold the reset
        #40;
        rst_n = 1; 
        $display("Released reset at Time=%0t ns",$time);
        
        // initial check after reset
        check_output(10'b10000_00000);

        //4 cycles = 80 ns (at 12.5 MHz enable rate)
        #80;
        check_output(10'b01000_00000); //1 right shift

        #80;
        check_output(10'b00100_00000); //2 right shift

        //test the hold_n task
        set_hold(1'b0, 160); //hold for 2 cycles(160ns)

        check_output(10'b00100_00000); 


        set_hold(1'b1, 80);
        check_output(10'b00010_00000); // Continued shifting

        #100;
        $display("sim stop");
        $stop;
    end

endmodule
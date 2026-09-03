module tb_stream_parity_gen;
    reg clk;
    reg rst;
    reg serial_in;

    wire valid;
    wire parity_out;

    integer i;
    reg expected_val;

    stream_parity_gen dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .valid(valid),
        .parity_out(parity_out)
    );

    always #5 clk = ~clk;

    function reg expected_parity;
        input [7:0] data;
        begin
            expected_parity = ^data;
        end
    endfunction

    task send_byte;
        input [7:0] data_to_send;
        integer bit_i;
        begin
            for (bit_i = 7; bit_i >= 0; bit_i = bit_i - 1) begin
                serial_in <= data_to_send[bit_i]; //problem 1 using blocking assignment //fix to use non blocking instead
                @(posedge clk);
            end
        end
    endtask

    initial begin
        clk = 0;
        rst = 1;
        serial_in = 0;
        #20;

        @(posedge clk);
        rst = 0;

        for (i = 0; i < 256; i = i + 1) begin
            send_byte(i[7:0]);

            wait (valid == 1'b1);

            expected_val = expected_parity(i[7:0]);
            
            if (parity_out === expected_val) begin
                $display("pass [%0d/255] | Data is %b | Expected= %b | parity_out= %b"
                        , i             , i[7:0]   ,    expected_val,  parity_out);
            end else begin
                $display("wrong[%0d/255] | Data is %b | Expected= %b | parity_out= %b",
                         i,               i[7:0],       expected_val,  parity_out);
            end
        end

        $display("sim stopped----256 bytes tested");
        $stop; 
    end

endmodule
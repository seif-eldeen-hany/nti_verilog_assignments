module wrapper_ram_piso_sipo_alu_tb;
    parameter ADDR_WIDTH= 8;
    parameter DATA_WIDTH= 20;
    parameter ALU_WIDTH = 8;

    reg clk;
    reg rst_n;
    reg write_en;
    reg [ADDR_WIDTH-1:0] address;
    reg [DATA_WIDTH-1:0] din;
    reg read_en;

    wire [ALU_WIDTH-1:0] alu_out;
    wire a_is_zero;

    wrapper_ram_piso_sipo_alu #(
        .ADDR_WIDTH(ADDR_WIDTH),
        .DATA_WIDTH(DATA_WIDTH),
        .ALU_WIDTH(ALU_WIDTH) 
    ) DUT_tb (
        .clk(clk),
        .rst_n(rst_n),

        .write_en(write_en),
        .address(address),
        .din(din),
        .read_en(read_en),

        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );

    always #5 clk = ~clk;

    function [DATA_WIDTH-1:0] gather_for_ram(
        input alu_en,
        input [2:0] opcode,
        input [ALU_WIDTH-1:0] in_a, 
        input [ALU_WIDTH-1:0] in_b
    );
        begin
            gather_for_ram= {alu_en,opcode,in_a,in_b}; 
        end
    endfunction

task ram_write(input [7:0] target_addr,input [19:0] write_data);
        begin
            @(negedge clk);
            write_en= 1'b1;
            address= target_addr;
            din= write_data;

            @(negedge clk);
            write_en= 1'b0;
        end
    endtask

task ram_read(input [7:0] target_addr);
        begin
            @(negedge clk);
            read_en = 1'b1;
            address = target_addr;

            @(negedge clk);
            read_en = 1'b0;
        end
    endtask

    initial begin
        clk = 0;
        rst_n = 0;
        write_en = 0;
        read_en = 0;
        address = 0;
        din = 0;

        $monitor("Time=%0t| rst_n = %b| addr=%b| write= %b |read = %b |alu_out = %b |a_is_zero = %b", 
                 $time, rst_n, address, write_en, read_en, alu_out, a_is_zero);

        #15; 
        rst_n = 1;
                                                    //add        //10           //5
        ram_write(8'b0000_0001, gather_for_ram(1'b1, 3'b000, 8'b0000_1010, 8'b0000_0101));
        ram_read(8'b0000_0001);
        
        repeat(25) @(posedge clk);
                                                    //dif        //20          //8
        ram_write(8'b00000010, gather_for_ram(1'b1, 3'b001, 8'b00010100, 8'b00001000));
        ram_read(8'b00000010);
        
        repeat(25) @(posedge clk);
        #50;
        $finish;
    end
endmodule
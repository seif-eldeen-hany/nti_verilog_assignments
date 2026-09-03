module wrapper_ram_piso_sipo_alu #(
    parameter ADDR_WIDTH =8,
    parameter DATA_WIDTH =20,
    parameter ALU_WIDTH  =8
) (
    input clk,
    input rst_n,
    input write_en,
    input [ADDR_WIDTH-1 :0] address,
    input [DATA_WIDTH-1 :0] din,
    input read_en,
    
    //alu outputs
    output wire [ALU_WIDTH-1:0]alu_out,
    output wire a_is_zero
);

    //RAM ---> PISO internatl wires
    wire [DATA_WIDTH-1:0]dout__parallel_in;
    wire valid__en;

    //PISO ---> SIPO internatl wires
    wire serial_out__series_in;
    wire valid__shift_en;

    //SIPO ---> ALU  internatl wires
    wire [DATA_WIDTH-1:0]parallel_out__alu_out;


    Ram #(.ADDR_WIDTH(ADDR_WIDTH) ,.DATA_WIDTH(DATA_WIDTH)) 
    R1(
        .clk(clk),
        .rst_n(rst_n),

        .write_en(write_en),
        .address(address),
        .din(din),
        .read_en(read_en),

        .dout(dout__parallel_in),
        .valid(valid__en)
    );

    PISO #(.WIDTH(DATA_WIDTH)) 
    piso_1 (
        .clk(clk),
        .rst_n(rst_n),

        .parallel_in(dout__parallel_in),
        .en(valid__en),
        
        .serial_out(serial_out__series_in),
        .valid(valid__shift_en)
    );

    sipo_shift_reg #(.WIDTH(DATA_WIDTH)) 
    siop_1(
        .clk(clk),
        .rst_n(rst_n),

        .series_in(serial_out__series_in),
        .shift_en(valid__shift_en),

        .parallel_out(parallel_out__alu_out)
    );

    ALU #(.WIDTH(ALU_WIDTH)) 
    alu_1(
        .alu_en(parallel_out__alu_out[19]),
        .opcode(parallel_out__alu_out[18:16]),
        .in_a(parallel_out__alu_out[15:8]),
        .in_b(parallel_out__alu_out[7:0]),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );
    
endmodule
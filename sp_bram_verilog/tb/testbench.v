// project     : sp_bram
// date        : 22.04.2026
// author      : siarhei baldzenka
// e-mail      : sbaldzenka@proton.me
// description : https://github.com/sbaldzenka/sp_bram/sp_bram_verilog

`timescale 1ns/100ps

module testbench
#(
    parameter SYS_CLK_PERIOD = 10.000, // 100 MHz
    parameter ADDR_WIDTH     = 4,
    parameter DATA_WIDTH     = 8
);

    //variables
    integer i;
    integer index;

    // signals
    reg                   sys_clk;
    reg                   we;
    reg  [ADDR_WIDTH-1:0] addr;
    reg  [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;

    initial begin
        sys_clk = 1'b0;
    end

    always #(SYS_CLK_PERIOD/2) sys_clk = ~sys_clk;

    initial begin
        we      = 1'b0;
        addr    = 'b0;
        data_in = 'b0;

        for (i = 0; i < 2; i = i + 1) begin
            #1000;
            @(negedge sys_clk);
            for (index = 0; index < (2**ADDR_WIDTH); index = index + 1) begin
                we      = 1'b1;
                #SYS_CLK_PERIOD;
                addr    = addr + 1'b1;
                data_in = data_in + 1'b1;
            end

            we = 1'b0;

            #1000;
            @(negedge sys_clk);
            for (index = 0; index < (2**ADDR_WIDTH); index = index + 1) begin
                #SYS_CLK_PERIOD;
                addr = addr + 1'b1;
            end
        end
    end

    defparam DUT_inst.ADDR_WIDTH = ADDR_WIDTH;
    defparam DUT_inst.DATA_WIDTH = DATA_WIDTH;

    sp_bram DUT_inst
    (
        .i_clk  ( sys_clk  ),
        .i_we   ( we       ),
        .i_addr ( addr     ),
        .i_data ( data_in  ),
        .o_data ( data_out )
    );

endmodule
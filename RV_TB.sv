// RISC-V Test Bench
`timescale 1 ns / 1 ps

module RV_TB (
    output logic rst
);

    logic clk_out;
    assign rst = 1'b0;

    // Clock Generation
    clk_gen clk_gen (
        .clk_out(clk_out)
    );

    // Device Under Test
    RV_Core core (
        .clk(clk_out),
        .rst(rst)
    );

    initial begin
        $dumpfile("waveform.fst");
        $dumpvars;
        #1ms;
        $finish;
    end

endmodule

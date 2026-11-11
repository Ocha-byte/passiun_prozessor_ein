// Instruction Memory module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::MEM_DEPTH;

module IMEM (
    input logic [RV_INSTR_WIDTH - 1:0] addr,
    output logic [RV_INSTR_WIDTH - 1:0] instr
);

    // Declare Memory
    logic [RV_INSTR_WIDTH - 1:0] IMEM_Store[rvi_pkg::MEM_DEPTH - 1:0];

    // Load instructions.
    initial begin
        $readmemh("test_instr.txt", IMEM_Store);
        //$readmemh("test_instr.txt", IMEM_Store, 32'h0, 32'hFFFF);
        //$readmemb("test_instr.bin", IMEM_Store, 32'h0, 32'hFFFF);
    end

    // Set output
    assign instr = IMEM_Store[addr[RV_INSTR_WIDTH - 1:2]]; // Word-aligned.

endmodule

// Program Counter (Instruction Pointer) module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;

module PC (
    input logic clk, rst, ALU_zero, PC_src,
    input logic [RV_INSTR_WIDTH - 1:0] IMM_Offset,
    output logic [RV_INSTR_WIDTH - 1:0] addr
);

    always @(posedge clk, posedge rst) begin
        if (rst) begin // Reset PC
            addr <= RV_INSTR_WIDTH'('b0);
        end else if (ALU_zero && PC_src) begin // Branch/Jump taken.
            addr <= addr + IMM_Offset;
        end else begin  // Next instruction. PC += 4.
            addr <= addr + 32'd4;
        end
    end

endmodule

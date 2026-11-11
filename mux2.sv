// 2-input, 1-output multiplexor module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;

module mux2 (
    input logic [RV_INSTR_WIDTH - 1:0] rs2_out,
    input logic [RV_INSTR_WIDTH -1:0] IMM_Offset,
    input logic ALU_src,
    output logic [RV_INSTR_WIDTH - 1:0] ALU_rs2
);

    assign ALU_rs2 = (ALU_src) ? IMM_Offset : rs2_out;

endmodule

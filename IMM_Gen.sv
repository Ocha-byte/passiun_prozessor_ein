// Immediate Generator module
`include "rvi_pkg.sv";
`include "datapath.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::IMM_t;
import datapath::instr;

module IMM_Gen (
    input logic [RV_INSTR_WIDTH - 1:7] instr,
    input IMM_t IMM_src,
    output logic [RV_INSTR_WIDTH -1:0] IMM_Offset
);

    always_comb begin
        case (IMM_src)

            // R-type
            rvi_pkg::R_type: IMM_Offset = 32'b0;

            // I-type
            rvi_pkg::I_type: IMM_Offset = {{20{instr[31]}}, instr[31:20]};

            // S-type
            rvi_pkg::S_type: IMM_Offset = {{20{instr[31]}}, instr[31:25], instr[11:7]};

            // B-type
            rvi_pkg::B_type: IMM_Offset = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};

            // U-type
            rvi_pkg::U_type: IMM_Offset = {instr[31:12], 12'b0};

            // J-type
            rvi_pkg::J_type: IMM_Offset = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};

            // Undefined
            default: IMM_Offset = RV_INSTR_WIDTH'('bx);

        endcase
    end


endmodule

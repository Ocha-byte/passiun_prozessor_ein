// Sign Extension module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::opcode_t;

module Sign_Ext (

    input logic ext_en,
    input opcode_t opcode,

    input logic [31:12] instr_upper,
    input logic [RV_INSTR_WIDTH - 1:0] PC,
    output logic [RV_INSTR_WIDTH - 1:0] SER
);

    always_comb begin
        if (ext_en) begin
            case (opcode)
                rvi_pkg::LUI_OP: SER = {instr_upper, 12'b0};
                rvi_pkg::AUIPC_OP: SER = PC + {instr_upper, 12'b0};
                default: SER = 32'b0;
            endcase
        end
    end

endmodule

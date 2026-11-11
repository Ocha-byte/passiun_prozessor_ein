// 3-input, 1-output multiplexor module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;

module mux3 (
    input logic [RV_INSTR_WIDTH - 1:0] mem_rd_data,
    input logic [RV_INSTR_WIDTH - 1:0] ALU_res,
    input logic [RV_INSTR_WIDTH - 1:0] SER,
    input logic [1:0] mem_to_reg_src,
    output logic [RV_INSTR_WIDTH - 1:0] reg_wr_back
);

    always_comb begin
        case (mem_to_reg_src)
            2'b00: reg_wr_back = mem_rd_data;
            2'b01: reg_wr_back = ALU_res;
            2'b10: reg_wr_back = SER;
            2'b11: reg_wr_back = RV_INSTR_WIDTH'('b0);
            default: reg_wr_back = RV_INSTR_WIDTH'('b0);
        endcase
    end

endmodule

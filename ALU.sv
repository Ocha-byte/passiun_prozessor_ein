// Arithmetic Logic Unit module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::RV_DATA_WIDTH;
import rvi_pkg::ALU_t;

module ALU (
    input logic [RV_INSTR_WIDTH-1:0] rs1,
    input logic [RV_INSTR_WIDTH-1:0] rs2,
    input rvi_pkg::ALU_t ALU_op,

    output logic [RV_INSTR_WIDTH-1:0] ALU_res, // goes to dmem addr/write-back
    output logic ALU_zero // used for Branchs.

);

    assign ALU_zero = (ALU_res == RV_INSTR_WIDTH'('b0));
    logic [4:0] shamt = rs2[4:0]; // shift amount, lower 5 bits of rs2.

    always_comb begin
        case (ALU_op)

            // ALU_Zero
            rvi_pkg::ALU_ZERO: ALU_res = RV_INSTR_WIDTH'('b0);

            // JAL_OP
            rvi_pkg::JAL: ALU_res = RV_INSTR_WIDTH'('b0);

            // JALR_OP
            rvi_pkg::JALR: ALU_res = RV_INSTR_WIDTH'('b0);

            // BRANCH_OPS
            rvi_pkg::BEQ: ALU_res = (rs1 == rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::BNE: ALU_res = (rs1 != rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::BLT: ALU_res = ($signed(rs1) < $signed(rs2)) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::BGE: ALU_res = ($signed(rs1) > $signed(rs2)) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::BLTU: ALU_res = (rs1 < rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::BGEU: ALU_res = (rs1 > rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);

            // LOAD_OPS
            rvi_pkg::LB: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::LH: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::LW: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::LBU: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::LHU: ALU_res = RV_INSTR_WIDTH'('b0);

            // STORE_OPS
            rvi_pkg::SB: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::SH: ALU_res = RV_INSTR_WIDTH'('b0);
            rvi_pkg::SW: ALU_res = RV_INSTR_WIDTH'('b0);

            // IMM_OPS
            rvi_pkg::ADDI: ALU_res = rs1 + rs2;
            rvi_pkg::SLTI: ALU_res = ($signed(rs1) < $signed(rs2)) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::SLTIU: ALU_res = (rs1 < rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0);
            rvi_pkg::XORI: ALU_res = rs1 ^ rs2;
            rvi_pkg::ORI: ALU_res = rs1 | rs2;
            rvi_pkg::ANDI: ALU_res = rs1 & rs2;
            rvi_pkg::SLLI: ALU_res = rs1 << rs2;
            rvi_pkg::SRLI: ALU_res = rs1 >> rs2;
            rvi_pkg::SRAI: ALU_res = $signed(rs1) >>> shamt;

            // IMM64_OPS
            rvi_pkg::ADDIW: ALU_res = rs1 + rs2;
            rvi_pkg::SLLIW: ALU_res = rs1 << rs2;
            rvi_pkg::SRLIW: ALU_res = rs1 >> rs2;
            rvi_pkg::SRAIW: ALU_res = $signed(rs1) >>> shamt;

            // REG_OPS
            rvi_pkg::ADD: ALU_res = rs1 + rs2;
            rvi_pkg::SUB: ALU_res = rs1 - rs2;
            rvi_pkg::SLL: ALU_res = rs1 << rs2;
            rvi_pkg::SLT: ALU_res = ($signed(rs1) < $signed(rs2)) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0); // Set less than
            rvi_pkg::SLTU: ALU_res = (rs1 < rs2) ? RV_INSTR_WIDTH'('b1) : RV_INSTR_WIDTH'('b0); // unsigned slt.
            rvi_pkg::XOR: ALU_res = rs1 ^ rs2;
            rvi_pkg::SRL: ALU_res = rs1 >> rs2;
            rvi_pkg::SRA: ALU_res = $signed(rs1) >>> shamt;
            rvi_pkg::OR: ALU_res = rs1 | rs2;
            rvi_pkg::AND: ALU_res = rs1 & rs2;

            // REG64_OPS
            rvi_pkg::ADDW: ALU_res = rs1 + rs2;
            rvi_pkg::SUBW: ALU_res = rs1 + rs2;
            rvi_pkg::SLLW: ALU_res = rs1 << rs2;
            rvi_pkg::SRLW: ALU_res = rs1 >> rs2;
            rvi_pkg::SRAW: ALU_res = $signed(rs1) >>> shamt;

            // FENCE - Temp 32'b0;
            rvi_pkg::FENCE: begin // Memory ordering
                ALU_res = RV_INSTR_WIDTH'('b0);
            end

            // ENV - Temp 32'b0;
            rvi_pkg::ECALL: begin
                ALU_res = RV_INSTR_WIDTH'('b0);
            end

            rvi_pkg::EBREAK: begin
                ALU_res = RV_INSTR_WIDTH'('b0);
            end

            // Default
            default: ALU_res = RV_INSTR_WIDTH'('b0);

            endcase

    end

endmodule

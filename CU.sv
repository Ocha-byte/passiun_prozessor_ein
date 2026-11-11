// Control Unit module
`include "rvi_pkg.sv";

import rvi_pkg::opcode_t;
import rvi_pkg::ALU_OP_NUM;
import rvi_pkg::ALU_NUM;
import rvi_pkg::IMM_t;

module CU (

    input opcode_t opcode,

    output logic PC_src,
    output logic mem_rd_en,
    output logic [1:0] mem_to_reg_src,
    output logic mem_wr_en,
    output logic ALU_src,
    output logic reg_wr_en,
    output logic ext_en,

    output IMM_t IMM_src,
    output logic [rvi_pkg::ALU_NUM - 1:0] ALU_opcode

);

    always_comb begin
        case (opcode)
            rvi_pkg::LUI_OP: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b10;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b1;
                IMM_src = rvi_pkg::U_type;
                ALU_opcode = 7'b0110111;
            end

            rvi_pkg::AUIPC_OP: begin
                PC_src = 1'b1;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b10;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b1;
                IMM_src = rvi_pkg::U_type;
                ALU_opcode = 7'b0010111;
            end

            rvi_pkg::JAL_OP: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::J_type;
                ALU_opcode = 7'b1101111;
            end

            rvi_pkg::JALR_OP: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b1100111;
            end

            rvi_pkg::BRANCH_OPS: begin
                PC_src = 1'b1;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::B_type;
                ALU_opcode = 7'b1100011;
            end

            rvi_pkg::LOAD_OPS: begin
                PC_src = 1'b1;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b0000011;
            end

            rvi_pkg::STORE_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b1;
                ALU_src = 1'b1;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::S_type;
                ALU_opcode = 7'b0100011;
            end

            rvi_pkg::IMM_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b01;
                mem_wr_en = 1'b0;
                ALU_src = 1'b1;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b0010011;
            end

            rvi_pkg::IMM64_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b01;
                mem_wr_en = 1'b0;
                ALU_src = 1'b1;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b0011011;
            end

            rvi_pkg::REG_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b01;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::R_type;
                ALU_opcode = 7'b0110011;
            end

            rvi_pkg::REG64_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b01;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b1;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::R_type;
                ALU_opcode = 7'b0110011;
            end

            rvi_pkg::FENCE_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b0001111;
            end

            rvi_pkg::ENV_OPS: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b11;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::I_type;
                ALU_opcode = 7'b1110011;
            end

            rvi_pkg::NOP: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b00;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::No_type;
                ALU_opcode = 7'b0000000;
            end

            default: begin
                PC_src = 1'b0;
                mem_rd_en = 1'b0;
                mem_to_reg_src = 2'b00;
                mem_wr_en = 1'b0;
                ALU_src = 1'b0;
                reg_wr_en = 1'b0;
                ext_en = 1'b0;
                IMM_src = rvi_pkg::No_type;
                ALU_opcode = 7'b0000000;
            end
        endcase
    end

endmodule

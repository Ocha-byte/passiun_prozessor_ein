// ALU Control Unit module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::opcode_t;
import rvi_pkg::ALU_NUM;
import rvi_pkg::ALU_t;
import rvi_pkg::CU_OP_NUM;

module ALU_CU (
    input logic [2:0] funct3,
    input logic funct7_b5,
    input logic [ALU_NUM - 1:0] ALU_opcode,
    output ALU_t ALU_op
);

    always_comb begin
        case (ALU_opcode)
            rvi_pkg::LUI_OP: ALU_op = rvi_pkg::ALU_ZERO;
            rvi_pkg::AUIPC_OP: ALU_op = rvi_pkg::ALU_ZERO;
            rvi_pkg::JAL_OP: ALU_op = rvi_pkg::JAL;
            rvi_pkg::JALR_OP: ALU_op = rvi_pkg::JALR;

            rvi_pkg::BRANCH_OPS: begin
                case (funct3)
                    3'b000: ALU_op = rvi_pkg::BEQ;
                    3'b001: ALU_op = rvi_pkg::BNE;
                    3'b100: ALU_op = rvi_pkg::BLT;
                    3'b101: ALU_op = rvi_pkg::BGE;
                    3'b110: ALU_op = rvi_pkg::BLTU;
                    3'b111: ALU_op = rvi_pkg::BGEU;
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::LOAD_OPS: begin
                case (funct3)
                    3'b000: ALU_op = rvi_pkg::LB;
                    3'b001: ALU_op = rvi_pkg::LH;
                    3'b010: ALU_op = rvi_pkg::LW;
                    3'b100: ALU_op = rvi_pkg::LBU;
                    3'b101: ALU_op = rvi_pkg::LHU;
                    3'b110: ALU_op = rvi_pkg::LWU;
                    3'b011: ALU_op = rvi_pkg::LD;
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::STORE_OPS: begin
                case (funct3)
                    3'b000: ALU_op = rvi_pkg::SB;
                    3'b001: ALU_op = rvi_pkg::SH;
                    3'b010: ALU_op = rvi_pkg::SW;
                    3'b011: ALU_op = rvi_pkg::SD;
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::IMM_OPS: begin
                case (funct3)
                    3'b000: ALU_op = rvi_pkg::ADDI;
                    3'b010: ALU_op = rvi_pkg::SLTI;
                    3'b011: ALU_op = rvi_pkg::SLTIU;
                    3'b100: ALU_op = rvi_pkg::XORI;
                    3'b110: ALU_op = rvi_pkg::ORI;
                    3'b111: ALU_op = rvi_pkg::ANDI;
                    3'b001: ALU_op = rvi_pkg::SLLI;
                    3'b101: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::SRLI;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SRAI;
                        end
                    end
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::IMM64_OPS: begin
                case (funct3)
                    3'b000: ALU_op = rvi_pkg::ADDIW;
                    3'b001: ALU_op = rvi_pkg::SLLIW;
                    3'b101: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::SRLIW;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SRAIW;
                        end
                    end
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::REG_OPS: begin
                case (funct3)
                    3'b000: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::ADD;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SUB;
                        end
                    end

                    3'b001: ALU_op = rvi_pkg::SLL;
                    3'b010: ALU_op = rvi_pkg::SLT;
                    3'b011: ALU_op = rvi_pkg::SLTU;
                    3'b100: ALU_op = rvi_pkg::XOR;
                    3'b101: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::SRL;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SRA;
                        end
                    end
                    3'b110: ALU_op = rvi_pkg::OR;
                    3'b111: ALU_op = rvi_pkg::AND;
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::REG64_OPS: begin
                case (funct3)
                    3'b000: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::ADDW;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SUBW;
                        end
                    end
                    3'b001: ALU_op = rvi_pkg::SLLW;
                    3'b101: begin
                        if (funct7_b5 == 1'b0) begin
                            ALU_op = rvi_pkg::SRLW;
                        end else if (funct7_b5 == 1'b1) begin
                            ALU_op = rvi_pkg::SRAW;
                        end
                    end
                    default: ALU_op = rvi_pkg::ALU_ZERO;
                endcase
            end

            rvi_pkg::FENCE_OPS: begin // Memory ordering
                ALU_op = rvi_pkg::ALU_ZERO;

                //ALU_op = FENCE;
            end

            rvi_pkg::ENV_OPS: begin
                ALU_op = rvi_pkg::ALU_ZERO;

                /*
                if (instr[31:20] == 12'b000_000_000_000) begin
                    ALU_op = ECALL;
                end else begin
                    ALU_op = EBREAK;
                end
                */

            end

            default: begin
                ALU_op = rvi_pkg::ALU_ZERO;
            end
        endcase
    end
endmodule

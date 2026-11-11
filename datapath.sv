// Data Path package - Wires that connect components.
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::ALU_OP_NUM;
import rvi_pkg::RF_ADDR_WIDTH;
import rvi_pkg::opcode_t;
import rvi_pkg::ALU_t;
import rvi_pkg::IMM_t;
import rvi_pkg::ALU_NUM;

package datapath;

    // PC
    logic [RV_INSTR_WIDTH - 1:0] addr;

    // IMEM
    logic [RV_INSTR_WIDTH - 1:0] instr;

    // CU
    opcode_t opcode;

    logic PC_src;
    logic mem_rd_en;
    logic [1:0] mem_to_reg_src;
    logic mem_wr_en;
    logic ALU_src;
    logic reg_wr_en;
    logic ext_en;
    IMM_t IMM_src;
    logic [rvi_pkg::ALU_NUM - 1:0] ALU_opcode;

    // RF
    logic [RF_ADDR_WIDTH - 1:0] rs1_in;
    logic [RF_ADDR_WIDTH - 1:0] rs2_in;
    logic [RF_ADDR_WIDTH - 1:0] rd_in;
    logic [RV_INSTR_WIDTH - 1:0] reg_wr_data;
    logic [RV_INSTR_WIDTH - 1:0] rs1_out;
    logic [RV_INSTR_WIDTH - 1:0] rs2_out;

    // ALU_CU
    logic [2:0] funct3;
    logic funct7_b5;
    ALU_t ALU_op;

    // IMM_Gen
    logic [RV_INSTR_WIDTH -1:0] IMM_Offset;

    // Sign-Ext
    logic [RV_INSTR_WIDTH - 1:0] SER;

    // ALU RS2 Mux
    logic [RV_INSTR_WIDTH - 1:0] ALU_rs2;
    // ALU
    logic [RV_INSTR_WIDTH-1:0] ALU_res;
    logic ALU_zero;

    // DMEM
    logic [RV_INSTR_WIDTH - 1:0] mem_rd_data;

    // Write-Back Mux
    logic [RV_INSTR_WIDTH - 1:0] reg_wr_back;

endpackage

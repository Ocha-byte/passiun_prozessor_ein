// RISC-V Core module - Connects components.
`include "rvi_pkg.sv";
`include "datapath.sv";

import rvi_pkg::opcode_t;
import datapath::instr;
import datapath::IMM_src;

module RV_Core (
    input logic clk,
    input logic rst
);

    // PC
    PC PC (
        .clk(clk),
        .rst(rst),
        .ALU_zero(datapath::ALU_zero),
        .PC_src(datapath::PC_src),
        .IMM_Offset(datapath::IMM_Offset),
        .addr(datapath::addr)
    );

    // IMEM
    IMEM IMEM (
        .addr(datapath::addr),
        .instr(datapath::instr)
    );

    // CU
    CU CU (
        .opcode(rvi_pkg::opcode_t'(datapath::instr[6:0])),
        .PC_src(datapath::PC_src),
        .mem_rd_en(datapath::mem_rd_en),
        .mem_to_reg_src(datapath::mem_to_reg_src),
        .mem_wr_en(datapath::mem_wr_en),
        .ALU_src(datapath::ALU_src),
        .reg_wr_en(datapath::reg_wr_en),
        .ext_en(datapath::ext_en),
        .IMM_src(datapath::IMM_src),
        .ALU_opcode(datapath::ALU_opcode)
    );

    // RF
    RF RF (
        .clk(clk),
        .rst(rst),

        .reg_wr_en(datapath::reg_wr_en),

        .rs1_in(datapath::instr[19:15]),
        .rs2_in(datapath::instr[24:20]),
        .rd_in(datapath::instr[11:7]),

        .reg_wr_data(datapath::reg_wr_back),
        .rs1_out(datapath::rs1_out),
        .rs2_out(datapath::rs2_out)
    );

    // ALU_CU
    ALU_CU ALU_CU (
        .funct3(datapath::instr[14:12]),
        .funct7_b5(datapath::instr[30]),
        .ALU_opcode(datapath::ALU_opcode),
        .ALU_op(datapath::ALU_op)
    );

    // IMM_Gen
    IMM_Gen IMM_Gen (
        .instr(datapath::instr[31:7]),
        .IMM_src(datapath::IMM_src),
        .IMM_Offset(datapath::IMM_Offset)
    );

    // Sign-Ext
    Sign_Ext Sign_Ext (
        .ext_en(datapath::ext_en),
        .opcode(rvi_pkg::opcode_t'(datapath::instr[6:0])),
        .instr_upper(datapath::instr[31:12]),
        .PC(datapath::addr),
        .SER(datapath::SER)
    );

    // ALU RS2 Mux
    mux2 ALU_mux (
        .rs2_out(datapath::rs2_out),
        .IMM_Offset(datapath::IMM_Offset),
        .ALU_src(datapath::ALU_src),
        .ALU_rs2(datapath::ALU_rs2)
    );

    // ALU
    ALU ALU (
        .rs1(datapath::rs1_out),
        .rs2(datapath::ALU_rs2),
        .ALU_op(datapath::ALU_op),
        .ALU_res(datapath::ALU_res),
        .ALU_zero(datapath::ALU_zero)
    );

    // DMEM
    DMEM DMEM (
        .clk(clk),
        .rst(rst),
        .mem_wr_en(datapath::mem_wr_en),
        .mem_rd_en(datapath::mem_rd_en),
        .addr(datapath::ALU_res),
        .mem_wr_data(datapath::rs2_out),
        .mem_rd_data(datapath::mem_rd_data)
    );

    // Write-back mux
    mux3 WB_mux (
        .mem_rd_data(datapath::mem_rd_data),
        .ALU_res(datapath::ALU_res),
        .SER(datapath::SER),
        .mem_to_reg_src(datapath::mem_to_reg_src),
        .reg_wr_back(datapath::reg_wr_back)
    );

endmodule

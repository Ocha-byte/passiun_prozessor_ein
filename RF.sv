// Register File module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::RF_ADDR_WIDTH;
import rvi_pkg::RF_NUM;

module RF (
    input logic clk, rst, reg_wr_en,
    input logic [RF_ADDR_WIDTH - 1:0] rs1_in, rs2_in, rd_in,
    input logic [RV_INSTR_WIDTH - 1:0] reg_wr_data,

    output logic [RV_INSTR_WIDTH - 1:0] rs1_out, rs2_out
);

    // Declare file with 32 entries, 64-bit registers.
    logic [RV_INSTR_WIDTH - 1:0] RF_Store[rvi_pkg::RF_NUM - 1:0];

    // Synchronous write logic
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            for (int i = 0; i < rvi_pkg::RF_NUM; i = i + 1) begin
                RF_Store[i] <= RV_INSTR_WIDTH'('b0);
            end
        end else begin
            if (reg_wr_en) begin
                RF_Store[rd_in] <= reg_wr_data;
            end
        end
    end

    // Asynchronous read logic.
    assign rs1_out = RF_Store[rs1_in];
    assign rs2_out = RF_Store[rs2_in];

    //assign rs1_out = (rs1_in != 0) ? RF_Store[rs1_in] : 0;
    //assign rs2_out = (rs2_in != 0) ? RF_Store[rs2_in] : 0;

endmodule

// Arithmetic Logic Unit module
`include "rvi_pkg.sv";

import rvi_pkg::RV_INSTR_WIDTH;
import rvi_pkg::MEM_DEPTH;

module DMEM (
    input logic clk, rst,
    input logic mem_wr_en,
    input logic mem_rd_en,

    input logic [RV_INSTR_WIDTH - 1:0] addr, mem_wr_data,
    output logic [RV_INSTR_WIDTH - 1:0] mem_rd_data
);

    // Declare memory
    logic [RV_INSTR_WIDTH - 1:0] DMEM_Store[rvi_pkg::MEM_DEPTH -1:0];

    // Asynchronous read logic.
    assign mem_rd_data = DMEM_Store[addr[RV_INSTR_WIDTH - 1:2]]; // Word-aligned.

    // Synchronous write logic.
    always_ff @(posedge clk, posedge rst) begin
        if (rst) begin
            for (int i = 0; i < rvi_pkg::MEM_DEPTH; i = i + 1) begin
                DMEM_Store[i] <= RV_INSTR_WIDTH'('b0); // Fill memory with zeros.
            end
        end else if (mem_wr_en) begin
            DMEM_Store[addr[RV_INSTR_WIDTH - 1:2]] <= mem_wr_data; // Word-aligned.
        end
    end

endmodule

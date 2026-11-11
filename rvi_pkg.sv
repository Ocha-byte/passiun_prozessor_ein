package rvi_pkg;

    // General
    parameter RV_INSTR_WIDTH = 32; // 32-bit
    parameter RV_DATA_WIDTH = 2*RV_INSTR_WIDTH; // 64-bit

    // Memory
    parameter ADDR_WIDTH = 12;
    parameter MEM_DEPTH = 2**(ADDR_WIDTH); // 2^10 = 1024 entries

    // Register File
    parameter RF_ADDR_WIDTH = 5;
    parameter RF_NUM = 2**(RF_ADDR_WIDTH); // 2^5 = 32 registers

    // ALU - Operations
    parameter ALU_NUM = 7;
    parameter ALU_OP_NUM = 6; // 2^6 = 64 operations.
    parameter CU_OP_NUM = 7; // CU Opcodes.

    typedef enum logic [CU_OP_NUM - 1:0] {
        LUI_OP = 7'b011_0111,
        AUIPC_OP = 7'b001_0111,
        JAL_OP = 7'b110_1111,
        JALR_OP = 7'b110_0111,
        BRANCH_OPS = 7'b110_0011,
        LOAD_OPS = 7'b000_0011,
        STORE_OPS  = 7'b010_0011,
        IMM_OPS = 7'b001_0011,
        IMM64_OPS = 7'b001_1011,
        REG_OPS  = 7'b011_0011,
        REG64_OPS = 7'b011_1011,
        FENCE_OPS = 7'b000_1111,
        ENV_OPS = 7'b111_0011,
        NOP = 7'b0_000_000
    } opcode_t;

    typedef enum logic [2:0] {
        R_type = 3'b000,
        I_type = 3'b001,
        S_type = 3'b010,
        B_type = 3'b011,
        U_type = 3'b100,
        J_type = 3'b101,
        No_type = 3'b110
    } IMM_t;

    typedef enum logic [ALU_OP_NUM-1:0] {

        ALU_ZERO = ALU_OP_NUM'('d0),

        // R-type
        ADD = ALU_OP_NUM'('d1),
        SUB = ALU_OP_NUM'('d2),
        SLL = ALU_OP_NUM'('d3),
        SLT = ALU_OP_NUM'('d4),
        SLTU = ALU_OP_NUM'('d5),
        XOR = ALU_OP_NUM'('d6),
        SRL = ALU_OP_NUM'('d7),
        SRA = ALU_OP_NUM'('d8),
        OR = ALU_OP_NUM'('d9),
        AND = ALU_OP_NUM'('d10),

        ADDW = ALU_OP_NUM'('d11),
        SUBW = ALU_OP_NUM'('d12),
        SLLW = ALU_OP_NUM'('d13),
        SRLW = ALU_OP_NUM'('d14),
        SRAW = ALU_OP_NUM'('d15),

        // I-type
        JALR = ALU_OP_NUM'('d16),
        LB = ALU_OP_NUM'('d17),
        LH = ALU_OP_NUM'('d18),
        LW = ALU_OP_NUM'('d19),
        LBU = ALU_OP_NUM'('d20),
        LHU = ALU_OP_NUM'('d21),
        LWU = ALU_OP_NUM'('d22),
        LD = ALU_OP_NUM'('d23),

        ADDI = ALU_OP_NUM'('d24),
        ADDIW = ALU_OP_NUM'('d25),
        SLTI = ALU_OP_NUM'('d26),
        SLTIU = ALU_OP_NUM'('d27),
        XORI = ALU_OP_NUM'('d28),
        ORI = ALU_OP_NUM'('d29),
        ANDI = ALU_OP_NUM'('d30),
        SLLI = ALU_OP_NUM'('d31),
        SRLI = ALU_OP_NUM'('d32),
        SRAI = ALU_OP_NUM'('d33),
        SLLIW = ALU_OP_NUM'('d34),
        SRLIW = ALU_OP_NUM'('d35),
        SRAIW = ALU_OP_NUM'('d36),

        // Used in pipelines - finish one process before starting the next.
        // Implemented as NOP.
        FENCE = ALU_OP_NUM'('d37),

        // Encoded as Fence instruction
        // it is a HINT - Software can use to reduce energy consumption.
        // https://riscv.github.io/riscv-unified-db/manual/html/isa/isa_20240411/insts/pause.html
        // Implemented as NOP.
        PAUSE = ALU_OP_NUM'('d38),

        // Ask the OS what to do - RARS. - Takes multiple cycles to complete!
        // Implemented as NOP.
        ECALL = ALU_OP_NUM'('d39),

        // Breakpoint - for debug - Takes multiple cycles to complete!
        // Implemented as NOP.
        EBREAK = ALU_OP_NUM'('d40),

        // S-type
        SB = ALU_OP_NUM'('d41),
        SH = ALU_OP_NUM'('d42),
        SW = ALU_OP_NUM'('d43),
        SD = ALU_OP_NUM'('d44),

        // B-type
        BEQ = ALU_OP_NUM'('d45),
        BNE = ALU_OP_NUM'('d46),
        BLT = ALU_OP_NUM'('d47),
        BGE = ALU_OP_NUM'('d48),
        BLTU = ALU_OP_NUM'('d49),
        BGEU = ALU_OP_NUM'('d50),

        // J-type
        JAL = ALU_OP_NUM'('d51) // 'b110_011
    } ALU_t;

endpackage

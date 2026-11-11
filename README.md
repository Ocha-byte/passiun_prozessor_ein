# passiun_prozessor_ein
A single-cycle RV32I Core capable of processing 37/42 instructions of the RV32I v2.1 Spec.

The instructions FENCE, ECALL, EBREAK return NOP.

To simulate the core
1. verilator -f verilator.f
2. ./obj/VRV_TB
3. Check waveform viewer

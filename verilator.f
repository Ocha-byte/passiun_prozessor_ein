
// Timescale
--timescale 1ns/1ps

//--timescale-override <timescale>  Overrides all timescales

// module.sv
RV_Core.sv

// testbench.sv
RV_TB.sv

// top module
--top RV_TB

// generate executable binary
--binary

// Translate sv to C++
//--cc

// lint only
//--lint-only

// All warnings
-Wall

// Disable %Warning-UNUSEDPARAM
-Wno-UNUSEDPARAM

// Disable %Warning-UNUSEDSIGNAL
-Wno-UNUSEDSIGNAL

// Disable %Warning-IMPORTSTAR
//-Wno-IMPORTSTAR

// Disable module duplication warning
-Wno-MODDUP

// Disable %Warning-WIDTHTRUNC
-Wno-WIDTHTRUNC

// Disable %Warning-VARHIDDEN
-Wno-VARHIDDEN

// Disable missing time scale warning
//-Wno-TIMESCALEMOD

// Disable zero delay warning
-Wno-ZERODLY

// Disable source context on warnings
//-Wno-context

// Disable fatal exit on warnings
//-Wno-fatal

// Disable all lint warnings
//-Wno-lint

// Disable all style warnings
//-Wno-style

// Timing
--timing

// Multithreading
-j 0

// SystemVerilog assertions
--assert

// dump waveform as FST
--trace-fst

// Human readable structs
--trace-structs

// Tracing depth
//--trace-depth 4

// Tracing coverage
//--trace-coverage

// Random intergers for unknown values
--x-assign unique

// Custom inital values of all signals
--x-initial unique

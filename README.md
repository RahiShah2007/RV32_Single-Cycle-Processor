# RV32_Single-Cycle-Processor
 This RISCV processor 32 bits is a single cycle processor that performs various instructions such as addition,subtraction,fibonacci series and lot more, this processor is based on VHDL language 
# 32-Bit Single-Cycle RISC-V Processor (RV32I) in VHDL

A 32-bit single-cycle RISC-V microprocessor designed and verified from scratch in VHDL using Xilinx Vivado. Every sub-module was built and unit-tested individually before integrating the complete datapath to execute a Fibonacci sequence program.

# Supported Instructions
* **R-Type:** `ADD`, `SUB`, `AND`, `OR`, `XOR`, `SLT`, `SLL`, `SRL`
* **I-Type:** `ADDI`, `ANDI`, `ORI`, `XORI`
* **Memory:** `LW`, `LB`, `SW`, `SB`
* **Branches & Jumps:** `BEQ`, `BNE`, `BLT`, `BGT` (`BGE`), `JAL`, `JALR`

## Architecture & Module Breakdown
The processor follows a classic 5-stage single-cycle datapath where every instruction completes in one clock cycle:

* **Instruction Fetch:**
  * `PC.vhd`: 32-bit Program Counter with active-low asynchronous reset.
  * `Instruction_Mem.vhd`: Byte-addressed instruction ROM storing 32-bit machine code.
* **Instruction Decode:**
  * `Control.vhd`: Main combinational decoder mapping `opcode`, `funct3`, and `funct7` to 8 datapath control signals.
  * `Immediate_gen.vhd`: Parallel bit-slicer and two's-complement sign extender for I, S, SB, and UJ formats.
  * `reg.vhd`: 32x32-bit register file with synchronous writes, dual asynchronous reads, and hardwired `x0 = 0` protection.
* **Execution:**
  * `ALU_32.vhd`: 32-bit ALU featuring a 5-stage combinational barrel shifter, 33-bit add/subtract overflow detection, and `zero`/`sign` status flags.
  * `Branch_ctrl.vhd`: Evaluates branch conditions and jump signals to drive `PCSrc`.
  * `mux_32b.vhd`: Reusable 32-bit 2-to-1 multiplexer used across ALU operand selection, store masking, and PC branching.
* **Memory & Writeback:**
  * `Data_memory.vhd`: Little-endian byte-addressable RAM with synchronous writes and asynchronous reads.
  * `Mux_ToReg.vhd`: 6-to-1 writeback multiplexer with 8-to-32-bit sign extension for `LB`.
* **Top-Level Integration:**
  * `DataPath.vhd`: Structural top-level file wiring all components, PC+4 adder, and branch target shift-add logic together.

## Key Design Improvements & Bug Fixes
While building and testing the RTL, several hardware details were refined and fixed:
1. **`OR` & `ORI` Control Decoding:** Fixed conflicting `ALUOp` assignments in the control unit so both bitwise OR instructions properly select `ALUOp = "001"`.
2. **`SLT` Comparison Logic:** Corrected the signed comparison check in the ALU (`sub(31) = '1'`) so `Set Less Than` properly flags negative subtraction results.
3. **Little-Endian Memory Alignment:** Implemented standard RISC-V little-endian byte ordering in `Data_memory.vhd`.
4. **Clean RTL Refactoring:** Removed unused generics, redundant libraries, and dead signals to keep every module lightweight and warning-free in simulation.


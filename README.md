# RV32I Single-Cycle CPU

A 32-bit RISC-V single-cycle processor designed and implemented using Verilog HDL. This project focuses on processor architecture, RTL design, datapath implementation, control logic, functional verification, synthesis, and implementation analysis.

## Overview

This project implements a simplified RV32I processor architecture in which each supported instruction completes its execution within a single clock cycle.

The processor consists of a program counter, instruction memory, control unit, register file, immediate generator, arithmetic logic unit (ALU), data memory, and writeback logic.

## Supported Instructions

The processor currently supports the following 10 instructions:

| Category | Instruction | Description |
|---|---|---|
| Arithmetic | ADD | Register addition |
| Arithmetic | SUB | Register subtraction |
| Immediate | ADDI | Addition with immediate |
| Memory | LW | Load word |
| Memory | SW | Store word |
| Branch | BEQ | Branch if equal |
| Jump | JAL | Jump and link |
| Jump | JALR | Jump and link register |
| Upper Immediate | LUI | Load upper immediate |
| Upper Immediate | AUIPC | Add upper immediate to PC |

## Architecture

The processor follows a single-cycle datapath architecture.

### Main RTL Modules

| Module | Function |
|---|---|
| `rv32i_single_cycle.v` | Top-level processor integration |
| `pc.v` | Program counter |
| `instruction_memory.v` | Instruction storage and retrieval |
| `control_unit.v` | Instruction decoding and control signal generation |
| `regfile.v` | 32 × 32-bit register file |
| `imm_gen.v` | Immediate value generation |
| `alu.v` | Arithmetic and logical operations |
| `data_memory.v` | Data memory for load and store operations |

## Verification

Functional verification was initially performed using a directed Verilog testbench in ModelSim.

The original directed testbench covered:
- Arithmetic and immediate operations
- Register file read/write behavior
- Load and store operations
- Conditional branching
- Jump and link operations
- Upper immediate instructions
- Jump target execution and link addresses

### Original Behavioral Verification Results

The original directed behavioral simulation reported PASS results for all 10 supported instructions.

**Overall original behavioral simulation: PASS**

Note: The current `tb/full_cpu_tb.v` has since been changed to a trace-based testbench for post-synthesis functional simulation. The original directed checks are not currently present in this file.

### Post-Synthesis Functional Simulation

Post-synthesis functional simulation was performed using Vivado Simulator.

The trace-based testbench monitors:
- Program counter (`debug_pc`)
- Current instruction (`debug_instruction`)
- ALU result (`debug_alu_result`)

The simulation trace demonstrates execution of arithmetic, memory, branch, and jump instructions, including PC redirection through BEQ, JAL, and JALR.

## Synthesis and Implementation

RTL synthesis and implementation were completed successfully in AMD Vivado 2025.2 for the target FPGA part `xc7a35tcpg236-1`.

### Synthesis Utilization

| Resource | Used |
|---|---:|
| LUTs | 534 |
| Flip-flops | 40 |
| I/O ports | 98 |
| LUTs as Memory | 176 |
| BUFGCTRL | 1 |

### Timing Analysis

The implementation timing summary reported:

| Metric | Result |
|---|---:|
| Worst Negative Slack (WNS) | +0.165 ns |
| Total Negative Slack (TNS) | 0 ns |
| Worst Hold Slack (WHS) | +0.328 ns |
| Total Hold Slack (THS) | 0 ns |
| Setup failing endpoints | 0 |
| Hold failing endpoints | 0 |

The timing summary shows no failing setup or hold endpoints for the analyzed implementation.

### Design Rule Checks

Implementation completed successfully, but the DRC report contains warnings related to:
- Unspecified I/O standards (NSTD-1)
- Unassigned package pins (UCIO-1)
- Unspecified configuration voltage settings (CFGBVS-1)

These constraints have not been assigned because a physical FPGA board and its pinout are not available. Bitstream generation and physical FPGA testing have therefore not been completed.

## Tools Used

- Verilog HDL
- AMD Vivado 2025.2
- ModelSim
- Git and GitHub

## Future Improvements

- Expand instruction-set support toward full RV32I compatibility.
- Restore and expand directed behavioral verification.
- Develop randomized verification.
- Improve timing and resource utilization.
- Add board-specific pin and I/O constraints when hardware is available.
- Generate a bitstream and perform physical FPGA testing.
- Explore ASIC physical design and implementation.

## Project Status

**A 10-instruction RV32I single-cycle CPU subset has been implemented, behaviorally tested, synthesized, and successfully implemented in Vivado.**

Post-synthesis functional simulation and implementation timing analysis have also been performed.

Physical FPGA validation and full RV32I instruction support remain future work.

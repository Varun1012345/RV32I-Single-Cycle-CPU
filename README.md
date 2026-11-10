# RV32I Single-Cycle CPU

A 32-bit RISC-V single-cycle processor designed and implemented using Verilog HDL. This project focuses on processor architecture, RTL design, datapath implementation, control logic, and functional verification.

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

Functional verification was performed using a Verilog testbench in ModelSim.

The testbench checks:
- Arithmetic and immediate operations
- Register file read/write behavior
- Load and store operations
- Conditional branching
- Jump and link operations
- Upper immediate instructions
- Jump target execution and link addresses

### Verification Results

| Instruction | Result |
|---|---|
| ADD | PASS |
| SUB | PASS |
| ADDI | PASS |
| LW | PASS |
| SW | PASS |
| BEQ | PASS |
| JAL | PASS |
| JALR | PASS |
| LUI | PASS |
| AUIPC | PASS |

**Overall functional simulation: PASS**

## Tools Used

- Verilog HDL
- ModelSim
- Git and GitHub

## Repository Structure

```text
RV32I-Single-Cycle-CPU/
│
├── rtl/
│   ├── alu.v
│   ├── control_unit.v
│   ├── data_memory.v
│   ├── imm_gen.v
│   ├── instruction_memory.v
│   ├── pc.v
│   ├── regfile.v
│   └── rv32i_single_cycle.v
│
├── tb/
│   └── full_cpu_tb.v
│
├── README.md
└── .gitignore
```

## Future Improvements

- Expand instruction-set support.
- Develop more comprehensive directed and randomized verification.
- Perform RTL synthesis and area analysis.
- Conduct static timing analysis.
- Explore ASIC physical design and implementation.

## Project Status

**RTL implementation and functional simulation completed for the selected 10 instructions.**

Synthesis, timing analysis, and physical implementation are planned as future stages.

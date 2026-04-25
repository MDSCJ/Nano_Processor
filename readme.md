# 4-Bit NanoProcessor in VHDL ⚡

![VHDL](https://img.shields.io/badge/Language-VHDL-blue.svg)
![EDA Tool](https://img.shields.io/badge/EDA-Xilinx_Vivado-orange.svg)
![Platform](https://img.shields.io/badge/Board-Basys_3-brightgreen.svg)

A modular, 4-bit custom microprocessor designed from scratch using VHDL and synthesized for the Xilinx Vivado environment. This project demonstrates foundational computer architecture concepts, including data paths, control units, arithmetic logic operations, and assembly instruction execution.

## 📋 Table of Contents
- [Architecture Overview](#-architecture-overview)
- [Instruction Set Architecture (ISA)](#-instruction-set-architecture-isa)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Getting Started](#-getting-started)
- [Simulation & Testing](#-simulation--testing)

---

## 🏛 Architecture Overview

The NanoProcessor follows a Harvard-like architecture with a 12-bit instruction word and a 4-bit data path. The system is highly modular and consists of the following core components:

* **Instruction ROM:** 8x12-bit Read-Only Memory storing the compiled machine code.
* **Instruction Decoder:** Parses the 12-bit instruction to generate necessary control signals (Enables, Selectors).
* **Program Counter (PC):** A 3-bit register tracking the current execution address.
* **Register Bank:** Eight 4-bit D-Flip Flop registers (`R0` to `R7`). *Note: `R0` is hardwired to `0000`.*
* **Arithmetic Logic Unit (ALU):** Performs 4-bit addition and 2's complement subtraction. Features a `Zero` flag output.
* **Multiplexers:** Used for data routing (e.g., 2-way MUX for Immediate Value vs. ALU result, 8-way MUX for Register selection).

---

## 🧮 Instruction Set Architecture (ISA)

The processor executes a custom 12-bit instruction set. The instruction word is divided into the Opcode, Destination Register, Source Register, and Immediate Value/Address fields.

| Instruction | Opcode | Action | 12-Bit Binary Format | Example |
| :--- | :---: | :--- | :--- | :--- |
| **ADD** | `00` | Adds the values of two registers and stores the result in the target register. | `00` `RRR` `RRR` `0000` | `00 111 001 0000` (ADD R7, R1) |
| **NEG** | `01` | Performs 2's complement (negation) on a register and overwrites it. | `01` `RRR` `000` `0000` | `01 111 000 0000` (NEG R7) |
| **MOVI** | `10` | Moves a 4-bit immediate (hardcoded) value into a register. | `10` `RRR` `000` `VVVV` | `10 010 000 0011` (MOVI R2, 3) |
| **JZR** | `11` | Jumps to a specific ROM address **IF** the checked register equals 0. | `11` `RRR` `000` `0AAA` | `11 001 000 0101` (JZR R1, 5) |

*(Note: `R` = Register Address, `V` = Immediate Value, `A` = Jump Address)*

---

## 📂 Project Structure

```text
├── src/
│   ├── Add_Sub_4.vhd         # 4-bit Arithmetic Logic Unit
│   ├── Instruction_Decoder.vhd # Control Signal Generator
│   ├── MUX_2_to_1_4bit.vhd   # Data routing multiplexers
│   ├── MUX_8_to_1_4bit.vhd   # Register selection multiplexers
│   ├── PC.vhd                # 3-bit Program Counter
│   ├── Reg_Bank.vhd          # 8x4-bit Register Bank
│   ├── ROM.vhd               # Instruction Memory
│   └── NanoProcessor.vhd     # Top-Level Structural Entity
├── sim/
│   └── tb_NanoProcessor.vhd  # Behavioral Testbench
├── constraints/
│   └── Basys3Labs.xdc        # Pin mapping for physical FPGA testing
└── README.md

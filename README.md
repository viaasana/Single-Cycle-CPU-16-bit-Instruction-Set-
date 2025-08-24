# Single-Cycle-CPU-16-bit-Instruction-Set-
### 📌 Overview
This project implements a single-cycle CPU with a custom 16-bit instruction set architecture (ISA). It supports arithmetic, logic, shift, jump, and I/O operations, making it a good example of how a processor fetches, decodes, and executes instructions in hardware.  The design is written in Verilog HDL and verified with a testbench.

## 🏗️ Instruction Set
[View Instructions Decode](Control_Unit/Control_Unit.v)

Each instruction is 16 bits:

### 1. Register-Register (RR)
**Opcode:** `000`

**Format:**
| Opcode | R1     | R2     | RD     | FUNC  |
| ------ | ------ | ------ | ------ | ----- |
| 3 Bits | 3 Bits | 3 Bits | 3 Bits | 4 Bits| 

**Operations:**
| FUNC  | Instruction | Description       |
|-------|-------------|-------------------|
| 0000  | ADD         | RD ← R1 + R2      |
| 0001  | INC         | RD ← R1 + 1       |
| 0010  | SUB         | RD ← R1 - R2      |
| 0011  | DEC         | RD ← R1 - 1       |
| 0100  | AND         | RD ← R1 & R2      |
| 0101  | OR          | RD ← R1 \| R2     |
| 0110  | XOR         | RD ← R1 ^ R2      |
| 0111  | NAND        | RD ← ~(R1 & R2)   |
| 1000  | SHL1        | RD ← R1 << 1      |
| 1001  | SHL2        | RD ← R1 << 2      |
| 1010  | SHL3        | RD ← R1 << 3      |
| 1011  | SHL4        | RD ← R1 << 4      |
| 1100  | SHR1        | RD ← R1 >> 1      |
| 1101  | SHR2        | RD ← R1 >> 2      |
| 1110  | SHR3        | RD ← R1 >> 3      |
| 1111  | SHR4        | RD ← R1 >> 4      |

### 2. Register-Register-Immediate (RRI)
**Opcode:** `010` and `011`

**Fortmat:**
| Opcode | R1 | R2 | Immediate      |
| ------ | -- | -- | -------------- |
| 3 Bits | 3 Bits | 3 Bits | 7 Bits |

**Operations:**
| Opcode | Instruction | Description         |
|--------|-------------|---------------------|
| 010    | JUM         | PC = R1==R2?Imm:PC+1|
| 011    | JR          | PC = R1             |

### 3. Input-Output
**Opcode:** `100` and `101`

**Fortmat:**
| Opcode | R      |
|--------|--------|
| 3 Bits | 3 Bits |

**Operations:**
| Opcode | Instruction | Description         |
|--------|-------------|---------------------|
| 100    | Get Input   | R = Input           |
| 101    | Output      |data_out = R         |

## ⚙️ Testbench 
[View Testbench](tb_Single_Circle_CPU.v)

A Verilog testbench is provided to:
 - Load instructions into CPU
 - Provide input values
 - Observe outputs
 - Verify correctness of all instructions
Example (simplified):
``` verilog
instruction_in = 16'b1000000000000000; // LINP -> R0
instruction_in = 16'b1000010000000000; // LINP -> R1
instruction_in = 16'b0000000010100000; // ADD R0 + R1 -> R2
instruction_in = 16'b1010100000000000; // WOUT R2
```

## 🎯 Features
 - Custom 16-bit ISA
 - Supports arithmetic, logic, shifts, jumps, and I/O
 - Single-cycle execution (one clock per instruction)
 - Modular Verilog design with testbench
 - Demonstrates fundamental CPU architecture concepts

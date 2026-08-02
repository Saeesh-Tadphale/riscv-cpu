# RISC-V CPU — Verilog Implementation

A pipelined 32-bit RISC-V (RV32I) processor built from scratch in Verilog, targeting the Digilent Basys 3 (Artix-7) FPGA. This is a summer project built to develop practical digital design and computer architecture skills
relevant to the semiconductor industry.

**Built by:** Saeesh Tadphale  
**University:** Carleton University: Electrical Engineering with a Physics Minor
**Tools:** Vivado ML Standard 2025.2, Verilog, Basys 3 Artix-7 FPGA  
**Reference:** *Digital Design and Computer Architecture: RISC-V Edition* by  Harris & Harris

---

## PROJECT GOAL

Design and implement a fully functional pipelined RISC-V CPU in Verilog over 12 weeks, starting from basic digital logic all the way to running fully functioning C programs on FPGA hardware. This project is to learn how CPUs
function and to target internships at semiconductor companies like Intel, AMD, Qualcomm, and Texas Instruments. \

---

## Roadmap

| Phase | Weeks | Goal |
|---|---|---|
| Foundations | 1–3 | Verilog refresh, ALU, RISC-V ISA study |
| Single-Cycle CPU | 4–6 | Full RV32I single-cycle datapath |
| Pipelined CPU | 7–9 | 5-stage pipeline with hazard handling |
| Stretch Goals | 10–12 | UART, run compiled C programs |

---

## Repository Structure

```
riscv-cpu/
├── Week 1/
│   ├── and_or_gates.v       # Combinational AND/OR gate demo
│   ├── Basys-3-Master.xdc   # Basys 3 constraints file
│   ├── fourbit_reg.v        # Parameterized N-bit register
│   └── fourBit_reg_tb.v     # Testbench for register
├── Week 2/
│   ├── ALU.v                # 32-bit Arithmetic Logic Unit      
│   ├── ALU_TB.v             # Testbench for ALU
├── Week 3/                  # Coming soon — RISC-V ISA study & register file
│   ├── regFile.v            # 32x32 RISC-V register file
│   └── reg_TB.v             # Testbench for register file
├── Week 4/                  # Coming soon — Fetch & Decode stages
│   ├── PC.v                 # 32-bit Program Counter
│   ├── imem.v               # Instruction memory (ROM)
│   ├── decode.v             # Instruction decoder
│   ├── datapath.v           # Top-level fetch/decode datapath
│   └── datapath_tb.v        # Testbench for datapath
│   ├── fourbit_reg.v        # Parameterized N-bit register that is instantiated by PC
│   ├── regFile.v            # 32x32 RISC-V register file that is instantiated in datapath
├── Week 5/
│   ├── control.v            # Main control unit
│   ├── ALUControl.v         # ALU control sub-decoder
│   ├── dmem.v               # Data memory (RAM)
│   ├── datapath.v           # Updated top-level datapath (full single-cycle CPU)
│   ├── datapath_tb.v        # Testbench for full CPU
│   ├── PC.v                 # Updated PC with next_pc input for branching
│   ├── imem.v               # Updated with real test program
│   ├── ALU.v                # ALU from Week 2 instantiated in datapath
│   ├── decode.v             # Decoder from Week 4
│   └── regFile.v            # Register file from Week 3
├── Week 6/                  # Coming soon — Single-cycle CPU complete
│   ├── imem.v               # Updated with another real test program
├── Week 7/                  # Coming soon — Pipeline registers
└── ...                        
```

---

## Week 1 — Foundations

**Goals:** Set up Vivado, get familiar with XSIM simulation, write first synthesizable Verilog modules, deploy first programs to FPGA hardware.

### AND/OR Gates ('and_or_gates.v')
A simple combinational logic module utilizing all 16 switches and LEDs on the Basys 3:
- **LEDs 0–7:** AND logic — LED lights when both corresponding switches are ON
- **LEDs 8–15:** OR logic — LED lights when either switch is ON

Successfully synthesized and programmed onto the Basys 3

### Parameterized N-bit Register ('fourBit_reg.v')
A clocked, synchronous register with configurable bit width using Verilog parameters
-Synchronous active-high reset
-Clock enable signal
-Default to 4-bit, instantiable at any width (e.g., 32-bit for the CPU register file)

```verilog
// Instantiate as a 32-bit register
register #(32) pc (.clk(clk), .rst(rst), .en(en), .d(d), .q(q));
```

Verified with a behavioral simulation testbench in Vivado XSIM covering reset, enable-off, enable-on, and rest-while-enabled cases.

---

## Week 2 — 32-bit ALU

**Goals:** Design and verify a fully functional 32-bit ALU that supports all possible RV32I arithmetic, logic, comparison, and shift operations.

###ALU ('ALU.v')
A combinational 32-bit Arithmetic Logic Unit implementing all 10 RV32I operations selected via a 4-bit selector:

| Control | Operation | Description |
|---|---|---|
| 4'b0000 | ADD | A + B |
| 4'b0001 | SUB | A - B |
| 4'b0010 | AND | A & B |
| 4'b0011 | OR | A \| B |
| 4'b0100 | XOR | A ^ B |
| 4'b0101 | SLT | 1 if A < B (signed), else 0 |
| 4'b0110 | SLTU | 1 if A < B (unsigned), else 0 |
| 4'b0111 | SLL | A << B[4:0] |
| 4'b1000 | SRL | A >> B[4:0] |
| 4'b1001 | SRA | A >>> B[4:0] (sign-extending) |

Also included a 'Zero' flag output that goes high when the result outputs 0. Will be used later for CPU branch logic.

```verilog
module ALU(
    input [31:0] A, 
    input [31:0] B, 
    input [3:0] sel,
    output [31:0] ALU_out,
    output Zero
    );
```

### ALU TestBench ('ALU_TB.v')
A fully comprehensive testbench incorporating all 10 operations needed for the RV32I instruction set with 36 test cases, including edge cases such as overflow, underflow, negative number comparisons, shift-by-zero, arithmetic right shift extensions, and Zero flag validation. 

Verified in Vivado XSIM - all 36 tests pass.

## Week 3 - RISC-V Register File and ISA Study

**Goals:** Study all 6 RV32I instruction formats and build a register file used to implement the CPU starting in week 4.

### ISA Study
Studying all 6 RV32I instruction formats:

| Format | Instructions | Key Fields |
|---|---|---|
| R-type | ADD, SUB, AND, OR, XOR, SLL, SRL, SRA, SLT, SLTU | opcode, funct3, funct7, rs1, rs2, rd |
| I-type | ADDI, LW, JALR | opcode, funct3, rs1, rd, imm[11:0] |
| S-type | SW | opcode, funct3, rs1, rs2, imm[11:0] |
| B-type | BEQ, BNE, BLT, BGE | opcode, funct3, rs1, rs2, imm[12:1] |
| U-type | LUI, AUIPC | opcode, rd, imm[31:12] |
| J-type | JAL | opcode, rd, imm[20:1] |

### Register File ('regFile.v')
A synchronous 32x32 register file that implements the RISC-V register bank with two asynchronous read ports and one synchronous write port:
- 32 registers that are 32 bits wide ('reg[31:0], regs[31:0])
- Two asynchronous read ports working simultaneously (rd1, rd2)
- One synchronous write port clocked on the rising edge
- x0 hardwired to 0: reads always return 0, writes are ignored.

```verilog
module regFile(
    input clk,
    input we,                  // write enable
    input [4:0] ra1, ra2,      // read addresses
    input [4:0] wa,            // write address
    input [31:0] wd,           // write data
    output [31:0] rd1, rd2     // read data
);
```

### Register File TestBench ('regTB.v')
A comprehensive testbench that tests 7 different groups of tests:
- **Group 1:** Basic read/write and register impedance
- **Group 2:** x0 hardwired to zero rule
- **Group 3:** Write enabled gating
- **Group 4:** Simultaneous dual read ports
- **Group 5:** All 31 writable registers 
- **Group 6:** Boundray cases (x1 - x31)
- **Group 7:** Edge case data values

Verified in Vivado xSim; all tests pass.

## Week 4: Fetch and Decode Stages

**Goals:** Build the fetch and decode stages of the CPU datapath, program counter, instruction memory, instruction decoder, and wire them together into a top-level datapath file

### Program Counter (`PC.v`)
A 32-bit register that holds the current instruction memory address. Increments by 4 every clock cycle. Resets to `0x00000000` on reset. Built using the parameterized register(`fourbit_reg.v`) from Week 1. 

```verilog
module PC(
    input clk,rst,
    output [31:0] pc_out
);
```
### Instruction Memory (`imem.v`)
A 64-word read-only instruction ROM. It takes a byte address from the PC and outputs a corresponding 32-bit instruction. These instructions have been pre-initialized with NOP instructions (32'h00000013`) and are overridden with test instructions for simulation.

```verilog
module imem(
    input [31:0] address,
    output [31:0] instr
);
```

### Instruction Decoder (`decode.v`)
Takes a 32-bit instruction and splits it into the 6 RSVI instructions by extracting all the fields and information using bit slicing. It then properly formats the information using correct sign extension.

| Field | Bits | Description |
|---|---|---|
| opcode | [6:0] | Instruction type |
| rd | [11:7] | Destination register |
| funct3 | [14:12] | Operation modifier |
| rs1 | [19:15] | Source register 1 |
| rs2 | [24:20] | Source register 2 |
| funct7 | [31:25] | Operation modifier 2 |

### Datapath (`datapath.v`)
A top-level module that wires the PC to the instruction memory (IMEM), the decoder, and finally the register file. The operation of this module was verified using a simulation testbench to ensure that it correctly performs instruction fetching and decoding across multiple clock cycles.
---

### Simulation Testbench (`datapath_tb.v`)
A behavioural simulation that instantiates the full datapath and clocks it for 10 cycles, printing the PC, instruction, opcode, rd, rs1, rs2, and immediate every cycle. Verifies that the fetch and decode stages work as intended. 

Test Confirmed:
    - PC starts at 0x00000000 on reset and increments by 4 every cycle
    - ADDI x1, x0, 1 correctly decoded: opcode = 0010011, rd = 1, rs1 = 0, imm = 1
    - ADD x2, x1, x2 correctly decoded: opcode = 0110011, rd = 2, rs1 = 1, rs2 = 2, imm = 0
    - Uninitialized memory slots correctly output NOP (0x00000013)

All verified using Vivado xSim; all cycles produce expected output

## Week 5: Execute, Memory & Writeback

**Goals:** Complete the single-cycle CPU by adding a control unit, ALU control decoder, data memory, writeback mux, and branch logic: making the CPU capable of executing real RISC-V programs.

### Control Unit (`control.v`)
The brain of the CPU. Takes the opcode and generates all control signals for every other module:

| Signal | Description |
|---|---|
| RegWrite | Enable register file write |
| ALUSrc | Select immediate (1) or register (0) as ALU SrcB |
| MemWrite | Enable data memory write |
| MemRead | Enable data memory read |
| Branch | Signal a conditional branch |
| ResultSrc | Select writeback source: ALU result (00) or memory (01) |
| ALUOp | Tell ALU control what category of operation to perform |
| PCSrc | Computed as Branch & Zero: selects branch target or PC+4 |

```verilog
module control(
    input [6:0] opcode,
    input [2:0] funct3,
    input funct7b5,
    input zero,
    output PCSrc,
    output reg RegWrite, ALUSrc, MemWrite, MemRead, Branch,
    output reg [1:0] ResultSrc, ALUOp
);
```

### ALU Control (`ALUControl.v`)
A sub-decoder that takes `ALUOp` from the control unit plus `funct3` and `funct7b5`, and outputs the 4-bit `ALUSel` signal for the week 2 ALU. Handles the ADD/SUB and SRL/SRA disambiguation via `funct7b5`.

### Data Memory (`dmem.v`)
A 64-word synchronous RAM with one asynchronous read port and one synchronous write port. Used by `LW` and `SW` instructions. Initialized to all zeros.

```verilog
module dmem(
    input clk, MemWrite,
    input [31:0] address, wd,
    output [31:0] rd
);
```

### Updated Datapath (`datapath.v`)
Full single-cycle CPU: wires all modules together including the control unit, ALU control, ALU, data memory, ALUSrc mux, writeback mux, and branch logic.

```
PC -> IMEM -> Decode -> RegFile -> ALUSrc mux -> ALU -> Writeback mux -> RegFile write
                                                  |
                                                  v
                                              Data Memory
```

### CPU Testbench (`datapath_tb.v`)
Runs a 5-instruction test program through the CPU and verifies correct execution:

```
ADDI x1, x0, 5: load 5 into x1
ADDI x2, x0, 3: load 3 into x2
ADD  x3, x1, x2: x3 = 8
SW   x3, 0(x3): store 8 to data memory
LW   x4, 0(x3): load 8 back into x4
```

Simulation output confirmed all 5 instructions executed correctly: ALU results, register writes, memory store and load all verified in Vivado xsim.

## Week 6: Complete Single-Cycle CPU

### Instruction Memory (`imem.v`)
A 64-word read-only instruction ROM. It takes a byte address from the PC and outputs a corresponding 32-bit instruction. These instructions have been pre-initialized with NOP instructions (32'h00000013`) and are overridden with test instructions for simulation. Updated with new instructions to test other real scenarios 

```verilog
module imem(
    input [31:0] address,
    output [31:0] instr
);
```
---

## Hardware

- **Board:** Digilent Basys 3 (Xilinx Artix-7 XC7A35T)
- **Toolchain:** AMD Vivado ML Standard 2025.2 (free edition)
- **Simulation:** Vivado xsim

---

## Progress

- [x] Week 1 — Toolchain setup, combinational logic, sequential registers
- [x] Week 2 — 32-bit ALU with comprehensive testbench
- [x] Week 3 — RISC-V ISA study and 32x32 register file
- [x] Week 4 — Fetch & Decode stages: PC, imem, decoder, datapath
- [x] Week 5 — Execute, Memory & Writeback
- [x] Week 6 — Single-cycle CPU complete
- [ ] Week 7 — Pipeline registers
- [ ] Week 8 — Hazard detection & forwarding
- [ ] Week 9 — Pipelined CPU on FPGA
- [ ] Week 10 — UART peripheral
- [ ] Week 11 — Run compiled C program
- [ ] Week 12 — Documentation & polish

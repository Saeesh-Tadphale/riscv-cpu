# RISC-V CPU — Verilog Implementation

A pipelined 32-bit RISC-V (RV32I) processor built from scratch in Verilog, targeting the Digilent Basys 3 (Artix-7) FPGA. This is a summer project built to develop practical digital design and computer architecture skills
relevant to the semiconductor industry.

**Built by:** Saeesh Tadphale  
**Institution:** Carleton University — Electrical Engineering  
**Tools:** Vivado ML Standard 2025.2, Verilog, Basys 3 Artix-7 FPGA  
**Reference:** *Digital Design and Computer Architecture: RISC-V Edition* — Harris & Harris

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
a clocked, synchronous register with configurable bit width using Verilog parameters
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

## Hardware

- **Board:** Digilent Basys 3 (Xilinx Artix-7 XC7A35T)
- **Toolchain:** AMD Vivado ML Standard 2025.2 (free edition)
- **Simulation:** Vivado xsim

---

## Progress

- [x] Week 1 — Toolchain setup, combinational logic, sequential registers
- [x] Week 2 — 32-bit ALU
- [ ] Week 3 — RISC-V ISA study
- [ ] Week 4 — Fetch & Decode stages
- [ ] Week 5 — Execute, Memory & Writeback
- [ ] Week 6 — Single-cycle CPU complete
- [ ] Week 7 — Pipeline registers
- [ ] Week 8 — Hazard detection & forwarding
- [ ] Week 9 — Pipelined CPU on FPGA
- [ ] Week 10 — UART peripheral
- [ ] Week 11 — Run compiled C program
- [ ] Week 12 — Documentation & polish

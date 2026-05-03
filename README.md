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
├── Week 2/                  # Coming soon — 32-bit ALU
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

## Hardware

- **Board:** Digilent Basys 3 (Xilinx Artix-7 XC7A35T)
- **Toolchain:** AMD Vivado ML Standard 2025.2 (free edition)
- **Simulation:** Vivado xsim

---

## Progress

- [x] Week 1 — Toolchain setup, combinational logic, sequential registers
- [ ] Week 2 — 32-bit ALU
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

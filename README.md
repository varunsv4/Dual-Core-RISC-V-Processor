# Dual-Core-RISC-V-Processor
RISCV Processor
This project details the design and implementation of a dual-core RISC-V processor. The system features two cores, each with its own L1 cache hierarchy, and a snooping-based MSI (Modified, Shared, Invalid) cache coherence protocol to ensure data consistency between cores. The design also supports atomic instructions for synchronization. The entire design was implemented in SystemVerilog and synthesized for an Atera Cyclone IV FPGA.

Key Features:
- Dual-Core Architecture: Two independent RISC-V cores operating in parallel.

- 5-Stage Pipeline: Each core is built on a classic 5-stage RISC pipeline (IF, ID, EX, MEM, WB), optimized for modularity and high throughput.

- Split L1 Caches:

  - I-Cache: Direct-mapped instruction cache for efficient instruction fetching.

  - D-Cache: 2-way set-associative data cache to minimize data-related stalls.

- MSI Cache Coherence Protocol: A snooping protocol ensures cache coherence and data consistency between the two cores.

- Atomic Instructions Support: The processor supports atomic memory operations, crucial for building synchronization primitives.

- Parallel Benchmark Validation: The multicore functionality was validated using parallel benchmarks, including a multicore merge sort and a producer-consumer algorithm (/asmFiles/palgorithm.asm).


Repository Contents:
- /source: Contains the source code for the processor cores, cache system, and coherence protocol logic.

- /testbench: Includes test benches for RTL simulation and verification.

- /asmFiles: Assembly files used to validate design

- /include: Header files

- /scripts: Waveform config files


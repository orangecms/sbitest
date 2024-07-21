# SBI test

This is a collection of simple tests for RISC-V SBI runtimes.
The code is supposed to run in S-mode.

## Usage

- `make run` will run as a payload in QEMU
- `make objdump` will show assembly of the final QEMU binary
- `make k230-bin` will build a raw binary for oreboot on the Kendryte K230 SoC
- `make` will build all the binaries

## Timer example in C

<https://popovicu.com/posts/risc-v-interrupts-with-timer-example/>

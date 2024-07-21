# optionally replace with your own toolchain
CROSS_COMPILE ?= riscv64-linux-gnu-

# e.g. "path/to/qemu-8.0.2/build/", mind the trailing "/"
QEMU_PREFIX ?=
# e.g. "-bios path/to/opensbi/fw_dynamic.bin"
QEMU_OPTION ?=

ARCH := rv64imafdc_zicsr_zifencei
ABI := lp64d

# outputs
INTERMEDIATE := intermediate.o
QEMU_ELF := sbitest_qemu.elf
QEMU_BIN := sbitest_qemu.bin
K230_ELF := sbitest_k230.elf
K230_BIN := sbitest_k230.bin

all: elf k230-bin

clean:
	rm -f *.bin *.elf

elf:
	$(CROSS_COMPILE)as -march=$(ARCH) -mabi=$(ABI) -o $(INTERMEDIATE) sbitest.S
	$(CROSS_COMPILE)ld -T link.ld -o $(QEMU_ELF) $(INTERMEDIATE)

run: elf
	$(QEMU_PREFIX)qemu-system-riscv64 $(QEMU_OPTION) \
		-machine virt -nographic -kernel $(QEMU_ELF)

objdump: elf
	$(CROSS_COMPILE)objdump -D $(QEMU_ELF)

k230-bin: elf
	$(CROSS_COMPILE)ld -T k230.ld -o $(K230_ELF) $(INTERMEDIATE)
	$(CROSS_COMPILE)objcopy -O binary $(K230_ELF) $(K230_BIN)

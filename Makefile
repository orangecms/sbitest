ARCH := rv64imafdc_zicsr_zifencei

elf:
	riscv64-linux-gnu-as -march=$(ARCH) -mabi=lp64d \
		-o test.elf test.S

payload:
	riscv64-linux-gnu-ld -T link.ld -o payload.elf test.elf

bin: elf
	riscv64-linux-gnu-objcopy -O binary test.elf test.bin

run: bin
	qemu-system-riscv64 -machine virt -nographic -kernel test.bin

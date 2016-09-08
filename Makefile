all: os-image

# Run bochs to simulate loading of code
run: all
	bochs

# Disk image that computer loads
os-image: boot_sect.bin kernel.bin
	cat $^ > os-image

# Builds binary of kernel file from 2 object files
kernel.bin: kernel_entry.o kernel.o
	ld -o kernel.bin -Ttext 0x1000 $^ --oformat binary

# Builds kernel object file
kernel.o: kernel.c
	gcc -ffreestanding -c $< -o $@

# Build kernel entry object file
kernel_entry.o: kernel_entry.nasm
	nasm $< -f elf -o $@

# Assemble to boot sector into raw machine code
boot_sect.bin: boot_sect.nasm
	nasm $< -f bin -I '../../16-bit/' -o $@

# Clear away all generated files
clean:
	rm -fr *.bin *.dis *.o os-image *.map

# Dissassemble kernel -- for debugging purposes
kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

BOOTLOADER_SRC = boot/bootloader.asm
KERNEL_SRC = kernel/kernel.asm

BOOTLOADER_BIN = build/bootloader.bin
KERNEL_BIN = kernel/kernel.bin
OS_IMAGE = iso/os.img

#nasm icin
NASM = nasm

#qemu ayarlari
QEMU = qemu-system-i386 #ben i386 kullaniyorum x86_64 te kullanabilirsiniz
QEMU_FLAGS = -drive format=raw,file=$(OS_IMAGE)

all: build_dirs $(OS_IMAGE)

#dosyalari derleme
#bootloader derleme
$(BOOTLOADER_BIN): $(BOOTLOADER_SRC)
	$(NASM) -f bin $(BOOTLOADER_SRC) -o $(BOOTLOADER_BIN)

$(KERNEL_BIN): $(KERNEL_SRC)
	$(NASM) -f bin $(KERNEL_SRC) -o $(KERNEL_BIN)

$(OS_IMAGE): $(BOOTLOADER_BIN) $(KERNEL_BIN)
	dd if=/dev/zero of=$(OS_IMAGE) bs=512 count=2880 status=none
	dd if=$(BOOTLOADER_BIN) of=$(OS_IMAGE) bs=512 count=1 conv=notrunc status=none
	dd if=$(KERNEL_BIN)  of=$(OS_IMAGE) bs=512 seek=1 conv=notrunc status=none
	echo "ISO basariyla derlendi : $(OS_IMAGE)"

build_dirs:
	mkdir -p build iso

run: $(OS_IMAGE)
	$(QEMU) $(QEMU_FLAGS)

clean:
	rm -rf build iso/os.img
	echo "Temizlik basarili"

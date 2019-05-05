#!/bin/sh
set -ex
i686-elf-as arch/boot.s -o obj/boot.o
i686-elf-gdc -fno-druntime -Isrc -g -c src/convert.d -o obj/convert.o
i686-elf-gdc -fno-druntime -Isrc -g -c src/serial.d -o obj/serial.o
i686-elf-gdc -fno-druntime -Isrc -g -c src/terminal.d -o obj/terminal.o
i686-elf-gdc -fno-druntime -Isrc -g -c src/io.d -o obj/io.o
i686-elf-gdc -fno-druntime -Isrc -g -c src/main.d -o obj/main.o
i686-elf-ld -T arch/linker.ld obj/*.o -o kernel.bin
qemu-system-i386 -kernel kernel.bin $@

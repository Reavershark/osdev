# osdev

A x86 kernel written in D (-betterC).

## Building a gdc cross-compiler

```sh
#!/bin/sh

mkdir build build/binutils-build build/gcc-build
cd build

wget http://ftp.gnu.org/gnu/binutils/binutils-2.32.tar.xz -O binutils.tar.xz
wget http://ftp.gnu.org/gnu/gcc/gcc-9.1.0/gcc-9.1.0.tar.xz -O gcc.tar.xz

tar xf binutils.tar.xz
rm binutils.tar.xz
tar xf gcc.tar.xz
rm gcc.tar.xz

mv binutils-* binutils
mv gcc-* gcc

export PREFIX=/usr
export TARGET=i686-elf

cd binutils-build
../binutils/configure --target=$TARGET --prefix=$PREFIX --disable-nls
make all -j4
sudo make install
cd ..

export PATH=$PATH:$PREFIX/bin
../gcc/configure --target=$TARGET --prefix=$PREFIX --disable-nls --enable-languages=c,d,c++ --without-headers --disable-libphobos
make all-gcc -j4
sudo make install-gcc
cd ..
```

---
title: "LLVM Z80: Building"
date: 2021-08-30T12:23:09-04:00
draft: false
toc: false
author: Codetector
tags: 
  - Software
  - LLVM
  - Tutorial
---

# Steps

1. Clone the github repo (This is quite big, so make some disk space)
```bash
git clone https://github.com/gt-retro-computing/llvm-project
```

2. Setup the cmake project by going into the `llvm` sub-directory and create a build directory
```bash
# ...../llvm-project/llvm>
mkdir cmake-build
cd cmake-build

cmake -DLLVM_USE_LINKER="lld" -DLLVM_TARGETS_TO_BUILD="" -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD="Z80" -DLLVM_ENABLE_PROJECTS="clang" ../

make clang llvm-mc llc lld -j$(nproc)

```

3. Step 2 will compile a clang for Z80 in the `"build"/bin` directory.
P.S. Feel free to use an IDE like CLion, it _might_ be very helpful when reading LLVM source code. 

4. You can try to compile a simple C program for example

```c
char testFn(char var1, char var2) {
  return var1 + var2;
}
```

Save it as `test.c` then you can do
```bash
--target=z80-unknown-none-code16 -fintegrated-as -O3 -c -S -o - test.c
```

It should output something like this

```asm
  .text
  .file "test.c"
  .globl  _testFn                         ; -- Begin function testFn
_testFn:                                ; @testFn
; %bb.0:                                ; %entry
  ld  l, a
  ld  a, b
  add a, l
  ret
                                        ; -- End function
  .addrsig
  extern  __Unwind_SjLj_Register
  extern  __Unwind_SjLj_Unregister

```
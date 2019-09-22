---
title: "LLVM For Dummies: (1)Intro & Assembler"
date: 2019-09-06T00:00:00-04:00
draft: true
toc: false
author: Codetector
tags: 
  - Software
  - LLVM
  - Compiler
---

# What is LLVM and why?

> The **LLVM** [compiler](https://en.wikipedia.org/wiki/Compiler) infrastructure project is a set of compiler and [toolchain](https://en.wikipedia.org/wiki/Toolchain) technologies,[[4\]](https://en.wikipedia.org/wiki/LLVM#cite_note-4) which can be used to develop a [front end](https://en.wikipedia.org/wiki/Compiler#Front_end) for any [programming language](https://en.wikipedia.org/wiki/Programming_language) and a [back end](https://en.wikipedia.org/wiki/Compiler#Back_end) for any [instruction set architecture](https://en.wikipedia.org/wiki/Instruction_set_architecture). LLVM is designed around a [language-independent](https://en.wikipedia.org/wiki/Language-independent_specification) [intermediate representation](https://en.wikipedia.org/wiki/Intermediate_representation) that serves as a [portable](https://en.wikipedia.org/wiki/Software_portability), high-level [assembly language](https://en.wikipedia.org/wiki/Assembly_language) that can be [optimized](https://en.wikipedia.org/wiki/Optimizing_compiler) with a variety of transformations over multiple passes. (Wikipedia)

So they why actually comes from the goal of this bigger restoration project which includes writing a modern multi-tasking operating system for the Intel 8080 microprocessor. Due to the limited amount of memory and releativly low speed, we would like our OS code to be compiled as efficient as possible. In order to achieve efficient complication, we decied to port a existing compiler to the Intel 8080. LLVM is just the right portable framework for such a compiler.



# But How?

if you just go out and checkout (or download) the LLVM source tree from GitHub right now, you will soon realize that it is a massive project, and there are not much documentation to help you get started on porting it into a new platfom (Target).

[LLVM master branch GitHub mirror repository](https://github.com/llvm/llvm-project)

So through this series of posts we will try out best to describe the process of porting LLVM to a new architecture, as well as the "hoops" we had to jump through in order to make progress. This is meant to be for beginners, as we started with just about zero knowledge on LLVM.

# LLVM? What's special about it?

Before we jump into building a backend for LLVM that targets an architechture we want, I want to describe on a very high level how does LLVM turn your high level programming language into machine code

The concept of LLVM is that instead of building multiple compilers for each language and target, we can seperate the langauge sepecific part (Front end) and the machine specific part (Backend). With this approach, we can change the process of building compilers O(n^2) to O(2n). 



# Building a backend

In this series we will slowly cover how to use the LLVM Compiler Infrastrucutre. We will start by building a new backend that targets the famouz Zilog Z80 processor. 

In order to make our backend easy to test, we will start by building a assembler. Strictly saying this is not nessrary unless you are planing on either using the LLVM assembler (llvm-mc) or supporting inline assembly, but I found that starting from a assembler is usually the best place to start a new backend. Since by creating the assembler you will have the opportiunity to describe all the instructions that the architecture support without having to worry about instruction selection. 

Also note that this will be a big theme throughout this series,  where we will try to keep the project in a "building" state, which means you can build and test your progress along the way. I personally find being able to see incremental progress very important to 1) find error early on and 2) motivate me to keep continue working on it.
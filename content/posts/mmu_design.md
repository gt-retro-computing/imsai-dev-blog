---
title: "The MMU - Part 1: Design and measure"
date: 2019-03-01T12:08:13-05:00
draft: false
toc: false
author: Codetector
images:
tags: 
  - MMU
  - Hardware 
---

# Creating an Memory Management Unit for the 8080 CPU

## Background and Theory
As part of the project goal is to get this IMSAI to run a modern operating system with 
preemptive multitasking capabilities. A crucial component that is currently missing is the 
[Memory Management Unit](https://en.wikipedia.org/wiki/Memory_management_unit)[^1]. Having 
the memory management uint allows programs to be allocated "virtual address spaces". 
This is great solution for multiple programs competing for the same blocks of memory. 
In modern processors, the MMU is built as part of the CPU's architecture, so there are 
instructions that support memory mapping operation as well as a mapping from the 
memory map table. However, looking at the 8080, there is apparently no support for this at all.
Therefore a solution to this problem is to "expand" the instruction set by using the ```OUT``` 
instruction with specific address as a 'trap' to address external hardware do the memory mapping.

## Implementation
To implement this memory management scheme, we need to bridge the real memory and the CPU address 
space with the MMU. Unfortunately, to achieve this we will be breaking the comparability with any 
of the original memory cards. To the CPU, the only memory it sees is going to be our MMU card[^2]. 

The MMU will divide the entire address space (64K) of the CPU into 16 4K sized pages. 
Each page can be independently mapped into any 4K boundary in the real 1M address space.[^3]

To accomplish this mapping feature, the MMU has two on-board register file that contains 16 x 8bit 
and 16 x4 bit registers. The 8 bit register file contains mapping to the physical address space. 
The 4 bit register file contains read/write protection bits when operate in protection ring[^4] 1.

### Known limitations

### Measurement of the BUS status during different instruction cycles
![Screenshot 1](/image/post/mmu_design/scope_6.png)
<center>Scope Screenshot of the TODO cycle</center>

[^1]: Wikipedia: Memory Management Unit
[^2]: It's not entirely true, as described in the memory map section.
[^3]: Due to some technical difficulties with our specific implementation and the nature of the operating system the lowest 4K block can not be realistically remapped. Thus later we decided to remove the mapping capability of the lowest 4K page.
[^4]: [Memory protection](https://en.wikipedia.org/wiki/Memory_protection) and execution [protection ring](https://en.wikipedia.org/wiki/Protection_ring).
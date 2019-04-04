---
title: "Memory Dumper"
date: 2019-02-08
draft: false
toc: false
images:
author: Codetector
tags: 
  - Hardware
  - Software
  - NewCard
---

# Background
So we have got our first program running on the old IMSAI 8080 computer. 
Although the process of flipping switches to program the machine in *binary*
was an extraordinary experience for the first few days, but very soon it got
very tedious and slowing us down in the process of debugging the system.

With all the modern technology we have got, we decided to make some quick 
hardware that allows us to directly write the memory without manually entering
each byte. 

# Overall Design
The core of this card is a STM32F103C8T6 ARM microcontroller. Ironically it is
many many times more powerful than the CPU of the system (Intel 8080). However,
due to the number of IOs that are availiable on the MCU, we are unable to map
all the necessary pins from the S100 bus directly to the MCU. Thus we had to 
use shiftregisters for both input and output data. The shfit registers that we
selected are 74HC595 (Serial to Parallel (Used for Output)) and 74HC165
(Parallel or Serial to Serial (Used for Input)).

# Schematics

The [PCB Design Files](https://github.com/gt-retro-computing/S100-Memory-Dumper-PCB)
are located on Github under S100MemoryDumper-PCB. The board is designed with
Altium Designer 19. To provide easier and broder access, the exported Gerber
files are located under the releases tab.

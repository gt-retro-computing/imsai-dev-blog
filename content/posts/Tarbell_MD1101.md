---
title: "Tarbell MD1101 SSSD Floppy Controller"
date: 2019-11-27T00:00:00-04:00
draft: false
toc: false
author: Codetector
tags: 
  - Hardware
  - Floppy

---

# MD1101
Our machine came with a Tarbell MD1101 Single Side Single Density (SSSD) floppy drive controller along with 2 8" floppy drives. 

> The Tarbell Floppy Disk Interface was a programmed-data-transfer (not DMA) device utilizing Port I/O, similar for example to the SD Systems Versafloppy boards. It was designed to work with a variety of standard-size floppy disk drives. It includes a 32-byte ROM bootstrap program, which was automatically enabled when the computer RESET button was pushed, and which switched itself out after the bootstrap had run. In this way, no part of the computer 64K of memory needed to be dedicated to Read-Only-Memory (ROM). <br>
The interface ran at the standard speed of 250,000 bits per second, and the normal formatted capacity per diskette of 256 kilobytes. Places for two connectors were provided on the board.

# Documentation Typo
The WD1771 chip used by the card actually does not support multi-drive configuration. The card used a 74LS175 Quad D Flip-Flop to select between up to four drives. Drive select only use 2 of the 4 bits in the flip-flop, the other 2 seems to be releatively undocumented. However, the provided sample code for selecting drive would not work. It would cause any subsquent input from the controller to hang the CPU. (Stuck in ```IN DWAIT```)

After a lot of trail and error along with reading the tiny text schematics, we are able to narrow the problem downto that the code is incorrectly setting one of the bit on the Flip Flop. Effectively disabling the controller interrupt request handling thus causing it to hang forever. 

## Modified Code Listing
```asm
SELECT_DIRVE:
;Select drive in register C
MOV A, C ; Move drive number to A
CMA
ANI 3 ;Limit drive selection to only 0-3
RAL! RAL! RAL! RAL ;shift left by 4
ORI 0x82 ;MODIFIED: original is 0x2
OUT DEXT
RET ;return from subroutine
---
```

# 5.25" Drive Mod
In addition to the 8" drives, we also happen to have a few 5.25" 
drive on hand. that we would like to operate as well. Upon close inspection, the 5.25" and 8" (Shugart 801) interface are not very different from eachother. The only difference being the 5.25" drives has a Motor Enable line in lieu of a Head Load (This is due the the difference in physical construction of the drive.) But I think it is okay to subsitute the signal. Since if achieve the same effect which is to *begin* reading the diskett. Conviently the board has a free 40 pin mounting hole for a additional 2 8" drive. We decided to use this connector for our 5.25" drive header. This required a lot of jumper wires (All the blue mod wires below).

![MD 1101 board after 5.25" mod](/image/post/md1101/board_mod.jpeg)
<center>MD 1101 board after 5.25" mod</center>

![Overall Machine Setup](/image/post/md1101/setup.jpeg)
<center>Overall Machine Setup</center>
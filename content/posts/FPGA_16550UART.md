---
title: "S100 FPGA and 16550 UART"
date: 2021-08-30T15:27:06-04:00
draft: false
toc: false
images:
author: Yaotian Feng
tags: 
  - SerialCard
  - Hardware
  - NewCard
  - IMSAI SIO
  - S100 SIO
  - FPGA
---


It has been a while since I've written on this blog. 
There has been quite a lot that has happened since my last update. 
One of the most recurring theme in this endavor on the retro computing
has been constantly repairing old, unreliable circuits. Since now the 
focus has been slowly shifting to the software side, for the interest 
of providing a reliable platform for software debugging, I decided to 
deisng a S100 add-in card that features an FPGA.

## Design Goals

Some of the main goal of this FPGA add-in card is to be able to provide a reliable way of emulating any hardware, let it be existing 
retro hardware or anything we are about to design. It turns out having
an FPGA at your disposal really aids in accelerating the design and 
revision process. Here are some of the requirement we set when 
designing this AIC (add-in card).

- Have access to the entire S100 bus and it's signals.
- Able to respond to IO reuqests as well as Memory requests.
- Ability to issue interrupt to the CPU.
- Efficient power regulation (aka not 7805s)

## Implementation

![FPGA Card](/image/post/fpga_16550/fpga_card.jpg)

In the above picture, you can see the first implementation of this 
design. As most electronic designs are, this first revision is flawed 
in a few ways (as indicated by the patch wires haha). On the left side 
of the board, it is a 16550 UART and supporting circutry for it to 
work in a S100 computer. 16550 became the standard UART chip that can 
even be commonly found in modern computers and various micro 
controllers.

On the bottom left corner of the board, you can see the voltage 
regulation section of the board. Where there are a few sets of power 
regulation system that derive a regulated +5V and +3.3V for various 
component on the board from the unregulated +8V rail on the S100 bus.

On the right side of the board, you can see the main component, the 
FPGA daughter board. Due to the flexibility nature of FPGA, even if in 
the future this specific FPGA is not availiable anymore, you can very 
easily design an adapter / redesign the board without much effort to 
adapt it for another FPGA.

## Ending

I think it would be very interesting to see where this addition to the 
IMSAI can take us. Now having the ability to quickly prototype and 
potentially debug other hardware on the bus, this FPGA should give us 
some big help in the future.

## Stuff might be cool to implement with this card

1. Banked memory support
1. S100 Bus recording / dumping tool. Like a logic analyzer.
1. Co-Processor (idk something like a tiny RISCV core could be fun)
1. DMA Engine (I think this is possible with the current board design, but should verify).
1. Graphics Engine / VGA.
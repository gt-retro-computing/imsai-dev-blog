---
title: "GWEMU - Intel 8080 Emulator"
date: 2019-08-27T12:23:09-04:00
draft: false
toc: false
author: Codetector
tags: 
  - Software
  - 8080 Emulator
  - 8080 Simulator
---

## Why write another emulator

If you look around for intel 8080 (which is what the system is based on) emulator on the internet today, all you will find is emulators that are tailored towards running games (namely space invadors); however, we wanted to use an emulator to 1) test our compiler 2) help debugging our assembly software when debugging using the real machine could be tricky.

## Introducing the GWEMU

[GitHub Project URL](https://github.com/gt-retro-computing/i8080-sim)

Writing this emulator the biggest challenge is probably figuring out how to create a decent looking GUI, as I have no exprience in C/C++ GUI programming. After seeing one of my friend drown in Qt land, I decided to try something different: GTK+ 3. This is a very popular X11 based UI framework, it should be cross-platform (Well at least on mac, I think it also works on windows but your milage may vary). 

> Sidenote: It's kind of important that it runs crossplatform since our team members use all three major OS platform. 

GTK offered a UI deisgn suite called ```glade``` which greatly simplify the process of creating UI. The tool itself is pretty much drag and drop. Although it requires some tinkering to get fully working, compare to writing coding that layout the UI this is not much to complain about. 

![GWEMU UI](/image/post/gwemu/gwemu_1.png)

The UI ended up looking like the picture above. There's not much design factor went into it, just thought that have a blinking light machine is interesting so made that.

## TODO Items
- Add Hexdecimal Displays for registers. (blinking light is really cool and whatnot, but I still can't really read binary)
- Disassembler for current instruction. (This might be helpful for debugging unknown program or just helps tracing)
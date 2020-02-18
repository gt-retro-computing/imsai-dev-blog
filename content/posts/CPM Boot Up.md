---
title: "CP/M 2.2 from scratch"
date: 2019-10-05T12:23:09-04:00
draft: false
toc: false
author: Codetector
tags: 
  - Software
  - CP/M
  - OS

---

# CP/M 2.2

CP/M was the state-of-art operating system for home computers of the era. As CP/M is designed for this machine, we thought it might be helpful to be able to run the CP/M OS before we start writing our own. 

## Getting the CP/M Boot disk

With some quick research, it's not hard to find that instead of having a "generic" CP/M boot disk, you are suppose to have a customized version of the boot disk specifically designed for your machine configuration. It's natural to come to the question of how would we obtain this disk. As according to the manual, the first step of creating such a disk is to have a machine that can run CP/M which unfortunately we don't have.

## Starting from nothing to CP/M Bootup

As discussed above, we can not go through the steps described in the manual to obtain a working copy of CP/M for our IMSAI. So we have to find out some other creative solutions. Fortunately, we are able to find a copy of a disassembled CP/M operating system. Combining this with out memory dumper card, we should be able to dump this CP/M directly to memory and start from there. 

### CBIOS (Custom Basic I/O System)

CBIOS is the part of CP/M that differs from system to system, it is the part that the user have to create / modify to suite their specific system needs. We started by implementing the various routines described in the CP/M manual. 

### Loading CP/M

After having the CBIOS written, we can simply dump the CP/M memory image then the assembled CBIOS after hitting reset and run, we are up and running in CP/M

## Creating a boot disk

Now that we have a working version of CP/M, the next step is to bootstrap itself so we can perform a cold start without the aid of modern hardware like the memory dumper.

At this point, all we need to do is to implement a program called save_cpm, that reads the memory image, along with our CBIOS and write to floppy disk between track 1 and 2. (Note, leave track 1, sector 0 empty for bootstrap loader we will talk about in the next section).

## Bootstrap loader

The floppy controller we have right now have a "phantom" ROM that is able to load the track 1, sector 0 of floppy disk to memory and then execute it. We are going to use this hardware feature now to load a very short program (as one sector is only 128 bytes) that is able to load the rest of CP/M. This will be our COLD_BOOT subroutine.

# Demo time!

<center>
<iframe width="560" height="315" src="https://www.youtube-nocookie.com/embed/oYCM-KIvgKA" frameborder="0" allow="accelerometer; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</center>


# Improvements to be made

- Update the loader code to support our "new floppy controller"
- Diagnose our subroutine to check why it causes Z80 incompatabilities
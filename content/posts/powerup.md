---
title: "Power Up!"
date: 2019-02-01
draft: false
featuredImg: "/image/imsai.jpg"
author: "Codetector"
tags: 
  - Hardware
  - General
---
# The IMSAI 8080

> TLDR; this post documents the IMSAI system as we got it.

Through the VIP program at Georgia Tech, 
we were able to acquire an IMSAI 8080 system to work on.
Initially I had little to no knowledge about the IMSAI system. 
Through some quick web search we were able to find the manual for the computer 
and understand some history behind it. 

## History
The IMSAI 8080 is one of the first desktop computer at the time. 
(following the Altair 8800) It's also one of the machine that shaped the S-100 Bus
standard which ruled the personal computing market for quite a while back in the 1970s.

The IMSAI 8080 come standard with a MPU (MPU-A) board equipped with an Intel&trade; 8080 CPU and 
IMSAI MPU front panel. 

# Our System
These are the boards that we got along with the machine
## IMSAI MPU-A
This is the original CPU board that shipped with the system. It contains the Intel&trade; 8080
CPU and some supporting circuitry. The board looks complicated, as the Intel&trade; 8080 requires
rather complicated support circuitry including a special 2 phase clock generator 
and 3 rail power supply (±5V and 12V).

As shown in the picture, the white and gold ceramic packaged chip is the Intel&trade; 8080 CPU.
This particular one is made in Malaysia 1977.
On the top right there is an empty socket, which is the for the front panel (CPA) and CPU private 
bus to connect to. Although it looks like a 16 pin socket, in reality the two pins are shorted in 
every column. It only carries an 8-bit signal (data bus) between the front panel and the CPU board.

<a href="/image/post/powerup/MPU-A.jpeg" target="_blank">![IMSAI MPU-A](/image/post/powerup/thumb/MPU-A.jpeg)</a>
<center>*The IMSAI MPU* (click for a larger image)</center>
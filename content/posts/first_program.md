---
title: "Fibonacci! - First program!"
date: 2019-02-02T12:08:13-05:00
draft: false
toc: false
author: Codetector
images:
tags: 
  - Software
  - Assembly
  - Code 
---
# Computing the Fibonacci Series

We have got the computer operational again. As of right now, everything 
essential is working again. The IMSAI 8080 come with a input and output 
both addressed on port ```0xFF``` which maps to the higher 8 bits of 
address and the 8 led on the top left corner of the front panel.

The first program we decided to run on the machine is to compute the fibonacci
series and display them one at a time on the front panel led. 

Below is the listing and video of it running
```asm
;fib
.org 0

init:
	mvi a, 0
	mvi b, 1
	mvi l, 0xFF
fib:
	mov c, a
	add b
	jc init
	xra l
	out 0xff
	xra l
	mov b, c
	mov h, a
	LXI d, 0FFFFh
delay:
	dcx d
	mov a, d
	ora e
	jnz delay
	mov a, h
	jmp fib
```

# Videos
<center>
<iframe width="560" height="315" src="https://www.youtube.com/embed/9FKPAX2WN8E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</center>
<center>The above code executed</center>

# Original Single Stepped version.
This is the first *actual* first program we got working on this machine. There's lots of patching 
thus includes a lot of  ```NOP``` and ```JMP``` instructions. 
<center><iframe width="560" height="315" src="https://www.youtube.com/embed/Uavji8Hw_UQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe></center> 
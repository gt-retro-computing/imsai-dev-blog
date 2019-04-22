---
title: "IMSAI SIO Card Debugging"
date: 2019-03-12T13:21:53-04:00
draft: false
---
# Status: Finding Issue

As listed in the system summary, we have an original IMSAI SIO-2 card. Which
contains 2 USART serial interfaces. This is post will document the process and
steps we took to debug and repair the card. Simply following the directions from
the manual did not give us the expected result, thus this post will be quite 
long.

# Troubleshooting
## Naive attempt at the example give from the original IMSAI Manual.


```
; jsio.asm jha 8/2/2018 testing sio
; https://wiki.theretrowagon.com/wiki/Imsai_8080
; Originally from a Monitor program code by John Garza hence the EQUates
; http://jgarza.sdf.org/files/M72.ASM
;
; Important init code from VCF forums
; handy VCF threads for configuration
; http://www.vcfed.org/forum/showthread.php?64964-Imsai-FIF-FDC-project
; http://www.vcfed.org/forum/showthread.php?37137-How-to-get-output-from-SIO-with-Intel-8251A-USART
;
; uses a straight through cable.

;------------------
;IMSAI 8080 EQUATES

LEDS	equ	0FFh	;IMSAI front panel output LEDs (top left)
SWCH	equ	0FFh	;IMSAI front panel input switches (left)

; channel a
TTS     equ     03h     ;SIO channel A command port
TTI     equ     02h     ;SIO channel A data port (yes input=output)
TTO     equ     02h     ;SIO channel A data port

; channel b
;TTS     equ     05h     ;SIO channel B command port
;TTI     equ     04h     ;SIO channel B data port (yes input=output)
;TTO     equ     04h     ;SIO channel B data port

TTYDA   equ     02h     ;tty data available (ready to receive?)
TTYTR   equ     01h     ;tty terminal ready (ready to transmit?)

    org 0000h
init:
    mvi a,0
    out TTS
    out TTS
    out TTS
    mvi a,040h
    out TTS
    mvi a,04eh  ; 8,1,n
    out TTS
    mvi a,037h
    out TTS

inout:               ; loop read from serial, write it to serial. Serial terminal echo.
    in TTS
    ani TTYDA        ; DATA available?
    jz inout
io1:
    in TTS
ani TTYTR           ; ready to receive?
    jz io1
    in TTO          ; read character
    out TTO         ; write
    jmp inout       ; repeat
    end
```


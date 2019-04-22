
DWAIT .equ 0fch
DCOM .equ 0f8h
DDATA .equ 0fbh
DSTAT .equ 0f8h
DSECT .equ 0fah
RAMADD .equ 0x100

.org 0x100
.dw 0
.dw 0
.dw 0
.dw 0
.dw 0

.org 0
begin:
in DWAIT
LXI H, RAMADD
MVI A, 01h
OUT DSECT
MVI A, 8ch
OUT DCOM
rLoop:
IN DWAIT
ORA a
jp rdone
in ddata
mov m,a
inx h
jmp rLoop

rdone:
in DSTAT
ora a
cma
out 0xff
hlt

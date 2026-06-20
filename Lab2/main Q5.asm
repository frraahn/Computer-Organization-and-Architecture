INCLUDE Irvine32.inc

.code
main PROC
MOV DX, 0; Clear DX
MOV AX, 1000h; Load 1000h into AX
MOV CX, 25h; Load 25h into CX
MUL CX; Multiply AX by CX, storing the result in DX : AX

call DumpRegs
exit
main ENDP
END main
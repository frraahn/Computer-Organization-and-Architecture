INCLUDE Irvine32.inc

.code
main PROC
MOV DX, 0; Clear DX to form the 16 - bit dividend in DX : AX
MOV AX, 803h; Load the dividend(8003h) into AX
MOV BL, 10h; Load the divisor(10h) into BL
DIV BL; Divide DX : AX by BL, whereby AX = quotient & DX = remainder
call DumpRegs
exit
main ENDP
END main

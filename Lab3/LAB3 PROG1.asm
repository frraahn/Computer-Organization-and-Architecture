INCLUDE Irvine32.inc

.data
msg1 BYTE "Calculate Perimeter 2-Hexagon (LOOP and ADD instructions):", 0dh, 0ah, 0
msg2 BYTE "Input Hexagon 1 (side length): ", 0
msg3 BYTE "Input Hexagon 2 (side length): ", 0
msg4 BYTE "Result of Perimeter Hexagon 1 and 2:", 0dh, 0ah, 0
msg5 BYTE "Total Perimeter: ", 0

.data
sideHex1 DWORD ?
sideHex2 DWORD ?
Perimeter_hexagon1 DWORD ?
Perimeter_hexagon2 DWORD ?
TotalPerimeter DWORD ?

.code
main proc
; Clear screen
call Clrscr

; Print msg1
mov edx, OFFSET msg1
call WriteString

; Get sideHex1
mov edx, OFFSET msg2
call WriteString
call ReadInt
mov sideHex1, eax

; Get sideHex2
mov edx, OFFSET msg3
call WriteString
call ReadInt
mov sideHex2, eax

; Calculate Perimeter_hexagon1 = sideHex1 * 6
mov eax, sideHex1
mov ecx, 6
imul eax, ecx
mov Perimeter_hexagon1, eax

; Calculate Perimeter_hexagon2 = sideHex2 * 6
mov eax, sideHex2
mov ecx, 6
imul eax, ecx
mov Perimeter_hexagon2, eax

; Calculate TotalPerimeter = Perimeter_hexagon1 + Perimeter_hexagon2
mov eax, Perimeter_hexagon1
add eax, Perimeter_hexagon2
mov TotalPerimeter, eax

; Print Perimeter_hexagon1
mov edx, OFFSET msg4
call WriteString
mov eax, Perimeter_hexagon1
call WriteDec
call Crlf

; Print Perimeter_hexagon2
mov eax, Perimeter_hexagon2
call WriteDec
call Crlf

; Print TotalPerimeter
mov edx, OFFSET msg5
call WriteString
mov eax, TotalPerimeter
call WriteDec

call Crlf

; Wait for user to press Enter
call WaitMsg

; Exit program
exit

main ENDP

END main

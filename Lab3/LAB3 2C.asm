INCLUDE Irvine32.inc

.data 
welcomeMsg BYTE "Welcome to Simple Math Activities:", 0dh, 0ah, 0
menuMsg BYTE "Select Your Option (Main Menu):", 0dh, 0ah, 0
option1Msg BYTE "1. To calculate Perimeter Hexagon (Loop and ADD instructions)", 0dh, 0ah, 0
option2Msg BYTE "2. To calculate SUM (unsign int) index (Odd or Even) in an Array Matrix", 0dh, 0ah, 0
continueMsg BYTE "Continue - type (y) and Exit type (n): y or n", 0dh, 0ah, 0
thankyouMsg BYTE "Thank you ... BYE !!!", 0dh, 0ah, 0
invalidMsg BYTE "Invalid option, please try again.", 0dh, 0ah, 0

msg1 BYTE "Calculate Perimeter 2-Hexagon (LOOP and ADD instructions):", 0dh, 0ah, 0
msg2 BYTE "Input Hexagon 1 (side length): ", 0
msg3 BYTE "Input Hexagon 2 (side length): ", 0
msg4 BYTE "Result of Perimeter Hexagon 1 and 2:", 0dh, 0ah, 0
msg5 BYTE "Total Perimeter: ", 0

calcMsg BYTE "Calculate SUM (unsign INT) index (Odd or Even) in array Hello[6] : ", 0
prompt BYTE "Integer Input : ", 0
resultMsg BYTE "Result Sum Hello[index]:", 0
evenMsg BYTE "Sum Hello[even] index location : ", 0
oddMsg BYTE "Sum Hello[odd] index location : ", 0

newline BYTE 0Dh, 0Ah, 0

sideHex1 DWORD ?
sideHex2 DWORD ?
Perimeter_hexagon1 DWORD ?
Perimeter_hexagon2 DWORD ?
TotalPerimeter DWORD ?

HELLO DWORD 6 DUP(? )
TotalEVEN DWORD ?
TotalODD DWORD ?

.code
main PROC
call Clrscr
mov edx, OFFSET welcomeMsg
call WriteString
call Crlf

main_menu :
call Clrscr
mov edx, OFFSET menuMsg
call WriteString
call Crlf
mov edx, OFFSET option1Msg
call WriteString
call Crlf
mov edx, OFFSET option2Msg
call WriteString
call Crlf
mov edx, OFFSET continueMsg
call WriteString
call Crlf

call ReadChar
cmp al, '1'
je periHex_loopAdd
cmp al, '2'
je calSum_oddeven
cmp al, 'y'
je main_menu
cmp al, 'n'
je exit_program
mov edx, OFFSET invalidMsg
call WriteString
call Crlf
jmp main_menu

periHex_loopAdd :
call Clrscr
; Print msg1
mov edx, OFFSET msg1
call WriteString
call Crlf

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
call WriteInt
call Crlf

; Print Perimeter_hexagon2
mov eax, Perimeter_hexagon2
call WriteInt
call Crlf

; Print TotalPerimeter
mov edx, OFFSET msg5
call WriteString
mov eax, TotalPerimeter
call WriteInt
call Crlf

jmp continue_menu

calSum_oddeven :
call Clrscr
; Display calculation message
mov edx, OFFSET calcMsg
call WriteString
call Crlf

; Initialize array HELLO with user input
mov ecx, 6; number of integers to read
mov esi, 0; index for HELLO array

input_loop:
mov edx, OFFSET prompt
call WriteString

call ReadInt
mov[HELLO + esi * TYPE DWORD], eax; store user input in HELLO array
inc esi
loop input_loop

; Calculate sums of evenand odd indexed elements
mov ecx, 6
mov esi, 0; reset index for HELLO array
xor eax, eax; TotalEVEN
xor ebx, ebx; TotalODD

sum_loop :
mov edx, [HELLO + esi * TYPE DWORD]
test esi, 1
jz add_to_even
add ebx, edx
jmp next

add_to_even :
add eax, edx

next :
inc esi
loop sum_loop

mov TotalEVEN, eax
mov TotalODD, ebx

; Print result message
mov edx, OFFSET resultMsg
call WriteString
call Crlf

; Print result for TotalEVEN
mov edx, OFFSET evenMsg
call WriteString

mov eax, TotalEVEN
call WriteInt

call Crlf

; Print result for TotalODD
mov edx, OFFSET oddMsg
call WriteString

mov eax, TotalODD
call WriteInt

call Crlf

jmp continue_menu

continue_menu :
mov edx, OFFSET continueMsg
call WriteString
call Crlf

call ReadChar
cmp al, 'y'
je main_menu
cmp al, 'n'
je exit_program
mov edx, OFFSET invalidMsg
call WriteString
call Crlf
jmp continue_menu

exit_program :
mov edx, OFFSET thankyouMsg
call WriteString
call Crlf
exit

main ENDP
END main
INCLUDE Irvine32.inc

.data
prompt BYTE "Integer Input : ", 0
calc_msg BYTE "Calculate SUM (unsign INT) index (Odd or Even) in array Hello[6] : ", 0
result_msg BYTE "Result Sum Hello[index]:", 0
even_msg BYTE "Sum Hello[even] index location : ", 0
odd_msg BYTE "Sum Hello[odd] index location : ", 0
newline BYTE 0Dh, 0Ah, 0

HELLO DWORD 6 DUP(? )
TotalEVEN DWORD ?
TotalODD DWORD ?

.code
main PROC
; Display calculation message
mov edx, OFFSET calc_msg
call WriteString
mov edx, OFFSET newline
call WriteString
call WriteString

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

; Calculate sums of even and odd indexed elements
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
mov edx, OFFSET newline
call WriteString
mov edx, OFFSET result_msg
call WriteString
mov edx, OFFSET newline
call WriteString

; Print result for TotalEVEN
mov edx, OFFSET even_msg
call WriteString

mov eax, TotalEVEN
call WriteDec

mov edx, OFFSET newline
call WriteString

; Print result for TotalODD
mov edx, OFFSET odd_msg
call WriteString

mov eax, TotalODD
call WriteDec

mov edx, OFFSET newline
call WriteString

exit
main ENDP
END main


INCLUDE Irvine32.inc

.data
welcomeMsg BYTE "Welcome to CPU Benchmark Program", 0
benchmarkMsg BYTE "Benchmark CPU time Using Equation y = 30*x^3 + 11*x^2 + 18*x + 5", 0
delayMsg BYTE "(with delay coef1,coef2,coef3,coef4 = 30,11,18,5 msec)", 0
enterLoopMsg BYTE "Enter Number of Looping (N) = ", 0
resultMsg BYTE "Result:", 0
firstCaptureMsg BYTE "First Capture Execution time in milliseconds: ", 0
secondCaptureMsg BYTE "Second Capture Execution time in milliseconds: ", 0
diffExecutionMsg BYTE "Different Execution time in milliseconds: ", 0
polySumMsg BYTE "Value of Sum from the Stress Test (polynomial) = ", 0
exitPromptMsg BYTE "Press 'y' to continue or 'n' to exit the benchmark: ", 0

input DWORD ?
N DWORD ?
result DWORD ?
timeBefore DWORD ?
timeAfter DWORD ?
diffTime DWORD ?
polySum DWORD ?
coef1 DWORD 30
coef2 DWORD 11
coef3 DWORD 18
coef4 DWORD 5

.code
main PROC
; Initialize values
call Clrscr
mov edx, OFFSET welcomeMsg
call WriteString
call Crlf

mov edx, OFFSET benchmarkMsg
call WriteString
call Crlf

mov edx, OFFSET delayMsg
call WriteString
call Crlf

mov edx, OFFSET enterLoopMsg
call WriteString

call ReadDec
mov N, eax

call GetMseconds
mov timeBefore, eax

; Perform polynomial calculation
mov ecx, N
mov polySum, 0

stress_loop:
mov eax, ecx
imul eax, ecx
imul eax, ecx; eax = x ^ 3
imul eax, coef1; eax = coef1 * x ^ 3
mov ebx, eax

mov eax, ecx
imul eax, ecx; eax = x ^ 2
imul eax, coef2; eax = coef2 * x ^ 2
add ebx, eax

mov eax, ecx
imul eax, coef3; eax = coef3 * x
add ebx, eax

add ebx, coef4; ebx = (coef1 * x ^ 3) + (coef2 * x ^ 2) + (coef3 * x) + coef4
add polySum, ebx

; Add delay to ensure measurable time difference
mov eax, 1
call Delay

loop stress_loop

call GetMseconds
mov timeAfter, eax

mov eax, timeAfter
sub eax, timeBefore
mov diffTime, eax

; Print results
mov edx, OFFSET resultMsg
call WriteString
call Crlf

mov edx, OFFSET firstCaptureMsg
call WriteString
mov eax, timeBefore
call WriteDec
call Crlf

mov edx, OFFSET secondCaptureMsg
call WriteString
mov eax, timeAfter
call WriteDec
call Crlf

mov edx, OFFSET diffExecutionMsg
call WriteString
mov eax, diffTime
call WriteDec
call Crlf

mov edx, OFFSET polySumMsg
call WriteString
mov eax, polySum
call WriteDec
call Crlf

; Exit prompt
mov edx, OFFSET exitPromptMsg
call WriteString
call ReadChar

cmp al, 'y'
jne exit_program

jmp main

exit_program :
invoke ExitProcess, 0

main ENDP
END main



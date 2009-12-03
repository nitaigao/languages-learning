extern printf
extern scanf

section .data

question1: 	db "Enter the first number: ",  0
question2:	db "Enter the second number: ", 0
entered:	db "You entered: %d", 10, 0
result:		db "Result: %d", 10,  0
infmt:		db "%d", 0 
number1:	dd 0
number2:	dd 0
total:		dd 0

section	.text

    global main

main:
	push    ebp
        mov     ebp, esp

	; first number

	push 	dword question1
	call 	printf
	add	esp, 4

	push	number1
	push	dword infmt
	call 	scanf
	add 	esp, 8
	mov 	eax, [number1]
	
	; first number

	push	eax
	push 	dword entered
	call 	printf
	add	esp, 8

	; second number	

	push	dword question2
	call 	printf 
	add	esp, 4

	push	dword number2
	push 	dword infmt
	call 	scanf
	add	esp, 8
	mov	eax, [number2]

	; second number
	
	push eax
	push dword entered
	call printf
	add esp, 8

	; do sum

	mov 	eax, [number1]
	add	eax, [number2]
	
	; total

	push	eax
	push	dword result
	call	printf 	
	add	esp, 8
	
 	mov     esp, ebp
        pop     ebp

	mov 	eax, 1
	mov 	ebx, 0
	int	0x80
	
	;ret


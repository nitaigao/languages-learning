extern printf
extern scanf

section .data

question1: 	db "Enter the first number: ",  0
question2:	db "Enter the second number: ", 0
entered:	db "You entered: %d", 10, 0
infmt:		db "%d", 0 
result1:	db "Number 1 is greater", 10, 0
result2:	db "Number 2 is greater", 10, 0
resultequal	db "Numbers are equal", 10, 0
number1:	dd 0
number2:	dd 0

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

	; do comparison

	mov 	eax, [number1]
	cmp	eax, [number2]
	jg	number1greater
	je	numbersequal
	jmp	number2greater
	
	; numbers are equal

numbersequal:

	push	dword resultequal
	call	printf
	add	esp, 4
	jmp quit

	; number 1 is greater

number1greater:

	push	dword result1
	call 	printf
	add	esp, 4
	jmp	quit

	; number 2 is greater

number2greater:
	
	push	dword result2
	call	printf
	add	esp, 4
	jmp	quit

quit:
	
 	mov     esp, ebp
        pop     ebp

	mov 	eax, 1
	mov 	ebx, 0
	int	0x80
	
	;ret


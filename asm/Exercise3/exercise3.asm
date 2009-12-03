extern printf
extern scanf

section .data

firstquestion:	db "Enter the first number: ", 0, 10
nextquestion:	db "Enter the next number: ", 0, 10
entered:        db "You entered: %d", 10, 0
result:		db "Total: %d", 0, 10
infmt:		db "%d", 0 
number1:	dd 0
total:		dd 0


section	.text

    global main

main:
	push    ebp
        mov     ebp, esp

	mov	eax, 0

	; first question
	
	push 	dword firstquestion
	call 	printf
	add 	esp, 4
	mov	eax, 0
	jmp 	capturenumber

	; capture number

capturenumber:

	push	number1
	push	dword infmt
	call 	scanf
	add 	esp, 8

	mov 	eax, [number1]
	cmp	eax, 0
	jle	printtotal

	mov	eax, [total]
	add	eax, [number1]
	mov 	[total], eax
	
	jmp	asknextquestion
		
asknextquestion:

	push	dword nextquestion
	call 	printf
	add	esp, 4
	jmp 	capturenumber

printtotal:

	mov	eax, [total]
	push 	eax
        push 	dword entered
        call 	printf
        add 	esp, 8
	jmp 	quit

	; quit

quit:
	
 	mov     esp, ebp
        pop     ebp

	mov 	eax, 1
	mov 	ebx, 0
	int	0x80
	
	;ret


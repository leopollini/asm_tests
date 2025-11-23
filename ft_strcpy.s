section .text
	global	ft_strcpy

ft_strcpy:									; entry point : rdi -> to, rsi -> fro
			mov		rcx, -1					; set counter to -1 (i)
			xor		al, al					; set al to 0
			cmp		rsi, 0					; if rsi is NULL
			jz		exit					; return immediately
			cmp		rdi, 0					; if rdi is NULL
			jz		exit					; return immediately
loop:
			inc		rcx						; increment counter (i++)
			mov		al, BYTE[rsi + rcx]		; copy fro[i] into al
			mov		BYTE[rdi + rcx], al		; copy al into to[i]
			cmp		al, 0					; loop if
			jnz		loop					; al is 0 (reached end of fro)
			mov		rax, rdi				; copy rdi into rax for return pointer (not required)
exit:
			ret								; return
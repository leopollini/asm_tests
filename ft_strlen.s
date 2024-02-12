			section .text
			global	ft_strlen

ft_strlen:								; entry point rdi -> s
			mov		rax, -1				; rax to -1
lp:
			inc		rax					; increment rax
			cmp		BYTE[rdi + rax], 0	; comparation of str[rax] and 0
			jnz		lp					; jmp if (str[rax])
			ret							; return

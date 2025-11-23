section .text
			global	ft_strlen

ft_strlen:								; entry point rdi -> s
			xor		rax, rax			; set rax to 0 in case of bad input
			cmp		rdi, 0				; return if input is null ptr
			jz		done
			mov		rax, -1				; rax to -1
loop:
			inc		rax					; increment rax
			cmp		BYTE[rdi + rax], 0	; comparison of str[rax] and 0
			jnz		loop				; jmp if (str[rax])
done:
			ret							; return


;ft_strlen:								; works not yet
			xor		rax, rax			; set rax to 0
			cmp		rdi, 0				; return if input is null ptr
			jz		done
loop2:
			mov		rdx, [rdi + rax]	; load 8 bytes from string into rdx
			mov		rcx, 0xFF00000000000000	; byte mask
inc_loop:
			and		rdx, rcx			; filter rdx
			jz		done				; if zero return
			shr		rcx, 8				; shift mask by 8
			inc		rax					; increase return value
			jnz		inc_loop			; loop until mask is empty
			jmp		loop2				; repeat process


; done:
			ret							; return


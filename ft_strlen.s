section .text
			global	ft_strlen

; one memory access per byte
ft_strlen:								; entry point rdi: s
			xor		rax, rax			; set rax to 0 in case of bad input
			cmp		rdi, 0				; return if input is null ptr
			jz		done
			mov		rax, -1				; rax to -1
loop:
			inc		rax					; increment rax
			cmp		BYTE[rdi + rax], 0	; comparison of str[rax] and 0
			jnz		loop				; jmp if (str[rax])
;done:
			ret							; return



; less memory accesses, 1 every 8 bytes
; ft_strlen:								; rdi: s
			xor		rax, rax			; set rax to 0
			cmp		rdi, 0				; return if input is null ptr
			jz		done
loop2:
			mov		rdx, [rdi + rax]	; load 8 bytes from string into rdx
			mov		rcx, 0xFF			; byte mask
inc_loop:
			mov		rsi, rdx
			and		rsi, rcx			; filter rdx
			jz		done				; if zero return
			inc		rax					; increase return value
			shl		rcx, 8				; shift mask by a byte
			jnz		inc_loop			; loop until mask is empty
			jmp		loop2				; repeat process


done:
			ret							; return


section	.text
	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy
	global	ft_strdup

ft_strdup:						; rdi -> s
			cmp		rdi, 0		; check if input is null
			jz		done_0		; returns (rax is already 0, no errno)
			push	rdi			; push rdi into stack
			call	ft_strlen	; call ft_strlen(s) -> rax
			inc		rax			; increment rax to store \0 char into string
			mov		rdi, rax	; copy rax into rdi
			call	malloc wrt ..plt	; malloc(rdi -> ft_strlen(s)) -> rax
			cmp		rax, 0		; check if rax is 0 (malloc failed)
			jz		fail		; jump to fail (errno already set by malloc)
			mov		rdi, rax	; copy rax: malloc'd memory into rdi
			pop		rsi			; restore source string into rsi: s
			push	rdi			; save allocated memory
			call	ft_strcpy	; ft_strcpy(rdi -> malloc'd mem, rsi -> s)
			pop		rax			; restore allocated memory and return it
			ret					; return

done_0:
			mov		rax, 0		; return null if input is null
			ret					; strdup originally just trhrows segmentation fault

fail:
			pop		rdx			; restore stack
			ret

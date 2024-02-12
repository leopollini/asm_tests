section	.text
	extern	malloc
	extern	ft_strlen
	extern	ft_strcpy
	global	ft_strdup

ft_strdup:						; rdi -> s
			push	rdi			; push rdi into stack
			call	ft_strlen	; call ft_strlen(s) -> rax
			mov		rdi, rax	; copy rax into rdi
			inc		rdi			; increment rdi to store \0 char into string
			call	malloc		; malloc(rdi -> ft_strlen(s)) -> rax
			mov		rdi, rax	; copy rax -> malloc'd memory into rdi
			cmp		rax, 0		; check if rax is 0 (malloc failed)
			mov		rax, 0		; set rax to 0 in case of fail
			jz		fail		; jump to fail
			pop		rsi			; pop original source into rsi -> s
			call	ft_strcpy	; ft_strcpy(rdi -> malloc'd mem, rsi -> s)
			ret					; return

fail:
			pop		rdx
			ret

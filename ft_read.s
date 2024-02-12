	section	.text
	extern	___error
	global	ft_read

ft_read:							; since the arguments are already well-placed there is no need for any register content adjustment
			xor		rax, rax	; set rax to 0 for write syscall
			int		80h			; syscall: read(rdi~fd, rsi~char *s, rdx~n)
			jnc		fail
			ret					; return

fail:
			ret
	section	.text
	extern	___error
	global	ft_write

ft_write:							; since the arguments are already well-placed there is no need for any register content adjustment
			mov		rax, 1		; set rax to 1 for write syscall
			syscall				; syscall: write(rdi~fd, rsi~char *s, rdx~n)
			jc		fail		; if syscall returns -1 (write failed) jumps to error
			ret					; return

fail:
			ret
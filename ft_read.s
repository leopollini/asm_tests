section	.text
	global	ft_read
	extern	__errno_location

ft_read:						; since the arguments are already well-placed there is no need for any register content adjustment
			mov		rax, 0		; set rax to 1 for read syscall
			syscall				; syscall: read(rdi: fd, rsi: char *s, rdx: n)
			test	rax, rax	; check return value of syscall
			js		fail		; if syscall fails it returns -errno (negative), otherwise returns length of wrote stuff
			ret					; return (success)

fail:
			neg		rax			; rax: errno
			push	rax			; save errno
			call	__errno_location wrt ..plt	; get __errno pointer
			pop		rdx			; restore errno
			mov		[rax], rdx	; update __errno
			mov		rax, -1		;
			ret					; return -1
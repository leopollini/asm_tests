section	.text
	global	ft_write
	; global	ft_putstr
	; extern	ft_strlen
	extern	__errno_location

; ft_putstr:
; 			cmp		rdi, 0
; 			jz		fail
; 			push	rdi
; 			call	ft_strlen
; 			mov		rdx, rax
; 			mov		rdi, 1
; 			pop		rsi
; 			call	ft_write
; 			ret

ft_write:						; since the arguments are already well-placed there is no need for any register content adjustment
			mov		rax, 1		; set rax to 1 for write syscall
			syscall				; syscall: write(rdi: fd, rsi: char *s, rdx: n)
			cmp		rax, 0		; check return value of syscall
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
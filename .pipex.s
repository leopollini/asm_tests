section .text
global	_pipex

putstr :
			cmp		rdi, 0
			jz		putstr_end
			mov		rsi, rdi
			mov		rdi, 1
			mov		rdx, 1
putstr_lp :
			cmp		byte[rsi], 0
			jz		putstr_end
			mov		rax, 1
			syscall
			inc		rsi
			jmp		putstr_lp
putstr_end
			ret




_pipex :
			push	rdi
			mov		rdi, qword[rdi + 8]
			mov 	rax, rdi
			call	putstr

			mov		rdi, pipefds
			mov		rax, 0x16
			syscall
			cmp		rax, 0
			js		error_ret
			

			pop 	rdi
			ret

error_ret :
			pop		rdi
			mov		rax, -1
			ret

section	.data
	pipefds : dd ?, ?

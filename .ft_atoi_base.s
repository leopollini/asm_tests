section	.text
	global	ft_atoi_base

ft_atoi_base:						; int ft_atoi_base(char *s, short base) : rdi -> s, rsi -> base
			cmp		rdi, 0			; bad input
			jz		fail
			cmp		rsi, 2			; bad input
			jc		fail
			xor		cl, cl			; cl to 0 (will contain signs)
			xor		rax, rax		; rax to 0 (for result)
			mov		rdx, 1
check_sign:							; sign skip routine. Skips all signs and return
									; cl odd if result is negative
			cmp		byte[rdi], '-'	; s[0] is '-'
			jnz		cs_pos			; test positive
			inc		cl				; increment cl
			inc		rdi				; s++
cs_pos:
			cmp		byte[rdi], '-'	; s[0] is '-'
			jz		check_sign		; jump back to check_sign and restart
			cmp		byte[rdi], '+'	; s[0] is '+'
			jnz		cs_ret			; if not jump to cs_ret
			inc		rdi				; s++
			jmp		pos				; restart from pos
cs_ret:
			mov		dl, byte[rdi]	; copy s[0] into dl
			cmp		dl, 0			; nothing inside string	
			jz		fail
			jmp		skip			; skip base multiplication only on first cycle
loop:
			push	rdx				; push rdx to stack (MUL influences rdx, so it must be saved)
			mul		rsi				; multiply rax by base
			pop		rdx				; restore rdx from stack
skip:
			inc		rdi				; increment rdi
			sub		dl, '0'			; |-----------|
			cmp		dl, 10
			jc		nohexdigit
			sub		dl, 7
			cmp		dl, 16
			jc		nohexdigit
			sub		dl, 32
nohexdigit:
			cmp		dl, sil
			jnc		fail 			; |-----------| this section turns every input char into a short int first, checks if it is a digit, then an uppercase hex, then lowercase hex. In any case the result is stored into dl as a number 0-15 in hexadecimal base, then it checks if the number is out of bounds for the used base
			add		rax, rdx		; add found value to rax
			mov		dl, byte[rdi]	; copy s[rdi] into dl
			cmp		dl, 0			; check if string ended
			jnz		loop			; loop
			and		cl, 1			; cl % 2 be 1 if sign is negative
			jz		pos
			neg		rax				; negate rax
pos:
			ret						; return
		
fail:
			mov		rax, 0		; return 0 (failed: bad input)
			ret

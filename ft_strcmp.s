section .text
	global	ft_strcmp

ft_strcmp:									; entry point : rdi -> s1, rsi -> s2
			xor		rax, rax				; rax to 0
			cmp		rdi, 0					; NULL check
			jz		end
			cmp		rsi, 0					; NULL check
			jz		end
			mov		rcx, -1

loop:
			inc		rcx						; increment counter (i++)
			mov		al, BYTE[rdi + rcx]		; copy s1[i] into al
			cmp		al, 0
			jz		ends1					; if s1[i] is 0 then exits with -s2[i]
			sub		al, BYTE[rsi + rcx]		; s1[i] - s2[i]
			jz		loop					; if the result is 0 then loops
			jnc		end						; else if s1[i] > s2[i] then correcly negate al
			neg		al						;
			neg		rax						;
			ret								; and return
ends1:
			mov		al, BYTE[rsi + rcx]		; in case s1[i] is 0
			neg		rax						; exit with -s2[i]
end:
			ret								; return
struc   _t_list
	next:		resq	1
	content:	resq	1
endstruc

__list_len	equ 16

section	.data

	temp	dq		0

section	.text
	extern	malloc
	extern	free
	global	ft_lstnew
	global	ft_lstsize
	global	ft_lstlast
	global	ft_lstadd_front
	global	ft_lstadd_back
	global	ft_lstdelone


ft_lstnew:										; t_list *ft_lstnew(void *content) : rdi -> content*
			push	rdi							; push rdi on stack
			mov		rdi, __list_len				; set rdi = sizoef(t_list) for malloc
			call	malloc						; malloc(rdi) -> rax
			pop		rdi							; restore rdi from stack
			cmp		rax, 0						; check if rax is 0 (malloc failed)
			jz		fail						; jump to fail
			mov		qword [rax + content], rdi	; set newlist->content to input content pointer
			mov		qword [rax + next], 0		; set newlist->next to null (0)
			ret									; return (success)



ft_lstsize:										; size_t ft_lstsize(t_list *lst) : rdi -> lst
			cmp		rdi, 0						; return 0 if lst = NULL
			jz		general_exit
			mov		rax, -1						; set counter to -1
			mov		[temp], rdi					; load rdi into temp
			lea		rdi, temp					; load rdi with &temp
loop_lstsize:
			inc		rax							; increment counter
			mov		rdi, qword[rdi + next]		; lst = lst->next
			cmp		rdi, 0						; test if lst is 0
			jnz		loop_lstsize;				; loop
			ret									; return (success)



ft_lstlast:										; t_list *ft_lstlast(t_list *lst) : rdi -> lst
			cmp		rdi, 0						; rdi can be 0 only at first call
			jz		general_exit				; return 0
			mov		rax, rdi					; copy rdi into rax
			mov		rdi, qword[rax + next]		; set rdi to lst->next
			cmp		rdi, 0						; loop if rdi is not 0
			jnz		ft_lstlast					; recursion
			ret									; return



ft_lstadd_front:								; void ft_lstadd_front(t_list **alst, t_list *new) rdi -> alst, rsi -> new
											; rdi contains the address of the variable pointing to the list start
			cmp		rdi, 0						; test bad input
			jz		general_exit
			cmp		rsi, 0						; test bad input
			jz		general_exit
			mov		rax, qword[rdi]				; load the list start address in rax
			cmp		rdi, 0						; test bad input
			jz		general_exit
			mov		qword[rsi + next], rax		; set new->next to rax -> old list start
			mov		qword[rdi], rsi				; load the new list start into the pointer
			ret									; return



ft_lstadd_back:									; void ft_lstadd_back(t_list **alst, t_list *new) rdi -> alst, rsi -> new
			cmp		rsi, 0						; test bad input
			jz		general_exit
			cmp		rdi, 0						; test bad input
			jz		general_exit
			mov		rdi, qword[rdi]				; set rdi to actual address of list start
			cmp		rdi, 0						; test bad input
			jz		general_exit
			push	rsi							; push rsi to stack
			call	ft_lstlast					; call ft_lstlast(*alst) <- rax
			pop		rsi							; restore rsi from stack
			mov		qword[rax + next], rsi		; set rax->next to nerw
			ret									; return



ft_lstdelone:									; void ft_lstdelone(t_list *lst, void (*del)(void*)) rdi -> lst, rsi -> del
			cmp		rsi, 0						; test bad input
			jz		general_exit
			cmp		rdi, 0						; test bad input
			jz		general_exit
			push	rdi							; push rdi to stack
			mov		rdi, qword[rdi + content]	; load rdi with lst->content
			call	rsi							; call del on lst->content
			pop		rdi							; restore rdi from stack
			call	free						; call free on lst
			ret									; return


general_exit:
			xor		rax, rax					; return 0
			ret

fail:
			xor		rax, rax					; set rax to 0 for
			ret									; return with error

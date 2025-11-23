struc   _t_list
	next:		resq	1
	content:	resq	1
endstruc

__list_len	equ 16

section	.data
	temp1:	dq		0
	temp2:	dq		0
	temp3:	dq		0

section	.text
	extern	malloc
	extern	free
	extern	ft_putstr
	global	ft_list_new
	global	ft_list_size
	global	ft_list_last
	global	ft_list_add_front
	global	ft_list_add_back
	global	ft_list_delone
	global	ft_list_clear
	global	ft_list_delete_if


ft_list_new:										; t_list *ft_list_new(void *content) : rdi -> content*
			push	rdi							; push rdi on stack
			mov		rdi, __list_len				; set rdi = sizoef(t_list) for malloc
			call	malloc wrt ..plt			; malloc(rdi) -> rax
			pop		rdi							; restore rdi from stack
			cmp		rax, 0						; check if rax is 0 (malloc failed)
			jz		fail						; jump to fail
			mov		qword [rax + content], rdi	; set newlist->content to input content pointer
			mov		qword [rax + next], 0		; set newlist->next to null (0)
			ret									; return (success)



ft_list_size:										; size_t ft_list_size(t_list *list_) : rdi -> list_
			mov		rax, 0						; set counter to 0
			cmp		rdi, 0						; return 0 if list_ = NULL
			jz		general_exit
			lea		rdi, [rdi]					; load rdi with *temp
.loop_list_size:
			inc		rax							; increment counter
			mov		rdi, qword[rdi + next]		; list_ = list_->next
			cmp		rdi, 0						; test if list_ is 0
			jnz		.loop_list_size;			; loop
			ret									; return (success)



ft_list_last:										; t_list *ft_list_last(t_list *list_) : rdi -> list_
			cmp		rdi, 0						; rdi can be 0 only at first call
			jz		general_exit				; return 0
			mov		rax, rdi					; copy rdi into rax
			mov		rdi, qword[rax + next]		; set rdi to list_->next
			cmp		rdi, 0						; loop if rdi is not 0
			jnz		ft_list_last					; recursion
			ret									; return



ft_list_add_front:								; void ft_list_add_front(t_list **alist_, t_list *new) rdi -> alist_, rsi -> new
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



ft_list_add_back:									; void ft_list_add_back(t_list **alist_, t_list *new) rdi -> alist_, rsi -> new
			cmp		rsi, 0						; test bad input
			jz		general_exit
			cmp		rdi, 0						; test bad input
			jz		general_exit
			mov		rdi, qword[rdi]				; set rdi to actual address of list start
			cmp		rdi, 0						; test bad input
			jz		general_exit
			push	rsi							; push rsi to stack
			call	ft_list_last				; call ft_list_last(*alist_) <- rax
			pop		rsi							; restore rsi from stack
			mov		qword[rax + next], rsi		; set rax->next to nerw
			ret									; return


ft_list_delone:									; void ft_list_delone(t_list *list_, void (*del)(void*)) rdi -> list_, rsi -> del
			cmp		rsi, 0						; test bad input
			jz		general_exit
			cmp		rdi, 0						; test bad input
			jz		general_exit
			push	rdi							; push rdi to stack
			mov		rdi, qword[rdi + content]	; load rdi with list_->content
			call	rsi							; call del on list_->content
			pop		rdi							; restore rdi from stack
			call	free wrt ..plt				; call free on list_
			ret									; return


ft_list_clear:				; void ft_list_clear(t_list **list_, void (*del)(void*)) rdi -> list_, rsi -> del
			cmp		rsi, 0						; test bad input
			jz		general_exit
			cmp		rdi, 0						; test bad input
			jz		general_exit
			;mov		rdi, [rdi]
			;cmp		rdi, 0						; test bad input
			;jz		general_exit
.clear_loop:
			push	rsi							; save del
			push	rdi							; save lst
	
			mov		rdi, qword[rdi + content]	; load rdi with list_->content
			call	rsi							; call del on lst->content

			pop		rdi							; retrive lst
			push	qword[rdi + next]			; save lst->next
			call	free wrt ..plt				; free lst

			pop		rdi							;
			pop		rsi							; restore stack
			cmp		rdi, 0						; repeat
			jnz		.clear_loop
			ret


ft_list_delete_if:									; rdi -> &lst, rsi -> ref_data, rdx -> cmp, rcx -> del (deletes if cmp(lst->content, ref_data) returns 0, otherwise does nothing)
			cmp		rdi, 0						; test bad input
			jz		general_exit
			cmp		rdx, 0						; test bad input
			jz		general_exit
			cmp		rcx, 0						; test bad input
			jz		general_exit
			mov		[rel temp1], rsi			; save ref_data
			mov		[rel temp2], rdx			; save cmp
			mov		[rel temp3], rcx			; save del
.delete_loop:										; MUST have rdi -> &lst
			mov		rsi, [rdi]					; rsi: lst
			cmp		rsi, 0
			jz		general_exit				; return if lst is null
			push	rdi							; save lst
			mov		rdi, [rsi + content]		; rdi : lst->content
			mov		rsi, [rel temp1]			; load ref_data
			mov		rdx, [rel temp2]			; load cmp
			call	rdx							; call cmp
			pop 	rdx							; rdx: &lst
			mov		rsi, [rdx]					; rsi: lst
			lea		rdi, [rsi + next]			; rdi: &lst->next (&nextlst)
			cmp		rax, 0						; 0 => remove
			jnz		.delete_loop
			
			mov		rsi, [rel temp3]			; rsi: del
			push	rdx							; save &lst
			mov		rcx, [rdx]					; rcx: lst
	
			mov		rdi, [rcx + content]		; load rcx with lst->content
			call	rsi							; call del on lst->content

			pop		rdx							; retrive &lst
			push	rdx							; save &lst
			mov		rdi, [rdx]					; rdi: lst
			push	qword[rdi + next]			; save lst->next
			call	free wrt ..plt				; free lst
			pop		rdi							; rdi: lst->next
			pop		rdx							; rdx: &lst
			mov		[rdx], rdi					; lst = lst->next
			jmp		.delete_loop
			
			 
			


general_exit:
			xor		rax, rax					; return 0
			ret

fail:
			xor		rax, rax					; set rax to 0 for
			ret									; return with error

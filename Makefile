# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: lpollini <lpollini@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2019/11/15 14:54:43 by ncolomer          #+#    #+#              #
#    Updated: 2023/12/27 23:53:14 by lpollini         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

SRCS		=	 ft_atoi_base.s
OBJS		=	$(SRCS:.s=.o)
OBJSDIR		=	.
BONUS_SRCS	=	
BONUS_OBJS	=	$(BONUS_SRCS:.s=.o)

NA			=	nasm
NA_FLAGS	=	-f elf64 -g
FLAGS 		=	-no-pie -g
NAME		=	libasm.a
TEST		=	test
TEST_BONUS	=	test_bonus


all:			$(NAME)

$(NAME):		$(OBJS)
				ar rcs $(NAME) $(OBJS)

$(OBJS):		$(OBJSDIR)/%.o:	%.s
				$(NA) $(NA_FLAGS) $< -o $@

clean:
				rm -rf $(OBJS) $(BONUS_OBJS)

fclean:			clean
				rm -rf $(NAME) $(BONUS) $(TEST) $(TEST_BONUS)
re:				fclean $(NAME)

test:			$(NAME)
				gcc $(FLAGS) -o $(TEST) main.c $(NAME)
				rm *.o
				./$(TEST) < Makefile
				@echo

bonus:			$(OBJS) $(BONUS_OBJS)
				ar rcs $(NAME) $(OBJS) $(BONUS_OBJS)

test_bonus:		bonus
				gcc $(FLAGS) -L. -lasm -o $(TEST_BONUS) main_bonus.c
				./$(TEST_BONUS)

.PHONY:			clean fclean re test bonus test_bonus

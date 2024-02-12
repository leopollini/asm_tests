/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpollini <lpollini@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/24 12:37:38 by lpollini          #+#    #+#             */
/*   Updated: 2024/02/12 18:26:06 by lpollini         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "protos.h"
#include <stdlib.h>

extern	char *	_pipex(char *a[]);

int main(int argn, char *argv[])
{
	
	printf("##called. %i##\n", _pipex(argv));
}

// int main(int argn, char *argv[])
// {
// 	char *lol = ft_strdup("asdaaaaaaaaaaaaaaaaaaa34 2 rr|\n"), *cop;
// 	cop = ft_strdup(lol);
// 	cop[0] = 'A';

// 	t_list	*ls;

// 	ls = ft_lstnew(lol);
// 	t_list *ls1 = ft_lstnew(NULL);
// 	t_list *ls2 = ft_lstnew(cop);
// 	ls->next = ls1;
// 	ft_lstdelone(ls, free);
	
// 	printf("called. %li\n", ft_atoi_base(argv[1], 16));
// 	//printf("called. %s\n", ls1->next->content);
// }

/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpollini <lpollini@student.42firenze.it    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/24 12:37:38 by lpollini          #+#    #+#             */
/*   Updated: 2025/11/20 17:31:04 by lpollini         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "protos.h"
#include <stdlib.h>
#include <stdio.h>
#include <fcntl.h>
#include <errno.h>
#include <string.h>

// void print_free(void *str)
// {
// 	ft_putstr("No more ");
// 	ft_putstr((char *)str);
// 	ft_write(1, "; ", 2);
// 	free(str);
// }

// int	cmper(void *el, void *ref)
// {
// 	printf("checking %s:", (char*)el);
// 	if (((char *)el)[0] == 'A')
// 	{
// 		printf("Remove!!\n");
// 		return 0;
// 	}
// 	printf("Dont remove.\n");
// 	return 1;
// }

int main(int argn, char *argv[])
{
	printf("argv[1]: \'%s\'\n\n", argv[1]);
	printf("---- now testing stuff ----\n");

	printf("ft_strlen: %i (%c)\n\n", ft_strlen(argv[1]), ft_strlen(argv[1]));
	
	char *copy = malloc(ft_strlen(argv[1]) + 1);
	ft_strcpy(copy, argv[1]);
	printf("ft_strcpy \'%s\' (len): %i\n\n", copy, ft_strlen(argv[1]));

	printf("ft_strcmp 1: %i\n", ft_strcmp(copy, argv[1]));
	copy[1] = 'd';
	printf("ft_strcmp 2: %i\n\n", ft_strcmp(copy, argv[1]));

	printf("writing copy: \n");
	int len = ft_write(1, copy, ft_strlen(copy));			// maybe not aligned because of printf slow
	printf("; len: %i\n\n", len);
	
	// printf("reading from stdin to copy >>");
	// ft_read(0, copy, ft_strlen(copy));
	// printf("\nCopied \'%s\'\n\n", copy);

	char *dup = ft_strdup(argv[1]);
	printf("ft_strdup of argv[1]: \'%s\'; errno: %i\n\n", dup, errno);

	// printf("---- now testing lists ----\n");
	
	// t_list *ls = ft_list_new(copy);
	// ft_list_add_back(&ls, ft_list_new(dup));
	// ft_list_add_front(&ls, ft_list_new(ft_strdup(dup)));

	// printf("size of list: %li\n", ft_list_size(ls));
	// printf("contents: %s->%s->%s\n", (char *)ls->content, (char *)ls->next->content, (char *)ls->next->next->content);

	// ft_list_delete_if(&ls, NULL, cmper, print_free);
	
	// ft_putstr("doing the clear\n");
	// ft_list_clear(ls, print_free);
	// ft_putstr("\ndone the clear\n");

	int filefd = open("lolfile", O_RDWR);
	int lenc = ft_strlen(copy);

	ft_read(filefd, copy, lenc);
	printf("read from file (%i) characters: %s\n", lenc, copy);
	copy[0] = '?';
	ft_write(filefd, copy, lenc);
	printf("writing to file: %s, errno: %i\n", copy, errno);


	free(dup);
	free(copy);

	return(errno);
}
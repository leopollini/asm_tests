/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpollini <lpollini@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/24 12:37:38 by lpollini          #+#    #+#             */
/*   Updated: 2023/12/27 23:53:11 by lpollini         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "protos.h"
#include <stdlib.h>

int main(int argn, char *argv[])
{
	printf("called. %li\n", ft_atoi_base(argv[1], 16));
	//printf("called. %s\n", ls1->next->content);
}

/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   protos.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpollini <lpollini@student.42firenze.it    +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/24 12:38:42 by lpollini          #+#    #+#             */
/*   Updated: 2025/11/20 17:57:44 by lpollini         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef PROTOS_H

# define PROTOS_H

# include <stdio.h>
# include <unistd.h>
# include <stdlib.h>

typedef struct s_list
{
	struct s_list	*next;
	void			*content;
}			t_list;


extern int	ft_strlen(const char *s);
extern int	ft_strcmp(char *s1, char *s2);
extern void	ft_strcpy(char *to, char *fro);
extern int	ft_write(int fd, char *s, size_t n);
extern int	ft_read(int fd, char *s, size_t n);
extern char	*ft_strdup(char *s);
extern void ft_putstr(void *s);

// extern t_list	*ft_list_new(void *c);
// extern size_t	ft_list_size(void *c);
// extern t_list	*ft_list_last(t_list *lst);
// extern void		ft_list_add_front(t_list **alst, t_list *new);
// extern void		ft_list_add_back(t_list **alst, t_list *new);
// extern void		ft_list_delone(t_list *lst, void (*del)(void*));
// extern void		ft_list_clear(t_list *lst, void (*del)(void*));
// extern void		ft_list_iter(t_list *lst, void (*f)(void*));
// extern long		ft_atoi_base(char *s, short base);
// extern t_list	*ft_list_map(t_list *lst, void *(*f)(void*), void (*del)(void *));
// extern t_list	*ft_list_sort(t_list **lst, int (*cmp)());
// extern void		ft_list_delete_if(t_list **lst, void *ref, int (*cmp)(), void (*del)());

#endif

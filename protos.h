/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   protos.h                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: lpollini <lpollini@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2023/12/24 12:38:42 by lpollini          #+#    #+#             */
/*   Updated: 2023/12/27 23:31:22 by lpollini         ###   ########.fr       */
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


extern int	ft_strlen(char *s);
extern int	ft_strcmp(char *s1, char *s2);
extern char *ft_strcpy(char *to, char *fro);
extern int	ft_write(int fd, char *s, size_t n);
extern int	ft_read(int fd, char *s, size_t n);
extern char	*ft_strdup(char *s);
extern int	boh();

extern t_list	*ft_lstnew(void *c);
extern size_t	ft_lstsize(void *c);
extern t_list	*ft_lstlast(t_list *lst);
extern void		ft_lstadd_front(t_list **alst, t_list *new);
extern void		ft_lstadd_back(t_list **alst, t_list *new);
extern void		ft_lstdelone(t_list *lst, void (*del)(void*));
extern void		ft_lstclear(t_list **lst, void (*del)(void*));
extern void		ft_lstiter(t_list *lst, void (*f)(void*));
extern long		ft_atoi_base(char *s, short base);
extern t_list	*ft_lstmap(t_list *lst, void *(*f)(void*), void (*del)(void *));



#endif

NAME = tester_ps.a
CC = gcc  # C compiler
CFLAGS = -Wall -Werror -Wextra -I.   # C flags
RM = rm -f   # rm command


SRCS = moves_counter.c\
gnl/get_next_line.c\
gnl/get_next_line_utils.c\

OBJS = $(SRCS:.c=.o)

all: ${NAME}
	@printf "Makefile for tester starts\n"

$(NAME): $(OBJS)
	ar rcs $@ $(OBJS)
	$(CC) $(NAME) -o tester_ps

clean:
	$(RM) $(OBJS)

fclean: clean
	rm -f $(NAME)
	rm tester_ps

cleanall: fclean
	rm output*
	rm checker_linux
	rm push_swap 


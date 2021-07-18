#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <fcntl.h>
#include "gnl/get_next_line.h"

int	ft_isspace_isdigit(char c, char d)
{
	if (d == 's')
	{
		if (c == ' ' || c == '\t' || c == '\n'
			|| c == '\v' || c == '\f' || c == '\r')
			return (1);
	}
	else if (d == 'd')
	{
		if (c >= 48 && c <= 57)
			return (1);
	}
	else if (d == 'b')
	{
		if (c == ' ' || c == '\t' || c == '\n'
			|| c == '\v' || c == '\f' || c == '\r'
			|| (c >= 48 && c <= 57))
			return (1);
	}
	return (0);
}

char	*remove_space_digit(char *line, char c)
{
	if (c == 's')
	{
		while (ft_isspace_isdigit(*line, 's'))
			line++;
	}
	else if (c == 'd')
	{
		while (ft_isspace_isdigit(*line, 'd'))
			line++;
	}
	else if (c == 'b')
	{
		while (ft_isspace_isdigit(*line, 's'))
			line++;
		if (*line == '+' || *line == '-')
			line++;
		while (ft_isspace_isdigit(*line, 'd'))
			line++;
	}
	return (line);
}


int	ft_atoi(const char *str)
{
	int		sign;
	int		result;

	sign = 1;
	result = 0;
	while (ft_isspace_isdigit(*str, 's'))
		str++;
	if (*str == '-' || *str == '+')
	{
		if (*(str++) == '-')
			sign *= -1;
	}
	while (*str)
	{
		if (*str >= '0' && *str <= '9')
		{
			result *= 10;
			result += (*(str++) - '0');
		}
		else
			return (result * sign);
	}
	return (result * sign);
}

void	get_max_moves(char *line, int total)
{
	int num;
	int	big_num;

	big_num = ft_atoi(line);
	while (*line != '\0')
	{
		num = ft_atoi(line);
		line = remove_space_digit(line, 'b');
		if (num > big_num)
			big_num = num;
	}
	printf("Total Number Of Tests Done: [%d]\n", total);
	printf("Maximum Moves taken To Sort: [%d]\n", big_num);
}

int main(int argc, char **argv)
{
	
	char	*str;
	char	*join;
	char	*line;
	int		fd;
	int		i;
	int		j;
		
	if (argc != 2)
	{
		printf("Error in args\n");
		printf("please enter the path of test.txt in arg\n");
		return (1);
	}
	str = ft_strdup(argv[1]);
	fd = open(str, O_RDONLY);
	if (fd < 0)
	{
		printf("error in opening the file\n");
		return (1);
	}
	free(str);
	j = 0;
	join = ft_strdup("");
	while ((i = get_next_line(fd, &line)) > 0)
	{
		j++;
		join = ft_strjoin(join, line);
		join = ft_strjoin(join, " ");
		free(line);
	}
	free(line);
	get_max_moves(join, j);
	free(join);
	i = close(fd);
	return (0);
}
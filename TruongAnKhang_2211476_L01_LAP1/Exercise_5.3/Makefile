CC = gcc
CFLAGS = -Wall -Wextra -std=c99

SRC = calc.c calculator.c
OBJ = $(SRC:.c=.o)

all: calc

calc: $(OBJ)
	$(CC) $(CFLAGS) -o $@ $^

clean:
	rm -f $(OBJ) calc


All: assig8main
LIB=libConversions.o
CC=gcc

assig8main: assig8main.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@


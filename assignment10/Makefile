All: a10q2
LIB=lib.o
CC=gcc

assig8main: a10q2.o $(LIB)
	$(CC) $@.o $(LIB) -g -o $@

.s.o:
	$(CC) $(@:.o=.s) -g -c -o $@


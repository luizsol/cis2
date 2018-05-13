# Makefile

# Compiler
CC = ghdl

# Goals
.DEFAULT_GOAL := main

# Object files
xor2.o: xor2.vhd
	$(CC) -a xor2.vhd

reg.o: reg.vhd
	$(CC) -a reg.vhd

lfsr.o: lfsr.vhd
	$(CC) -a lfsr.vhd

lfsr: xor2.o reg.o lfsr.o
	$(CC) -e lfsr

# All
all main: lfsr

clean:
	rm -f *.o

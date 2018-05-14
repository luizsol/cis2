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

clock.o: clock.vhd
	$(CC) -a clock.vhd

stimuli_lfsr.o: stimuli_lfsr.vhd
	$(CC) -a stimuli_lfsr.vhd

testbench_lfsr.o: testbench_lfsr.vhd
	$(CC) -a testbench_lfsr.vhd

testbench_lfsr: testbench_lfsr.o stimuli_lfsr.o clock.o lfsr.o reg.o xor2.o
	$(CC) -e tb_lfsr

testbench_lfsr_run: testbench_lfsr
	$(CC) -r tb_lfsr --vcd=tb_lfsr.vcd

# All
all main: testbench_lfsr_run

clean:
	rm -f *.cf *.o

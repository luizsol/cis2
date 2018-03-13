# Definindo o diretório do projeto
cd X:/projects/cis2/exp01/rc_1
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work X:/projects/cis2/exp01/rc_1/rc_adder_1.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.rc_adder_1
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/rc_adder_1/a_i \
sim:/rc_adder_1/b_i \
sim:/rc_adder_1/c_i \
sim:/rc_adder_1/z_out \
sim:/rc_adder_1/c_o \
sim:/rc_adder_1/cout_0 \
sim:/rc_adder_1/cout_1 \
sim:/rc_adder_1/cout_2
# Realizando simulação por 100ns
force a_i 1011
force b_i 0011
force c_i 0
run 100ns

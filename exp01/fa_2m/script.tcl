# Definindo o diretório do projeto
cd X:/projects/cis2/exp01/fa_2m
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work X:/projects/cis2/exp01/fa_2m/full_adder_2m.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.full_adder_2m
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/full_adder_2m/a_in \
sim:/full_adder_2m/b_in \
sim:/full_adder_2m/c_in \
sim:/full_adder_2m/z_out \
sim:/full_adder_2m/c_out \
sim:/full_adder_2m/aux_xor \
sim:/full_adder_2m/aux_and_1 \
sim:/full_adder_2m/aux_and_2 \
sim:/full_adder_2m/aux_and_3
# Realizando simulação por 100ns
force a_in 0
force b_in 1
force c_in 0
run 100ns

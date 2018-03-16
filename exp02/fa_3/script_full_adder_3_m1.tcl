# Definindo o diretório do projeto
cd X:/projects/cis2/exp02/fa_3
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work X:/projects/cis2/exp02/fa_3/full_adder_3_m1.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.full_adder
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/full_adder/a_in \
sim:/full_adder/b_in \
sim:/full_adder/c_in \
sim:/full_adder/z_out \
sim:/full_adder/c_out \
sim:/full_adder/aux_xor \
sim:/full_adder/aux_and_1 \
sim:/full_adder/aux_and_2 \
sim:/full_adder/aux_and_3
# Realizando simulação por 100ns
force a_in 0
force b_in 1
force c_in 0
run 100ns

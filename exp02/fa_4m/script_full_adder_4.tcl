# Definindo o diretório do projeto
cd X:/projects/cis2/exp02/fa_4m
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work X:/projects/cis2/exp02/fa_4m/full_adder_4.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.full_adder_4
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/full_adder_4/a_in \
sim:/full_adder_4/b_in \
sim:/full_adder_4/c_in \
sim:/full_adder_4/z_out \
sim:/full_adder_4/c_out
# Realizando simulação por 100ns
set meio_periodo 10
force -freeze a_in 0 0, 1 $meio_periodo ns -r [expr {2 * $meio_periodo}]
force -freeze b_in 0 0, 1 [expr {2 * $meio_periodo}] ns -r [expr {4 * $meio_periodo}]
force -freeze c_in 0 0, 1 [expr {4 * $meio_periodo}] ns -r [expr {8 * $meio_periodo}]
run [expr {8 * $meio_periodo}]


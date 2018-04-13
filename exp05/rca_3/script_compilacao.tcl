# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp05/rca_3"

set arquivos {"full_adder_1.vhd" "rc_adder_3.vhd" "stimuli_rc_adder.vhd" "testbench_rc_adder.vhd"}

set componente "tb_rc_adder"

set duration [expr {60 * 5}]
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
[foreach arquivo $arquivos {
    vcom -reportprogress 300 -work work $diretorio/$arquivo
}]

# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente/*
# add wave -position insertpoint sim:/$componente/dut/cout_s
run $duration ns

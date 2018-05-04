# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp07/mem_1"

set arquivos {"mem_1.vhd" "stimuli_mem_1.vhd" "testbench_mem_1.vhd"}

set componente "tb_mem_1"

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

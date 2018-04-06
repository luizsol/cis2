# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp04/seq_2"

set arquivo1 "fsm_main_2.vhd"
set componente1 "fsm_main"

set arquivo2 "clock_generator.vhd"
set componente2 "clock_generator"

set arquivo3 "stimuli_seq_2.vhd"
set componente3 "stimuli_seq_2"

set arquivo4 "testbench_seq_2.vhd"
set componente4 "tb_fsm_main_seq_2"

set duration [expr {350 * 10}]
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work $diretorio/$arquivo1
vcom -reportprogress 300 -work work $diretorio/$arquivo2
vcom -reportprogress 300 -work work $diretorio/$arquivo3
vcom -reportprogress 300 -work work $diretorio/$arquivo4
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente4
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente4/*
run $duration ns

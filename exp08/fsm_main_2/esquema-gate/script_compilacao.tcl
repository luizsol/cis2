# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp08/fsm_main_2/esquema-gate"

set arquivo1 "adk_comp.vhd"

set arquivo2 "adk.vhd"

set arquivo3 "fsm_main_gt.vhd"

set arquivo4 "clock_generator.vhd"

set arquivo5 "stimuli_seq_2.vhd"

set arquivo6 "testbench_seq_2.vhd"
set componente "tb_fsm_main_seq_2"

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
vcom -reportprogress 300 -work work $diretorio/$arquivo5
vcom -reportprogress 300 -work work $diretorio/$arquivo6
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente/*
run $duration ns

# Saindo de uma possível simulação anterior
quit -sim
# Apangando a library work atual
vmap -del work
vdel -all -lib work
# Definindo variáveis da compilação e simulação
set diretorio "~/projects/cis2/snake"
# set diretorio "X:/projects/cis2/snake"

set arquivos {"src/snake_package.vhd" "src/fsm_step.vhd" "src/clock.vhd" "test/fsm_step_stimuli.vhd" "test/fsm_step_tb.vhd"}

set componente "fsm_step_tb"

set duration [expr {500}]
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
add wave -position insertpoint sim:/$componente/dut/STATE
run $duration ns

# Saindo de uma possível simulação anterior
quit -sim
# Apangando a library work atual
vmap -del work
vdel -all -lib work
# Definindo variáveis da compilação e simulação
set diretorio "~/projects/cis2/snake"

set arquivos {"src/full_adder.vhd" "test/full_adder_stimuli.vhd" "test/full_adder_tb.vhd"}

set componente "full_adder_tb"

set duration [expr {40}]
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
run $duration ns

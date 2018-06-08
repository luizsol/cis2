# Saindo de uma possível simulação anterior
quit -sim
# Apangando a library work atual
vmap -del work
# Definindo variáveis da compilação e simulação
set diretorio "~/projects/cis2/snake"

set arquivos {"src/snake_package.vhd" "src/num_gen.vhd" "test/num_gen_stimuli.vhd" "test/num_gen_tb.vhd"}

set componente "num_gen_tb"

set duration [expr {8}]
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
add wave -position insertpoint sim:/$componente/ctrl_ctrl_s.ng_one_gen
add wave -position insertpoint sim:/$componente/ctrl_ctrl_s.ng_pos_neg
add wave -position insertpoint sim:/$componente/ctrl_ctrl_s.ng_one_three
add wave -position insertpoint sim:/$componente/random_num_s
add wave -position insertpoint sim:/$componente/number_s
run $duration ns

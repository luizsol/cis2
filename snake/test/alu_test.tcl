# Saindo de uma possível simulação anterior
quit -sim
# Apangando a library work atual
vmap -del work
# Definindo variáveis da compilação e simulação
set diretorio "~/projects/cis2/snake"

set arquivos {"src/snake_package.vhd" "src/full_adder.vhd" "src/rc_adder.vhd" "src/alu.vhd" "test/alu_stimuli.vhd" "test/alu_tb.vhd"}

set componente "alu_tb"

set duration [expr {15}]
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
add wave -position insertpoint sim:/$componente/op_first_s
add wave -position insertpoint sim:/$componente/rb_op_s
add wave -position insertpoint sim:/$componente/ofc_result_s
add wave -position insertpoint sim:/$componente/ctrl_ctrl_s.alu_x_y
add wave -position insertpoint sim:/$componente/ctrl_ctrl_s.alu_pass_calc
run $duration ns

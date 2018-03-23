# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp03/ng_1m"
set arquivo "num_gen_1m_v2.vhd"
set componente "num_gen_direct"
set meio_periodo 10
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work $diretorio/$arquivo
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/$componente/pos_neg \
sim:/$componente/one_three \
sim:/$componente/one_num_gen \
sim:/$componente/pos_neg_s \
sim:/$componente/one_three_s \
sim:/$componente/one_gen_s \
sim:/$componente/rand_num_direct \
sim:/$componente/number
# Realizando simulação por 100ns
force -freeze pos_neg 0 0, 1 $meio_periodo ns -r [expr {2 * $meio_periodo}]
force -freeze one_three 0 0, 1 [expr {2 * $meio_periodo}] ns -r [expr {4 * $meio_periodo}]
force -freeze one_num_gen 0 0, 1 [expr {4 * $meio_periodo}] ns -r [expr {8 * $meio_periodo}]
run [expr {8 * $meio_periodo}]

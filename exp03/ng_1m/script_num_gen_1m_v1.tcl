quit -sim
set diretorio "X:/projects/cis2/exp03/ng_1m"
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work $diretorio/num_gen_1m_v1.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.num_gen_direct
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/num_gen_direct/pos_neg \
sim:/num_gen_direct/one_three \
sim:/num_gen_direct/one_num_gen \
sim:/num_gen_direct/pos_neg_s \
sim:/num_gen_direct/one_three_s \
sim:/num_gen_direct/one_gen_s \
sim:/num_gen_direct/rand_num_direct \
sim:/num_gen_direct/number
# Realizando simulação por 100ns
set meio_periodo 10
force -freeze pos_neg 0 0, 1 $meio_periodo ns -r [expr {2 * $meio_periodo}]
force -freeze one_three 0 0, 1 [expr {2 * $meio_periodo}] ns -r [expr {4 * $meio_periodo}]
force -freeze one_num_gen 0 0, 1 [expr {4 * $meio_periodo}] ns -r [expr {8 * $meio_periodo}]
run [expr {8 * $meio_periodo}]

# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp03/ng_2"
set arquivo "num_gen_2.vhd"
set componente "num_gen_with_function"
set sinais_input [list "pos_neg" "one_three" "one_num_gen"]
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
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente/*
# Fazendo estímulos na entrada
[for {set i 0} {$i < [llength $sinais_input]} {incr i} {
    set tick_tock [expr {[expr pow(2, $i)] * $meio_periodo}]
    force -freeze [lindex $sinais_input $i] 0 0, 1 [expr {$tick_tock / 2}] ns -r $tick_tock
    if {[string match [lindex $sinais_input $i] [lindex $sinais_input end]]} {
        run $tick_tock
    }
}]

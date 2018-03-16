# Definindo o diretório do projeto
cd X:/projects/cis2/exp02/rb_2m
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work X:/projects/cis2/exp02/rb_2m/reg_bank_simplificado_2_m.vhd
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.reg_bank
# Configurando os sinais a serem apresentados
add wave -position insertpoint  \
sim:/reg_bank/out_sel \
sim:/reg_bank/alu_out \
sim:/reg_bank/head_out_s \
sim:/reg_bank/reg2_out_s \
sim:/reg_bank/fifo_out_s
# Realizando simulação por 100ns
set meio_periodo 10
force -freeze out_sel HEAD_OUT 0, REG2_OUT $meio_periodo ns, FIFO_OUT [expr {2 * $meio_periodo}] ns -r [expr {3 * $meio_periodo}]
run [expr {6 * $meio_periodo}]


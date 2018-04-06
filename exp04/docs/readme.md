# PSI-3451 Projeto de CI Lógicos Integrados
# Luiz Sol - 8586861
# Experimento 4

## 1) Captura, compilação e simulação do testbench para o circuito combinacional.

Estrutura da pasta:
```
comb
|-- num_gen_1.vhd
|-- script_compilacao.tcl
|-- stimuli_comb.vhd
`-- testbench_comb.vhd
```

Script de compilação:

```tcl
# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp04/comb"
set arquivo1 "num_gen_1.vhd"
set arquivo2 "stimuli_comb.vhd"
set arquivo3 "testbench_comb.vhd"
set componente1 "num_gen_direct"
set componente2 "stimuli_module"
set componente3 "tb_num_gen_direct_combinatorial"
set duration [expr {2 * 100}]
# Definindo o diretório do projeto
cd $diretorio
# Criando as libraries do projeto
vlib work
vmap work work
# Compilando o projeto
vcom -reportprogress 300 -work work $diretorio/$arquivo1
vcom -reportprogress 300 -work work $diretorio/$arquivo2
vcom -reportprogress 300 -work work $diretorio/$arquivo3
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente3
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente1/*
add wave -position insertpoint sim:/$componente2/*
add wave -position insertpoint sim:/$componente3/*
run $duration ns
```

Resultado da simulação

![Resultado da primeira simulação](img/wave_comb_01.bmp)

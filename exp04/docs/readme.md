# PSI-3451 Projeto de CI Lógicos Integrados
# Luiz Sol - 8586861
# Experimento 4

## 1) Captura, compilação e simulação do testbench para o circuito combinacional.

Recomendação para a simulação:

* adicione os sinais desejado para a janela Wave e rode a simulação por um tempo compatível com os tempos de wait do stimuli_module.
* observe que você não precisará gerar estímulos para as entrada através do comando force
* após a primeira rodada, adicione mais vetores de teste (chamadas do procedure) para testar todas as condições de entrada.
* Guarde os resultados do Wave para futuras referências e comparações.

***Perguntas***: você conseguiu verificar todas as opções de controle do módulo num_gen_direct? Seguindo as recomendações, a simulação mostrou o comportamento esperado do testbench como descrito na apostila de conceitos? Como você compara o uso do testbench com o uso do arquivo `*.tcl` feito até o momento?

Simulando o circuito na sua forma original

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
add wave -position insertpoint sim:/$componente3/*
run $duration ns
```

Resultado da simulação

![Resultado da primeira simulação](img/wave_comb_01.bmp)


Alterando o arquivo `stimuli_comb.vhd` para adicionar mais vetores de simulação:
```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity stimuli_module is
    generic
    (
    WIDTH   : natural := 6
    );

    port
    (
    pos_neg         : out STD_LOGIC;
    one_three           : out STD_LOGIC;
    one_num_gen     : out STD_LOGIC;
    number          : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );

end stimuli_module ;

architecture test of stimuli_module  is
-- "Time" that will elapse between test vectors we submit to the component.
constant TIME_DELTA : time := 100 ns;

signal  pos_neg_s       :  STD_LOGIC_VECTOR (0 downto 0);
signal  one_three_s :  STD_LOGIC_VECTOR (0 downto 0);



begin

pos_neg <= pos_neg_s(0);
one_three <= one_three_s (0);

simulation : process

-- procedure for vector generation

procedure check_num_gen(constant a, b: in INTEGER; c : in STD_LOGIC) is
begin
-- Assign values to estimuli_module´s outputs.
pos_neg_s <= std_logic_vector(to_unsigned(a,1));
one_three_s <= std_logic_vector(to_unsigned(b,1));
one_num_gen <= c;


wait for TIME_DELTA;
end procedure check_num_gen;

begin

-- test vectors application

check_num_gen(0, 0, '0');
check_num_gen(0, 1, '0');
check_num_gen(1, 0, '0');
check_num_gen(1, 1, '0');
check_num_gen(0, 0, '1');
check_num_gen(0, 1, '1');
check_num_gen(1, 0, '1');
check_num_gen(1, 1, '1');

wait;
end process simulation;
end architecture test;
```

Novo script de compilação:

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
set duration [expr {8 * 100}]
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
add wave -position insertpoint sim:/$componente3/*
run $duration ns
```

Resultado da nova simulação:
![Resultado da primeira simulação](img/wave_comb_02.bmp)

***Respostas***:
> você conseguiu verificar todas as opções de controle do módulo num_gen_direct?

Sim.

> Seguindo as recomendações, a simulação mostrou o comportamento esperado do testbench como descrito na apostila de conceitos?

Sim.

> Como você compara o uso do testbench com o uso do arquivo `*.tcl` feito até o momento?

Mais simples, uma vez que essa arquitetura compartimenta os estímulos dos testes em um arquivo *vhd* e a lógica de compilação no arquivo *tcl*, deixando ambos mais claros e organizados.

## 2) Captura, compilação e simulação do testbench para o primeiro circuito sequencial.

Simulando o circuito na sua forma original

Estrutura da pasta:
```
comb
|-- clock_generator.vhd
|-- fsm_main_1.vhd
|-- script_compilacao.tcl
|-- stimuli_seq_1.vhd
`-- testbench_seq_1.vhd
```

Script de compilação:

```tcl
# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp04/seq_1"

set arquivo1 "fsm_main_1.vhd"
set componente1 "fsm_main_simplificado"

set arquivo2 "clock_generator.vhd"
set componente2 "clock_generator"

set arquivo3 "stimuli_seq_1.vhd"
set componente3 "stimuli_seq_1"

set arquivo4 "testbench_seq_1.vhd"
set componente4 "tb_fsm_main_seq_1"

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
# Modificando as opções de visualização do projeto
vsim -gui -voptargs=+acc work.$componente4
view wave
# Configurando os sinais a serem apresentados
add wave -position insertpoint sim:/$componente4/*
run $duration ns
```

Resultado da simulação

![Resultado da primeira simulação](img/wave_seq_1_01.bmp)

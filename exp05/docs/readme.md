# PSI-3451 Projeto de CI Lógicos Integrados

# Luiz Sol - 8586861

# Experimento 5

## 1) Captura, compilação e simulação do somador ripple_carry no modelo estrutural

**Perguntas**: todas as entidades aparecem na biblioteca work?

* Faça a simulação da entidade `testbench_rc_adder` (cf. descrito em exemplos trabalhados na práticas anteriores).

**Recomendação**: adicione estímulos ao testbench e sinais internos no Wave a fim de para verificar:

* o funcionamento do ripple carry adder
* teste casos de propagação de carry-out e de overflow

Guarde os resultados do Wave para futuras referências e comparações.

**Perguntas**: seguindo as recomendações, a simulação mostrou o comportamento esperado do circuito como descrito na apostila de conceitos? É o mesmo resultado da simulação do item 5) da Aula 2?

**Resultados**:

Layout da pasta:
```
rca_2
|-- full_adder_1.vhd
|-- rc_adder_2.vhd
|-- script_compilacao.tcl
|-- stimuli_rx_adder.vhd
|-- testbench_rc_adder.vhd
```

`testbench_rc_adder.vhd`:
```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_rc_adder is

GENERIC (WIDTH: natural :=8);

end tb_rc_adder;

architecture test of tb_rc_adder is

component stimuli_module
  generic
  (
  WIDTH: natural := 32
  );

  port
  (
  a_i, b_i: out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  c_i:      out STD_LOGIC
  );
end component ;

component rc_adder_2
  generic
  (
  WIDTH : integer := 32
  );

  port
  (
  a_i, b_i: in STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  c_i:      in STD_LOGIC;
  z_o :     out STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  c_o:      out STD_LOGIC
  );
end component ;

  signal a_i_s, b_i_s, z_o_s : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
  signal c_i_s, c_o_s : STD_LOGIC;

begin

-- Instantiate DUT
  dut : rc_adder_2
    generic map(WIDTH => WIDTH)
    port map(a_i => a_i_s,
        b_i => b_i_s,
        c_i => c_i_s,
        z_o => z_o_s,
        c_o => c_o_s);

-- Instantiate test module
  test : stimuli_module
    generic map(WIDTH => WIDTH)
    port map(a_i => a_i_s,
        b_i => b_i_s,
        c_i => c_i_s);


end architecture test;
```

`script_compilacao.tcl`:
```tcl
# Saindo de uma possível simulação anterior
quit -sim
# Definindo variáveis da compilação e simulação
set diretorio "X:/projects/cis2/exp05/rca_2"

set arquivos {"full_adder_1.vhd" "rc_adder_2.vhd" "stimuli_rc_adder.vhd" "testbench_rc_adder.vhd"}

set componente "tb_rc_adder"

set duration [expr {40 * 3}]
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
add wave -position insertpoint sim:/$componente/dut/cout_s
run $duration ns
```

Resultado da simulação:

![](img/rca_2_wave01.bmp)

> todas as entidades aparecem na biblioteca work?

Sim, todas as entidades apareceram na biblioteca `work`.

> seguindo as recomendações, a simulação mostrou o comportamento esperado do circuito como descrito na apostila de conceitos?

Sim.

> É o mesmo resultado da simulação do item 5) da Aula 2?

Sim.

### 2) Captura, compilação e simulação da unidade lógica aritmética

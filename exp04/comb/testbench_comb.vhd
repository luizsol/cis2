library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_num_gen_direct_combinatorial is

GENERIC (WIDTH: natural :=8);

end tb_num_gen_direct_combinatorial;

architecture test of tb_num_gen_direct_combinatorial is

component stimuli_module
    generic
    (
    WIDTH   : natural := 6
    );

    port
    (
    pos_neg         : out STD_LOGIC;
    one_three       : out STD_LOGIC;
    one_num_gen     : out STD_LOGIC;
    number          : in STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );

end component ;

component num_gen_direct is
    generic
    (
    WIDTH   : natural := 6
    );

    port
    (
    pos_neg         : in STD_LOGIC;
    one_three       : in STD_LOGIC;
    one_num_gen     : in STD_LOGIC;
    number          : out STD_LOGIC_VECTOR (WIDTH-1 downto 0)
    );
end component;

    signal number_s : STD_LOGIC_VECTOR(WIDTH-1 downto 0);
    signal pos_neg_s, one_three_s, one_num_gen_s  : STD_LOGIC;

begin

-- Instantiate DUT
    dut : num_gen_direct
        generic map(WIDTH => WIDTH)
        port map(pos_neg            => pos_neg_s,
                one_three           => one_three_s,
                one_num_gen         => one_num_gen_s,
                number      => number_s);

-- Instantiate test module
    test : stimuli_module
        generic map(WIDTH => WIDTH)
        port map(pos_neg            => pos_neg_s,
                one_three           => one_three_s,
                one_num_gen         => one_num_gen_s,
                number      => number_s);


end architecture test;

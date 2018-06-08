library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.snake_package.all;

entity num_gen_tb is
    generic (
        WIDTH  : natural := 8
    );
end num_gen_tb;

architecture test of num_gen_tb is
    component num_gen
        generic (
            WIDTH  : natural := 8
        );

        port (
            ctrl_ctrl   : in  datapath_ctrl_flags;
            random_num  : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            number      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component num_gen_stimuli is
        generic (
            WIDTH  : natural := 8
        );

        port (
            ctrl_ctrl   : out datapath_ctrl_flags;
            random_num  : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
            number      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    signal ctrl_ctrl_s: datapath_ctrl_flags;
    signal random_num_s, number_s : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    -- Instantiate DUT
    dut : num_gen
        port map (
            ctrl_ctrl   => ctrl_ctrl_s,
            random_num  => random_num_s,
            number      => number_s
        );

    -- Instantiate stimuli generation module
    test : num_gen_stimuli
        port map (
            ctrl_ctrl   => ctrl_ctrl_s,
            random_num  => random_num_s,
            number      => number_s
        );

end architecture test;

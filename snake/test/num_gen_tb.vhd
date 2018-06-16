--******************************************************************************
--*                                                                            *
--* Title   : num_gen_tb.vhd                                                   *
--* Design  :                                                                  *
--* Author  : Luiz Sol                                                         *
--* Email   : luizedusol@gmail.com                                             *
--*                                                                            *
--******************************************************************************
--*                                                                            *
--* Description :                                                              *
--*                                                                            *
--******************************************************************************

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
            clk         : in  STD_LOGIC;
            res         : in  STD_LOGIC;
            pos_neg     : in  STD_LOGIC;
            one_three   : in  STD_LOGIC;
            one_num_gen : in  STD_LOGIC;
            number      : out STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    component num_gen_stimuli is
        generic (
            WIDTH  : natural := 8
        );

        port (
            clk         : out STD_LOGIC;
            res         : out STD_LOGIC;
            pos_neg     : out STD_LOGIC;
            one_three   : out STD_LOGIC;
            one_num_gen : out STD_LOGIC;
            number      : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0)
        );
    end component;

    signal clk_s, res_s, pos_neg_s, one_three_s, one_num_gen_s: STD_LOGIC;
    signal number_s : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);

begin
    -- Instantiate DUT
    dut : num_gen
        port map (
            clk         => clk_s,
            res         => res_s,
            pos_neg     => pos_neg_s,
            one_three   => one_three_s,
            one_num_gen => one_num_gen_s,
            number      => number_s
        );

    -- Instantiate stimuli generation module
    test : num_gen_stimuli
        port map (
            clk         => clk_s,
            res         => res_s,
            pos_neg     => pos_neg_s,
            one_three   => one_three_s,
            one_num_gen => one_num_gen_s,
            number      => number_s
        );

end architecture test;

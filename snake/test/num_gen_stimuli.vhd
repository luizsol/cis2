--******************************************************************************
--*                                                                            *
--* Title   : num_gen_stimuli.vhd                                              *
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

entity num_gen_stimuli is
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
end num_gen_stimuli;

architecture test of num_gen_stimuli is

    signal clk_s, res_s: STD_LOGIC;

    component clock
        generic (
            CLK_PERIOD: TIME := 10 ns
        );
        port (
            clk : out STD_LOGIC
        );
    end component;

begin
    clk <= clk_s;
    res <= res_s;

    clock_cmp : clock
        port map (
            clk => clk_s
        );

    sim : process
        procedure select_function(
            one_num_gen_s, pos_neg_s, one_three_s: STD_LOGIC
        ) is
        begin
            one_num_gen <= one_num_gen_s;
            pos_neg     <= pos_neg_s;
            one_three   <= one_three_s;
        end procedure select_function;

        procedure reset is
        begin
            wait until falling_edge(clk_s);
            res_s <= '1';
            wait until falling_edge(clk_s);
            res_s <= '0';

        end procedure reset;

    begin
        -- The truth table of this device must be:
        --
        -- | test | one_gen | pos_neg | one_three |   number   |
        -- |------|---------|---------|-----------|------------|
        -- |  1   |    1    |    x    |     x     | random_num |
        -- |  2   |    0    |    0    |     0     |     +1     |
        -- |  3   |    0    |    0    |     1     |     +3     |
        -- |  4   |    0    |    1    |     0     |     -1     |
        -- |  5   |    0    |    1    |     1     |     -3     |

        -- Test 1
        select_function('1', '0', '0');
        reset;
        wait for 1 ns;
        assert number = "01110111" report
            "Test 1: The output was different from random_num";

        -- Test 2
        wait until falling_edge(clk_s);
        select_function('0', '0', '0');
        wait until falling_edge(clk_s);
        assert number = STD_LOGIC_VECTOR(TO_UNSIGNED(1, WIDTH)) report
            "Test 2: The output was different from +1";

        -- Test 3
        wait until falling_edge(clk_s);
        select_function('0', '0', '1');
        wait until falling_edge(clk_s);
        assert number = STD_LOGIC_VECTOR(TO_UNSIGNED(3, WIDTH)) report
            "Test 3: The output was different from +1";

        -- Test 4
        wait until falling_edge(clk_s);
        select_function('0', '1', '0');
        wait until falling_edge(clk_s);
        assert number = STD_LOGIC_VECTOR(TO_SIGNED(-1, WIDTH)) report
            "Test 4: The output was different from +1";

        -- Test 5
        wait until falling_edge(clk_s);
        select_function('0', '1', '1');
        wait until falling_edge(clk_s);
        assert number = STD_LOGIC_VECTOR(TO_SIGNED(-3, WIDTH)) report
            "Test 5: The output was different from +1";

        wait;
    end process sim;
end architecture test;

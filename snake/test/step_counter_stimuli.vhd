--******************************************************************************
--*                                                                            *
--* Title   : step_counter_stimuli.vhd                                         *
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

entity step_counter_stimuli is
    generic (
        COUNT_MAX   : UNSIGNED := x"3C"; -- 60 decimal
        CLK_PERIOD  : TIME := 10 ns
    );

    port (
        clk         : out STD_LOGIC;
        res         : out STD_LOGIC := '0';
        cnt_rdy     : in  STD_LOGIC;
        cnt_value   : in  UNSIGNED(7 downto 0)
    );
end step_counter_stimuli;

architecture test of step_counter_stimuli is
    signal clk_s : STD_LOGIC;

    component clock
        generic (
            CLK_PERIOD  : TIME := 10 ns
        );

        port (
            clk : out STD_LOGIC
        );
    end component ;
begin
    clk <= clk_s;

    clock_cmp : clock
        generic map (
            CLK_PERIOD => CLK_PERIOD
        )
        port map (
            clk => clk_s
        );

    sim : process
    begin
        res <= '1';
        wait for 2 ns;
        assert cnt_rdy = '0' report "Test 1: cnt_rdy = 1 when res.";
        assert cnt_value = "00000000" report "Test 1: cnt_value not reset.";

        wait until falling_edge(clk_s);
        res <= '0';
        wait until rising_edge(clk_s);
        wait for 60 * CLK_PERIOD;
        assert cnt_rdy = '1' report "Test 2: cnt_rdy != 1 when count ready.";
        assert cnt_value = "00111100" report "Test 2: wrong cnt_value.";

        wait for 5 * CLK_PERIOD;
        wait until falling_edge(clk_s);
        res <= '1';
        wait until falling_edge(clk_s);
        assert cnt_rdy = '0' report "Test 3: cnt_rdy = 1 when res.";
        assert cnt_value = "00000000" report "Test 3: reset failed.";

        wait;
    end process sim;
end architecture test;

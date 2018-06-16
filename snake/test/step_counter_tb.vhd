--******************************************************************************
--*                                                                            *
--* Title   : step_counter_tb.vhd                                              *
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

entity step_counter_tb is
    generic (
        WIDTH       : NATURAL := 16;
        CLK_PERIOD  : TIME := 10 ns
    );
end step_counter_tb;

architecture test of step_counter_tb is
    component step_counter
        generic (
            COUNT_MAX   : UNSIGNED := x"3C" -- 60 decimal
        );

        port (
            clk         : in STD_LOGIC;
            res         : in STD_LOGIC;
            cnt_rdy     : out STD_LOGIC;
            cnt_value   : out UNSIGNED(7 downto 0)
        );
    end component;

    component step_counter_stimuli is
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
    end component;

    signal clk_s, res_s, cnt_rdy_s: STD_LOGIC;
    signal cnt_value_s: UNSIGNED(7 downto 0);

begin
    dut : step_counter
        port map (
            clk         => clk_s,
            res         => res_s,
            cnt_rdy     => cnt_rdy_s,
            cnt_value   => cnt_value_s
        );

    -- Instantiate stimuli generation module
    test : step_counter_stimuli
        generic map (
            CLK_PERIOD => CLK_PERIOD
        )

        port map (
            clk         => clk_s,
            res         => res_s,
            cnt_rdy     => cnt_rdy_s,
            cnt_value   => cnt_value_s
        );

end architecture test;

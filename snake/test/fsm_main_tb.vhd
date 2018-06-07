library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.my_package.all;

entity fsm_main_tb is
    GENERIC (WIDTH: natural :=8);
end fsm_main_tb;

architecture test of fsm_main_tb is
    component fsm_main
        port (
            clk             : in STD_LOGIC;
            res             : in STD_LOGIC;
            cnt_rdy         : in STD_LOGIC;
            cmp_food_flag   : in STD_LOGIC;
            fsm_i_done      : in STD_LOGIC;
            fsm_f_done      : in STD_LOGIC;
            fsm_s_done      : in STD_LOGIC;
            fsm_s_game_over : in STD_LOGIC;
            con_sel         : out CONTROL_SELECT;
            fsm_i_start     : out STD_LOGIC;
            fsm_f_start     : out STD_LOGIC;
            fsm_s_start     : out STD_LOGIC
        );
    end component;

    component fsm_main_stimuli is
        generic (
            WIDTH       : NATURAL := 8;
            CLK_PERIOD  : TIME := 10ns
        );

        port (
            clk             : out STD_LOGIC;
            res             : out STD_LOGIC;
            cnt_rdy         : out STD_LOGIC;
            cmp_food_flag   : out STD_LOGIC;
            fsm_i_done      : out STD_LOGIC;
            fsm_f_done      : out STD_LOGIC;
            fsm_s_done      : out STD_LOGIC;
            fsm_s_game_over : out STD_LOGIC;
            con_sel         : in CONTROL_SELECT;
            fsm_i_start     : in STD_LOGIC;
            fsm_f_start     : in STD_LOGIC;
            fsm_s_start     : in STD_LOGIC
        );
    end component;

    signal clk_s, rst_s, cnt_rdy_s, cmp_food_flag_s, fsm_i_done_s, fsm_f_done_s,
        fsm_s_done_s, fsm_s_game_over_s: STD_LOGIC;

    signal fsm_i_start_s, fsm_f_start_s,fsm_s_start_s: STD_LOGIC :='0';
    signal con_sel_s: CONTROL_SELECT;

begin
    -- Instantiate DUT
    dut : fsm_main
        port map (
            clk             => clk_s,
            res             => rst_s,
            cnt_rdy         => cnt_rdy_s,
            cmp_food_flag   => cmp_food_flag_s,
            fsm_i_done      => fsm_i_done_s,
            fsm_f_done      => fsm_f_done_s,
            fsm_s_done      => fsm_s_done_s,
            fsm_s_game_over => fsm_s_game_over_s,
            con_sel         => con_sel_s,
            fsm_i_start     => fsm_i_start_s,
            fsm_f_start     => fsm_f_start_s,
            fsm_s_start     => fsm_s_start_s
        );

    -- Instantiate stimuli generation module
    test : fsm_main_stimuli
        port map (
            clk             => clk_s,
            res             => rst_s,
            cnt_rdy         => cnt_rdy_s,
            cmp_food_flag   => cmp_food_flag_s,
            fsm_i_done      => fsm_i_done_s,
            fsm_f_done      => fsm_f_done_s,
            fsm_s_done      => fsm_s_done_s,
            fsm_s_game_over => fsm_s_game_over_s,
            con_sel         => con_sel_s,
            fsm_i_start     => fsm_i_start_s,
            fsm_f_start     => fsm_f_start_s,
            fsm_s_start     => fsm_s_start_s
        );

end architecture test;

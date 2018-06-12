--******************************************************************************
--*                                                                            *
--* Title   : fsm_step_tb.vhd                                                  *
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

entity fsm_step_tb is
    GENERIC (WIDTH: natural :=8);
end fsm_step_tb;

architecture test of fsm_step_tb is
    component fsm_step
        port (
            clk             : in STD_LOGIC;
            res             : in STD_LOGIC;
            fsm_m_start     : in STD_LOGIC;
            cmp_body_flag   : in STD_LOGIC;
            sys_direction   : in direction;
            cmp_flags       : in STD_LOGIC_VECTOR(1 downto 0);
            dp_ctrl         : out datapath_ctrl_flags;
            fsm_m_done      : out STD_LOGIC;
            fsm_m_game_over : out STD_LOGIC
        );
    end component;

    component fsm_step_stimuli is
        generic (
            CLK_PERIOD: TIME := 10 ns
        );

        port (
            clk             : out STD_LOGIC;
            res             : out STD_LOGIC;
            fsm_m_start     : out STD_LOGIC;
            cmp_body_flag   : out STD_LOGIC;
            sys_direction   : out direction;
            cmp_flags       : out STD_LOGIC_VECTOR(1 downto 0);
            dp_ctrl         : in  datapath_ctrl_flags;
            fsm_m_done      : in  STD_LOGIC;
            fsm_m_game_over : in  STD_LOGIC
        );
    end component;

    signal clk_s, res_s, fsm_m_start_s, cmp_body_flag_s, fsm_m_done_s,
        fsm_m_game_over_s: STD_LOGIC;
    signal cmp_flags_s: STD_LOGIC_VECTOR(1 downto 0);
    signal sys_direction_s: direction;
    signal dp_ctrl_s: datapath_ctrl_flags;

begin
    -- Instantiate DUT
    dut : fsm_step
        port map (
            clk             => clk_s,
            res             => res_s,
            fsm_m_start     => fsm_m_start_s,
            cmp_body_flag   => cmp_body_flag_s,
            sys_direction   => sys_direction_s,
            cmp_flags       => cmp_flags_s,
            dp_ctrl         => dp_ctrl_s,
            fsm_m_done      => fsm_m_done_s,
            fsm_m_game_over => fsm_m_game_over_s
        );

    -- Instantiate stimuli generation module
    test : fsm_step_stimuli
        port map (
            clk             => clk_s,
            res             => res_s,
            fsm_m_start     => fsm_m_start_s,
            cmp_body_flag   => cmp_body_flag_s,
            sys_direction   => sys_direction_s,
            cmp_flags       => cmp_flags_s,
            dp_ctrl         => dp_ctrl_s,
            fsm_m_done      => fsm_m_done_s,
            fsm_m_game_over => fsm_m_game_over_s
        );

end architecture test;

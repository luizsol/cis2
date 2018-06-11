--******************************************************************************
--*                                                                            *
--* Title   : fsm_food_tb.vhd                                                  *
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

entity fsm_food_tb is
end fsm_food_tb;

architecture test of fsm_food_tb is
    component fsm_food
        port (
            clk             : in STD_LOGIC;
            res             : in STD_LOGIC;
            fsm_m_start     : in STD_LOGIC;
            cmp_body_flag   : in STD_LOGIC;
            ofc_of_x        : in STD_LOGIC;
            dp_ctrl         : out datapath_ctrl_flags;
            fsm_m_done      : out STD_LOGIC
        );
    end component;

    component fsm_food_stimuli is
        generic (
            CLK_PERIOD: TIME := 10 ns
        );

        port (
            clk             : out STD_LOGIC;
            res             : out STD_LOGIC;
            fsm_m_start     : out STD_LOGIC;
            cmp_body_flag   : out STD_LOGIC;
            ofc_of_x        : out STD_LOGIC;
            dp_ctrl         : in  datapath_ctrl_flags;
            fsm_m_done      : in  STD_LOGIC
        );
    end component;

    signal dp_ctrl_s: datapath_ctrl_flags;
    signal clk_s, res_s, fsm_m_start_s, ofc_of_x_s, cmp_body_flag_s,
        fsm_m_done_s : STD_LOGIC;

begin
    -- Instantiate DUT
    dut : fsm_food
        port map (
            clk             => clk_s,
            res             => res_s,
            fsm_m_start     => fsm_m_start_s,
            ofc_of_x        => ofc_of_x_s,
            cmp_body_flag   => cmp_body_flag_s,
            dp_ctrl         => dp_ctrl_s,
            fsm_m_done      => fsm_m_done_s
        );

    -- Instantiate stimuli generation module
    test : fsm_food_stimuli
        port map (
            clk             => clk_s,
            res             => res_s,
            fsm_m_start     => fsm_m_start_s,
            ofc_of_x        => ofc_of_x_s,
            cmp_body_flag   => cmp_body_flag_s,
            dp_ctrl         => dp_ctrl_s,
            fsm_m_done      => fsm_m_done_s
        );

end architecture test;

--******************************************************************************
--*                                                                            *
--* Title   : code_gen_tb.vhd                                                  *
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

entity code_gen_tb is
end code_gen_tb;

architecture test of code_gen_tb is
    component code_gen
        port (
            ctrl_code_sel   : in CODE;
            mem_code_w      : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component code_gen_stimuli is
        port (
            ctrl_code_sel   : out CODE;
            mem_code_w      : in  STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    signal ctrl_code_sel_s: CODE;
    signal mem_code_w_s: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : code_gen
        port map (
            ctrl_code_sel   => ctrl_code_sel_s,
            mem_code_w       => mem_code_w_s
        );

    -- Instantiate stimuli generation module
    test : code_gen_stimuli
        port map (
            ctrl_code_sel   => ctrl_code_sel_s,
            mem_code_w       => mem_code_w_s
        );

end architecture test;

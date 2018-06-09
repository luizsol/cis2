--******************************************************************************
--*                                                                            *
--* Title   : full_adder_tb.vhd                                                *
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

entity full_adder_tb is
end full_adder_tb;

architecture test of full_adder_tb is
    component full_adder
        port (
            a_in    : in  STD_LOGIC;
            b_in    : in  STD_LOGIC;
            c_in    : in  STD_LOGIC;
            z_out   : out STD_LOGIC;
            c_out   : out STD_LOGIC
        );
    end component;

    component full_adder_stimuli is
         port (
            a_in    : out  STD_LOGIC;
            b_in    : out  STD_LOGIC;
            c_in    : out  STD_LOGIC;
            z_out   : in STD_LOGIC;
            c_out   : in STD_LOGIC
        );
    end component;

    signal a_in_s, b_in_s, c_in_s, z_out_s, c_out_s: STD_LOGIC;

begin
    -- Instantiate DUT
    dut : full_adder
        port map (
            a_in    => a_in_s,
            b_in    => b_in_s,
            c_in    => c_in_s,
            z_out   => z_out_s,
            c_out   => c_out_s
        );

    -- Instantiate stimuli generation module
    test : full_adder_stimuli
        port map (
            a_in    => a_in_s,
            b_in    => b_in_s,
            c_in    => c_in_s,
            z_out   => z_out_s,
            c_out   => c_out_s
        );

end architecture test;

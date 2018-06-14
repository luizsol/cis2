--******************************************************************************
--*                                                                            *
--* Title   : comparator_tb.vhd                                                *
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

entity comparator_tb is
end comparator_tb;

architecture test of comparator_tb is
    component comparator
        port (
            value   : in  STD_LOGIC_VECTOR(7 downto 0);
            dp_flags: out datapath_flags
        );
    end component;

    component comparator_stimuli is
        port (
            value   : out STD_LOGIC_VECTOR(7 downto 0);
            dp_flags: in datapath_flags
        );
    end component;

    signal dp_flags_s: datapath_flags;
    signal value_s: STD_LOGIC_VECTOR(7 DOWNTO 0);

begin
    -- Instantiate DUT
    dut : comparator
        port map (
            value       => value_s,
            dp_flags    => dp_flags_s
        );

    -- Instantiate stimuli generation module
    test : comparator_stimuli
        port map (
            value       => value_s,
            dp_flags    => dp_flags_s
        );

end architecture test;
